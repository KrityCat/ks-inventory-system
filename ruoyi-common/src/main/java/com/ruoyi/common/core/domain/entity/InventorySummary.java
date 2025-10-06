package com.ruoyi.common.core.domain.entity;


import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * 库存汇总对象 InventorySummary
 *
 * @author KrityCat
 */
public class InventorySummary extends BaseEntity {

    private static final long serialVersionUID = 1L;

    private String warehousingId;

    @Excel(name = "仓库")
    private String warehousingName;

    private String retrievalId;

    //    @Excel(name = "调出仓库")
    private String retrievalName;

    @Excel(name = "货品编号")
    private String productCode;

    @Excel(name = "货品名称")
    private String productName;

    private String productType;

    @Excel(name = "货品类型")
    private String productTypeName;

    @Excel(name = "规格")
    private String productSpecifications;

    @Excel(name = "单位")
    private String measureUnit;

    private String producer;


    @Excel(name = "期初数量")
    private String OBPlanQuantity;

    private String OBUnivalence;

    @Excel(name = "期初金额")
    private Double OBMoney;

    @Excel(name = "入库数量")
    private String EIPlanQuantity;

    @Excel(name = "入库金额")
    private Double EIMoney;

    @Excel(name = "出库数量")
    private String ERPlanQuantity;

    @Excel(name = "出库金额")
    private Double ERMoney;

    @Excel(name = "期末数量")
    private String CBPlanQuantity;

    private String CBUnivalence;

    @Excel(name = "期末金额")
    private Double CBMoney;

    private String productId;


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


    public String getOBPlanQuantity() {
        return OBPlanQuantity;
    }

    public void setOBPlanQuantity(String obPlanQuantity) {
        this.OBPlanQuantity = obPlanQuantity;
    }

    public String getOBUnivalence() {
        return OBUnivalence;
    }

    public void setOBUnivalence(String OBUnivalence) {
        this.OBUnivalence = OBUnivalence;
    }

    public Double getOBMoney() {
        return OBMoney;
    }

    public void setOBMoney(Double obMoney) {
        this.OBMoney = obMoney;
    }

    public String getEIPlanQuantity() {
        return EIPlanQuantity;
    }

    public void setEIPlanQuantity(String eiPlanQuantity) {
        this.EIPlanQuantity = eiPlanQuantity;
    }

    public Double getEIMoney() {
        return EIMoney;
    }

    public void setEIMoney(Double eiMoney) {
        this.EIMoney = eiMoney;
    }

    public String getERPlanQuantity() {
        return ERPlanQuantity;
    }

    public void setERPlanQuantity(String erPlanQuantity) {
        this.ERPlanQuantity = erPlanQuantity;
    }

    public Double getERMoney() {
        return ERMoney;
    }

    public void setERMoney(Double erMoney) {
        this.ERMoney = erMoney;
    }

    public String getCBPlanQuantity() {
        return CBPlanQuantity;
    }

    public void setCBPlanQuantity(String cbPlanQuantity) {
        this.CBPlanQuantity = cbPlanQuantity;
    }

    public String getCBUnivalence() {
        return CBUnivalence;
    }

    public void setCBUnivalence(String CBUnivalence) {
        this.CBUnivalence = CBUnivalence;
    }

    public Double getCBMoney() {
        return CBMoney;
    }

    public void setCBMoney(Double cbMoney) {
        this.CBMoney = cbMoney;
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

    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
                .append("productId", getProductId())
                .append("warehousingId", getWarehousingId())
                .append("warehousingName", getWarehousingName())
                .append("retrievalId", getRetrievalId())
                .append("retrievalName", getRetrievalName())
                .append("productCode", getProductCode())
                .append("productName", getProductName())
                .append("OBPlanQuantity", getOBPlanQuantity())
                .append("OBUnivalence", getOBUnivalence())
                .append("OBMoney", getOBMoney())
                .append("EIPlanQuantity", getEIPlanQuantity())
                .append("EIMoney", getEIMoney())
                .append("ERPlanQuantity", getERPlanQuantity())
                .append("ERMoney", getERMoney())
                .append("CBPlanQuantity", getCBPlanQuantity())
                .append("CBUnivalence", getCBUnivalence())
                .append("CBMoney", getCBMoney())
                .append("productType", getProductType())
                .append("productTypeName", getProductTypeName())
                .append("productSpecifications", getProductSpecifications())
                .append("measureUnit", getMeasureUnit())
                .append("producer", getProducer())
                .append("createBy", getCreateBy())
                .append("createTime", getCreateTime())
                .append("updateBy", getUpdateBy())
                .append("updateTime", getUpdateTime())
                .toString();
    }
}
