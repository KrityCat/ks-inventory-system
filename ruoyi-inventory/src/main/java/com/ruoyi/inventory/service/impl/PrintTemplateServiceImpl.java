package com.ruoyi.inventory.service.impl;

import com.ruoyi.common.core.domain.entity.PrintTemplate;
import com.ruoyi.inventory.mapper.PrintTemplateMapper;
import com.ruoyi.inventory.service.IPrintTemplateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 打印模板Service业务层处理
 *
 * @author ruoyi
 * @date 2023-10-27
 */
@Service
public class PrintTemplateServiceImpl implements IPrintTemplateService {
    @Autowired
    private PrintTemplateMapper printTemplateMapper;

    /**
     * 查询打印模板
     *
     * @param templateId 打印模板主键
     * @return 打印模板
     */
    @Override
    public PrintTemplate selectPrintTemplateByTemplateId(Long templateId) {
        return printTemplateMapper.selectPrintTemplateByTemplateId(templateId);
    }

    /**
     * 查询打印模板列表
     *
     * @param printTemplate 打印模板
     * @return 打印模板
     */
    @Override
    public List<PrintTemplate> selectPrintTemplateList(PrintTemplate printTemplate) {
        return printTemplateMapper.selectPrintTemplateList(printTemplate);
    }

    /**
     * 新增打印模板
     *
     * @param printTemplate 打印模板
     * @return 结果
     */
    @Override
    public int insertPrintTemplate(PrintTemplate printTemplate) {
        return printTemplateMapper.insertPrintTemplate(printTemplate);
    }

    /**
     * 修改打印模板
     *
     * @param printTemplate 打印模板
     * @return 结果
     */
    @Override
    public int updatePrintTemplate(PrintTemplate printTemplate) {
        return printTemplateMapper.updatePrintTemplate(printTemplate);
    }

    /**
     * 删除打印模板信息
     *
     * @param templateId 打印模板主键
     * @return 结果
     */
    @Override
    public int deletePrintTemplateByTemplateId(Long templateId) {
        return printTemplateMapper.deletePrintTemplateByTemplateId(templateId);
    }
}