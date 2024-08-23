package com.ruoyi.system.service;

import com.ruoyi.common.core.domain.entity.Product;

import java.util.List;

/**
 * 用户 业务层
 *
 * @author KrityCat
 */
public interface ProductService {
    /**
     * 根据条件分页查询货品列表
     *
     * @param bo 货品信息
     * @return 货品信息集合信息
     */
    List<Product> productQuery(Product bo);

    /**
     * 根据货品库存积压预警查询货品列表
     *
     * @param bo 货品信息
     * @return 货品信息集合信息
     */
    List<Product> productOverstockQuery(Product bo);

    /**
     * 根据货品库存不足预警查询货品列表
     *
     * @param bo 货品信息
     * @return 货品信息集合信息
     */
    List<Product> productDangerQuery(Product bo);

    /**
     * 积压3个月未出预警查询
     *
     * @param bo 货品信息
     * @return 货品信息集合信息
     */
    List<Product> productThreeDangerQuery(Product bo);

    /**
     * 积压6个月未出预警查询
     *
     * @param bo 货品信息
     * @return 货品信息集合信息
     */
    List<Product> productSixDangerQuery(Product bo);

    /**
     * 积压12个月未出预警查询
     *
     * @param bo 货品信息
     * @return 货品信息集合信息
     */
    List<Product> productTwelveDangerQuery(Product bo);

    /**
     * 通过货品CODE查询货品
     *
     * @param productId 货品ID
     * @return 仓库对象信息
     */
    Product selectProductById(Long productId);

    /**
     * 新增货品信息
     *
     * @param bo 货品信息
     * @return 结果
     */
    int insertProduct(Product bo);

    /**
     * 修改货品信息
     *
     * @param bo 货品信息
     * @return 结果
     */
    int updateProduct(Product bo);

    /**
     * 批量删除货品信息
     *
     * @param productIds 需要删除的货品ID
     * @return 结果
     */
    int deleteProductByIds(Long[] productIds);

    /**
     * 导入货品数据
     *
     * @param productList     货品数据列表
     * @param isUpdateSupport 是否更新支持，如果已存在，则进行更新数据
     * @param operName        操作用户
     * @return 结果
     */
    String importProduct(List<Product> productList, Boolean isUpdateSupport, String operName);

}
