package com.ruoyi.common.core.domain.entity;

import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import java.util.List;

/**
 * 订单头对象 HeadOrderForm
 *
 * @author KrityCat
 */
public class HeadOrderForm extends BaseEntity {

    private static final long serialVersionUID = 1L;

    /**
     * 系统单号
     */
    @Excel(name = "系统单号")
    private String systematicOrderForm;

    /**
     * 原始单号
     */
    @Excel(name = "原始单号")
    private String originalOrderForm;

    /**
     * 订单类型
     */
    @Excel(name = "订单类型", readConverterExp = "1=采购订单,2=销售订单,3=库存订单")
    private Long orderFormType;

    /**
     * 订单状态
     */
    @Excel(name = "订单状态", readConverterExp = "1=待审核,2=已审核")
    private Long orderFormStatus;

    /**
     * 订货日期
     */
    @Excel(name = "订货日期")
    private String orderDate;

    /**
     * 发生日期
     */
    @Excel(name = "发生日期")
    private String deliveryDate;

    @Excel(name = "调入仓库", targetAttr = "warehousingName", type = Excel.Type.EXPORT)
    private Warehouse warehousing;

    @Excel(name = "调出仓库", targetAttr = "retrievalName", type = Excel.Type.EXPORT)
    private Warehouse retrieval;

    @Excel(name = "经手人", targetAttr = "userName", type = Excel.Type.EXPORT)
    private SysUser sysUser;

    @Excel(name = "供应商", targetAttr = "supplierName", type = Excel.Type.EXPORT)
    private Supplier supplier;

    @Excel(name = "客户", targetAttr = "customerName", type = Excel.Type.EXPORT)
    private Customer customer;

    /**
     * 入库仓库ID
     */
    @Excel(name = "入库仓库ID", type = Excel.Type.IMPORT)
    private String warehousingIds;

    /**
     * 出库仓库ID
     */
    @Excel(name = "出库仓库ID", type = Excel.Type.IMPORT)
    private String retrievalIds;

    /**
     * 经手人ID
     */
    @Excel(name = "经手人ID", type = Excel.Type.IMPORT)
    private String userIds;

    /**
     * 供应商ID
     */
    @Excel(name = "供应商ID", type = Excel.Type.IMPORT)
    private String supplierIds;

    /**
     * 客户ID
     */
    @Excel(name = "客户ID", type = Excel.Type.IMPORT)
    private String customerIds;

    /**
     * 货品编码
     */
    private String productCode;

    /**
     * 货品名称
     */
    private String productName;

    /**
     * 计划单号
     */
    @Excel(name = "订单号")
    private String planReceipt;

    /**
     * 备注
     */
    @Excel(name = "备注")
    private String orderFormNotes;

    /**
     * 定金
     */
    @Excel(name = "定金")
    private String deposit;

    /**
     * 总金额
     */
    @Excel(name = "总金额")
    private String orderFormAmount;

    /**
     * 总金额（大写）
     */
    @Excel(name = "总金额（大写）")
    private String orderCapitalizeAmount;

    @Excel(name = "售后安装", readConverterExp = "0=是,1=否")
    private String afterSalesInstallation;

    /**
     * 审核结果
     */
    @Excel(name = "审核结果")
    private String findingOfAudit;

    /**
     * 审核意见
     */
    @Excel(name = "审核意见")
    private String reviewComments;

    private List<Product> product;

    private List<DetailOrderForm> details;

    public String getSystematicOrderForm() {
        return systematicOrderForm;
    }

    public void setSystematicOrderForm(String systematicOrderForm) {
        this.systematicOrderForm = systematicOrderForm;
    }

    public String getOriginalOrderForm() {
        return originalOrderForm;
    }

    public void setOriginalOrderForm(String originalOrderForm) {
        this.originalOrderForm = originalOrderForm;
    }

    public Long getOrderFormType() {
        return orderFormType;
    }

    public void setOrderFormType(Long orderFormType) {
        this.orderFormType = orderFormType;
    }

    public Long getOrderFormStatus() {
        return orderFormStatus;
    }

    public void setOrderFormStatus(Long orderFormStatus) {
        this.orderFormStatus = orderFormStatus;
    }

