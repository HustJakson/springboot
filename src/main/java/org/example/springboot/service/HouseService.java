package org.example.springboot.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import jakarta.annotation.Resource;
import org.apache.commons.lang3.StringUtils;
import org.example.springboot.DTO.RecommendParam;
import org.example.springboot.DTO.UserHousePreference;
import org.example.springboot.entity.House;
import org.example.springboot.entity.HouseType;
import org.example.springboot.entity.Order;
import org.example.springboot.entity.User;
import org.example.springboot.exception.ServiceException;
import org.example.springboot.mapper.HouseMapper;
import org.example.springboot.mapper.HouseTypeMapper;
import org.example.springboot.mapper.OrderMapper;
import org.example.springboot.mapper.UserMapper;
import org.example.springboot.util.JwtTokenUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDateTime;
import java.util.*;
import java.util.function.Function;
import java.util.stream.Collectors;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;

import java.util.Map;
import java.util.Objects;
import java.util.Set;



/**
 * 房屋服务实现类
 */
@Service
public class HouseService {
    private static final Logger LOGGER = LoggerFactory.getLogger(HouseService.class);

    @Resource
    private HouseMapper houseMapper;

    @Resource
    private HouseTypeMapper houseTypeMapper;

    @Resource
    private UserMapper userMapper;
    @Resource
    private OrderMapper orderMapper;

    @Value("${house.recommend.price-range-ratio:0.2}")
    private BigDecimal PRICE_RANGE_RATIO;

    @Value("${house.recommend.similar-user-min-match:1}")
    private int SIMILAR_USER_MIN_MATCH;

    @Value("${house.recommend.max-similar-user:20}")
    private int MAX_SIMILAR_USER;

    /**
     * 分页查询房屋信息
     * @param title 房屋标题
     * @param address 房屋地址
     * @param minPrice 最低价格
     * @param maxPrice 最高价格
     * @param typeId 房屋类型ID
     * @param status 房屋状态
     * @param currentPage 当前页
     * @param size 每页大小
     * @return 分页数据
     */
    public Page<House> getHousesByPage(String title, String address, Long landLordId, BigDecimal minPrice, BigDecimal maxPrice,
                                       Long typeId, Integer status, Integer currentPage, Integer size) {
        LambdaQueryWrapper<House> queryWrapper = new LambdaQueryWrapper<>();

        // 添加查询条件
        if (StringUtils.isNotBlank(title)) {
            queryWrapper.like(House::getTitle, title);
        }

        //地址查询条件

        if (StringUtils.isNotBlank(address)) {
            queryWrapper.like(House::getAddress, address);
        }

        if (minPrice != null) {
            queryWrapper.ge(House::getPrice, minPrice);
        }

        if (maxPrice != null) {
            queryWrapper.le(House::getPrice, maxPrice);
        }

        // 只有typeId非null时才添加条件
        if (typeId != null) {
            queryWrapper.eq(House::getTypeId, typeId);
        }

        if (status != null) {
            queryWrapper.eq(House::getStatus, status);
        }
        if(landLordId != null) {
            queryWrapper.eq(House::getLandlordId, landLordId);
        }


        // 按创建时间降序排序
        queryWrapper.orderByDesc(House::getCreateTime);

        Page<House> page = houseMapper.selectPage(new Page<>(currentPage, size), queryWrapper);

        // 填充房屋类型名称和房东姓名
        page.getRecords().forEach(this::fillHouseInfo);

        return page;
    }

    /**
     * 房东查询自己的房屋
     * @param title 房屋标题
     * @param status 房屋状态
     * @param currentPage 当前页
     * @param size 每页大小
     * @return 分页数据
     */
    public Page<House> getLandlordHouses(String title, Integer status, Integer currentPage, Integer size) {
        // 获取当前登录用户
        User currentUser = JwtTokenUtils.getCurrentUser();
        if (currentUser == null) {
            throw new ServiceException("获取当前用户信息失败");
        }

        LambdaQueryWrapper<House> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(House::getLandlordId, currentUser.getId());

        if (StringUtils.isNotBlank(title)) {
            queryWrapper.like(House::getTitle, title);
        }

        if (status != null) {
            queryWrapper.eq(House::getStatus, status);
        }

        queryWrapper.orderByDesc(House::getCreateTime);

        Page<House> page = houseMapper.selectPage(new Page<>(currentPage, size), queryWrapper);

        // 填充房屋类型名称和房东姓名
        page.getRecords().forEach(this::fillHouseInfo);

        return page;
    }

