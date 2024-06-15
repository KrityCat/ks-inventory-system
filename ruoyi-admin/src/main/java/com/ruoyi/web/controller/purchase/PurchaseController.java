package com.ruoyi.web.controller.purchase;

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
import com.ruoyi.system.service.PurchaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 采购模块
 *
 * @author KrityCat
 */
@RestController
@RequestMapping("/system/purchase")
public class PurchaseController extends BaseController {

    @Autowired
    private PurchaseService PcService;

    @Autowired
    private InventoryService InventoryService;

    /**
     * 查询采购头单接口
     */
    @PreAuthorize("@ss.hasPermi('system:purchase:PurchaseOrderQuery')")
    @GetMapping("/PurchaseOrderQuery")
    public TableDataInfo list(HeadReceipt bo) {
        startPage();
        List<HeadReceipt> list = PcService.PurchaseHeadReceiptQuery(bo);
        return getDataTable(list);
    }

    /**
     * 查询采购明细单接口
     */
    @PreAuthorize("@ss.hasPermi('system:purchase:PurchaseDetailOrderQuery')")
    @GetMapping("/PurchaseDetailOrderQuery")
    public TableDataInfo list(DetailReceipt bo) {
        startPage();
        List<DetailReceipt> list = PcService.PurchaseDetailReceiptQuery(bo);
        return getDataTable(list);
    }

    /**
     * 查询采购单详情接口
     */
    @PreAuthorize("@ss.hasPermi('system:purchase:systematicReceipt')")
    @GetMapping(value = {"/", "/{systematicReceipt}"})
    public AjaxResult getInfo(@PathVariable(value = "systematicReceipt", required = false) String systematicReceipt) {
        AjaxResult ajax = AjaxResult.success();
        if (StringUtils.isNotNull(systematicReceipt)) {
            HeadReceipt headReceipt = PcService.selectPurchaseOrderById(systematicReceipt);
            ajax.put(AjaxResult.DATA_TAG, headReceipt);
        }
        return ajax;
    }

    /**
     * 保存采购入库单据接口
     */
    @PreAuthorize("@ss.hasPermi('system:purchase:saveWarehouseReceipt')")
    @Log(title = "保存采购入库单据", businessType = BusinessType.INSERT)
    @PostMapping("/saveWarehouseReceipt")
    public AjaxResult saveWarehouseReceipt(@RequestBody ReceiptFrom bo) throws Exception {
        bo.setCreateBy(getUsername());
        bo.setUpdateBy(getUsername());
        return toAjax(PcService.saveWarehouseReceipt(bo));
    }

    /**
     * 保存采购退库单据接口
     */
    @PreAuthorize("@ss.hasPermi('system:purchase:saveRetreatWarehouse')")
    @Log(title = "保存采购退库单据", businessType = BusinessType.INSERT)
    @PostMapping("/saveRetreatWarehouse")
    public AjaxResult saveRetreatWarehouse(@RequestBody ReceiptFrom bo) throws Exception {
        bo.setCreateBy(getUsername());
        bo.setUpdateBy(getUsername());
        return toAjax(PcService.saveRetreatWarehouse(bo));
    }

    /**
     * 删除采购单据接口
     */
    @PreAuthorize("@ss.hasPermi('system:purchase:delete')")
    @Log(title = "删除采购单", businessType = BusinessType.INSERT)
    @PostMapping("/delete")
    public AjaxResult remove(@RequestBody List<DetailReceipt> bo) {
        return toAjax(InventoryService.delInventoryReceipt(bo));
    }

    /**
     * 导出头表接口
     */
    @PreAuthorize("@ss.hasPermi('system:purchase:purchaseOrderExport')")
    @Log(title = "导出采购单据头表", businessType = BusinessType.EXPORT)
    @PostMapping("/purchaseOrderExport")
    public void export(HttpServletResponse response, HeadReceipt bo) {
        List<HeadReceipt> list = PcService.PurchaseHeadReceiptQuery(bo);
        ExcelUtil<HeadReceipt> util = new ExcelUtil<HeadReceipt>(HeadReceipt.class);
        util.exportExcel(response, list, "采购单据表");
    }

    /**
     * 导出明细表接口
     */
    @PreAuthorize("@ss.hasPermi('system:purchase:purchaseDetailOrderExport')")
    @Log(title = "导出采购单据明细表", businessType = BusinessType.EXPORT)
    @PostMapping("/purchaseDetailOrderExport")
    public void export(HttpServletResponse response, DetailReceipt bo) {
        List<DetailReceipt> list = PcService.PurchaseDetailReceiptQuery(bo);
        ExcelUtil<DetailReceipt> util = new ExcelUtil<DetailReceipt>(DetailReceipt.class);
        util.exportExcel(response, list, "采购单据明细表");
    }

}
