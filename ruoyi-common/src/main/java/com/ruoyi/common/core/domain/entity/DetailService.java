package com.ruoyi.common.core.domain.entity;


import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.annotation.Excels;
import com.ruoyi.common.core.domain.BaseEntity;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * 单据明细对象 DetailReceipt
 *
 * @author KrityCat
 */
public class DetailService extends BaseEntity {

    private static final long serialVersionUID = 1L;

    /**
     * 系统单号
     */
    @Excel(name = "系统单号")
    private String systematicReceipt;

    @Excel(name = "货品编号", type = Excel.Type.IMPORT)
    private String productId;

    /**
     * 入库仓库ID
     */
    @Excel(name = "入库仓库ID", type = Excel.Type.IMPORT)
    private String warehousingId;

    /**
     * 入库仓库Name
     */
    private String warehousingName;

    /**
     * 出库仓库ID
     */
    @Excel(name = "出库仓库ID", type = Excel.Type.IMPORT)
    private String retrievalId;

    /**
     * 出库仓库Name
     */
    private String retrievalName;

    /**
     * 供应商ID
     */
    @Excel(name = "供应商ID", type = Excel.Type.IMPORT)
    private String supplierId;

    /**
     * 客户ID
     */
    @Excel(name = "客户ID", type = Excel.Type.IMPORT)
    private String customerId;

    @Excels({
            @Excel(name = "货品编号", targetAttr = "productCode", type = Excel.Type.EXPORT),
            @Excel(name = "货品名称", targetAttr = "productName", type = Excel.Type.EXPORT),
            @Excel(name = "规格", targetAttr = "productSpecifications", type = Excel.Type.EXPORT),
            @Excel(name = "单位", targetAttr = "measureUnit", type = Excel.Type.EXPORT),
            @Excel(name = "产地", targetAttr = "producer", type = Excel.Type.EXPORT)
    })
    private Product product;

    @Excels({
            @Excel(name = "货品类型", targetAttr = "productTypeName", type = Excel.Type.EXPORT)
    })
    private ProductType type;

    private HeadService headService;

    private Supplier supplier;

    private Customer customer;

    @Excel(name = "当前库存量")
    private String currentInventory;

    @Excel(name = "实际库存量")
    private String actualInventory;

    @Excel(name = "数量")
    private String planQuantity;

    @Excel(name = "单价")
    private String univalence;

    @Excel(name = "折扣")
    private String discount;

    @Excel(name = "金额")
    private String money;

    @Excel(name = "成本")
    private String cost;

    @Excel(name = "备注")
    private String remarks;

    /**
     * 原始单号
     */
    private String originalReceipt;

    /**
     * 单据类型
     */
    private Long serviceType;

    /**
     * 单据状态
     */
    private Long receiptStatus;

    /**
     * 入库仓库ID
     */
    private String warehousingIds;

    /**
     * 出库仓库ID
     */
    private String retrievalIds;

    /**
     * 货品库存仓库ID
     */
    private String warehouseId;

    /**
     * 经手人ID
     */
    private String userIds;

    /**
     * 供应商ID
     */
    private String supplierIds;

    /**
     * 客户ID
     */
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
     * 货品类型
     */
    private String productType;

    /**
     * 货品类型名称
     */
    private String productTypeName;

    /**
     * 商品规格
     */
    private String productSpecifications;

    /**
     * 计量单位
     */
    private String measureUnit;

    /**
     * 产地
     */
    private String producer;

    /**
     * 库存数量
     */
    private String inventoryQty;

    public String getSystematicReceipt() {
        return systematicReceipt;
    }

    public void setSystematicReceipt(String systematicReceipt) {
        this.systematicReceipt = systematicReceipt;
    }

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public String getWarehousingId() {
        return warehousingId;
    }

    public void setWarehousingId(String warehousingId) {
        this.warehousingId = warehousingId;
    }

    public String getWarehousingName() {
        return warehousingName;
    }

    public void setWarehousingName(String warehousingName) {
        this.warehousingName = warehousingName;
    }

    public String getRetrievalId() {
        return retrievalId;
    }

    public void setRetrievalId(String retrievalId) {
        this.retrievalId = retrievalId;
    }

    public String getRetrievalName() {
        return retrievalName;
    }

    public void setRetrievalName(String retrievalName) {
        this.retrievalName = retrievalName;
    }

    public String getWarehouseId() {
        return warehouseId;
    }

    public void setWarehouseId(String warehouseId) {
        this.warehouseId = warehouseId;
    }

    public String getSupplierId() {
        return supplierId;
    }

