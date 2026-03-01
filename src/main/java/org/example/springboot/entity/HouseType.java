package org.example.springboot.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 房屋类型实体类
 */
@Data
@TableName("house_type")
@Schema(description = "房屋类型实体类")
public class HouseType {
    @TableId(type = IdType.AUTO)
    @Schema(description = "类型ID")
    private Long id;
    
    @Schema(description = "类型名称(合租/整租)")
    private String name;
    
    @Schema(description = "类型描述")
    private String description;
    
    @Schema(description = "创建时间")
    private LocalDateTime createTime;
    
    @Schema(description = "更新时间")
    private LocalDateTime updateTime;
} 