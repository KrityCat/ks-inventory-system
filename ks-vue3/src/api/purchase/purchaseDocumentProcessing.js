import request from '@/utils/request'
import { parseStrEmpty } from "@/utils/ruoyi";

// 查询采购头单详情
export function getPurchaseOrder(systematicReceipt) {
  return request({
    url: '/purchase/purchaseReceiptProcessing/' + parseStrEmpty(systematicReceipt),
    method: 'get'
  })
}

// 保存采购单据
export function savePurchaseReceipt(data) {
  return request({
    url: '/purchase/purchaseReceiptProcessing/save',
    method: 'post',
    data: data
  })
}

// 删除采购单据
export function delPurchaseReceipt(data) {
  return request({
    url: '/purchase/purchaseReceiptQuery/delete',
    method: 'post',
    data: data
  })
}