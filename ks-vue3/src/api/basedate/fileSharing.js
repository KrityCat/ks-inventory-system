import request from '@/utils/request'
import { parseStrEmpty } from "@/utils/ruoyi";

// 查询文件信息列表
export function listFile(query) {
  return request({
    url: '/baseDate/fileSharing/list',
    method: 'get',
    params: query
  })
}

// 查询文件
export function getFile(fileId) {
  return request({
    url: '/baseDate/fileSharing/' + parseStrEmpty(fileId),
    method: 'get'
  })
}

// 新增文件
export function addFileName(data) {
  return request({
    url: '/baseDate/fileSharing/add',
    method: 'put',
    data: data
  })
}

// 修改文件名称
export function updateFileName(data) {
  return request({
    url: '/baseDate/fileSharing/update',
    method: 'put',
    data: data
  })
}

// 上传文件
export function fileUpload(data) {
  return request({
    url: '/baseDate/fileSharing/upload',
    method: 'post',
    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
    data: data
  })
}

// 删除文件
export function delFile(fileId) {
  return request({
    url: '/baseDate/fileSharing/' + fileId,
    method: 'delete'
  })
}
