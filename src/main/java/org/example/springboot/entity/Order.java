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
@TableName("`order`")
@Schema(description = "订单实体类")
public class Order {
    @TableId(type = IdType.AUTO)
    @Schema(description = "订单ID")
    private Long id;
    
    @Schema(description = "订单编号")
    private String orderNo;
    
    @Schema(description = "房屋ID")
    private Long houseId;
    
    @Schema(description = "租客ID")
    private Long tenantId;
    
    @Schema(description = "房东ID")
    private Long landlordId;
    
    @Schema(description = "订单金额")
    private BigDecimal amount;
    
    @Schema(description = "押金金额")
    private BigDecimal deposit;
    
    @Schema(description = "状态(0:待支付,1:已支付待确认,2:已确认,3:已取消,4:已退款)")
    private Integer status;
    
    @Schema(description = "支付时间")
    private LocalDateTime paymentTime;
    
    @Schema(description = "支付方式")
    private String paymentMethod;
    
    @Schema(description = "创建时间")
    private LocalDateTime createTime;
    
    @Schema(description = "更新时间")
    private LocalDateTime updateTime;
    
    // 非数据库字段，关联房屋信息
    @TableField(exist = false)
    @Schema(description = "房屋信息")
    private House house;
    
    // 非数据库字段，关联租客信息
    @TableField(exist = false)
    @Schema(description = "租客信息")
    private User tenant;
    
    // 非数据库字段，关联房东信息
    @TableField(exist = false)
    @Schema(description = "房东信息")
    private User landlord;
} 