package com.ruoyi.common.core.domain.entity;

import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import java.util.List;

/**
 * 单据头对象 HeadReceipt
 *
 * @author KrityCat
 */
public class HeadReceipt extends BaseEntity {

    private static final long serialVersionUID = 1L;

    /**
     * 系统单号
     */
    @Excel(name = "系统单号")
    private String systematicReceipt;

    /**
     * 原始单号
     */
    @Excel(name = "原始单号")
    private String originalReceipt;

    /**
     * 单据类别
     */
    @Excel(name = "单据类别", readConverterExp = "1=采购单据,2=销售单据,3=库存单据", type = Excel.Type.IMPORT)
    private Long receiptCategory;

    /**
     * 单据类型
     */
    @Excel(name = "单据类型", readConverterExp = "1=采购入库,2=采购退库,3=销售出库,4=销售退库,5=其他入库,6=其他出库,7=库存调拨,8=库存盘点")
    private Long receiptType;

    /**
     * 单据状态
     */
    @Excel(name = "单据状态", readConverterExp = "1=拟制,2=生效")
    private Long receiptStatus;

    /**
     * 发生日期
     */
    @Excel(name = "发生日期")
    private String invoiceDate;

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
    private String receiptNotes;

    /**
     * 备注
     */
    @Excel(name = "定金")
    private String deposit;

    /**
     * 备注
     */
    @Excel(name = "总金额")
    private String totalAmount;

    /**
     * 备注
     */
    @Excel(name = "总金额（大写）")
    private String capitalizeTotalAmount;

    private List<Product> product;

    private List<DetailReceipt> detail;

    public String getSystematicReceipt() {
        return systematicReceipt;
    }

    public void setSystematicReceipt(String systematicReceipt) {
        this.systematicReceipt = systematicReceipt;
    }

    public String getOriginalReceipt() {
        return originalReceipt;
    }

    public void setOriginalReceipt(String originalReceipt) {
        this.originalReceipt = originalReceipt;
    }

    public Long getReceiptCategory() {
        return receiptCategory;
    }

    public void setReceiptCategory(Long receiptCategory) {
        this.receiptCategory = receiptCategory;
    }

    public Long getReceiptType() {
        return receiptType;
    }

    public void setReceiptType(Long receiptType) {
        this.receiptType = receiptType;
    }

    public Long getReceiptStatus() {
        return receiptStatus;
    }

    public void setReceiptStatus(Long receiptStatus) {
        this.receiptStatus = receiptStatus;
    }

    public String getInvoiceDate() {
        return invoiceDate;
    }

    public void setInvoiceDate(String invoiceDate) {
        this.invoiceDate = invoiceDate;
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

    public String getReceiptNotes() {
        return receiptNotes;
    }

    public void setReceiptNotes(String receiptNotes) {
        this.receiptNotes = receiptNotes;
    }

    public String getDeposit() {
        return deposit;
    }

    public void setDeposit(String deposit) {
        this.deposit = deposit;
    }

    public String getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(String totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getCapitalizeTotalAmount() {
        return capitalizeTotalAmount;
    }

    public void setCapitalizeTotalAmount(String capitalizeTotalAmount) {
        this.capitalizeTotalAmount = capitalizeTotalAmount;
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

    public List<DetailReceipt> getDetail() {
        return detail;
    }

    public void setDetail(List<DetailReceipt> detail) {
        this.detail = detail;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
                .append("systematicReceipt", getSystematicReceipt())
                .append("originalReceipt", getOriginalReceipt())
                .append("receiptCategory", getReceiptCategory())
                .append("receiptType", getReceiptType())
                .append("receiptStatus", getReceiptStatus())
                .append("invoiceDate", getInvoiceDate())
                .append("warehousingIds", getWarehousingIds())
                .append("retrievalIds", getRetrievalIds())
                .append("userIds", getUserIds())
                .append("supplierIds", getSupplierIds())
                .append("customerIds", getCustomerIds())
                .append("productCode", getProductCode())
                .append("productName", getProductName())
                .append("planReceipt", getPlanReceipt())
                .append("receiptNotes", getReceiptNotes())
                .append("deposit", getDeposit())
                .append("totalAmount", getTotalAmount())
                .append("capitalizeTotalAmount", getCapitalizeTotalAmount())
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
                .append("detail", getDetail())
                .toString();
    }
}
