package com.ruoyi.system.mapper;

import com.ruoyi.common.core.domain.entity.DetailService;

import java.util.List;

public interface DetailServiceMapper {

    /**
     * 库存明细表查询
     */
    List<DetailService> selectDetailServiceQuery(DetailService bo);

    /**
     * 单据明细表新增
     */
    int addDetailService(List<DetailService> bo);

    /**
     * 单据明细表导入新增
     */
    int addImportDetailService(DetailService bo);

    /**
     * 单据明细表修改
     */
    int updateDetailService(List<DetailService> bo);

    /**
     * 单据明细表导入修改
     */
    int updateImportDetailService(DetailService bo);

    /**
     * 单据明细表删除
     */
    int delDetailService(List<DetailService> bo);

}
