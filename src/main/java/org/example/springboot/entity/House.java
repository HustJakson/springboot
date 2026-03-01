package org.example.springboot.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 房屋信息实体类
 */
@Data
@TableName("house")
@Schema(description = "房屋实体类")
public class House {
    @TableId(type = IdType.AUTO)
    @Schema(description = "房屋ID")
    private Long id;
    
    @Schema(description = "房屋标题")
    private String title;
    
    @Schema(description = "房屋描述")
    private String description;
    
    @Schema(description = "面积(平方米)")
    private BigDecimal area;
    
    @Schema(description = "价格(元/月)")
    private BigDecimal price;
    
    @Schema(description = "地址")
    private String address;
    
    @Schema(description = "房屋类型ID")
    private Long typeId;
    
    @Schema(description = "房东ID")
    private Long landlordId;
    
    @Schema(description = "状态(0:下架,1:待出租,2:已出租)")
    private Integer status;
    
    @Schema(description = "房屋图片(JSON格式)")
    private String images;
    
    @Schema(description = "配套设施(JSON格式)")
    private String facilities;
    
    @Schema(description = "创建时间")
    private LocalDateTime createTime;
    
    @Schema(description = "更新时间")
    private LocalDateTime updateTime;
    
    @TableField(exist = false)
    @Schema(description = "房屋类型名称")
    private String typeName;
    
    @TableField(exist = false)
    @Schema(description = "房东姓名")
    private String landlordName;
    @TableField(exist = false)
    @Schema(description = "房东头像")
    private String landlordImg;

} 