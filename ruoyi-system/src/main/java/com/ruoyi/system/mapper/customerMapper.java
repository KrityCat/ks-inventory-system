package com.ruoyi.system.mapper;

import com.ruoyi.common.core.domain.entity.Customer;

import java.util.List;

public interface customerMapper {
    /**
     * 客户资料查询
     */
    List<Customer> CustomerQuery(Customer bo);

    /**
     * 客户详情查询
     */
    Customer selectCustomerById(Long customerId);

    /**
     * 客户名称查询
     */
    Customer selectCustomerByCustomerName(String customerName);

    /**
     * 客户资料新增
     */
    int insertCustomer(Customer bo);

    /**
     * 客户资料修改
     */
    int updateCustomer(Customer bo);

    /**
     * 客户资料删除
     */
    int deleteCustomerByIds(Long[] customerId);


}
