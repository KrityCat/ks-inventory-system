import request from '@/utils/request'
import { parseStrEmpty } from "@/utils/ruoyi";

// 查询采购头单列表
export function listPurchaseOrder(query) {
  return request({
    url: '/system/purchase/PurchaseOrderQuery',
    method: 'get',
    params: query
  })
}

// 查询采购明细列表
export function listPurchaseDetailOrder(query) {
  return request({
    url: '/system/purchase/PurchaseDetailOrderQuery',
    method: 'get',
    params: query
  })
}

// 查询采购头单详情
export function getPurchaseOrder(systematicReceipt) {
  return request({
    url: '/system/purchase/' + parseStrEmpty(systematicReceipt),
    method: 'get'
  })
}

// 删除采购单据
export function delWarehouseReceipt(data) {
  return request({
    url: '/system/purchase/delete',
    method: 'post',
    data: data
  })
}