package org.example.springboot.DTO;

import java.math.BigDecimal;
import java.util.Collections;
import java.util.Optional;
import java.util.Set;

/**
 * @Author: Ynw
 * @Date: 2026/01/30/14:48
 * @Description:
 */
public class UserHousePreference {
    private Set<Long> houseTypeIds; // 偏好的房屋类型ID
    private BigDecimal minPrice;    // 价格区间最小值
    private BigDecimal maxPrice;    // 价格区间最大值

    // 构造方法
    public UserHousePreference(Set<Long> houseTypeIds, BigDecimal minPrice, BigDecimal maxPrice) {
        this.houseTypeIds = Optional.ofNullable(houseTypeIds).orElse(Collections.emptySet());
        this.minPrice = minPrice;
        this.maxPrice = maxPrice;
    }

    // 判断用户是否有有效偏好
    public boolean hasPreference() {
        return !this.houseTypeIds.isEmpty() || (this.minPrice != null && this.maxPrice != null);
    }

    // getter
    public Set<Long> getHouseTypeIds() { return houseTypeIds; }
    public BigDecimal getMinPrice() { return minPrice; }
    public BigDecimal getMaxPrice() { return maxPrice; }
}
