package org.example.springboot.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@TableName("transaction")
@Schema(description = "交易记录实体类")
public class Transaction {
    @TableId(type = IdType.AUTO)
    @Schema(description = "交易ID")
    private Long id;
    
    @Schema(description = "订单ID")
    private Long orderId;
    
    @Schema(description = "用户ID")
    private Long userId;
    
    @Schema(description = "类型(1:收入,2:支出)")
    private Integer type;
    
    @Schema(description = "金额")
    private BigDecimal amount;
    
    @Schema(description = "交易描述")
    private String description;
    
    @Schema(description = "创建时间")
    private LocalDateTime createTime;
    
    // 非数据库字段，关联订单信息
    @TableField(exist = false)
    @Schema(description = "订单信息")
    private Order order;
    
    // 非数据库字段，关联用户信息
    @TableField(exist = false)
    @Schema(description = "用户信息")
    private User user;
} 