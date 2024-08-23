import request from '@/utils/request'
import { parseStrEmpty } from "@/utils/ruoyi";

// 查询货品列表
export function listProduct(query) {
  return request({
    url: '/baseDate/product/list',
    method: 'get',
    params: query
  })
}

// 查询货品库存积压告警列表
export function listOverstockProduct(query) {
  return request({
    url: '/baseDate/product/overstockList',
    method: 'get',
    params: query
  })
}

// 查询货品库存不足告警列表
export function listDangerProduct(query) {
  return request({
    url: '/baseDate/product/dangerList',
    method: 'get',
    params: query
  })
}

// 积压3个月未出预警列表
export function listThreeOverstock(query) {
  return request({
    url: '/baseDate/product/threeOverstockList',
    method: 'get',
    params: query
  })
}

// 积压6个月未出预警列表
export function listSixOverstock(query) {
  return request({
    url: '/baseDate/product/sixOverstockList',
    method: 'get',
    params: query
  })
}

// 积压12个月未出预警列表
export function listTwelveOverstock(query) {
  return request({
    url: '/baseDate/product/twelveOverstockList',
    method: 'get',
    params: query
  })
}

// 查询货品详细
export function getProduct(productId) {
  return request({
    url: '/baseDate/product/' + parseStrEmpty(productId),
    method: 'get'
  })
}

// 新增货品
export function addProduct(data) {
  return request({
    url: '/baseDate/product/add',
    method: 'post',
    data: data
  })
}

// 修改货品
export function updateProduct(data) {
  return request({
    url: '/baseDate/product/update',
    method: 'put',
    data: data
  })
}

// 删除货品
export function delProduct(productId) {
  return request({
    url: '/baseDate/product/' + productId,
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

// 查询货品下拉树结构
export function productTypeTreeSelect() {
  return request({
    url: '/baseDate/product/productTypeTree',
    method: 'get'
  })
}