    /**
     * 根据ID获取房屋详情
     * @param id 房屋ID
     * @return 房屋信息
     */
    public House getHouseById(Long id) {
        House house = houseMapper.selectById(id);
        if (house == null) {
            throw new ServiceException("房屋不存在");
        }

        // 填充房屋类型名称和房东姓名
        fillHouseInfo(house);

        return house;
    }

    /**
     * 创建房屋
     * @param house 房屋信息
     */
    @Transactional
    public void createHouse(House house) {
        // 获取当前登录用户作为房东
        User currentUser = JwtTokenUtils.getCurrentUser();
        if (currentUser == null) {
            throw new ServiceException("获取当前用户信息失败");
        }

        // 检查房屋类型是否存在
        HouseType houseType = houseTypeMapper.selectById(house.getTypeId());
        if (houseType == null) {
            throw new ServiceException("所选房屋类型不存在");
        }

        // 设置房东ID和初始状态
        house.setLandlordId(currentUser.getId());
        house.setStatus(house.getStatus() != null ? house.getStatus() : 1); // 默认为待出租状态

        // 设置创建和更新时间
        LocalDateTime now = LocalDateTime.now();
        house.setCreateTime(now);
        house.setUpdateTime(now);

        int result = houseMapper.insert(house);
        if (result <= 0) {
            throw new ServiceException("创建房屋失败");
        }
    }

    /**
     * 更新房屋信息
     * @param id 房屋ID
     * @param house 房屋信息
     */
    @Transactional
    public void updateHouse(Long id, House house) {
        // 获取当前登录用户
        User currentUser = JwtTokenUtils.getCurrentUser();
        if (currentUser == null) {
            throw new ServiceException("获取当前用户信息失败");
        }

        // 检查房屋是否存在
        House existingHouse = houseMapper.selectById(id);
        if (existingHouse == null) {
            throw new ServiceException("房屋不存在");
        }

        // 校验房屋类型是否存在
        if (house.getTypeId() != null && !house.getTypeId().equals(existingHouse.getTypeId())) {
            HouseType houseType = houseTypeMapper.selectById(house.getTypeId());
            if (houseType == null) {
                throw new ServiceException("所选房屋类型不存在");
            }
        }

        // 检查权限：只有管理员或房东可以修改
        if (!"ADMIN".equals(currentUser.getRoleCode()) && !currentUser.getId().equals(existingHouse.getLandlordId())) {
            throw new ServiceException("无权修改该房屋信息");
        }

        // 设置ID和更新时间，保留创建时间和房东ID
        house.setId(id);
        house.setUpdateTime(LocalDateTime.now());
        house.setCreateTime(existingHouse.getCreateTime());
        house.setLandlordId(existingHouse.getLandlordId());

        int result = houseMapper.updateById(house);
        if (result <= 0) {
            throw new ServiceException("更新房屋信息失败");
        }
    }

