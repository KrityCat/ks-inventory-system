package com.ruoyi.web.controller.inventory;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.entity.DetailReceipt;
import com.ruoyi.common.core.domain.entity.HeadReceipt;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.system.service.InventoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 历史单据迁移模块
 *
 * @author KrityCat
 */
@RestController
@RequestMapping("/system/historicalDocuments")
public class historicalDocumentsController extends BaseController {

    @Autowired
    private InventoryService InventoryService;

    /**
     * 库存单据头表查询
     */
    @PreAuthorize("@ss.hasPermi('system:historicalDocuments:head')")
    @GetMapping("/head")
    public TableDataInfo list(HeadReceipt bo) {
        startPage();
        List<HeadReceipt> list = InventoryService.headReceiptQuery(bo);
        return getDataTable(list);
    }

    /**
     * 库存单据明细查询
     */
    @PreAuthorize("@ss.hasPermi('system:historicalDocuments:detail')")
    @GetMapping("/detail")
    public TableDataInfo list(DetailReceipt bo) {
        startPage();
        List<DetailReceipt> list = InventoryService.detailReceiptQuery(bo);
        return getDataTable(list);
    }

    /**
     * 库存指定单据查询
     */
    @PreAuthorize("@ss.hasPermi('system:historicalDocuments:SystematicReceipt')")
    @GetMapping(value = {"/", "/{SystematicReceipt}"})
    public AjaxResult getInfo(@PathVariable(value = "SystematicReceipt", required = false) String SystematicReceipt) {
        AjaxResult ajax = AjaxResult.success();
        if (StringUtils.isNotNull(SystematicReceipt)) {
            HeadReceipt headReceipt = InventoryService.selectHeadReceiptById(SystematicReceipt);
            ajax.put(AjaxResult.DATA_TAG, headReceipt);
        }
        return ajax;
    }


    /**
     * 删除库存单据
     */
    @PreAuthorize("@ss.hasPermi('system:historicalDocuments:delete')")
    @Log(title = "删除库存单据", businessType = BusinessType.INSERT)
    @PostMapping("/delete")
    public AjaxResult remove(@RequestBody List<DetailReceipt> bo) {
        return toAjax(InventoryService.delInventoryReceipt(bo));
    }

    /**
     * 单据头表模板接口
     */
    @PostMapping("/importHeadTemplate")
    public void importHeadTemplate(HttpServletResponse response) {
        ExcelUtil<HeadReceipt> util = new ExcelUtil<HeadReceipt>(HeadReceipt.class);
        util.importTemplateExcel(response, "单据头表数据");
    }

    /**
     * 单据明细表模板接口
     */
    @PostMapping("/importDetailTemplate")
    public void importDetailTemplate(HttpServletResponse response) {
        ExcelUtil<DetailReceipt> util = new ExcelUtil<DetailReceipt>(DetailReceipt.class);
        util.importTemplateExcel(response, "单据明细表数据");
    }

    /**
     * 导入单据头表接口
     */
    @PreAuthorize("@ss.hasPermi('system:historicalDocuments:importHeadData')")
    @Log(title = "导入单据头表", businessType = BusinessType.IMPORT)
    @PostMapping("/importHeadData")
    public AjaxResult importHeadData(MultipartFile file, boolean updateSupport) throws Exception {
        ExcelUtil<HeadReceipt> util = new ExcelUtil<HeadReceipt>(HeadReceipt.class);
        List<HeadReceipt> HeadDataList = util.importExcel(file.getInputStream());
        String operName = getUsername();
        String message = InventoryService.importHeadData(HeadDataList, updateSupport, operName);
        return success(message);
    }

    /**
     * 导入单据明细表接口
     */
    @PreAuthorize("@ss.hasPermi('system:historicalDocuments:importDetailData')")
    @Log(title = "导入单据明细表", businessType = BusinessType.IMPORT)
    @PostMapping("/importDetailData")
    public AjaxResult importDetailData(MultipartFile file, boolean updateSupport) throws Exception {
        ExcelUtil<DetailReceipt> util = new ExcelUtil<DetailReceipt>(DetailReceipt.class);
        List<DetailReceipt> DetailDataList = util.importExcel(file.getInputStream());
        String operName = getUsername();
        String message = InventoryService.importDetailData(DetailDataList, updateSupport, operName);
        return success(message);
    }

    /**
     * 库存单据头表导出
     */
    @PreAuthorize("@ss.hasPermi('system:historicalDocuments:headReceiptExport')")
    @Log(title = "库存单据头表导出", businessType = BusinessType.EXPORT)
    @PostMapping("/headReceiptExport")
    public void export(HttpServletResponse response, HeadReceipt bo) {
        List<HeadReceipt> list = InventoryService.headReceiptQuery(bo);
        ExcelUtil<HeadReceipt> util = new ExcelUtil<HeadReceipt>(HeadReceipt.class);
        util.exportExcel(response, list, "库存单据表");
    }

    /**
     * 库存单据明细导出
     */
    @PreAuthorize("@ss.hasPermi('system:historicalDocuments:detailReceiptExport')")
    @Log(title = "库存单据明细导出", businessType = BusinessType.EXPORT)
    @PostMapping("/detailReceiptExport")
    public void export(HttpServletResponse response, DetailReceipt bo) {
        List<DetailReceipt> list = InventoryService.detailReceiptQuery(bo);
        ExcelUtil<DetailReceipt> util = new ExcelUtil<DetailReceipt>(DetailReceipt.class);
        util.exportExcel(response, list, "库存单据明细表");
    }

}
