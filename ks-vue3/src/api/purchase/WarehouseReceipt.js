import request from '@/utils/request'
import { parseStrEmpty } from "@/utils/ruoyi";

// 查询采购头单详情
export function getPurchaseOrder(systematicReceipt) {
  return request({
    url: '/system/purchase/' + parseStrEmpty(systematicReceipt),
    method: 'get'
  })
}

// 保存采购入库单据
export function saveWarehouseReceipt(data) {
  return request({
    url: '/system/purchase/saveWarehouseReceipt',
    method: 'post',
    data: data
  })
}