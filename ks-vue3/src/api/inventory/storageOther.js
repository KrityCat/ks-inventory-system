import request from '@/utils/request'
import { parseStrEmpty } from "@/utils/ruoyi";

// 查询其他入库单据详情
export function getHeadReceipt(SystematicReceipt) {
  return request({
    url: '/system/inventory/' + parseStrEmpty(SystematicReceipt),
    method: 'get'
  })
}

// 保存其他入库单据
export function saveStorageOther(data) {
  return request({
    url: '/system/inventory/saveStorageOther',
    method: 'post',
    data: data
  })
}