package com.ruoyi.system.service.impl;

import com.ruoyi.common.core.domain.entity.DetailReceipt;
import com.ruoyi.common.core.domain.entity.HeadReceipt;
import com.ruoyi.common.core.domain.entity.InventoryProduct;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.bean.BeanValidators;
import com.ruoyi.system.mapper.DetailReceiptMapper;
import com.ruoyi.system.mapper.HeadReceiptMapper;
import com.ruoyi.system.mapper.InventoryMapper;
import com.ruoyi.system.mapper.ProductMapper;
import com.ruoyi.system.service.InventoryService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.validation.Validator;
import java.util.List;

/**
 * 库存单据 业务层处理
 *
 * @author KrityCat
 */
@Service
public class InventoryServiceImpl implements InventoryService {

    private static final Logger log = LoggerFactory.getLogger(CustomerServiceImpl.class);

    @Autowired
    protected Validator validator;

    @Autowired
    private HeadReceiptMapper HeadReceiptMapper;

    @Autowired
    private DetailReceiptMapper DetailReceiptMapper;

    @Autowired
    private InventoryMapper InventoryMapper;

    @Autowired
    private ProductMapper productMapper;

    /**
     * @param bo 单据信息
     * @return 库存货品查询
     */
    @Override
    public List<InventoryProduct> selectInventoryProduct(InventoryProduct bo) {
        return InventoryMapper.selectInventoryProduct(bo);
    }

    /**
     * @param bo 单据信息
     * @return 库存单据头表查询
     */
    @Override
    public List<HeadReceipt> headReceiptQuery(HeadReceipt bo) {
        return HeadReceiptMapper.headReceiptQuery(bo);
    }

    /**
     * @param bo 单据信息
     * @return 库存单据明细查询
     */
    @Override
    public List<DetailReceipt> detailReceiptQuery(DetailReceipt bo) {
        return DetailReceiptMapper.SelectDetailReceiptQuery(bo);
    }

    /**
     * @param bo 单据信息
     * @return 货品发生汇总查询
     */
    @Override
    public List<DetailReceipt> inventorySummaryQuery(DetailReceipt bo) {
        return DetailReceiptMapper.inventorySummaryQuery(bo);
    }

    /**
     * @param bo 单据信息
     * @return 货品发生明细查询
     */
    @Override
    public List<DetailReceipt> inventoryDetailsQuery(DetailReceipt bo) {
        return DetailReceiptMapper.inventoryDetailsQuery(bo);
    }

    /**
     * @param SystematicReceipt 系统单号
     * @return 库存指定单据查询
     */
    @Override
    public HeadReceipt selectHeadReceiptById(String SystematicReceipt) {
        return HeadReceiptMapper.selectHeadReceiptById(SystematicReceipt);
    }

    /**
     * @param bo 单据信息
     * @return 删除库存单据信息
     */
    @Override
    @Transactional
    public int delInventoryReceipt(List<DetailReceipt> bo) {
        DetailReceiptMapper.delDetailReceipt(bo);
        HeadReceiptMapper.delHeadReceipt(bo);
        InventoryMapper.updateInventory(bo);
        return productMapper.updateInventoryQty(bo);
    }

    /**
     * @param HeadDataList 单据信息
     * @return 导入单据头表
     */
    @Override
    public String importHeadData(List<HeadReceipt> HeadDataList, Boolean isUpdateSupport, String operName) {
        if (StringUtils.isNull(HeadDataList) || HeadDataList.isEmpty()) {
            throw new ServiceException("导入单据头表数据不能为空！");
        }
        int successNum = 0;
        int failureNum = 0;
        StringBuilder successMsg = new StringBuilder();
        StringBuilder failureMsg = new StringBuilder();
        for (HeadReceipt bo : HeadDataList) {
            try {
                // 验证是否存在这个系统编号
                HeadReceipt s = HeadReceiptMapper.selectHeadReceiptById(bo.getSystematicReceipt());
                if (StringUtils.isNull(s)) {
                    BeanValidators.validateWithException(validator, bo);
                    bo.setSystematicReceipt(bo.getSystematicReceipt());
                    bo.setCreateBy(operName);
                    HeadReceiptMapper.addHeadReceipt(bo);
                    successNum++;
                    successMsg.append("<br/>" + successNum + "、单据头 " + bo.getSystematicReceipt() + " 导入成功");
                } else if (isUpdateSupport) {
                    BeanValidators.validateWithException(validator, bo);
                    bo.setSystematicReceipt(s.getSystematicReceipt());
                    bo.setUpdateBy(operName);
                    HeadReceiptMapper.updateHeadReceipt(bo);
                    successNum++;
                    successMsg.append("<br/>" + successNum + "、单据头 " + bo.getSystematicReceipt() + " 更新成功");
                } else {
                    failureNum++;
                    failureMsg.append("<br/>" + failureNum + "、单据头 " + bo.getSystematicReceipt() + " 已存在");
                }
            } catch (Exception e) {
                failureNum++;
                String msg = "<br/>" + failureNum + "、单据头 " + bo.getSystematicReceipt() + " 导入失败：";
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

    /**
     * @param DetailDataList 单据信息
     * @return 导入单据明细表
     */
    @Override
    public String importDetailData(List<DetailReceipt> DetailDataList, Boolean isUpdateSupport, String operName) {
        if (StringUtils.isNull(DetailDataList) || DetailDataList.isEmpty()) {
            throw new ServiceException("导入单据明细表数据不能为空！");
        }
        int successNum = 0;
        int failureNum = 0;
        StringBuilder successMsg = new StringBuilder();
        StringBuilder failureMsg = new StringBuilder();
        for (DetailReceipt bo : DetailDataList) {
            try {
                // 验证是否存在这个系统编号
                HeadReceipt s = HeadReceiptMapper.selectHeadReceiptById(bo.getSystematicReceipt());
                if (StringUtils.isNull(s)) {
                    BeanValidators.validateWithException(validator, bo);
                    bo.setSystematicReceipt(bo.getSystematicReceipt());
                    bo.setCreateBy(operName);
                    DetailReceiptMapper.addImportDetailReceipt(bo);
                    successNum++;
                    successMsg.append("<br/>" + successNum + "、单据头 " + bo.getSystematicReceipt() + " 导入成功");
                } else if (isUpdateSupport) {
                    BeanValidators.validateWithException(validator, bo);
                    bo.setSystematicReceipt(s.getSystematicReceipt());
                    bo.setUpdateBy(operName);
                    DetailReceiptMapper.updateImportDetailReceipt(bo);
                    successNum++;
                    successMsg.append("<br/>" + successNum + "、单据头 " + bo.getSystematicReceipt() + " 更新成功");
                } else {
                    failureNum++;
                    failureMsg.append("<br/>" + failureNum + "、单据头 " + bo.getSystematicReceipt() + " 已存在");
                }
            } catch (Exception e) {
                failureNum++;
                String msg = "<br/>" + failureNum + "、单据头 " + bo.getSystematicReceipt() + " 导入失败：";
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
