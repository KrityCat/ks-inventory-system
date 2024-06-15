package com.ruoyi.common.core.domain.entity;


import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;
import lombok.Data;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * 仓库对象 Warehouse
 *
 * @author KrityCat
 */
@Data
public class Warehouse extends BaseEntity {

    @Excel(name = "仓库编号")
    private Long warehouseId;

    @Excel(name = "仓库名称")
    private String warehouseName;

    @Excel(name = "负责人")
    private String warehouseDirector;

    @Excel(name = "联系电话")
    private String warehouseTelephone;

    @Excel(name = "仓库地址")
    private String warehouseAddress;

    @Excel(name = "仓库状态", readConverterExp = "0=正常,1=停用")
    private Integer warehouseValid;

    @Excel(name = "备注")
    private String warehouseNotes;

    private Long warehousingId;

    private String warehousingName;

    private Long retrievalId;

    private String retrievalName;

    public Long getWarehouseId() {
        return warehouseId;
    }

    public void setWarehouseId(Long warehouseId) {
        this.warehouseId = warehouseId;
    }

    public String getWarehouseName() {
        return warehouseName;
    }

    public void setWarehouseName(String warehouseName) {
        this.warehouseName = warehouseName;
    }

    public String getWarehouseDirector() {
        return warehouseDirector;
    }

    public void setWarehouseDirector(String warehouseDirector) {
        this.warehouseDirector = warehouseDirector;
    }

    public String getWarehouseTelephone() {
        return warehouseTelephone;
    }

    public void setWarehouseTelephone(String warehouseTelephone) {
        this.warehouseTelephone = warehouseTelephone;
    }

    public String getWarehouseAddress() {
        return warehouseAddress;
    }

    public void setWarehouseAddress(String warehouseAddress) {
        this.warehouseAddress = warehouseAddress;
    }

    public Integer getWarehouseValid() {
        return warehouseValid;
    }

    public void setWarehouseValid(Integer warehouseValid) {
        this.warehouseValid = warehouseValid;
    }

    public String getWarehouseNotes() {
        return warehouseNotes;
    }

    public void setWarehouseNotes(String warehouseNotes) {
        this.warehouseNotes = warehouseNotes;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
                .append("warehouseId", getWarehouseId())
                .append("warehouseName", getWarehouseName())
                .append("warehouseDirector", getWarehouseDirector())
                .append("warehouseTelephone", getWarehouseTelephone())
                .append("warehouseAddress", getWarehouseAddress())
                .append("warehouseValid", getWarehouseValid())
                .append("warehouseNotes", getWarehouseNotes())
                .append("createBy", getCreateBy())
                .append("createTime", getCreateTime())
                .append("updateBy", getUpdateBy())
                .append("updateTime", getUpdateTime())
                .toString();
    }
}
