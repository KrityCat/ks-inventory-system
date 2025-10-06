package com.ruoyi.web.controller.common;

import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.entity.*;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.inventory.service.*;
import com.ruoyi.system.service.ISysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * 单据公共方法模块
 *
 * @author KrityCat
 */
@RestController
@RequestMapping("/common/commonReceipt")
public class CommonReceiptController extends BaseController {

    @Autowired
    private ISysUserService userService;

    @Autowired
    private ProductService productService;

    @Autowired
    private InventoryReceiptQueryService inventoryReceiptQueryService;

    @Autowired
    private InventoryReceiptProcessingService inventoryReceiptProcessingService;


    @Autowired
    private InventoryService inventoryService;

    @Autowired
    private WarehouseService warehouseService;

    @Autowired
    private SupplierService supplierService;

    @Autowired
    private CustomerService customerService;

    @Autowired
    private IPrintTemplateService printTemplateService;

    /**
     * 获取用户列表
     */
    @PreAuthorize("@ss.hasPermi('common:commonReceipt:list')")
    @GetMapping("/userList")
    public TableDataInfo list(SysUser user) {
        startPage();
        List<SysUser> list = userService.selectUserList(user);
        return getDataTable(list);
    }

    /**
     * 查询仓库接口
     */
    @PreAuthorize("@ss.hasPermi('common:commonReceipt:list')")
    @GetMapping("/warehouseList")
    public TableDataInfo list(Warehouse bo) {
        startPage();
        List<Warehouse> list = warehouseService.WarehouseQuery(bo);
        return getDataTable(list);
    }

    /**
     * 查询供应商接口
     */
    @PreAuthorize("@ss.hasPermi('common:commonReceipt:list')")
    @GetMapping("/supplierList")
    public TableDataInfo list(Supplier bo) {
        startPage();
        List<Supplier> list = supplierService.SupplierQuery(bo);
        return getDataTable(list);
    }

    /**
     * 查询客户接口
     */
    @PreAuthorize("@ss.hasPermi('common:commonReceipt:list')")
    @GetMapping("/customerList")
    public TableDataInfo list(Customer bo) {
        startPage();
        List<Customer> list = customerService.CustomerQuery(bo);
        return getDataTable(list);
    }

    /**
     * 查询货品接口
     */
    @PreAuthorize("@ss.hasPermi('common:commonReceipt:list')")
    @GetMapping("/productList")
    public TableDataInfo list(Product bo) {
        startPage();
        List<Product> list = productService.productQuery(bo);
        return getDataTable(list);
    }

    /**
     * 库存指定单据查询
     */
    @PreAuthorize("@ss.hasPermi('common:commonReceipt:list')")
    @GetMapping(value = {"/", "/{SystematicReceipt}"})
    public AjaxResult getInfo(@PathVariable(value = "SystematicReceipt", required = false) String systematicReceipt) {
        AjaxResult ajax = AjaxResult.success();
        if (StringUtils.isNotNull(systematicReceipt)) {
            HeadReceipt headReceipt = inventoryReceiptProcessingService.selectHeadReceiptById(systematicReceipt);
            ajax.put(AjaxResult.DATA_TAG, headReceipt);
        }
        return ajax;
    }

    /**
     * 查询接口
     */
    @PreAuthorize("@ss.hasPermi('common:commonReceipt:list')")
    @GetMapping("/inventoryList")
    public TableDataInfo inventoryList(Product bo) {
        startPage();
        List<Product> list = productService.productInventoryQuery(bo);
        return getDataTable(list);
    }

    /**
     * 单据锁单数量查询接口
     */
    @PreAuthorize("@ss.hasPermi('common:commonReceipt:list')")
    @GetMapping("/lockList")
    public TableDataInfo lockList(Product bo) {
        startPage();
        List<Product> list = productService.lockQuery(bo);
        return getDataTable(list);
    }

    /**
     * 库存数量查询
     */
    @PreAuthorize("@ss.hasPermi('common:commonReceipt:selectInventoryQtyQuery')")
    @GetMapping("/selectInventoryQtyQuery")
    public TableDataInfo selectInventoryQtyQuery(InventoryProduct bo) {
        startPage();
        List<InventoryProduct> list = inventoryService.selectInventoryProduct(bo);
        return getDataTable(list);
    }

    /**
     * 入库锁单数量查询
     */
    @PreAuthorize("@ss.hasPermi('common:commonReceipt:selectLockInventoryQtyQuery')")
    @GetMapping("/selectLockInventoryQtyQuery")
    public TableDataInfo selectLockInventoryQtyQuery(DetailReceipt bo) {
        startPage();
        List<DetailReceipt> list = inventoryService.selectLockInventoryQtyByReceipt(bo);
        return getDataTable(list);
    }

    /**
     * 单据锁单数量查询
     */
    @PreAuthorize("@ss.hasPermi('common:commonReceipt:selectLockQtyQuery')")
    @GetMapping("/selectLockQtyQuery")
    public TableDataInfo selectLockQtyQuery(DetailReceipt bo) {
        startPage();
        List<DetailReceipt> list = inventoryService.selectLockQtyByReceipt(bo);
        return getDataTable(list);
    }

    /**
     * 查询打印模板列表
     */
    @PreAuthorize("@ss.hasPermi('common:commonReceipt:list')")
    @GetMapping("/printList")
    public TableDataInfo list(PrintTemplate bo) {
        startPage();
        List<PrintTemplate> list = printTemplateService.selectPrintTemplateList(bo);
        return getDataTable(list);
    }


}
