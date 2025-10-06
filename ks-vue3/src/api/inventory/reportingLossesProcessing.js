import request from '@/utils/request'
import { parseStrEmpty } from "@/utils/ruoyi";

// 查询报损单据详情
export function getReceipt(SystematicReceipt) {
  return request({
    url: '/inventory/reportingLossesProcessing/' + parseStrEmpty(SystematicReceipt),
    method: 'get'
  })
}

// 保存报损单据
export function saveInventoryReceipt(data) {
  return request({
    url: '/inventory/reportingLossesProcessing/save',
    method: 'post',
    data: data
  })
}

/**   删除报损单据    */
export function delReceipt(data) {
  return request({
    url: '/inventory/reportingLossesProcessing/delete',
    method: 'post',
    data: data
  })
}