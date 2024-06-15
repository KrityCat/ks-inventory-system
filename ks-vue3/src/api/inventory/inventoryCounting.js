import request from '@/utils/request'
import { parseStrEmpty } from "@/utils/ruoyi";

// 查询库存盘点单据详情
export function getHeadReceipt(SystematicReceipt) {
  return request({
    url: '/system/inventory/' + parseStrEmpty(SystematicReceipt),
    method: 'get'
  })
}

// 保存库存盘点单据
export function saveInventoryCounting(data) {
  return request({
    url: '/system/inventory/saveInventoryCounting',
    method: 'post',
    data: data
  })
}