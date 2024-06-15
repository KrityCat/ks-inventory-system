package com.ruoyi.common.core.domain.entity;


import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * 供应商对象 Supplier
 *
 * @author KrityCat
 */
public class Supplier extends BaseEntity {

    private static final long serialVersionUID = 1L;

    private Long supplierId;

    @Excel(name = "供应商编号")
    private String supplierCode;

    @Excel(name = "供应商名称")
    private String supplierName;

    @Excel(name = "业务员")
    private String supplierSalesPerson;

    @Excel(name = "联系人")
    private String supplierContacts;

    @Excel(name = "联系电话")
    private String supplierContactNumber;

    @Excel(name = "单位地址")
    private String supplierWorkAddress;

    @Excel(name = "邮编")
    private String supplierPostalCode;

    @Excel(name = "期初欠款")
    private String supplierOpeningDebt;

    @Excel(name = "开户银行")
    private String supplierOpeningBank;

    @Excel(name = "银行账号")
    private String supplierAccountNumber;

    @Excel(name = "纳税号")
    private String supplierTaxId;

    @Excel(name = "公司主页")
    private String supplierCompanyHomepage;

    @Excel(name = "电子邮箱")
    private String supplierEmail;

    @Excel(name = "公司法人")
    private String supplierLegalPerson;

    @Excel(name = "供应商状态", readConverterExp = "0=正常,1=停用")
    private Integer status;

    @Excel(name = "备注")
    private String remarks;

    public Long getSupplierId() {
        return supplierId;
    }

    public void setSupplierId(Long supplierId) {
        this.supplierId = supplierId;
    }

    public String getSupplierCode() {
        return supplierCode;
    }

    public void setSupplierCode(String supplierCode) {
        this.supplierCode = supplierCode;
    }

    public String getSupplierName() {
        return supplierName;
    }

    public void setSupplierName(String supplierName) {
        this.supplierName = supplierName;
    }

    public String getSupplierSalesPerson() {
        return supplierSalesPerson;
    }

    public void setSupplierSalesPerson(String supplierSalesPerson) {
        this.supplierSalesPerson = supplierSalesPerson;
    }

    public String getSupplierContacts() {
        return supplierContacts;
    }

    public void setSupplierContacts(String supplierContacts) {
        this.supplierContacts = supplierContacts;
    }

    public String getSupplierContactNumber() {
        return supplierContactNumber;
    }

    public void setSupplierContactNumber(String supplierContactNumber) {
        this.supplierContactNumber = supplierContactNumber;
    }

    public String getSupplierWorkAddress() {
        return supplierWorkAddress;
    }

    public void setSupplierWorkAddress(String supplierWorkAddress) {
        this.supplierWorkAddress = supplierWorkAddress;
    }

    public String getSupplierPostalCode() {
        return supplierPostalCode;
    }

    public void setSupplierPostalCode(String supplierPostalCode) {
        this.supplierPostalCode = supplierPostalCode;
    }

    public String getSupplierOpeningDebt() {
        return supplierOpeningDebt;
    }

    public void setSupplierOpeningDebt(String supplierOpeningDebt) {
        this.supplierOpeningDebt = supplierOpeningDebt;
    }

    public String getSupplierOpeningBank() {
        return supplierOpeningBank;
    }

    public void setSupplierOpeningBank(String supplierOpeningBank) {
        this.supplierOpeningBank = supplierOpeningBank;
    }

    public String getSupplierAccountNumber() {
        return supplierAccountNumber;
    }

    public void setSupplierAccountNumber(String supplierAccountNumber) {
        this.supplierAccountNumber = supplierAccountNumber;
    }

    public String getSupplierTaxId() {
        return supplierTaxId;
    }

    public void setSupplierTaxId(String supplierTaxId) {
        this.supplierTaxId = supplierTaxId;
    }

    public String getSupplierCompanyHomepage() {
        return supplierCompanyHomepage;
    }

    public void setSupplierCompanyHomepage(String supplierCompanyHomepage) {
        this.supplierCompanyHomepage = supplierCompanyHomepage;
    }

    public String getSupplierEmail() {
        return supplierEmail;
    }

    public void setSupplierEmail(String supplierEmail) {
        this.supplierEmail = supplierEmail;
    }

    public String getSupplierLegalPerson() {
        return supplierLegalPerson;
    }

    public void setSupplierLegalPerson(String supplierLegalPerson) {
        this.supplierLegalPerson = supplierLegalPerson;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
                .append("supplierId", getSupplierId())
                .append("supplierCode", getSupplierCode())
                .append("supplierName", getSupplierName())
                .append("supplierSalesPerson", getSupplierSalesPerson())
                .append("supplierContacts", getSupplierContacts())
                .append("supplierContactNumber", getSupplierContactNumber())
                .append("supplierWorkAddress", getSupplierWorkAddress())
                .append("supplierPostalCode", getSupplierPostalCode())
                .append("supplierOpeningDebt", getSupplierOpeningDebt())
                .append("supplierOpeningBank", getSupplierOpeningBank())
                .append("supplierAccountNumber", getSupplierAccountNumber())
                .append("supplierTaxId", getSupplierTaxId())
                .append("supplierCompanyHomepage", getSupplierCompanyHomepage())
                .append("supplierEmail", getSupplierEmail())
                .append("supplierLegalPerson", getSupplierLegalPerson())
                .append("status", getStatus())
                .append("remarks", getRemarks())
                .append("createBy", getCreateBy())
                .append("createTime", getCreateTime())
                .append("updateBy", getUpdateBy())
                .append("updateTime", getUpdateTime())
                .toString();
    }
}
