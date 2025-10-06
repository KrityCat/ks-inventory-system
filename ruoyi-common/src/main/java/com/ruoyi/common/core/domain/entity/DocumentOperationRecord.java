package com.ruoyi.common.core.domain.entity;

import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * 单据操作记录对象 document_operation_record
 *
 * @author KrityCat
 * @date 2024-11-16
 */
public class DocumentOperationRecord extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /**
     * 操作记录ID
     */
    private Long logId;

    /**
     * 系统ID
     */
    @Excel(name = "系统ID")
    private Long systematicId;

    /**
     * 系统单号
     */
    @Excel(name = "系统单号")
    private String systematicReceipt;

    /**
     * 操作步骤
     */
    @Excel(name = "操作步骤")
    private String operate;

    public Long getLogId() {
        return logId;
    }

    public void setLogId(Long logId) {
        this.logId = logId;
    }

    public Long getSystematicId() {
        return systematicId;
    }

    public void setSystematicId(Long systematicId) {
        this.systematicId = systematicId;
    }

    public String getSystematicReceipt() {
        return systematicReceipt;
    }

    public void setSystematicReceipt(String systematicReceipt) {
        this.systematicReceipt = systematicReceipt;
    }

    public String getOperate() {
        return operate;
    }

    public void setOperate(String operate) {
        this.operate = operate;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
                .append("logId", getLogId())
                .append("systematicId", getSystematicId())
                .append("systematicReceipt", getSystematicReceipt())
                .append("operate", getOperate())
                .append("updateBy", getUpdateBy())
                .append("updateTime", getUpdateTime())
                .toString();
    }
}
