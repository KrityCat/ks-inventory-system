import request from "@/utils/request";
// 首页
export function indexUrl() {
  return request({
    url: "/baseDate/jiMuReport/index",
    method: "get"
  });
}
// 浏览
export function viewUrl() {
  return request({
    url: "/baseDate/jiMuReport/view",
    method: "get"
  });
}

// 查询打印文件信息列表
export function listJiMuReport(query) {
  return request({
    url: '/baseDate/jiMuReport/list',
    method: 'get',
    params: query
  })
}