    public void setSupplierId(String supplierId) {
        this.supplierId = supplierId;
    }

    public String getCustomerId() {
        return customerId;
    }

    public void setCustomerId(String customerId) {
        this.customerId = customerId;
    }

    public String getCurrentInventory() {
        return currentInventory;
    }

    public void setCurrentInventory(String currentInventory) {
        this.currentInventory = currentInventory;
    }


    public String getActualInventory() {
        return actualInventory;
    }

    public void setActualInventory(String actualInventory) {
        this.actualInventory = actualInventory;
    }

    public String getPlanQuantity() {
        return planQuantity;
    }

    public void setPlanQuantity(String planQuantity) {
        this.planQuantity = planQuantity;
    }

    public String getUnivalence() {
        return univalence;
    }

    public void setUnivalence(String univalence) {
        this.univalence = univalence;
    }

    public String getDiscount() {
        return discount;
    }

    public void setDiscount(String discount) {
        this.discount = discount;
    }

    public String getMoney() {
        return money;
    }

    public void setMoney(String money) {
        this.money = money;
    }

    public String getCost() {
        return cost;
    }

    public void setCost(String cost) {
        this.cost = cost;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public String getOriginalReceipt() {
        return originalReceipt;
    }

    public void setOriginalReceipt(String originalReceipt) {
        this.originalReceipt = originalReceipt;
    }

    public Long getServiceType() {
        return serviceType;
    }

    public void setServiceType(Long serviceType) {
        this.serviceType = serviceType;
    }

    public Long getReceiptStatus() {
        return receiptStatus;
    }

    public void setReceiptStatus(Long receiptStatus) {
        this.receiptStatus = receiptStatus;
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

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public ProductType getType() {
        return type;
    }

    public void setType(ProductType type) {
        this.type = type;
    }

    public HeadService getHeadService() {
        return headService;
    }

    public void setHeadService(HeadService headService) {
        this.headService = headService;
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

    public String getProductType() {
        return productType;
    }

    public void setProductType(String productType) {
        this.productType = productType;
    }

    public String getProductTypeName() {
        return productTypeName;
    }

    public void setProductTypeName(String productTypeName) {
        this.productTypeName = productTypeName;
    }

    public String getProductSpecifications() {
        return productSpecifications;
    }

    public void setProductSpecifications(String productSpecifications) {
        this.productSpecifications = productSpecifications;
    }

    public String getMeasureUnit() {
        return measureUnit;
    }

    public void setMeasureUnit(String measureUnit) {
        this.measureUnit = measureUnit;
    }

    public String getProducer() {
        return producer;
    }

    public void setProducer(String producer) {
        this.producer = producer;
    }

    public String getInventoryQty() {
        return inventoryQty;
    }

    public void setInventoryQty(String inventoryQty) {
        this.inventoryQty = inventoryQty;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
                .append("systematicReceipt", getSystematicReceipt())
                .append("productId", getProductId())
                .append("warehousingId", getWarehousingId())
                .append("warehousingName", getWarehousingName())
                .append("retrievalId", getRetrievalId())
                .append("retrievalName", getRetrievalName())
                .append("warehouseId", getWarehouseId())
                .append("supplierId", getSupplierId())
                .append("customerId", getCustomerId())
                .append("currentInventory", getCurrentInventory())
                .append("actualInventory", getActualInventory())
                .append("planQuantity", getPlanQuantity())
                .append("univalence", getUnivalence())
                .append("discount", getDiscount())
                .append("money", getMoney())
                .append("cost", getCost())
                .append("remarks", getRemarks())
                .append("originalReceipt", getOriginalReceipt())
                .append("serviceType", getServiceType())
                .append("receiptStatus", getReceiptStatus())
                .append("warehousingIds", getWarehousingIds())
                .append("retrievalIds", getRetrievalIds())
                .append("userIds", getUserIds())
                .append("supplierIds", getSupplierIds())
                .append("customerIds", getCustomerIds())
                .append("productCode", getProductCode())
                .append("productName", getProductName())
                .append("product", getProduct())
                .append("type", getType())
                .append("headService", getHeadService())
                .append("supplier", getSupplier())
                .append("customer", getCustomer())
                .append("productType", getProductType())
                .append("productTypeName", getProductTypeName())
                .append("productSpecifications", getProductSpecifications())
                .append("measureUnit", getMeasureUnit())
                .append("producer", getProducer())
                .append("inventoryQty", getInventoryQty())
                .append("createBy", getCreateBy())
                .append("createTime", getCreateTime())
                .append("updateBy", getUpdateBy())
                .append("updateTime", getUpdateTime())
                .toString();
    }
}