    /**
     * 修改房屋状态
     * @param id 房屋ID
     * @param status 状态(0:下架,1:待出租,2:已出租)
     */
    @Transactional
    public void updateHouseStatus(Long id, Integer status) {
        // 获取当前登录用户
        User currentUser = JwtTokenUtils.getCurrentUser();
        if (currentUser == null) {
            throw new ServiceException("获取当前用户信息失败");
        }

        // 检查房屋是否存在
        House existingHouse = houseMapper.selectById(id);
        if (existingHouse == null) {
            throw new ServiceException("房屋不存在");
        }

        // 检查权限：只有管理员或房东可以修改
        if (!"ADMIN".equals(currentUser.getRoleCode()) && !currentUser.getId().equals(existingHouse.getLandlordId())) {
            throw new ServiceException("无权修改该房屋状态");
        }

        // 检查状态值是否有效
        if (status < 0 || status > 2) {
            throw new ServiceException("无效的房屋状态值");
        }

        House house = new House();
        house.setId(id);
        house.setStatus(status);
        house.setUpdateTime(LocalDateTime.now());

        int result = houseMapper.updateById(house);
        if (result <= 0) {
            throw new ServiceException("更新房屋状态失败");
        }
    }

    /**
     * 删除房屋
     * @param id 房屋ID
     */
    @Transactional
    public void deleteHouse(Long id) {
        // 获取当前登录用户
        User currentUser = JwtTokenUtils.getCurrentUser();
        if (currentUser == null) {
            throw new ServiceException("获取当前用户信息失败");
        }

        // 检查房屋是否存在
        House existingHouse = houseMapper.selectById(id);
        if (existingHouse == null) {
            throw new ServiceException("房屋不存在");
        }

        // 检查权限：只有管理员或房东可以删除
        if (!"ADMIN".equals(currentUser.getRoleCode()) && !currentUser.getId().equals(existingHouse.getLandlordId())) {
            throw new ServiceException("无权删除该房屋");
        }

        // 已出租状态的房屋不能删除
        if (existingHouse.getStatus() == 2) {
            throw new ServiceException("已出租的房屋不能删除");
        }

        int result = houseMapper.deleteById(id);
        if (result <= 0) {
            throw new ServiceException("删除房屋失败");
        }
    }

    /**
     * 协同过滤推荐房屋（入参仅status、currentPage、size）
     * @param param 入参对象（包含status、currentPage、size）
     * @return 分页推荐房屋列表
     */
    public IPage<House> recommendHouses(RecommendParam param) {
        // 获取当前登录用户
        User currentUser = JwtTokenUtils.getCurrentUser();
        // 构建分页对象
        Page<House> page = new Page<>(param.getCurrentPage(), param.getSize());
        // 基础查询条件：仅查询指定状态（待出租）的房屋
        LambdaQueryWrapper<House> baseQuery = new LambdaQueryWrapper<House>()
                .eq(House::getStatus, param.getStatus())
                .orderByDesc(House::getCreateTime);

        // 1. 有登录用户：执行双层协同过滤推荐
        if (currentUser != null) {
            Long userId = currentUser.getId();
            // 获取用户历史所有订单
            List<Order> userOrders = getCurrentUserOrders(userId);
            // 提取当前用户的房屋偏好特征（类型ID、价格区间）
            UserHousePreference userPreference = extractUserHousePreference(userOrders);

            // 第一层推荐：基于当前用户自身订单（原有逻辑）
            IPage<House> personalRecommendPage = recommendByPersonalPreference(param.getStatus(), userPreference, page);
            if (personalRecommendPage.getTotal() > 0) {
//                personalRecommendPage.getRecords().forEach(this::fillHouseBasicInfo);
                fillHousesBasicInfo(personalRecommendPage.getRecords());
                return personalRecommendPage;
            }

            // 第二层推荐：基于相似用户行为（新增核心逻辑）
            if (userPreference.hasPreference() || !userOrders.isEmpty()) {
                IPage<House> similarUserRecommendPage = recommendBySimilarUser(
                        userId, param.getStatus(), userPreference, page);
                if (similarUserRecommendPage.getTotal() > 0) {
//                    similarUserRecommendPage.getRecords().forEach(this::fillHouseBasicInfo);
                    fillHousesBasicInfo(similarUserRecommendPage.getRecords());
                    return similarUserRecommendPage;
                }
            }
        }

        // 3. 兜底层：无登录/无偏好/无推荐结果 → 返回最新待出租房屋
        IPage<House> hotHousePage = houseMapper.selectPage(page, baseQuery);
//        hotHousePage.getRecords().forEach(this::fillHouseBasicInfo);
        fillHousesBasicInfo(hotHousePage.getRecords());
        return hotHousePage;
    }

