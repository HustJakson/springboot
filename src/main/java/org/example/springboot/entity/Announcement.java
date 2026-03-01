package org.example.springboot.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 公告实体类
 */
@Data
@TableName("announcement")
@Schema(description = "公告实体类")
public class Announcement {
    
    @TableId(type = IdType.AUTO)
    @Schema(description = "公告ID")
    private Long id;
    
    @Schema(description = "公告标题")
    private String title;
    
    @Schema(description = "公告内容")
    private String content;
    
    @Schema(description = "发布管理员ID")
    private Long adminId;
    
    @Schema(description = "状态(0:下架,1:发布)")
    private Integer status;
    
    @Schema(description = "创建时间")
    private LocalDateTime createTime;
    
    @Schema(description = "更新时间")
    private LocalDateTime updateTime;
    
    @TableField(exist = false)
    @Schema(description = "管理员信息")
    private User admin;
} 