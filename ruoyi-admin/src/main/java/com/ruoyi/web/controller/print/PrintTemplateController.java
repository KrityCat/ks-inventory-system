package com.ruoyi.web.controller.print;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.entity.PrintTemplate;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.inventory.service.IPrintTemplateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 打印模板Controller
 *
 * @author ruoyi
 * @date 2023-10-27
 */
@RestController
@RequestMapping("/print/template")
public class PrintTemplateController extends BaseController {
    @Autowired
    private IPrintTemplateService printTemplateService;

    /**
     * 查询打印模板列表
     */
    @PreAuthorize("@ss.hasPermi('print:template:list')")
    @GetMapping("/list")
    public TableDataInfo list(PrintTemplate bo) {
        startPage();
        List<PrintTemplate> list = printTemplateService.selectPrintTemplateList(bo);
        return getDataTable(list);
    }

    /**
     * 导出打印模板列表
     */
//    @PreAuthorize("@ss.hasPermi('print:template:export')")
//    @Log(title = "打印模板", businessType = BusinessType.EXPORT)
//    @PostMapping("/export")
//    public void export(HttpServletResponse response, PrintTemplate printTemplate)
//    {
//        List<PrintTemplate> list = printTemplateService.selectPrintTemplateList(printTemplate);
//        ExcelUtil<PrintTemplate> util = new ExcelUtil<>(PrintTemplate.class);
//        util.exportExcel(response, list, "打印模板数据");
//    }

    /**
     * 获取打印模板详细信息
     */
    @PreAuthorize("@ss.hasPermi('print:template:query')")
    @GetMapping(value = {"/", "/{templateId}"})
    public AjaxResult getInfo(@PathVariable("templateId") Long templateId) {
        return success(printTemplateService.selectPrintTemplateByTemplateId(templateId));
    }

    /**
     * 新增打印模板
     */
    @PreAuthorize("@ss.hasPermi('print:template:add')")
    @Log(title = "新增打印模板", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody PrintTemplate printTemplate) {
        printTemplate.setCreateBy(getUsername());
        return toAjax(printTemplateService.insertPrintTemplate(printTemplate));
    }

    /**
     * 修改打印模板
     */
    @PreAuthorize("@ss.hasPermi('print:template:edit')")
    @Log(title = "修改打印模板", businessType = BusinessType.UPDATE)
    @PutMapping("/update")
    public AjaxResult edit(@RequestBody PrintTemplate printTemplate) {
        printTemplate.setUpdateBy(getUsername());
        return toAjax(printTemplateService.updatePrintTemplate(printTemplate));
    }

    /**
     * 删除打印模板
     */
    @PreAuthorize("@ss.hasPermi('print:template:remove')")
    @Log(title = "删除打印模板", businessType = BusinessType.DELETE)
    @DeleteMapping("/{templateId}")
    public AjaxResult remove(@PathVariable Long templateId) {
        return toAjax(printTemplateService.deletePrintTemplateByTemplateId(templateId));
    }
}