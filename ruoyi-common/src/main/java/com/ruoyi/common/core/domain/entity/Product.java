package com.ruoyi.common.core.domain.entity;

import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.annotation.Excel.Type;
import com.ruoyi.common.annotation.Excels;
import com.ruoyi.common.core.domain.BaseEntity;
import lombok.Data;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;


/**
 * 货品对象 product
 *
 * @author KrityCat
 */
@Data
public class Product extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /**
     * 货品ID
     */
    private String productId;

    /**
     * 货品编号
     */
    @Excel(name = "货品编号")
    private String productCode;

    /**
     * 货品名称
     */
    @Excel(name = "货品名称")
    private String productName;

    /**
     * 货品类型
     */
    @Excel(name = "货品类型")
    private String productType;

    /**
     * 商品规格
     */
    @Excel(name = "商品规格")
    private String productSpecifications;

    /**
     * 计量单位
     */
    @Excel(name = "计量单位")
    private String measureUnit;

    /**
     * 产地
     */
    @Excel(name = "产地")
    private String producer;

    /**
     * 成本价
     */
    @Excel(name = "成本价")
    private String costPrice;

    /**
     * 参考售价
     */
    @Excel(name = "参考售价")
    private String univalence;

    /**
     * 销售折扣
     */
    @Excel(name = "销售折扣")
    private String discount;


    /**
     * 货品条码
     */
    @Excel(name = "货品条码")
    private String productBarcode;

    /**
     * 库存数量
     */
    @Excel(name = "库存数量")
    private String inventoryQty;

    /**
     * 库存上限
     */
    @Excel(name = "库存上限")
    private String upperLimit;

    /**
     * 库存下限
     */
    @Excel(name = "库存下限")
    private String lowerLimit;

    /**
     * 默认仓库
     */
    @Excel(name = "默认仓库")
    private String defaultWarehouse;

    /**
     * 备注
     */
    @Excel(name = "备注")
    private String notes;

    /**
     * 状态（0正常 1停用）
     */
    @Excel(name = "帐号状态", readConverterExp = "0=正常,1=停用")
    private String status;

    /**
     * 货品类型名称
     */
    @Excels({
            @Excel(name = "货品类型名称", targetAttr = "productTypeName", type = Type.EXPORT),
    })
    private ProductType type;

    /**
     * 货品类型名称
     */
    private String productTypeName;

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
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

    public String getCostPrice() {
        return costPrice;
    }

    public void setCostPrice(String costPrice) {
        this.costPrice = costPrice;
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

    public String getProductBarcode() {
        return productBarcode;
    }

    public void setProductBarcode(String productBarcode) {
        this.productBarcode = productBarcode;
    }

    public String getInventoryQty() {
        return inventoryQty;
    }

    public void setInventoryQty(String inventoryQty) {
        this.inventoryQty = inventoryQty;
    }

    public String getUpperLimit() {
        return upperLimit;
    }

    public void setUpperLimit(String upperLimit) {
        this.upperLimit = upperLimit;
    }

    public String getLowerLimit() {
        return lowerLimit;
    }

    public void setLowerLimit(String lowerLimit) {
        this.lowerLimit = lowerLimit;
    }

    public String getDefaultWarehouse() {
        return defaultWarehouse;
    }

    public void setDefaultWarehouse(String defaultWarehouse) {
        this.defaultWarehouse = defaultWarehouse;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public ProductType getType() {
        return type;
    }

    public void setType(ProductType type) {
        this.type = type;
    }

    public String getProductTypeName() {
        return productTypeName;
    }

    public void setProductTypeName(String productTypeName) {
        this.productTypeName = productTypeName;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
                .append("productId", getProductId())
                .append("productCode", getProductCode())
                .append("productName", getProductName())
                .append("productType", getProductType())
                .append("productSpecifications", getProductSpecifications())
                .append("measureUnit", getMeasureUnit())
                .append("producer", getProducer())
                .append("costPrice", getCostPrice())
                .append("univalence", getUnivalence())
                .append("discount", getDiscount())
                .append("productBarcode", getProductBarcode())
                .append("inventoryQty", getInventoryQty())
                .append("upperLimit", getUpperLimit())
                .append("lowerLimit", getLowerLimit())
                .append("defaultWarehouse", getDefaultWarehouse())
                .append("notes", getNotes())
                .append("status", getStatus())
                .append("type", getType())
                .append("productTypeName", getProductTypeName())
                .append("createBy", getCreateBy())
                .append("createTime", getCreateTime())
                .append("updateBy", getUpdateBy())
                .append("updateTime", getUpdateTime())
                .toString();
    }
}
