package com.ruoyi.common.core.domain.entity;

import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.util.ArrayList;
import java.util.List;

/**
 * 商品类型对象 commodity_type
 *
 * @author KrityCat
 */
public class CommodityType extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /**
     * 商品类型id
     */
    private Long commodityTypeId;

    /**
     * 父货品类型ID
     */
    private Long parentId;

    /**
     * 祖级列表
     */
    private String ancestors;

    /**
     * 商品类型名称
     */
    @Excel(name = "商品类型名称")
    private String commodityTypeName;

    /**
     * 显示顺序
     */
    private Integer orderNum;

    /**
     * 商品类型状态（0正常 1停用）
     */
    @Excel(name = "商品类型状态", readConverterExp = "0=正常,1=停用")
    private String status;

    /**
     * 删除标志（0代表存在 2代表删除）
     */
    private String delFlag;

    /**
     * 父部门名称
     */
    private String parentName;

    /**
     * 子部门
     */
    private List<CommodityType> children = new ArrayList<CommodityType>();

    public Long getCommodityTypeId() {
        return commodityTypeId;
    }

    public void setCommodityTypeId(Long commodityTypeId) {
        this.commodityTypeId = commodityTypeId;
    }

    public Long getParentId() {
        return parentId;
    }

    public void setParentId(Long parentId) {
        this.parentId = parentId;
    }

    public String getAncestors() {
        return ancestors;
    }

    public void setAncestors(String ancestors) {
        this.ancestors = ancestors;
    }

    @NotBlank(message = "货品类型名称不能为空")
    @Size(min = 0, max = 30, message = "货品类型名称长度不能超过30个字符")
    public String getCommodityTypeName() {
        return commodityTypeName;
    }

    public void setCommodityTypeName(String commodityTypeName) {
        this.commodityTypeName = commodityTypeName;
    }

    @NotNull(message = "显示顺序不能为空")
    public Integer getOrderNum() {
        return orderNum;
    }

    public void setOrderNum(Integer orderNum) {
        this.orderNum = orderNum;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getDelFlag() {
        return delFlag;
    }

    public void setDelFlag(String delFlag) {
        this.delFlag = delFlag;
    }

    public String getParentName() {
        return parentName;
    }

    public void setParentName(String parentName) {
        this.parentName = parentName;
    }

    public List<CommodityType> getChildren() {
        return children;
    }

    public void setChildren(List<CommodityType> children) {
        this.children = children;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
                .append("commodityTypeId", getCommodityTypeId())
                .append("parentId", getParentId())
                .append("ancestors", getAncestors())
                .append("commodityTypeName", getCommodityTypeName())
                .append("orderNum", getOrderNum())
                .append("status", getStatus())
                .append("delFlag", getDelFlag())
                .append("createBy", getCreateBy())
                .append("createTime", getCreateTime())
                .append("updateBy", getUpdateBy())
                .append("updateTime", getUpdateTime())
                .toString();
    }
}
