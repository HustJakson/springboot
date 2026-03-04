package org.example.springboot.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.example.springboot.common.Result;
import org.example.springboot.entity.Order;
import org.example.springboot.service.OrderService;
import org.springframework.web.bind.annotation.*;

import jakarta.annotation.Resource;

/**
 * 订单管理接口控制器
 * 提供订单的创建、支付、确认、取消、退款等操作接口
 * 以及不同角色(租客、房东、管理员)获取订单信息的接口
 */
@Tag(name = "订单管理接口")
@RestController
@RequestMapping("/orders")
public class OrderController {
    @Resource
    private OrderService orderService;  // 注入订单服务接口
    
    /**
     * 创建订单接口
     * @param order 订单信息
     * @return 返回创建结果
     */
    @Operation(summary = "创建订单")
    @PostMapping
    public Result<?> createOrder(@RequestBody Order order) {
        return Result.success(orderService.createOrder(order));
    }
    
    /**
     * 支付订单接口
     * @param id 订单ID
     * @param paymentMethod 支付方式
     * @return 返回支付结果
     */
    @Operation(summary = "支付订单")
    @PutMapping("/{id}/pay")
    public Result<?> payOrder(@PathVariable Long id, @RequestParam String paymentMethod) {
        return Result.success(orderService.payOrder(id, paymentMethod));
    }
    
    /**
     * 确认订单接口（房东确认）
     * @param id 订单ID
     * @return 返回确认结果
     */
    @Operation(summary = "确认订单（房东确认）")
    @PutMapping("/{id}/confirm")
    public Result<?> confirmOrder(@PathVariable Long id) {
        return Result.success(orderService.confirmOrder(id));
    }
    
    /**
     * 取消订单接口
     * @param id 订单ID
     * @return 返回取消结果
     */
    @Operation(summary = "取消订单")
    @PutMapping("/{id}/cancel")
    public Result<?> cancelOrder(@PathVariable Long id) {
        return Result.success(orderService.cancelOrder(id));
    }
    
    /**
     * 申请退款接口
     * @param id 订单ID
     * @return 返回退款申请结果
     */
    @Operation(summary = "申请退款")
    @PostMapping("/{id}/refund")
    public Result<?> refundOrder(@PathVariable Long id) {
        return Result.success(orderService.refundOrder(id));
    }
    
    /**
     * 获取订单详情接口
     * @param id 订单ID
     * @return 返回订单详细信息
     */
    @Operation(summary = "获取订单详情")
    @GetMapping("/{id}")
    public Result<?> getOrderDetail(@PathVariable Long id) {
        return Result.success(orderService.getOrderDetail(id));
    }
    
    /**
     * 租客获取自己的订单列表接口
     * @param orderNo 订单号(可选)
     * @param status 订单状态(可选)
     * @param currentPage 当前页码，默认为1
     * @param size 每页大小，默认为10
     * @return 返回租客的订单列表
     */
    @Operation(summary = "租客获取自己的订单")
    @GetMapping("/tenant")
    public Result<?> getTenantOrders(
            @RequestParam(required = false) String orderNo,
            @RequestParam(required = false) Integer status,
            @RequestParam(defaultValue = "1") Integer currentPage,
            @RequestParam(defaultValue = "10") Integer size) {
        return Result.success(orderService.getTenantOrders(orderNo, status, currentPage, size));
    }
    
    /**
     * 房东获取自己的订单列表接口
     * @param orderNo 订单号(可选)
     * @param status 订单状态(可选)
     * @param currentPage 当前页码，默认为1
     * @param size 每页大小，默认为10
     * @return 返回房东的订单列表
     */
    @Operation(summary = "房东获取自己的订单")
    @GetMapping("/landlord")
    public Result<?> getLandlordOrders(
            @RequestParam(required = false) String orderNo,
            @RequestParam(required = false) Integer status,
            @RequestParam(defaultValue = "1") Integer currentPage,
            @RequestParam(defaultValue = "10") Integer size) {
        return Result.success(orderService.getLandlordOrders(orderNo, status, currentPage, size));
    }
    
    /**
     * 管理员获取所有订单列表接口
     * @param orderNo 订单号(可选)
     * @param status 订单状态(可选)
     * @param tenantUsername 租客用户名(可选)
     * @param landlordUsername 房东用户名(可选)
     * @param currentPage 当前页码，默认为1
     * @param size 每页大小，默认为10
     * @return 返回所有订单列表
     */
    @Operation(summary = "管理员获取所有订单")
    @GetMapping("/admin")
    public Result<?> getAllOrders(
            @RequestParam(required = false) String orderNo,
            @RequestParam(required = false) Integer status,
            @RequestParam(required = false) String tenantUsername,
            @RequestParam(required = false) String landlordUsername,
            @RequestParam(defaultValue = "1") Integer currentPage,
            @RequestParam(defaultValue = "10") Integer size) {
        return Result.success(orderService.getAllOrders(orderNo, status, tenantUsername, landlordUsername, currentPage, size));
    }
} 