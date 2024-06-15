package com.ruoyi.system.service;

import com.ruoyi.common.core.domain.entity.Customer;

import java.util.List;

/**
 * 客户 业务层
 *
 * @author KrityCat
 */
public interface CustomerService {
    /**
     * 客户查询
     */
    List<Customer> CustomerQuery(Customer bo);

    /**
     * 通过客户ID查询客户
     *
     * @param customerId 客户ID
     * @return 客户对象信息
     */
    Customer selectCustomerById(Long customerId);

    /**
     * 新增保存客户信息
     *
     * @param bo 客户信息
     * @return 结果
     */
    int insertCustomer(Customer bo);

    /**
     * 修改保存客户信息
     *
     * @param bo 客户信息
     * @return 结果
     */
    int updateCustomer(Customer bo);

    /**
     * 删除客户信息
     *
     * @param customerId 需要删除的客户ID
     * @return 结果
     */
    int deleteCustomerByIds(Long[] customerId);

    /**
     * 导入客户数据
     *
     * @param CustomerList    客户数据列表
     * @param isUpdateSupport 是否更新支持，如果已存在，则进行更新数据
     * @param operName        操作用户
     * @return 结果
     */
    String importCustomer(List<Customer> CustomerList, Boolean isUpdateSupport, String operName);

}
