package com.ruoyi.system.mapper;

import com.ruoyi.common.core.domain.entity.Product;

import java.util.List;

public interface ProductMapper {
    /**
     * 货品资料查询
     */
    List<Product> ProductQuery(Product bo);

    /**
     * 货品详情查询
     */
    Product selectProductById(Long productId);

    /**
     * 货品名称查询
     */
    Product selectProductByProductName(String productId);

    /**
     * 货品资料新增
     */
    int insertProduct(Product bo);

    /**
     * 货品资料修改
     */
    int updateProduct(Product bo);

    /**
     * 货品资料删除
     */
    int deleteProductByIds(Long[] productId);


}
