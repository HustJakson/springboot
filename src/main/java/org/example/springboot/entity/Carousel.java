package org.example.springboot.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("carousel")
@Schema(description = "轮播图实体类")
public class Carousel {
    @TableId(type = IdType.AUTO)
    @Schema(description = "轮播图ID")
    private Long id;
    
    @Schema(description = "轮播图标题")
    private String title;
    
    @Schema(description = "轮播图描述")
    private String description;
    
    @Schema(description = "图片URL")
    private String imageUrl;
    
    @Schema(description = "链接URL")
    private String linkUrl;
    
    @Schema(description = "状态(0:禁用,1:启用)")
    private Integer status;
    
    @Schema(description = "创建时间")
    private LocalDateTime createTime;
    
    @Schema(description = "更新时间")
    private LocalDateTime updateTime;
} 