import request from '@/utils/request'
import {parseStrEmpty} from "@/utils/ruoyi";

// 查询用户列表
export function userList(query) {
    return request({
        url: '/common/commonReceipt/userList',
        method: 'get',
        params: query
    })
}

// 查询仓库信息列表
export function warehouseList(query) {
    return request({
        url: '/common/commonReceipt/warehouseList',
        method: 'get',
        params: query
    })
}

// 查询供应商信息列表
export function supplierList(query) {
    return request({
        url: '/common/commonReceipt/supplierList',
        method: 'get',
        params: query
    })
}

// 查询客户信息列表
export function customerList(query) {
    return request({
        url: '/common/commonReceipt/customerList',
        method: 'get',
        params: query
    })
}

// 查询货品列表
export function productList(query) {
    return request({
        url: '/common/commonReceipt/productList',
        method: 'get',
        params: query
    })
}

// 查询货品列表
export function inventoryList(query) {
    return request({
        url: '/common/commonReceipt/inventoryList',
        method: 'get',
        params: query
    })
}

// 查询单据锁单数量列表
export function lockList(query) {
    return request({
        url: '/common/commonReceipt/lockList',
        method: 'get',
        params: query
    })
}

// 查询单据详情
export function getReceipt(SystematicReceipt) {
    return request({
        url: '/common/commonReceipt/' + parseStrEmpty(SystematicReceipt),
        method: 'get'
    })
}


// 库存数量查询
export function selectInventoryQtyQuery(query) {
    return request({
        url: '/common/commonReceipt/selectInventoryQtyQuery',
        method: 'get',
        params: query
    })
}

// 入库锁单数量查询
export function selectLockInventoryQtyQuery(query) {
    return request({
        url: '/common/commonReceipt/selectLockInventoryQtyQuery',
        method: 'get',
        params: query
    })
}

// 单据锁单数量查询
export function selectLockQtyQuery(query) {
    return request({
        url: '/common/commonReceipt/selectLockQtyQuery',
        method: 'get',
        params: query
    })
}

// 单据锁单数量查询
export function selectPrintQuery(query) {
    return request({
        url: '/common/commonReceipt/printList',
        method: 'get',
        params: query
    })
}