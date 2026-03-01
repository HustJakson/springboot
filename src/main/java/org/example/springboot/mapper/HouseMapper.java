package org.example.springboot.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.example.springboot.entity.House;

/**
 * 房屋信息数据访问层
 */
@Mapper
public interface HouseMapper extends BaseMapper<House> {
} 