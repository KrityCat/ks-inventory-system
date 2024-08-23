import request from '@/utils/request'
import { parseStrEmpty } from "@/utils/ruoyi";

// 查询采购头单列表
export function headQuery(query) {
  return request({
    url: '/purchase/purchaseReceiptQuery/headQuery',
    method: 'get',
    params: query
  })
}

// 查询采购明细列表
export function detailQuery(query) {
  return request({
    url: '/purchase/purchaseReceiptQuery/detailQuery',
    method: 'get',
    params: query
  })
}

// 查询采购头单详情
export function getPurchaseReceipt(systematicReceipt) {
  return request({
    url: '/purchase/purchaseReceiptQuery/' + parseStrEmpty(systematicReceipt),
    method: 'get'
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