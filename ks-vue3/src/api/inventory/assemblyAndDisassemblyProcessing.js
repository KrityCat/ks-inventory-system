import request from '@/utils/request'
import { parseStrEmpty } from "@/utils/ruoyi";

// 查询组装与拆分单据详情
export function getReceipt(SystematicReceipt) {
  return request({
    url: '/inventory/assemblyAndDisassemblyProcessing/' + parseStrEmpty(SystematicReceipt),
    method: 'get'
  })
}

// 保存组装与拆分单据
export function saveAssemblyAndDisassemblyReceipt(data) {
  return request({
    url: '/inventory/assemblyAndDisassemblyProcessing/save',
    method: 'post',
    data: data
  })
}

/**   删除组装与拆分单据    */
export function delReceipt(data) {
  return request({
    url: '/inventory/assemblyAndDisassemblyProcessing/delete',
    method: 'post',
    data: data
  })
}