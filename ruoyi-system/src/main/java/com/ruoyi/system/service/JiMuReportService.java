package com.ruoyi.system.service;

import com.ruoyi.common.core.domain.entity.JiMuReport;

import java.util.List;

/**
 * 在线excel设计器 业务层
 *
 * @author KrityCat
 */
public interface JiMuReportService {
    /**
     * 在线excel设计器查询
     */
    List<JiMuReport> JiMuReportQuery(JiMuReport bo);

    /**
     * 在线excel设计器编号查询
     *
     * @param id ID
     * @return 在线excel设计器对象信息
     */
    JiMuReport selectJiMuReportById(String id);


}
