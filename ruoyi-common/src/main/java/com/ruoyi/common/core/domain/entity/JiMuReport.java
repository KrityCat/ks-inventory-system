package com.ruoyi.common.core.domain.entity;


import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;
import lombok.Data;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * 在线excel设计器对象 JiMuReport
 *
 * @author KrityCat
 */
@Data
public class JiMuReport extends BaseEntity {

    private static final long serialVersionUID = 1L;

    @Excel(name = "主键")
    private String id;

    @Excel(name = "编码")
    private String code;

    @Excel(name = "名称")
    private String name;

    @Excel(name = "说明")
    private String note;

    @Excel(name = "状态")
    private String status;

    @Excel(name = "类型")
    private String type;

    @Excel(name = "json字符串")
    private String jsonStr;

    @Excel(name = "请求地址")
    private String apiUrl;

    @Excel(name = "缩略图")
    private String thumb;

    @Excel(name = "删除标识", readConverterExp = "0=正常,1=已删除")
    private String delFlag;

    @Excel(name = "请求方法", readConverterExp = "0=get,1=post")
    private String apiMethod;

    @Excel(name = "请求编码")
    private String apiCode;

    @Excel(name = "是否是模板", readConverterExp = "0=是,1=不是")
    private String template;

    @Excel(name = "浏览次数")
    private String viewCount;

    @Excel(name = "css增强")
    private String cssStr;

    @Excel(name = "js增强")
    private Integer jsStr;

    @Excel(name = "py增强")
    private String pyStr;

    @Excel(name = "多租户标识")
    private String tenantId;


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getJsonStr() {
        return jsonStr;
    }

    public void setJsonStr(String jsonStr) {
        this.jsonStr = jsonStr;
    }

    public String getApiUrl() {
        return apiUrl;
    }

    public void setApiUrl(String apiUrl) {
        this.apiUrl = apiUrl;
    }

    public String getThumb() {
        return thumb;
    }

    public void setThumb(String thumb) {
        this.thumb = thumb;
    }

    public String getDelFlag() {
        return delFlag;
    }

    public void setDelFlag(String delFlag) {
        this.delFlag = delFlag;
    }

    public String getApiMethod() {
        return apiMethod;
    }

    public void setApiMethod(String apiMethod) {
        this.apiMethod = apiMethod;
    }

    public String getApiCode() {
        return apiCode;
    }

    public void setApiCode(String apiCode) {
        this.apiCode = apiCode;
    }

    public String getTemplate() {
        return template;
    }

    public void setTemplate(String template) {
        this.template = template;
    }

    public String getViewCount() {
        return viewCount;
    }

    public void setViewCount(String viewCount) {
        this.viewCount = viewCount;
    }

    public String getCssStr() {
        return cssStr;
    }

    public void setCssStr(String cssStr) {
        this.cssStr = cssStr;
    }

    public Integer getJsStr() {
        return jsStr;
    }

    public void setJsStr(Integer jsStr) {
        this.jsStr = jsStr;
    }

    public String getPyStr() {
        return pyStr;
    }

    public void setPyStr(String pyStr) {
        this.pyStr = pyStr;
    }

    public String getTenantId() {
        return tenantId;
    }

    public void setTenantId(String tenantId) {
        this.tenantId = tenantId;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
                .append("id", getId())
                .append("code", getCode())
                .append("name", getName())
                .append("note", getNote())
                .append("status", getStatus())
                .append("type", getType())
                .append("jsonStr", getJsonStr())
                .append("apiUrl", getApiUrl())
                .append("thumb", getThumb())
                .append("delFlag", getDelFlag())
                .append("apiMethod", getApiMethod())
                .append("apiCode", getApiCode())
                .append("template", getTemplate())
                .append("viewCount", getViewCount())
                .append("cssStr", getCssStr())
                .append("jsStr", getJsStr())
                .append("pyStr", getPyStr())
                .append("tenantId", getTenantId())
                .append("createBy", getCreateBy())
                .append("createTime", getCreateTime())
                .append("updateBy", getUpdateBy())
                .append("updateTime", getUpdateTime())
                .toString();
    }
}
