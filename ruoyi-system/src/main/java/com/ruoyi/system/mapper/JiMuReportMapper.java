package com.ruoyi.system.mapper;

import com.ruoyi.common.core.domain.entity.JiMuReport;

import java.util.List;

public interface JiMuReportMapper {
    /**
     * 在线excel设计器查询
     */
    List<JiMuReport> JiMuReportQuery(JiMuReport bo);

    /**
     * 在线excel设计器编号查询
     */
    JiMuReport selectJiMuReportById(String id);

}