    public String getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate;
    }

    public String getDeliveryDate() {
        return deliveryDate;
    }

    public void setDeliveryDate(String deliveryDate) {
        this.deliveryDate = deliveryDate;
    }

    public String getWarehousingIds() {
        return warehousingIds;
    }

    public void setWarehousingIds(String warehousingIds) {
        this.warehousingIds = warehousingIds;
    }

    public String getRetrievalIds() {
        return retrievalIds;
    }

    public void setRetrievalIds(String retrievalIds) {
        this.retrievalIds = retrievalIds;
    }

    public String getUserIds() {
        return userIds;
    }

    public void setUserIds(String userIds) {
        this.userIds = userIds;
    }

    public String getSupplierIds() {
        return supplierIds;
    }

    public void setSupplierIds(String supplierIds) {
        this.supplierIds = supplierIds;
    }

    public String getCustomerIds() {
        return customerIds;
    }

    public void setCustomerIds(String customerIds) {
        this.customerIds = customerIds;
    }

    public String getProductCode() {
        return productCode;
    }

    public void setProductCode(String productCode) {
        this.productCode = productCode;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getPlanReceipt() {
        return planReceipt;
    }

    public void setPlanReceipt(String planReceipt) {
        this.planReceipt = planReceipt;
    }

    public String getOrderFormNotes() {
        return orderFormNotes;
    }

    public void setOrderFormNotes(String orderFormNotes) {
        this.orderFormNotes = orderFormNotes;
    }

    public String getDeposit() {
        return deposit;
    }

    public void setDeposit(String deposit) {
        this.deposit = deposit;
    }

    public String getOrderFormAmount() {
        return orderFormAmount;
    }

    public void setOrderFormAmount(String orderFormAmount) {
        this.orderFormAmount = orderFormAmount;
    }

    public String getOrderCapitalizeAmount() {
        return orderCapitalizeAmount;
    }

    public void setOrderCapitalizeAmount(String orderCapitalizeAmount) {
        this.orderCapitalizeAmount = orderCapitalizeAmount;
    }

    public String getAfterSalesInstallation() {
        return afterSalesInstallation;
    }

    public void setAfterSalesInstallation(String afterSalesInstallation) {
        this.afterSalesInstallation = afterSalesInstallation;
    }

    public String getFindingOfAudit() {
        return findingOfAudit;
    }

    public void setFindingOfAudit(String findingOfAudit) {
        this.findingOfAudit = findingOfAudit;
    }

    public String getReviewComments() {
        return reviewComments;
    }

    public void setReviewComments(String reviewComments) {
        this.reviewComments = reviewComments;
    }

    public Warehouse getWarehousing() {
        return warehousing;
    }

    public void setWarehousing(Warehouse warehousing) {
        this.warehousing = warehousing;
    }

    public Warehouse getRetrieval() {
        return retrieval;
    }

    public void setRetrieval(Warehouse retrieval) {
        this.retrieval = retrieval;
    }

    public SysUser getSysUser() {
        return sysUser;
    }

    public void setSysUser(SysUser sysUser) {
        this.sysUser = sysUser;
    }

    public Supplier getSupplier() {
        return supplier;
    }

    public void setSupplier(Supplier supplier) {
        this.supplier = supplier;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public List<Product> getProduct() {
        return product;
    }

    public void setProduct(List<Product> product) {
        this.product = product;
    }

    public List<DetailOrderForm> getDetails() {
        return details;
    }

    public void setDetails(List<DetailOrderForm> details) {
        this.details = details;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
                .append("systematicOrderForm", getSystematicOrderForm())
                .append("originalOrderForm", getOriginalOrderForm())
                .append("orderFormType", getOrderFormType())
                .append("orderFormStatus", getOrderFormStatus())
                .append("orderDate", getOrderDate())
                .append("deliveryDate", getDeliveryDate())
                .append("warehousingIds", getWarehousingIds())
                .append("retrievalIds", getRetrievalIds())
                .append("userIds", getUserIds())
                .append("supplierIds", getSupplierIds())
                .append("customerIds", getCustomerIds())
                .append("productCode", getProductCode())
                .append("productName", getProductName())
                .append("planReceipt", getPlanReceipt())
                .append("orderFormNotes", getOrderFormNotes())
                .append("deposit", getDeposit())
                .append("orderFormAmount", getOrderFormAmount())
                .append("orderCapitalizeAmount", getOrderCapitalizeAmount())
                .append("afterSalesInstallation", getAfterSalesInstallation())
                .append("findingOfAudit", getFindingOfAudit())
                .append("reviewComments", getReviewComments())
                .append("createBy", getCreateBy())
                .append("createTime", getCreateTime())
                .append("updateBy", getUpdateBy())
                .append("updateTime", getUpdateTime())
                .append("warehousing", getWarehousing())
                .append("retrieval", getRetrieval())
                .append("sysUser", getSysUser())
                .append("supplier", getSupplier())
                .append("customer", getCustomer())
                .append("product", getProduct())
                .append("details", getDetails())
                .toString();
    }
}
