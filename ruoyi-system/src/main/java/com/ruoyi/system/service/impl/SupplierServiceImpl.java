package com.ruoyi.system.service.impl;

import com.ruoyi.common.core.domain.entity.Supplier;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.bean.BeanValidators;
import com.ruoyi.system.mapper.SupplierMapper;
import com.ruoyi.system.service.SupplierService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.validation.Validator;
import java.util.List;

/**
 * 供应商 业务层处理
 *
 * @author KrityCat
 */
@Service
public class SupplierServiceImpl implements SupplierService {

    private static final Logger log = LoggerFactory.getLogger(SupplierServiceImpl.class);
    @Autowired
    protected Validator validator;
    @Autowired
    private SupplierMapper SlMapper;

    /**
     * 供应商查询
     */
    @Override
    public List<Supplier> SupplierQuery(Supplier bo) {
        return SlMapper.SupplierQuery(bo);
    }

    /**
     * 通过供应商ID查询供应商
     *
     * @param supplierId 供应商ID
     * @return 供应商对象信息
     */
    @Override
    public Supplier selectSupplierById(Long supplierId) {
        return SlMapper.selectSupplierById(supplierId);
    }

    /**
     * 新增保存供应商信息
     *
     * @param bo 供应商信息
     * @return 结果
     */
    @Override
    @Transactional
    public int insertSupplier(Supplier bo) {
        return SlMapper.insertSupplier(bo);
    }

    /**
     * 修改保存供应商信息
     *
     * @param bo 供应商信息
     * @return 结果
     */
    @Override
    @Transactional
    public int updateSupplier(Supplier bo) {
        return SlMapper.updateSupplier(bo);
    }

    /**
     * 删除供应商信息
     *
     * @param supplierId 需要删除的供应商ID
     * @return 结果
     */
    @Override
    @Transactional
    public int deleteSupplierByIds(Long[] supplierId) {
//        for (Long userId : userIds)
//        {
//            checkUserAllowed(new SysUser(userId));
//            checkUserDataScope(userId);
//        }
        return SlMapper.deleteSupplierByIds(supplierId);
    }

    /**
     * 导入供应商数据
     *
     * @param SupplierList    供应商数据列表
     * @param isUpdateSupport 是否更新支持，如果已存在，则进行更新数据
     * @param operName        操作用户
     * @return 结果
     */
    @Override
    public String importSupplier(List<Supplier> SupplierList, Boolean isUpdateSupport, String operName) {
        if (StringUtils.isNull(SupplierList) || SupplierList.isEmpty()) {
            throw new ServiceException("导入供应商数据不能为空！");
        }
        int successNum = 0;
        int failureNum = 0;
        StringBuilder successMsg = new StringBuilder();
        StringBuilder failureMsg = new StringBuilder();
        for (Supplier bo : SupplierList) {
            try {
                // 验证是否存在这个供应商
                Supplier s = SlMapper.selectSupplierBySupplierName(bo.getSupplierName());
                if (StringUtils.isBlank(bo.getSupplierCode()) || StringUtils.isBlank(bo.getSupplierName())) {
                    failureNum++;
                    throw new ServiceException("供应商编号与名称不能为空！");
                } else if (StringUtils.isNull(s)) {
                    BeanValidators.validateWithException(validator, bo);
                    bo.setSupplierName(bo.getSupplierName());
                    bo.setCreateBy(operName);
                    SlMapper.insertSupplier(bo);
                    successNum++;
                    successMsg.append("<br/>" + successNum + "、供应商 " + bo.getSupplierName() + " 导入成功");
                } else if (isUpdateSupport) {
                    BeanValidators.validateWithException(validator, bo);
                    bo.setSupplierId(s.getSupplierId());
                    bo.setUpdateBy(operName);
                    SlMapper.updateSupplier(bo);
                    successNum++;
                    successMsg.append("<br/>" + successNum + "、供应商 " + bo.getSupplierName() + " 更新成功");
                } else {
                    failureNum++;
                    failureMsg.append("<br/>" + failureNum + "、供应商 " + bo.getSupplierName() + " 已存在");
                }
            } catch (Exception e) {
                failureNum++;
                String msg = "<br/>" + failureNum + "、供应商 " + bo.getSupplierName() + " 导入失败：";
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
