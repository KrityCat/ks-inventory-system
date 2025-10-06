package com.ruoyi.inventory.mapper;

import com.ruoyi.common.core.domain.entity.PrintTemplate;

import java.util.List;

/**
 * 打印模板Mapper接口
 *
 * @author ruoyi
 * @date 2023-10-27
 */
public interface PrintTemplateMapper {
    /**
     * 查询打印模板
     *
     * @param templateId 打印模板主键
     * @return 打印模板
     */
    PrintTemplate selectPrintTemplateByTemplateId(Long templateId);

    /**
     * 查询打印模板列表
     *
     * @param printTemplate 打印模板
     * @return 打印模板集合
     */
    List<PrintTemplate> selectPrintTemplateList(PrintTemplate printTemplate);

    /**
     * 新增打印模板
     *
     * @param printTemplate 打印模板
     * @return 结果
     */
    int insertPrintTemplate(PrintTemplate printTemplate);

    /**
     * 修改打印模板
     *
     * @param printTemplate 打印模板
     * @return 结果
     */
    int updatePrintTemplate(PrintTemplate printTemplate);

    /**
     * 删除打印模板
     *
     * @param templateId 打印模板主键
     * @return 结果
     */
    int deletePrintTemplateByTemplateId(Long templateId);
}