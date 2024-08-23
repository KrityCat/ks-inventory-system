package com.ruoyi.system.mapper;

import com.ruoyi.common.core.domain.entity.DetailService;
import com.ruoyi.common.core.domain.entity.HeadService;

import java.util.List;

public interface HeadServiceMapper {
    /**
     * 库存头单查询
     */
    List<HeadService> headServiceQuery(HeadService bo);

    /**
     * 单据编号查询
     */
    HeadService selectHeadServiceById(String systematicService);

    /**
     * 单据编号查询
     */
    List<HeadService> selectHeadServiceByCount(HeadService bo);

    /**
     * 单据头表新增
     */
    int addHeadService(HeadService bo);

    /**
     * 单据头表修改
     */
    int updateHeadService(HeadService bo);

    /**
     * 单据头表删除
     */
    int delHeadService(List<DetailService> bo);

}
