package com.ruoyi.system.mapper;

import com.ruoyi.common.core.domain.entity.DetailOrderForm;

import java.util.List;

/**
 * @author KrityCat
 */
public interface DetailOrderFormMapper {

    /**
     * 库存明细表查询
     */
    List<DetailOrderForm> selectDetailOrderFormQuery(DetailOrderForm bo);

    /**
     * 单据明细表新增
     */
    int addDetailOrderForm(List<DetailOrderForm> bo);

    /**
     * 单据明细表导入新增
     */
    int addImportDetailOrderForm(DetailOrderForm bo);

    /**
     * 单据明细表修改
     */
    int updateDetailOrderForm(List<DetailOrderForm> bo);

    /**
     * 单据明细表导入修改
     */
    int updateImportDetailOrderForm(DetailOrderForm bo);

    /**
     * 单据明细表删除
     */
    int delDetailOrderForm(List<DetailOrderForm> bo);

}
