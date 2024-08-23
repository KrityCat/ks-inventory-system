import request from '@/utils/request'
import { parseStrEmpty } from "@/utils/ruoyi";

// 查询采购订单详情
export function getPurchaseOrder(systematicOrderForm) {
  return request({
    url: '/purchase/purchaseOrderProcessing/' + parseStrEmpty(systematicOrderForm),
    method: 'get'
  })
}

// 保存采购订单
export function savePurchaseOrder(data) {
  return request({
    url: '/purchase/purchaseOrderProcessing/save',
    method: 'post',
    data: data
  })
}

// 删除采购订单
export function delPurchaseOrder(data) {
  return request({
    url: '/purchase/purchaseOrderProcessing/delete',
    method: 'post',
    data: data
  })
}