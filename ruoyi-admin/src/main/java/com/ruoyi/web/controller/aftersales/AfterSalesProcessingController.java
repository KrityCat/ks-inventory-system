package com.ruoyi.web.controller.aftersales;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.entity.DetailService;
import com.ruoyi.common.core.domain.entity.HeadService;
import com.ruoyi.common.core.domain.entity.ServiceFrom;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.system.service.AfterSalesProcessingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 售后模块
 *
 * @author KrityCat
 */
@RestController
@RequestMapping("/afterSales/afterSalesProcessing")
public class AfterSalesProcessingController extends BaseController {

    @Autowired
    private AfterSalesProcessingService afterSalesProcessingService;

    /**
     * @param systematicReceipt 系统单号
     * @return 单据详情
     */
    @PreAuthorize("@ss.hasPermi('afterSales:afterSalesOrderProcessing:systematicReceipt')")
    @GetMapping(value = {"/", "/{systematicReceipt}"})
    public AjaxResult getInfo(@PathVariable(value = "systematicReceipt", required = false) String systematicReceipt) {
        AjaxResult ajax = AjaxResult.success();
        if (StringUtils.isNotNull(systematicReceipt)) {
            HeadService headService = afterSalesProcessingService.selectSalesOrderById(systematicReceipt);
            ajax.put(AjaxResult.DATA_TAG, headService);
        }
        return ajax;
    }

    /**
     * @param bo 单据信息
     * @return 保存售后单据信息
     */
    @PreAuthorize("@ss.hasPermi('afterSales:afterSalesOrderProcessing:save')")
    @Log(title = "保存售后单据", businessType = BusinessType.INSERT)
    @PostMapping("/saveAfterSales")
    public AjaxResult save(@RequestBody ServiceFrom bo) throws Exception {
        bo.setCreateBy(getUsername());
        bo.setUpdateBy(getUsername());
        return toAjax(afterSalesProcessingService.saveAfterSales(bo));
    }

    /**
     * 删除售后单据接口
     */
    @PreAuthorize("@ss.hasPermi('afterSales:afterSalesOrderProcessing:delete')")
    @Log(title = "删除售后单据", businessType = BusinessType.INSERT)
    @PostMapping("/delete")
    public AjaxResult remove(@RequestBody List<DetailService> bo) {
        return toAjax(afterSalesProcessingService.delAfterSales(bo));
    }

}