    // ====================== 第一层：基于当前用户自身订单推荐 ======================
    private IPage<House> recommendByPersonalPreference(Integer status, UserHousePreference preference, Page<House> page) {
        LambdaQueryWrapper<House> query = new LambdaQueryWrapper<House>()
                .eq(House::getStatus, status);

        // 拼接个人偏好条件：同类型 或 价格在区间内
        if (preference.hasPreference()) {
            query.and(wrapper -> {
                if (!preference.getHouseTypeIds().isEmpty()) {
                    wrapper.in(House::getTypeId, preference.getHouseTypeIds());
                }
                if (preference.getMinPrice() != null && preference.getMaxPrice() != null) {
                    wrapper.or().between(House::getPrice, preference.getMinPrice(), preference.getMaxPrice());
                }
            });
        }

        query.orderByDesc(House::getCreateTime);
        return houseMapper.selectPage(page, query);
    }

    // ====================== 第二层：基于相似用户行为推荐 ======================
    private IPage<House> recommendBySimilarUser(Long currentUserId, Integer status,
                                                UserHousePreference currentPref, Page<House> page) {
        // 1. 查找与当前用户偏好相似的其他用户ID（排除自己）
        Set<Long> similarUserIds = findSimilarUserIds(currentUserId, currentPref);
        if (similarUserIds.isEmpty()) {
            return new Page<>(page.getCurrent(), page.getSize(), 0);
        }

        // 2. 提取相似用户的所有订单，过滤出有效房屋订单
        List<Order> similarUserOrders = getSimilarUserOrders(similarUserIds, status);
        if (similarUserOrders.isEmpty()) {
            return new Page<>(page.getCurrent(), page.getSize(), 0);
        }

        // 3. 提取相似用户订单中的房屋ID（去重，排除当前用户已订房屋）
        Set<Long> currentUserHouseIds = getCurrentUserHouseIds(currentUserId);
        Set<Long> recommendHouseIds = similarUserOrders.stream()
                .map(Order::getHouseId)
                .filter(houseId -> !currentUserHouseIds.contains(houseId))
                .collect(Collectors.toSet());
        if (recommendHouseIds.isEmpty()) {
            return new Page<>(page.getCurrent(), page.getSize(), 0);
        }

        // 4. 查询相似用户偏好的房屋，按订单数量排序（下单越多越推荐）
        LambdaQueryWrapper<House> query = new LambdaQueryWrapper<House>()
                .eq(House::getStatus, status)
                .in(House::getId, recommendHouseIds)
                .orderByDesc(House::getCreateTime);
        return houseMapper.selectPage(page, query);
    }

    // 查找相似用户ID：匹配房屋类型 或 价格区间重叠
    private Set<Long> findSimilarUserIds(Long currentUserId, UserHousePreference currentPref) {
        // 获取所有有订单的用户（排除当前用户）
        List<Order> allUserOrders = orderMapper.selectList(new LambdaQueryWrapper<Order>()
                .ne(Order::getTenantId, currentUserId));
        if (allUserOrders.isEmpty()) {
            return Collections.emptySet();
        }

        // 按用户ID分组，提取每个用户的房屋偏好
        Map<Long, UserHousePreference> userPreferenceMap = allUserOrders.stream()
                .collect(Collectors.groupingBy(Order::getTenantId))
                .entrySet().stream()
                .collect(Collectors.toMap(
                        Map.Entry::getKey,
                        entry -> extractUserHousePreference(entry.getValue())
                ));

        // 筛选出与当前用户偏好相似的用户
        Set<Long> similarUserIds = new HashSet<>();
        for (Map.Entry<Long, UserHousePreference> entry : userPreferenceMap.entrySet()) {
            UserHousePreference userPref = entry.getValue();
            if (isUserSimilar(currentPref, userPref)) {
                similarUserIds.add(entry.getKey());
                // 限制相似用户数量，避免查询过多
                if (similarUserIds.size() >= MAX_SIMILAR_USER) {
                    break;
                }
            }
        }
        return similarUserIds;
    }

