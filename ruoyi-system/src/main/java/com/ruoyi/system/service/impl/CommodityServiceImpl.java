package com.ruoyi.system.service.impl;

import com.ruoyi.common.core.domain.entity.Commodity;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.bean.BeanValidators;
import com.ruoyi.system.mapper.CommodityMapper;
import com.ruoyi.system.service.ICommodityService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.validation.Validator;
import java.util.List;

/**
 * 商品资料Service业务层处理
 *
 * @author KrityCat
 */
@Service
public class CommodityServiceImpl implements ICommodityService {

    private static final Logger log = LoggerFactory.getLogger(CommodityServiceImpl.class);

    @Autowired
    protected Validator validator;

    @Autowired
    private CommodityMapper commodityMapper;

    /**
     * 查询商品资料
     *
     * @param commodityId 商品资料主键
     * @return 商品资料
     */
    @Override
    public Commodity selectCommodityByCommodityId(Long commodityId) {
        return commodityMapper.selectCommodityByCommodityId(commodityId);
    }

    /**
     * 查询商品资料列表
     *
     * @param commodity 商品资料
     * @return 商品资料
     */
    @Override
    public List<Commodity> selectCommodityList(Commodity commodity) {
        return commodityMapper.selectCommodityList(commodity);
    }

    /**
     * 新增商品资料
     *
     * @param commodity 商品资料
     * @return 结果
     */
    @Override
    public int insertCommodity(Commodity commodity) {
        commodity.setCreateTime(DateUtils.getNowDate());
        return commodityMapper.insertCommodity(commodity);
    }

    /**
     * 修改商品资料
     *
     * @param commodity 商品资料
     * @return 结果
     */
    @Override
    public int updateCommodity(Commodity commodity) {
        commodity.setUpdateTime(DateUtils.getNowDate());
        return commodityMapper.updateCommodity(commodity);
    }

    /**
     * 批量删除商品资料
     *
     * @param commodityIds 需要删除的商品资料主键
     * @return 结果
     */
    @Override
    public int deleteCommodityByCommodityIds(Long[] commodityIds) {
        return commodityMapper.deleteCommodityByCommodityIds(commodityIds);
    }

    /**
     * 删除商品资料信息
     *
     * @param commodityId 商品资料主键
     * @return 结果
     */
    @Override
    public int deleteCommodityByCommodityId(Long commodityId) {
        return commodityMapper.deleteCommodityByCommodityId(commodityId);
    }

    /**
     * 导入商品数据
     *
     * @param commodityList   商品数据列表
     * @param isUpdateSupport 是否更新支持，如果已存在，则进行更新数据
     * @param operName        操作用户
     * @return 结果
     */
    @Override
    public String importCommodity(List<Commodity> commodityList, Boolean isUpdateSupport, String operName) {
        if (StringUtils.isNull(commodityList) || commodityList.isEmpty()) {
            throw new ServiceException("导入商品数据不能为空！");
        }
        int successNum = 0;
        int failureNum = 0;
        StringBuilder successMsg = new StringBuilder();
        StringBuilder failureMsg = new StringBuilder();
        for (Commodity bo : commodityList) {
            try {
                // 验证是否存在这个商品
                Commodity w = commodityMapper.selectCommodityByCommodityName(bo.getCommodityName());
                if (StringUtils.isBlank(bo.getCommodityCode()) || StringUtils.isBlank(bo.getCommodityName()) || StringUtils.isBlank(bo.getCommodityType()) || StringUtils.isBlank(bo.getMeasureUnit())) {
                    failureNum++;
                    throw new ServiceException("商品编号、商品名称、商品类型与计量单位不能为空！");
                } else if (StringUtils.isNull(w)) {
                    BeanValidators.validateWithException(validator, bo);
                    bo.setCommodityName(bo.getCommodityName());
                    bo.setCreateBy(operName);
                    commodityMapper.insertCommodity(bo);
                    successNum++;
                    successMsg.append("<br/>" + successNum + "、商品 " + bo.getCommodityName() + " 导入成功");
                } else if (isUpdateSupport) {
                    BeanValidators.validateWithException(validator, bo);
                    bo.setCommodityId(w.getCommodityId());
                    bo.setUpdateBy(operName);
                    commodityMapper.updateCommodity(bo);
                    successNum++;
                    successMsg.append("<br/>" + successNum + "、商品 " + bo.getCommodityName() + " 更新成功");
                } else {
                    failureNum++;
                    failureMsg.append("<br/>" + failureNum + "、商品 " + bo.getCommodityName() + " 已存在");
                }
            } catch (Exception e) {
                failureNum++;
                String msg = "<br/>" + failureNum + "、商品 " + bo.getCommodityName() + " 导入失败：";
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
