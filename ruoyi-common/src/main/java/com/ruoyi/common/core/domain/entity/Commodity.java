package com.ruoyi.common.core.domain.entity;

import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * 商品资料对象 commodity
 *
 * @author KrityCat
 */
public class Commodity extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /**
     * 商品id
     */
    private Long commodityId;

    /**
     * 商品编号
     */
    @Excel(name = "商品编号")
    private String commodityCode;

    /**
     * 商品名称
     */
    @Excel(name = "商品名称")
    private String commodityName;

    /**
     * 商品类型
     */
    @Excel(name = "商品类型")
    private String commodityType;

    /**
     * 商品规格
     */
    @Excel(name = "商品规格")
    private String commoditySpecifications;

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
    private String price;

    /**
     * 商品条码
     */
    @Excel(name = "商品条码")
    private String productBarcode;

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
     * 商品状态（0正常 1停用）
     */
    @Excel(name = "商品状态", readConverterExp = "0=正常,1=停用")
    private String status;

    public Long getCommodityId() {
        return commodityId;
    }

    public void setCommodityId(Long commodityId) {
        this.commodityId = commodityId;
    }

    public String getCommodityCode() {
        return commodityCode;
    }

    public void setCommodityCode(String commodityCode) {
        this.commodityCode = commodityCode;
    }

    public String getCommodityName() {
        return commodityName;
    }

    public void setCommodityName(String commodityName) {
        this.commodityName = commodityName;
    }

    public String getCommodityType() {
        return commodityType;
    }

    public void setCommodityType(String commodityType) {
        this.commodityType = commodityType;
    }

    public String getCommoditySpecifications() {
        return commoditySpecifications;
    }

    public void setCommoditySpecifications(String commoditySpecifications) {
        this.commoditySpecifications = commoditySpecifications;
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

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getProductBarcode() {
        return productBarcode;
    }

    public void setProductBarcode(String productBarcode) {
        this.productBarcode = productBarcode;
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

    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
                .append("commodityId", getCommodityId())
                .append("commodityCode", getCommodityCode())
                .append("commodityName", getCommodityName())
                .append("commodityType", getCommodityType())
                .append("commoditySpecifications", getCommoditySpecifications())
                .append("measureUnit", getMeasureUnit())
                .append("producer", getProducer())
                .append("costPrice", getCostPrice())
                .append("price", getPrice())
                .append("productBarcode", getProductBarcode())
                .append("upperLimit", getUpperLimit())
                .append("lowerLimit", getLowerLimit())
                .append("defaultWarehouse", getDefaultWarehouse())
                .append("notes", getNotes())
                .append("status", getStatus())
                .append("createBy", getCreateBy())
                .append("createTime", getCreateTime())
                .append("updateBy", getUpdateBy())
                .append("updateTime", getUpdateTime())
                .toString();
    }
}
