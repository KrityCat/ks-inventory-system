import request from '@/utils/request'
import { parseStrEmpty } from "@/utils/ruoyi";

// 查询销售单据详情
export function getSalesOrder(systematicReceipt) {
  return request({
    url: '/sales/salesReceiptProcessing/' + parseStrEmpty(systematicReceipt),
    method: 'get'
  })
}

// 保存销售单据
export function saveSalesReceipt(data) {
  return request({
    url: '/sales/salesReceiptProcessing/save',
    method: 'post',
    data: data
  })
}

// 删除销售单据
export function delSalesReceipt(data) {
  return request({
    url: '/sales/salesReceiptProcessing/delete',
    method: 'post',
    data: data
  })
}