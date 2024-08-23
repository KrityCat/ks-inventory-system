package com.ruoyi.web.controller.sales;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.entity.DetailOrderForm;
import com.ruoyi.common.core.domain.entity.HeadOrderForm;
import com.ruoyi.common.core.domain.entity.OrderFrom;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.system.service.SalesOrderProcessingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 销售订单模块
 *
 * @author KrityCat
 */
@RestController
@RequestMapping("/sales/salesOrderProcessing")
public class SalesOrderProcessingController extends BaseController {

    @Autowired
    private SalesOrderProcessingService salesOrderProcessingService;

    /**
     * @param systematicOrderForm 系统单号
     * @return 订单详情
     */
    @PreAuthorize("@ss.hasPermi('sales:salesOrderProcessing:systematicOrderForm')")
    @GetMapping(value = {"/", "/{systematicOrderForm}"})
    public AjaxResult getInfo(@PathVariable(value = "systematicOrderForm", required = false) String systematicOrderForm) {
        AjaxResult ajax = AjaxResult.success();
        if (StringUtils.isNotNull(systematicOrderForm)) {
            HeadOrderForm headOrderForm = salesOrderProcessingService.selectSalesOrderFormById(systematicOrderForm);
            ajax.put(AjaxResult.DATA_TAG, headOrderForm);
        }
        return ajax;
    }

    /**
     * @param bo 订单信息
     * @return 保存销售订单信息
     */
    @PreAuthorize("@ss.hasPermi('sales:salesOrderProcessing:save')")
    @Log(title = "保存销售订单", businessType = BusinessType.INSERT)
    @PostMapping("/save")
    public AjaxResult save(@RequestBody OrderFrom bo) throws Exception {
        bo.setCreateBy(getUsername());
        bo.setUpdateBy(getUsername());
        return toAjax(salesOrderProcessingService.saveSalesOrderForm(bo));
    }

    /**
     * 删除销售订单接口
     */
    @PreAuthorize("@ss.hasPermi('sales:salesOrderProcessing:delete')")
    @Log(title = "删除销售订单", businessType = BusinessType.INSERT)
    @PostMapping("/delete")
    public AjaxResult remove(@RequestBody List<DetailOrderForm> bo) {
        return toAjax(salesOrderProcessingService.delSalesOrder(bo));
    }
}
