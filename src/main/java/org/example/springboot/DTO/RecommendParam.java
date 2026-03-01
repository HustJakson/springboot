package org.example.springboot.DTO;

/**
 * @Author: Ynw
 * @Date: 2026/01/29/21:48
 * @Description: 推荐参数封装类，用于封装推荐功能所需的参数信息
 */
// 入参封装类（仅包含需要的字段）
public class RecommendParam {
    private Integer status;    // 房屋状态（1=待出租）
    private Integer currentPage; // 当前页码
    private Integer size;        // 每页条数

    // getter & setter
    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }
    public Integer getCurrentPage() { return currentPage; }
    public void setCurrentPage(Integer currentPage) { this.currentPage = currentPage; }
    public Integer getSize() { return size; }
    public void setSize(Integer size) { this.size = size; }
}