    // 获取当前用户已订的房屋ID（去重）
    private Set<Long> getCurrentUserHouseIds(Long userId) {
        return getCurrentUserOrders(userId).stream()
                .map(Order::getHouseId)
                .filter(Objects::nonNull)
                .collect(Collectors.toSet());
    }

    // 提取用户房屋偏好（核心：类型ID+价格区间）→ 封装为实体类
    private UserHousePreference extractUserHousePreference(List<Order> orders) {
        Set<Long> houseTypeIds = new HashSet<>();
        List<BigDecimal> prices = new ArrayList<>();

        for (Order order : orders) {
            House house = houseMapper.selectById(order.getHouseId());
            if (house == null) {
                continue;
            }
            // 提取房屋类型ID
            if (house.getTypeId() != null) {
                houseTypeIds.add(house.getTypeId());
            }
            // 提取房屋价格
            if (house.getPrice() != null && house.getPrice().compareTo(BigDecimal.ZERO) > 0) {
                prices.add(house.getPrice());
            }
        }

        // 计算价格区间：平均价±20%
        BigDecimal avgPrice = calculateAvgPrice(prices);
        BigDecimal minPrice = avgPrice != null ? avgPrice.multiply(BigDecimal.ONE.subtract(PRICE_RANGE_RATIO)) : null;
        BigDecimal maxPrice = avgPrice != null ? avgPrice.multiply(BigDecimal.ONE.add(PRICE_RANGE_RATIO)) : null;

        return new UserHousePreference(houseTypeIds, minPrice, maxPrice);
    }

    // 计算价格平均值
    private BigDecimal calculateAvgPrice(List<BigDecimal> prices) {
        if (prices.isEmpty()) {
            return null;
        }
        BigDecimal sum = prices.stream().reduce(BigDecimal.ZERO, BigDecimal::add);
        return sum.divide(new BigDecimal(prices.size()), 2, RoundingMode.HALF_UP);
    }

    // 判断两个用户是否相似：类型交集≥1 或 价格区间重叠
    private boolean isUserSimilar(UserHousePreference pref1, UserHousePreference pref2) {
        // 类型匹配：有至少一个相同的房屋类型
        if (!pref1.getHouseTypeIds().isEmpty() && !pref2.getHouseTypeIds().isEmpty()) {
            Set<Long> intersection = new HashSet<>(pref1.getHouseTypeIds());
            intersection.retainAll(pref2.getHouseTypeIds());
            if (intersection.size() >= SIMILAR_USER_MIN_MATCH) {
                return true;
            }
        }

        // 价格匹配：两个用户的价格区间有重叠
        if (pref1.getMinPrice() != null && pref1.getMaxPrice() != null
                && pref2.getMinPrice() != null && pref2.getMaxPrice() != null) {
            return pref1.getMinPrice().compareTo(pref2.getMaxPrice()) <= 0
                    && pref2.getMinPrice().compareTo(pref1.getMaxPrice()) <= 0;
        }

        return false;
    }

    // 提取相似用户的所有有效订单
    private List<Order> getSimilarUserOrders(Set<Long> similarUserIds, Integer status) {
        // 提取相似用户订单，并关联房屋状态为待出租
        List<Order> orders = orderMapper.selectList(new LambdaQueryWrapper<Order>()
                .in(Order::getTenantId, similarUserIds));
        if (orders.isEmpty()) {
            return Collections.emptyList();
        }

        // 过滤出订单对应的房屋为待出租的订单
        Set<Long> houseIds = orders.stream().map(Order::getHouseId).collect(Collectors.toSet());
        List<House> validHouses = houseMapper.selectList(new LambdaQueryWrapper<House>()
                .eq(House::getStatus, status)
                .in(House::getId, houseIds));
        Set<Long> validHouseIds = validHouses.stream().map(House::getId).collect(Collectors.toSet());

        return orders.stream()
                .filter(order -> validHouseIds.contains(order.getHouseId()))
                .collect(Collectors.toList());
    }

