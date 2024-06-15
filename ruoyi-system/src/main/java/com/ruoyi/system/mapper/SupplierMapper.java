package com.ruoyi.system.mapper;

import com.ruoyi.common.core.domain.entity.Supplier;

import java.util.List;

public interface SupplierMapper {
    /**
     * 仓库资料查询
     */
    List<Supplier> SupplierQuery(Supplier bo);

    /**
     * 仓库详情查询
     */
    Supplier selectSupplierById(Long supplierId);

    /**
     * 仓库名称查询
     */
    Supplier selectSupplierBySupplierName(String supplierName);

    /**
     * 仓库资料新增
     */
    int insertSupplier(Supplier bo);

    /**
     * 仓库资料修改
     */
    int updateSupplier(Supplier bo);

    /**
     * 仓库资料删除
     */
    int deleteSupplierByIds(Long[] supplierId);


}
