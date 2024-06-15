package com.ruoyi.common.core.domain.entity;


import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.annotation.Excels;
import com.ruoyi.common.core.domain.BaseEntity;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * 货品库存对象 InventoryProduct
 *
 * @author KrityCat
 */
public class InventoryProduct extends BaseEntity {

    private static final long serialVersionUID = 1L;

    private String productId;

    @Excels({
            @Excel(name = "货品编号", targetAttr = "productCode", type = Excel.Type.EXPORT),
            @Excel(name = "货品名称", targetAttr = "productName", type = Excel.Type.EXPORT),
            @Excel(name = "规格", targetAttr = "productSpecifications", type = Excel.Type.EXPORT),
            @Excel(name = "单位", targetAttr = "measureUnit", type = Excel.Type.EXPORT),
            @Excel(name = "产地", targetAttr = "producer", type = Excel.Type.EXPORT)
    })
    private Product product;

    @Excels({
            @Excel(name = "货品类型", targetAttr = "productTypeName", type = Excel.Type.EXPORT),
    })
    private ProductType type;

    /**
     * 货品编号
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
     * 商品规格
     */
    private String productSpecifications;

    private String warehouseId;

    private String supplierId;

    @Excels({
            @Excel(name = "仓库", targetAttr = "warehouseName", type = Excel.Type.EXPORT),
    })
    private Warehouse warehouse;

    @Excel(name = "货品数量")
    private String planQuantity;

    @Excel(name = "单价")
    private String univalence;

    @Excel(name = "折扣")
    private String discount;

    @Excel(name = "金额")
    private String money;

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
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

    public Warehouse getWarehouse() {
        return warehouse;
    }

    public void setWarehouse(Warehouse warehouse) {
        this.warehouse = warehouse;
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

    public String getProductType() {
        return productType;
    }

    public void setProductType(String productType) {
        this.productType = productType;
    }

    public String getProductSpecifications() {
        return productSpecifications;
    }

    public void setProductSpecifications(String productSpecifications) {
        this.productSpecifications = productSpecifications;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
                .append("productId", getProductId())
                .append("warehouseId", getWarehouseId())
                .append("supplierId", getSupplierId())
                .append("planQuantity", getPlanQuantity())
                .append("univalence", getUnivalence())
                .append("discount", getDiscount())
                .append("money", getMoney())
                .append("product", getProduct())
                .append("type", getType())
                .append("warehouse", getWarehouse())
                .append("productCode", getProductCode())
                .append("productName", getProductName())
                .append("productType", getProductType())
                .append("productSpecifications", getProductSpecifications())
                .append("createBy", getCreateBy())
                .append("createTime", getCreateTime())
                .append("updateBy", getUpdateBy())
                .append("updateTime", getUpdateTime())
                .toString();
    }
}
