package com.ruoyi.system.mapper;

import com.ruoyi.common.core.domain.entity.DetailReceipt;
import com.ruoyi.common.core.domain.entity.Product;

import java.util.List;

public interface ProductMapper {
    /**
     * 货品资料查询
     */
    List<Product> productQuery(Product bo);

    /**
     * 货品库存积压预警查询
     */
    List<Product> productOverstockQuery(Product bo);

    /**
     * 货品库存不足预警查询
     */
    List<Product> productDangerQuery(Product bo);

    /**
     * 积压3个月未出预警查询
     */
    List<Product> productThreeDangerQuery(Product bo);

    /**
     * 积压6个月未出预警查询
     */
    List<Product> productSixDangerQuery(Product bo);

    /**
     * 积压12个月未出预警查询
     */
    List<Product> productTwelveDangerQuery(Product bo);

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
