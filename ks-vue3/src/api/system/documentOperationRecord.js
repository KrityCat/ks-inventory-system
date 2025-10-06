import request from '@/utils/request'

// 查询单据操作记录列表
export function listDocumentOperationRecord(query) {
  return request({
    url: '/system/documentOperationRecord/list',
    method: 'get',
    params: query
  })
}

// 查询单据操作记录详细
export function getDocumentOperationRecord(logId) {
  return request({
    url: '/system/documentOperationRecord/' + logId,
    method: 'get'
  })
}

// 新增单据操作记录
export function addDocumentOperationRecord(data) {
  return request({
    url: '/system/documentOperationRecord',
    method: 'post',
    data: data
  })
}

// 修改单据操作记录
export function updateDocumentOperationRecord(data) {
  return request({
    url: '/system/documentOperationRecord',
    method: 'put',
    data: data
  })
}

// 删除单据操作记录
export function delDocumentOperationRecord(logId) {
  return request({
    url: '/system/documentOperationRecord/' + logId,
    method: 'delete'
  })
}
