import request from '@/utils/request'
import { parseStrEmpty } from "@/utils/ruoyi";

// 查询报溢单据详情
export function getReceipt(SystematicReceipt) {
  return request({
    url: '/inventory/reportOverflowProcessing/' + parseStrEmpty(SystematicReceipt),
    method: 'get'
  })
}

// 保存报溢单据
export function saveInventoryReceipt(data) {
  return request({
    url: '/inventory/reportOverflowProcessing/save',
    method: 'post',
    data: data
  })
}

/**   删除报溢单据    */
export function delReceipt(data) {
  return request({
    url: '/inventory/reportOverflowProcessing/delete',
    method: 'post',
    data: data
  })
}