    /**
     * 获取当前用户所有历史订单
     */
    private List<Order> getCurrentUserOrders(Long userId) {
        LambdaQueryWrapper<Order> query = new LambdaQueryWrapper<Order>()
                .eq(Order::getTenantId, userId);
        return orderMapper.selectList(query);
    }

//    /**
//     * 填充房屋基础信息：类型名称、房东姓名/头像（复用HouseService的核心逻辑）
//     */
//    private void fillHouseBasicInfo(House house) {
//        if (house == null) {
//            return;
//        }
//        // 填充房屋类型名称
//        if (house.getTypeId() != null) {
//            HouseType houseType = houseTypeMapper.selectById(house.getTypeId());
//            if (houseType != null) {
//                house.setTypeName(houseType.getName());
//            }
//        }
//        // 填充房东信息
//        if (house.getLandlordId() != null) {
//            User landlord = userMapper.selectById(house.getLandlordId());
//            if (landlord != null) {
//                house.setLandlordName(landlord.getName());
//                house.setLandlordImg(landlord.getAvatar());
//            }
//        }
//    }
//

    /*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
    /**
     * 批量填充房屋基础信息（一次性查询，避免N+1问题）
     * @param houses 房屋列表
     */
    private void fillHousesBasicInfo(List<House> houses) {
        if (houses == null || houses.isEmpty()) {
            return;
        }

        // 1. 收集所有需要查询的ID
        Set<Long> typeIds = new HashSet<>();
        Set<Long> landlordIds = new HashSet<>();

        for (House house : houses) {
            if (house.getTypeId() != null) {
                typeIds.add(house.getTypeId());
            }
            if (house.getLandlordId() != null) {
                landlordIds.add(house.getLandlordId());
            }
        }

        // 2. 批量查询类型信息（一次查询）
        Map<Long, HouseType> typeMap = new HashMap<>();
        if (!typeIds.isEmpty()) {
            List<HouseType> types = houseTypeMapper.selectBatchIds(typeIds);
            typeMap = types.stream()
                    .collect(Collectors.toMap(HouseType::getId, Function.identity()));
        }

        // 3. 批量查询房东信息（一次查询）
        Map<Long, User> userMap = new HashMap<>();
        if (!landlordIds.isEmpty()) {
            List<User> users = userMapper.selectBatchIds(landlordIds);
            userMap = users.stream()
                    .collect(Collectors.toMap(User::getId, Function.identity()));
        }

        // 4. 一次性填充所有房屋
        for (House house : houses) {
            // 填充类型名称
            if (house.getTypeId() != null) {
                HouseType type = typeMap.get(house.getTypeId());
                if (type != null) {
                    house.setTypeName(type.getName());
                }
            }

            // 填充房东信息
            if (house.getLandlordId() != null) {
                User landlord = userMap.get(house.getLandlordId());
                if (landlord != null) {
                    house.setLandlordName(landlord.getName());
                    house.setLandlordImg(landlord.getAvatar());
                }
            }
        }
    }
    /*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

    /**
     * 填充房屋类型名称和房东姓名
     * @param house 房屋信息
     */
    private void fillHouseInfo(House house) {
        if (house == null) {
            return;
        }

        // 填充房屋类型名称
        if (house.getTypeId() != null) {
            HouseType houseType = houseTypeMapper.selectById(house.getTypeId());
            if (houseType != null) {
                house.setTypeName(houseType.getName());
            }
        }

        // 填充房东姓名
        if (house.getLandlordId() != null) {
            User landlord = userMapper.selectById(house.getLandlordId());
            if (landlord != null) {
                house.setLandlordName(landlord.getName());
                house.setLandlordImg(landlord.getAvatar());
                //获取房东电话
                house.setLandlordPhone(landlord.getPhone());
            }
        }
    }

}
