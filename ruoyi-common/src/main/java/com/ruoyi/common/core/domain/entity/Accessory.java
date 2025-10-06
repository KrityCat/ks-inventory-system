package com.ruoyi.common.core.domain.entity;

import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;
import lombok.Data;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;


/**
 * 配件对象 product
 *
 * @author KrityCat
 */
@Data
public class Accessory extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /**
     * 配件ID
     */
    private String accessoryId;

    /**
     * 配件编号
     */
    @Excel(name = "配件编号")
    private String accessoryCode;

    /**
     * 配件名称
     */
    @Excel(name = "配件名称")
    private String accessoryName;

    /**
     * 配件类型
     */
    @Excel(name = "配件类型")
    private String accessoryType;

    /**
     * 商品规格
     */
    @Excel(name = "商品规格")
    private String accessorySpecifications;

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
     * 库存数量
     */
    @Excel(name = "库存数量")
    private String inventoryQty;

    /**
     * 状态（0正常 1停用）
     */
    @Excel(name = "状态", readConverterExp = "0=正常,1=停用")
    private String status;

    /**
     * 备注
     */
    @Excel(name = "备注")
    private String notes;

    /**
     * 配件类型名称
     */
    private String productTypeName;

    public String getAccessoryId() {
        return accessoryId;
    }

    public void setAccessoryId(String accessoryId) {
        this.accessoryId = accessoryId;
    }

    public String getAccessoryCode() {
        return accessoryCode;
    }

    public void setAccessoryCode(String accessoryCode) {
        this.accessoryCode = accessoryCode;
    }

    public String getAccessoryName() {
        return accessoryName;
    }

    public void setAccessoryName(String accessoryName) {
        this.accessoryName = accessoryName;
    }

    public String getAccessoryType() {
        return accessoryType;
    }

    public void setAccessoryType(String accessoryType) {
        this.accessoryType = accessoryType;
    }

    public String getAccessorySpecifications() {
        return accessorySpecifications;
    }

    public void setAccessorySpecifications(String accessorySpecifications) {
        this.accessorySpecifications = accessorySpecifications;
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

    public String getProductTypeName() {
        return productTypeName;
    }

    public void setProductTypeName(String productTypeName) {
        this.productTypeName = productTypeName;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
                .append("accessoryId", getAccessoryId())
                .append("accessoryCode", getAccessoryCode())
                .append("accessoryName", getAccessoryName())
                .append("accessoryType", getAccessoryType())
                .append("accessorySpecifications", getAccessorySpecifications())
                .append("measureUnit", getMeasureUnit())
                .append("producer", getProducer())
                .append("inventoryQty", getInventoryQty())
                .append("notes", getNotes())
                .append("status", getStatus())
                .append("productTypeName", getProductTypeName())
                .append("createBy", getCreateBy())
                .append("createTime", getCreateTime())
                .append("updateBy", getUpdateBy())
                .append("updateTime", getUpdateTime())
                .toString();
    }
}
