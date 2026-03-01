package org.example.springboot.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.example.springboot.entity.HouseType;

/**
 * 房屋类型数据访问层
 */
@Mapper
public interface HouseTypeMapper extends BaseMapper<HouseType> {
} 