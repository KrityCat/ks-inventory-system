import request from '@/utils/request'
import { parseStrEmpty } from "@/utils/ruoyi";

// 查询商品列表
export function listCommodity(query) {
  return request({
    url: '/baseDate/commodity/list',
    method: 'get',
    params: query
  })
}

// 查询商品详细
export function getCommodity(commodityId) {
  return request({
    url: '/baseDate/commodity/' + parseStrEmpty(commodityId),
    method: 'get'
  })
}

// 新增商品
export function addCommodity(data) {
  return request({
    url: '/baseDate/commodity/add',
    method: 'post',
    data: data
  })
}

// 修改商品
export function updateCommodity(data) {
  return request({
    url: '/baseDate/commodity/update',
    method: 'put',
    data: data
  })
}

// 删除商品
export function delCommodity(commodityId) {
  return request({
    url: '/baseDate/commodity/' + commodityId,
    method: 'delete'
  })
}

// 查询用户个人信息
export function getUserProfile() {
  return request({
    url: '/system/user/profile',
    method: 'get'
  })
}

// 查询商品下拉树结构
export function commodityTypeTreeSelect() {
  return request({
    url: '/baseDate/commodity/commodityTypeTree',
    method: 'get'
  })
}
