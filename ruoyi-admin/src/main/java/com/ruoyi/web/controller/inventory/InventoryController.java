package com.ruoyi.web.controller.inventory;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.entity.DetailReceipt;
import com.ruoyi.common.core.domain.entity.HeadReceipt;
import com.ruoyi.common.core.domain.entity.ReceiptFrom;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.system.service.InventoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 库存模块
 *
 * @author KrityCat
 */
@RestController
@RequestMapping("/system/inventory")
public class InventoryController extends BaseController {

    @Autowired
    private InventoryService InventoryService;

    /**
     * 库存单据头表查询
     */
    @PreAuthorize("@ss.hasPermi('system:inventory:headReceiptQuery')")
    @GetMapping("/headReceiptQuery")
    public TableDataInfo list(HeadReceipt bo) {
        startPage();
        List<HeadReceipt> list = InventoryService.headReceiptQuery(bo);
        return getDataTable(list);
    }

    /**
     * 库存单据明细查询
     */
    @PreAuthorize("@ss.hasPermi('system:inventory:detailReceiptQuery')")
    @GetMapping("/detailReceiptQuery")
    public TableDataInfo list(DetailReceipt bo) {
        startPage();
        List<DetailReceipt> list = InventoryService.detailReceiptQuery(bo);
        return getDataTable(list);
    }

    /**
     * 库存指定单据查询
     */
    @PreAuthorize("@ss.hasPermi('system:inventory:systematicReceipt')")
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
     * 保存其他入库单据信息
     */
    @PreAuthorize("@ss.hasPermi('system:inventory:saveStorageOther')")
    @Log(title = "保存其他入库单据信息", businessType = BusinessType.INSERT)
    @PostMapping("/saveStorageOther")
    public AjaxResult saveStorageOther(@RequestBody ReceiptFrom bo) throws Exception {
        bo.setCreateBy(getUsername());
        bo.setUpdateBy(getUsername());
        return toAjax(InventoryService.saveStorageOther(bo));
    }

    /**
     * 保存其他出库单据信息
     */
    @PreAuthorize("@ss.hasPermi('system:inventory:saveOutboundOther')")
    @Log(title = "保存其他出库单据信息", businessType = BusinessType.INSERT)
    @PostMapping("/saveOutboundOther")
    public AjaxResult saveOutboundOther(@RequestBody ReceiptFrom bo) throws Exception {
        bo.setCreateBy(getUsername());
        bo.setUpdateBy(getUsername());
        return toAjax(InventoryService.saveOutboundOther(bo));
    }

    /**
     * 保存库存调拨单据信息
     */
    @PreAuthorize("@ss.hasPermi('system:inventory:saveInventoryTransfer')")
    @Log(title = "保存库存调拨单据信息", businessType = BusinessType.INSERT)
    @PostMapping("/saveInventoryTransfer")
    public AjaxResult saveInventoryTransfer(@RequestBody ReceiptFrom bo) throws Exception {
        bo.setCreateBy(getUsername());
        bo.setUpdateBy(getUsername());
        return toAjax(InventoryService.saveInventoryTransfer(bo));
    }

    /**
     * 保存库存盘点单据信息
     */
    @PreAuthorize("@ss.hasPermi('system:inventory:saveInventoryCounting')")
    @Log(title = "保存库存盘点单据信息", businessType = BusinessType.INSERT)
    @PostMapping("/saveInventoryCounting")
    public AjaxResult saveInventoryCounting(@RequestBody ReceiptFrom bo) throws Exception {
        bo.setCreateBy(getUsername());
        bo.setUpdateBy(getUsername());
        return toAjax(InventoryService.saveInventoryCounting(bo));
    }

    /**
     * 删除库存单据
     */
    @PreAuthorize("@ss.hasPermi('system:inventory:delete')")
    @Log(title = "删除库存单据", businessType = BusinessType.INSERT)
    @PostMapping("/delete")
    public AjaxResult remove(@RequestBody List<DetailReceipt> bo) {
        return toAjax(InventoryService.delInventoryReceipt(bo));
    }

    /**
     * 库存单据头表导出
     */
    @PreAuthorize("@ss.hasPermi('system:inventory:headReceiptExport')")
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
    @PreAuthorize("@ss.hasPermi('system:inventory:detailReceiptExport')")
    @Log(title = "库存单据明细导出", businessType = BusinessType.EXPORT)
    @PostMapping("/detailReceiptExport")
    public void export(HttpServletResponse response, DetailReceipt bo) {
        List<DetailReceipt> list = InventoryService.detailReceiptQuery(bo);
        ExcelUtil<DetailReceipt> util = new ExcelUtil<DetailReceipt>(DetailReceipt.class);
        util.exportExcel(response, list, "库存单据明细表");
    }

}
