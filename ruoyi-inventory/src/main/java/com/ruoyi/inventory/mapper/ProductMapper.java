package com.ruoyi.inventory.mapper;

import com.ruoyi.common.core.domain.entity.DetailReceipt;
import com.ruoyi.common.core.domain.entity.Product;

import java.util.List;

public interface ProductMapper {
    /**
     * 货品资料查询
     */
    List<Product> productQuery(Product bo);

    /**
     * 货品库存查询
     */
    List<Product> productInventoryQuery(Product bo);

    /**
     * 单据锁单数量查询
     */
    List<Product> lockQuery(Product bo);

    /**
     * 货品详情查询
     */
    Product selectProductById(Long productId);

    /**
     * 货品名称查询
     */
    Product selectProductByProductName(String productName);

    /**
     * 货品资料新增
     */
    int insertProduct(Product bo);

    /**
     * 货品资料修改
     */
    int updateProduct(Product bo);

    /**
     * 库存数量更新
     */
    int updateInventoryQty(List<DetailReceipt> bo);

    /**
     * 货品资料删除
     */
    int deleteProductByIds(Long[] productId);


}
