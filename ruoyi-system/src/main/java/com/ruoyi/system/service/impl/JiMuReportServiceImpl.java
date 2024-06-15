package com.ruoyi.system.service.impl;

import com.ruoyi.common.core.domain.entity.JiMuReport;
import com.ruoyi.system.mapper.JiMuReportMapper;
import com.ruoyi.system.service.JiMuReportService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 在线excel设计器 业务层处理
 *
 * @author KrityCat
 */
@Service
public class JiMuReportServiceImpl implements JiMuReportService {

    private static final Logger log = LoggerFactory.getLogger(JiMuReportServiceImpl.class);

    @Autowired
    private JiMuReportMapper JiMuReportMapper;

    /**
     * 在线excel设计器查询
     */
    @Override
    public List<JiMuReport> JiMuReportQuery(JiMuReport bo) {
        return JiMuReportMapper.JiMuReportQuery(bo);
    }

    /**
     * 在线excel设计器编号查询
     *
     * @param id ID
     * @return 在线excel设计器对象信息
     */
    @Override
    public JiMuReport selectJiMuReportById(String id) {
        return JiMuReportMapper.selectJiMuReportById(id);
    }

}
