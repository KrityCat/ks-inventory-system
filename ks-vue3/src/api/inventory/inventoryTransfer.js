import request from '@/utils/request'
import { parseStrEmpty } from "@/utils/ruoyi";

// 查询库存调拨单据详情
export function getHeadReceipt(SystematicReceipt) {
  return request({
    url: '/system/inventory/' + parseStrEmpty(SystematicReceipt),
    method: 'get'
  })
}

// 保存库存调拨单据
export function saveInventoryTransfer(data) {
  return request({
    url: '/system/inventory/saveInventoryTransfer',
    method: 'post',
    data: data
  })
}