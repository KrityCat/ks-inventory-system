package com.ruoyi.system.service.impl;

import com.ruoyi.common.core.domain.entity.Customer;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.bean.BeanValidators;
import com.ruoyi.system.mapper.customerMapper;
import com.ruoyi.system.service.CustomerService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.validation.Validator;
import java.util.List;

/**
 * 客户 业务层处理
 *
 * @author KrityCat
 */
@Service
public class CustomerServiceImpl implements CustomerService {

    private static final Logger log = LoggerFactory.getLogger(CustomerServiceImpl.class);

    @Autowired
    protected Validator validator;

    @Autowired
    private customerMapper customerMapper;

    /**
     * 客户查询
     */
    @Override
    public List<Customer> CustomerQuery(Customer bo) {
        return customerMapper.CustomerQuery(bo);
    }

    /**
     * 通过客户ID查询客户
     *
     * @param customerId 客户ID
     * @return 客户对象信息
     */
    @Override
    public Customer selectCustomerById(Long customerId) {
        return customerMapper.selectCustomerById(customerId);
    }

    /**
     * 新增保存客户信息
     *
     * @param bo 客户信息
     * @return 结果
     */
    @Override
    @Transactional
    public int insertCustomer(Customer bo) {
        return customerMapper.insertCustomer(bo);
    }

    /**
     * 修改保存客户信息
     *
     * @param bo 客户信息
     * @return 结果
     */
    @Override
    @Transactional
    public int updateCustomer(Customer bo) {
        return customerMapper.updateCustomer(bo);
    }

    /**
     * 删除客户信息
     *
     * @param customerId 需要删除的客户ID
     * @return 结果
     */
    @Override
    @Transactional
    public int deleteCustomerByIds(Long[] customerId) {
        return customerMapper.deleteCustomerByIds(customerId);
    }

    /**
     * 导入客户数据
     *
     * @param CustomerList    客户数据列表
     * @param isUpdateSupport 是否更新支持，如果已存在，则进行更新数据
     * @param operName        操作用户
     * @return 结果
     */
    @Override
    public String importCustomer(List<Customer> CustomerList, Boolean isUpdateSupport, String operName) {
        if (StringUtils.isNull(CustomerList) || CustomerList.isEmpty()) {
            throw new ServiceException("导入客户数据不能为空！");
        }
        int successNum = 0;
        int failureNum = 0;
        StringBuilder successMsg = new StringBuilder();
        StringBuilder failureMsg = new StringBuilder();
        for (Customer bo : CustomerList) {
            try {
                // 验证是否存在这个客户
                Customer s = customerMapper.selectCustomerByCustomerName(bo.getCustomerName());
                if (StringUtils.isBlank(bo.getCustomerCode()) || StringUtils.isBlank(bo.getCustomerName())) {
                    failureNum++;
                    throw new ServiceException("客户编号与名称不能为空！");
                } else if (StringUtils.isNull(s)) {
                    BeanValidators.validateWithException(validator, bo);
                    bo.setCustomerName(bo.getCustomerName());
                    bo.setCreateBy(operName);
                    customerMapper.insertCustomer(bo);
                    successNum++;
                    successMsg.append("<br/>" + successNum + "、客户 " + bo.getCustomerName() + " 导入成功");
                } else if (isUpdateSupport) {
                    BeanValidators.validateWithException(validator, bo);
                    bo.setCustomerId(s.getCustomerId());
                    bo.setUpdateBy(operName);
                    customerMapper.updateCustomer(bo);
                    successNum++;
                    successMsg.append("<br/>" + successNum + "、客户 " + bo.getCustomerName() + " 更新成功");
                } else {
                    failureNum++;
                    failureMsg.append("<br/>" + failureNum + "、客户 " + bo.getCustomerName() + " 已存在");
                }
            } catch (Exception e) {
                failureNum++;
                String msg = "<br/>" + failureNum + "、客户 " + bo.getCustomerName() + " 导入失败：";
                failureMsg.append(msg + e.getMessage());
                log.error(msg, e);
            }
        }
        if (failureNum > 0) {
            failureMsg.insert(0, "很抱歉，导入失败！共 " + failureNum + " 条数据格式不正确，错误如下：");
            throw new ServiceException(failureMsg.toString());
        } else {
            successMsg.insert(0, "恭喜您，数据已全部导入成功！共 " + successNum + " 条，数据如下：");
        }
        return successMsg.toString();

    }
}
