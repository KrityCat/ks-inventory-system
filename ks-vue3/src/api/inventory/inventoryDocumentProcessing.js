import request from '@/utils/request'
import { parseStrEmpty } from "@/utils/ruoyi";

// 查询库存单据详情
export function getReceipt(SystematicReceipt) {
  return request({
    url: '/inventory/inventoryReceiptProcessing/' + parseStrEmpty(SystematicReceipt),
    method: 'get'
  })
}

// 保存库存单据
export function saveInventoryReceipt(data) {
  return request({
    url: '/inventory/inventoryReceiptProcessing/save',
    method: 'post',
    data: data
  })
}

// 保存库存调拨单据
export function saveInventoryTransfer(data) {
  return request({
    url: '/inventory/inventoryReceiptProcessing/saveInventoryTransfer',
    method: 'post',
    data: data
  })
}

// 保存库存盘点单据
export function saveInventoryCounting(data) {
  return request({
    url: '/inventory/inventoryReceiptProcessing/saveInventoryCounting',
    method: 'post',
    data: data
  })
}

/**   删除库存单据    */
export function delReceipt(data) {
  return request({
    url: '/inventory/inventoryReceiptQuery/delete',
    method: 'post',
    data: data
  })
}