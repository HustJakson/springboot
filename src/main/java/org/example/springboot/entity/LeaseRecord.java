package org.example.springboot.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
@TableName("lease_record")
@Schema(description = "租赁记录实体类")
public class LeaseRecord {
    @TableId(type = IdType.AUTO)
    @Schema(description = "记录ID")
    private Long id;
    
    @Schema(description = "订单ID")
    private Long orderId;
    
    @Schema(description = "房屋ID")
    private Long houseId;
    
    @Schema(description = "租客ID")
    private Long tenantId;
    
    @Schema(description = "房东ID")
    private Long landlordId;
    
    @Schema(description = "租期开始日期")
    private LocalDate startDate;
    
    @Schema(description = "租期结束日期")
    private LocalDate endDate;
    
    @Schema(description = "租金金额")
    private BigDecimal rentAmount;
    
    @Schema(description = "支付周期(MONTHLY/QUARTERLY/YEARLY)")
    private String paymentCycle;
    
    @Schema(description = "状态(0:已取消,1:租赁中,2:已结束,3:已退租)")
    private Integer status;
    
    @Schema(description = "实际结束日期")
    private LocalDate actualEndDate;
    
    @Schema(description = "合同文件URL")
    private String contractUrl;
    
    @Schema(description = "评价分数(1-5)")
    private Integer evaluationScore;
    
    @Schema(description = "评价内容")
    private String evaluationContent;
    
    @Schema(description = "创建时间")
    private LocalDateTime createTime;
    
    @Schema(description = "更新时间")
    private LocalDateTime updateTime;
    
    @TableField(exist = false)
    private House house;
    
    @TableField(exist = false)
    private User tenant;
    
    @TableField(exist = false)
    private User landlord;
    
    @TableField(exist = false)
    private Order order;
} 