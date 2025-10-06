package com.ruoyi.web.controller;

import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.entity.Index;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.inventory.service.IndexService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * 主页信息
 *
 * @author KrityCat
 */
@RestController
@RequestMapping("/index")
public class IndexController extends BaseController {

    @Autowired
    private IndexService indexService;

    /**
     * 销售金额与毛利润查询
     */
    @PreAuthorize("@ss.hasPermi('index:salesAmountQuery')")
    @GetMapping("/salesAmountQuery")
    public Index salesAmountQuery() {
        return indexService.salesAmountQuery();
    }

    /**
     * 待审核单据查询
     */
    @PreAuthorize("@ss.hasPermi('index:salesNotTakeEffectQuery')")
    @GetMapping("/salesNotTakeEffectQuery")
    public Index salesNotTakeEffectQuery() {
        return indexService.salesNotTakeEffectQuery();
    }


    /**
     * 货品库存预警查询接口
     */
    @PreAuthorize("@ss.hasPermi('index:overstockList')")
    @GetMapping("/overstockList")
    public TableDataInfo productOverstockQuery(Index bo) {
        startPage();
        List<Index> list = indexService.productOverstockQuery(bo);
        return getDataTable(list);
    }

    /**
     * 货品库存预警查询接口
     */
    @PreAuthorize("@ss.hasPermi('index:overstockList')")
    @GetMapping("/dangerList")
    public TableDataInfo productDangerQuery(Index bo) {
        startPage();
        List<Index> list = indexService.productDangerQuery(bo);
        return getDataTable(list);
    }

    /**
     * 积压3个月未出预警查询接口
     */
    @PreAuthorize("@ss.hasPermi('index:monthOverstockList')")
    @GetMapping("/threeOverstockList")
    public TableDataInfo productThreeDangerQuery(Index bo) {
        startPage();
        List<Index> list = indexService.productThreeDangerQuery(bo);
        return getDataTable(list);
    }

    /**
     * 积压6个月未出预警查询接口
     */
    @PreAuthorize("@ss.hasPermi('index:monthOverstockList')")
    @GetMapping("/sixOverstockList")
    public TableDataInfo productSixDangerQuery(Index bo) {
        startPage();
        List<Index> list = indexService.productSixDangerQuery(bo);
        return getDataTable(list);
    }

    /**
     * 积压12个月未出预警查询接口
     */
    @PreAuthorize("@ss.hasPermi('index:monthOverstockList')")
    @GetMapping("/twelveOverstockList")
    public TableDataInfo productTwelveDangerQuery(Index bo) {
        startPage();
        List<Index> list = indexService.productTwelveDangerQuery(bo);
        return getDataTable(list);
    }

}
