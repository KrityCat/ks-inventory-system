import request from '@/utils/request'
import { parseStrEmpty } from "@/utils/ruoyi";

// 查询其他出库单据详情
export function getHeadReceipt(SystematicReceipt) {
  return request({
    url: '/system/inventory/' + parseStrEmpty(SystematicReceipt),
    method: 'get'
  })
}

// 保存其他出库单据
export function saveOutboundOther(data) {
  return request({
    url: '/system/inventory/saveOutboundOther',
    method: 'post',
    data: data
  })
}