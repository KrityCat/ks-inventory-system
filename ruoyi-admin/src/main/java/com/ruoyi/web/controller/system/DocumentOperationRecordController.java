package com.ruoyi.web.controller.system;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.entity.DocumentOperationRecord;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.inventory.service.IDocumentOperationRecordService;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 单据操作记录Controller
 *
 * @author KrityCat
 * @date 2024-11-16
 */
@RestController
@RequestMapping("/system/documentOperationRecord")
public class DocumentOperationRecordController extends BaseController {
    @Autowired
    private IDocumentOperationRecordService documentOperationRecordService;

    /**
     * 查询单据操作记录列表
     */
//    @PreAuthorize("@ss.hasPermi('system:documentOperationRecord:list')")
    @GetMapping("/list")
    public TableDataInfo list(DocumentOperationRecord documentOperationRecord) {
        startPage();
        List<DocumentOperationRecord> list = documentOperationRecordService.selectDocumentOperationRecordList(documentOperationRecord);
        return getDataTable(list);
    }

    /**
     * 导出单据操作记录列表
     */
//    @PreAuthorize("@ss.hasPermi('system:documentOperationRecord:export')")
    @Log(title = "单据操作记录", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, DocumentOperationRecord documentOperationRecord) {
        List<DocumentOperationRecord> list = documentOperationRecordService.selectDocumentOperationRecordList(documentOperationRecord);
        ExcelUtil<DocumentOperationRecord> util = new ExcelUtil<DocumentOperationRecord>(DocumentOperationRecord.class);
        util.exportExcel(response, list, "单据操作记录数据");
    }

    /**
     * 获取单据操作记录详细信息
     */
//    @PreAuthorize("@ss.hasPermi('system:documentOperationRecord:query')")
    @GetMapping(value = "/{logId}")
    public AjaxResult getInfo(@PathVariable("logId") Long logId) {
        return success(documentOperationRecordService.selectDocumentOperationRecordByLogId(logId));
    }

    /**
     * 新增单据操作记录
     */
//    @PreAuthorize("@ss.hasPermi('system:documentOperationRecord:add')")
    @Log(title = "单据操作记录", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody DocumentOperationRecord documentOperationRecord) {
        return toAjax(documentOperationRecordService.insertDocumentOperationRecord(documentOperationRecord));
    }

    /**
     * 修改单据操作记录
     */
//    @PreAuthorize("@ss.hasPermi('system:documentOperationRecord:edit')")
    @Log(title = "单据操作记录", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody DocumentOperationRecord documentOperationRecord) {
        return toAjax(documentOperationRecordService.updateDocumentOperationRecord(documentOperationRecord));
    }

    /**
     * 删除单据操作记录
     */
//    @PreAuthorize("@ss.hasPermi('system:documentOperationRecord:remove')")
    @Log(title = "单据操作记录", businessType = BusinessType.DELETE)
    @DeleteMapping("/{logIds}")
    public AjaxResult remove(@PathVariable Long[] logIds) {
        return toAjax(documentOperationRecordService.deleteDocumentOperationRecordByLogIds(logIds));
    }
}
