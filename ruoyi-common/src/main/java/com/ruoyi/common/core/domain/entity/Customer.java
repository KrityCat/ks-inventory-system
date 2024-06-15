package com.ruoyi.common.core.domain.entity;


import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;
import lombok.Data;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * 客户对象 Customer
 *
 * @author KrityCat
 */
@Data
public class Customer extends BaseEntity {

    private static final long serialVersionUID = 1L;

    private Long customerId;

    @Excel(name = "客户编号")
    private String customerCode;

    @Excel(name = "客户名称")
    private String customerName;

    @Excel(name = "业务员")
    private String customerSalesPerson;

    @Excel(name = "联系人")
    private String customerContacts;

    @Excel(name = "联系电话")
    private String customerContactNumber;

    @Excel(name = "单位地址")
    private String customerWorkAddress;

    @Excel(name = "邮编")
    private String customerPostalCode;

    @Excel(name = "期初欠款")
    private String customerOpeningDebt;

    @Excel(name = "开户银行")
    private String customerOpeningBank;

    @Excel(name = "银行账号")
    private String customerAccountNumber;

    @Excel(name = "纳税号")
    private String customerTaxId;

    @Excel(name = "公司主页")
    private String customerCompanyHomepage;

    @Excel(name = "电子邮箱")
    private String customerEmail;

    @Excel(name = "公司法人")
    private String customerLegalPerson;

    @Excel(name = "客户状态", readConverterExp = "0=正常,1=停用")
    private Integer status;

    @Excel(name = "备注")
    private String remarks;

    public Long getCustomerId() {
        return customerId;
    }

    public void setCustomerId(Long customerId) {
        this.customerId = customerId;
    }

    public String getCustomerCode() {
        return customerCode;
    }

    public void setCustomerCode(String customerCode) {
        this.customerCode = customerCode;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getCustomerSalesPerson() {
        return customerSalesPerson;
    }

    public void setCustomerSalesPerson(String customerSalesPerson) {
        this.customerSalesPerson = customerSalesPerson;
    }

    public String getCustomerContacts() {
        return customerContacts;
    }

    public void setCustomerContacts(String customerContacts) {
        this.customerContacts = customerContacts;
    }

    public String getCustomerContactNumber() {
        return customerContactNumber;
    }

    public void setCustomerContactNumber(String customerContactNumber) {
        this.customerContactNumber = customerContactNumber;
    }

    public String getCustomerWorkAddress() {
        return customerWorkAddress;
    }

    public void setCustomerWorkAddress(String customerWorkAddress) {
        this.customerWorkAddress = customerWorkAddress;
    }

    public String getCustomerPostalCode() {
        return customerPostalCode;
    }

    public void setCustomerPostalCode(String customerPostalCode) {
        this.customerPostalCode = customerPostalCode;
    }

    public String getCustomerOpeningDebt() {
        return customerOpeningDebt;
    }

    public void setCustomerOpeningDebt(String customerOpeningDebt) {
        this.customerOpeningDebt = customerOpeningDebt;
    }

    public String getCustomerOpeningBank() {
        return customerOpeningBank;
    }

    public void setCustomerOpeningBank(String customerOpeningBank) {
        this.customerOpeningBank = customerOpeningBank;
    }

    public String getCustomerAccountNumber() {
        return customerAccountNumber;
    }

    public void setCustomerAccountNumber(String customerAccountNumber) {
        this.customerAccountNumber = customerAccountNumber;
    }

    public String getCustomerTaxId() {
        return customerTaxId;
    }

    public void setCustomerTaxId(String customerTaxId) {
        this.customerTaxId = customerTaxId;
    }

    public String getCustomerCompanyHomepage() {
        return customerCompanyHomepage;
    }

    public void setCustomerCompanyHomepage(String customerCompanyHomepage) {
        this.customerCompanyHomepage = customerCompanyHomepage;
    }

    public String getCustomerEmail() {
        return customerEmail;
    }

    public void setCustomerEmail(String customerEmail) {
        this.customerEmail = customerEmail;
    }

    public String getCustomerLegalPerson() {
        return customerLegalPerson;
    }

    public void setCustomerLegalPerson(String customerLegalPerson) {
        this.customerLegalPerson = customerLegalPerson;
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
                .append("customerId", getCustomerId())
                .append("customerCode", getCustomerCode())
                .append("customerName", getCustomerName())
                .append("customerSalesPerson", getCustomerSalesPerson())
                .append("customerContacts", getCustomerContacts())
                .append("customerContactNumber", getCustomerContactNumber())
                .append("customerWorkAddress", getCustomerWorkAddress())
                .append("customerPostalCode", getCustomerPostalCode())
                .append("customerOpeningDebt", getCustomerOpeningDebt())
                .append("customerOpeningBank", getCustomerOpeningBank())
                .append("customerAccountNumber", getCustomerAccountNumber())
                .append("customerTaxId", getCustomerTaxId())
                .append("customerCompanyHomepage", getCustomerCompanyHomepage())
                .append("customerEmail", getCustomerEmail())
                .append("customerLegalPerson", getCustomerLegalPerson())
                .append("status", getStatus())
                .append("remarks", getRemarks())
                .append("createBy", getCreateBy())
                .append("createTime", getCreateTime())
                .append("updateBy", getUpdateBy())
                .append("updateTime", getUpdateTime())
                .toString();
    }
}
