package com.ruoyi.system.mapper;

import com.ruoyi.common.core.domain.entity.DetailOrderForm;
import com.ruoyi.common.core.domain.entity.HeadOrderForm;

import java.util.List;

/**
 * @author KrityCat
 */
public interface HeadOrderFormMapper {
    /**
     * 库存头单查询
     */
    List<HeadOrderForm> headOrderFormQuery(HeadOrderForm bo);

    /**
     * 单据编号查询
     */
    HeadOrderForm selectHeadOrderFormById(String systematicOrderForm);

    /**
     * 单据编号查询
     */
    List<HeadOrderForm> selectHeadOrderFormByCount(HeadOrderForm bo);

    /**
     * 单据头表新增
     */
    int addHeadOrderForm(HeadOrderForm bo);

    /**
     * 单据头表修改
     */
    int updateHeadOrderForm(HeadOrderForm bo);

    /**
     * 单据头表删除
     */
    int delHeadOrderForm(List<DetailOrderForm> bo);

}
