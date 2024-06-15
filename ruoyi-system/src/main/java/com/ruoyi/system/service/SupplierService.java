package com.ruoyi.system.service;

import com.ruoyi.common.core.domain.entity.Supplier;

import java.util.List;

/**
 * 供应商 业务层
 *
 * @author KrityCat
 */
public interface SupplierService {
    /**
     * 供应商查询
     */
    List<Supplier> SupplierQuery(Supplier bo);

    /**
     * 通过供应商ID查询供应商
     *
     * @param supplierId 供应商ID
     * @return 供应商对象信息
     */
    Supplier selectSupplierById(Long supplierId);

    /**
     * 新增保存供应商信息
     *
     * @param bo 供应商信息
     * @return 结果
     */
    int insertSupplier(Supplier bo);

    /**
     * 修改保存供应商信息
     *
     * @param bo 供应商信息
     * @return 结果
     */
    int updateSupplier(Supplier bo);

    /**
     * 删除供应商信息
     *
     * @param supplierId 需要删除的供应商ID
     * @return 结果
     */
    int deleteSupplierByIds(Long[] supplierId);

    /**
     * 导入供应商数据
     *
     * @param SupplierList    供应商数据列表
     * @param isUpdateSupport 是否更新支持，如果已存在，则进行更新数据
     * @param operName        操作用户
     * @return 结果
     */
    String importSupplier(List<Supplier> SupplierList, Boolean isUpdateSupport, String operName);

}
