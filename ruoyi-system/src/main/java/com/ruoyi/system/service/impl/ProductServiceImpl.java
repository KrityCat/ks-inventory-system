package com.ruoyi.system.service.impl;

import com.ruoyi.common.core.domain.entity.Product;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.bean.BeanValidators;
import com.ruoyi.system.mapper.ProductMapper;
import com.ruoyi.system.service.ProductService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.validation.Validator;
import java.util.List;

/**
 * 货品资料
 *
 * @author KrityCat
 */
@Service
public class ProductServiceImpl implements ProductService {

    private static final Logger log = LoggerFactory.getLogger(ProductServiceImpl.class);
    @Autowired
    protected Validator validator;
    @Autowired
    private ProductMapper PdMapper;

    /**
     * 货品资料查询
     */
    @Override
    public List<Product> ProductQuery(Product bo) {
        return PdMapper.ProductQuery(bo);
    }

    /**
     * 通过货品ID查询货品
     */
    @Override
    public Product selectProductById(Long productId) {
        return PdMapper.selectProductById(productId);
    }


    /**
     * 新增保存货品资料
     *
     * @param bo 货品资料
     * @return 结果
     */
    @Override
    @Transactional
    public int insertProduct(Product bo) {
        return PdMapper.insertProduct(bo);
    }

    /**
     * 修改保存货品资料
     *
     * @param bo 货品资料
     * @return 结果
     */
    @Override
    @Transactional
    public int updateProduct(Product bo) {
        return PdMapper.updateProduct(bo);
    }

    /**
     * 删除货品资料
     *
     * @param productIds 需要删除的货品ID
     * @return 结果
     */
    @Override
    @Transactional
    public int deleteProductByIds(Long[] productIds) {
        return PdMapper.deleteProductByIds(productIds);
    }

    /**
     * 导入货品数据
     *
     * @param productList     货品数据列表
     * @param isUpdateSupport 是否更新支持，如果已存在，则进行更新数据
     * @param operName        操作用户
     * @return 结果
     */
    @Override
    public String importProduct(List<Product> productList, Boolean isUpdateSupport, String operName) {
        if (StringUtils.isNull(productList) || productList.isEmpty()) {
            throw new ServiceException("导入货品数据不能为空！");
        }
        int successNum = 0;
        int failureNum = 0;
        StringBuilder successMsg = new StringBuilder();
        StringBuilder failureMsg = new StringBuilder();
        for (Product bo : productList) {
            try {
                // 验证是否存在这个货品
                Product w = PdMapper.selectProductByProductName(bo.getProductName());
                if (StringUtils.isBlank(bo.getProductCode()) || StringUtils.isBlank(bo.getProductName()) || StringUtils.isBlank(bo.getProductType()) || StringUtils.isBlank(bo.getMeasureUnit())) {
                    failureNum++;
                    throw new ServiceException("货品编号、货品名称、货品类型与计量单位不能为空！");
                } else if (StringUtils.isNull(w)) {
                    BeanValidators.validateWithException(validator, bo);
                    bo.setProductName(bo.getProductName());
                    bo.setCreateBy(operName);
                    PdMapper.insertProduct(bo);
                    successNum++;
                    successMsg.append("<br/>" + successNum + "、货品 " + bo.getProductName() + " 导入成功");
                } else if (isUpdateSupport) {
                    BeanValidators.validateWithException(validator, bo);
//                    checkUserAllowed(w);
                    bo.setProductId(w.getProductId());
                    bo.setUpdateBy(operName);
                    PdMapper.updateProduct(bo);
                    successNum++;
                    successMsg.append("<br/>" + successNum + "、货品 " + bo.getProductName() + " 更新成功");
                } else {
                    failureNum++;
                    failureMsg.append("<br/>" + failureNum + "、货品 " + bo.getProductName() + " 已存在");
                }
            } catch (Exception e) {
                failureNum++;
                String msg = "<br/>" + failureNum + "、货品 " + bo.getProductName() + " 导入失败：";
                failureMsg.append(msg + e.getMessage());
                log.error(msg, e);
            }
        }
        if (failureNum > 0) {
            failureMsg.insert(0, "很抱歉，导入失败！共 " + failureNum + " 条数据格式不正确，错误如下：");
            throw new ServiceException(failureMsg.toString());
        } else {
            successMsg.insert(0, "恭喜您，数据已全部导入成功！共 " + successNum + " 条，数据如下：");
        }
        return successMsg.toString();

    }
}
