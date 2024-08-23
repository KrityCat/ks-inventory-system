import request from '@/utils/request'
import { parseStrEmpty } from "@/utils/ruoyi";

// 查询售后单据详情
export function getAfterSales(systematicReceipt) {
  return request({
    url: '/afterSales/afterSalesProcessing/' + parseStrEmpty(systematicReceipt),
    method: 'get'
  })
}

// 保存售后单据
export function saveAfterSales(data) {
  return request({
    url: '/afterSales/afterSalesProcessing/saveAfterSales',
    method: 'post',
    data: data
  })
}

// 删除售后单据
export function delAfterSales(data) {
  return request({
    url: '/afterSales/afterSalesProcessing/delete',
    method: 'post',
    data: data
  })
}