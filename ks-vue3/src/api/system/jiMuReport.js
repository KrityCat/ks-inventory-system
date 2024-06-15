import request from '@/utils/request'
import { parseStrEmpty } from "@/utils/ruoyi";

// 查询在线Excel设计器信息列表
export function listJiMuReport(query) {
  return request({
    url: '/baseDate/jiMuReport/list',
    method: 'get',
    params: query
  })
}

// 查询在线Excel设计器详细
export function getJiMuReport(id) {
  return request({
    url: '/baseDate/jiMuReport/' + parseStrEmpty(id),
    method: 'get'
  })
}
