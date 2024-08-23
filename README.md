<h1 align="center" style="margin: 30px 0 30px; font-weight: bold;">铠思商用进销存系统 v1.1.0</h1>
<h4 align="center">基于SpringBoot+Vue前后端分离的Java快速开发框架</h4>

## 平台简介

铠思进销存系统是一套开源的商用进销存系统(非生产)，用于中小公司系统转型。

* 前端采用Vue3、Element PLUS。
* 后端采用Spring Boot、Spring Security、Redis、Jwt & Jmreport。
* 权限认证使用Jwt，支持多终端认证系统。
* 支持加载动态权限菜单，多方式轻松权限控制。
* 单据状态生效，即可进入库存计算，非拟制不可。
* 库存发生汇总、明细，有效记录货品数据与金额进出数据。
* 页面可实时编辑打印模板并支持单据页面调用打印。
* 文件共享功能，上传文件内部可具有长期下载。
* 针对历史系统的数据迁移困难，支持历史单据批量导入。
* 销售单据生效可生成售后单据，通过售后单据可有效电子化售后。

## 登录账号

* 账号：admin
* 密码：admin123

## 商业版

* 支持定制化和上云服务，价格方案可WeChat【h508441878】或QQ【508441878】咨询。
* 铠思财务系统与铠思·繁星系统（进销存财务一体化）在开发中，敬请期待。

## 功能界面

<img alt="首页" height="24%" src="./img/首页.png" width="24%"/>
<img alt="采购订单制作草稿" height="24%" src="./img/采购订单制作草稿.png" width="24%"/>
<img alt="采购订单制作待审核" height="24%" src="./img/采购订单制作待审核.png" width="24%"/>
<img alt="采购订单查询" height="24%" src="./img/采购订单查询.png" width="24%"/>
<img alt="库存发生汇总" height="24%" src="./img/库存发生汇总.png" width="24%"/>
<img alt="库存发生明细" height="24%" src="./img/库存发生明细.png" width="24%"/>
<img alt="库存货品查询" height="24%" src="./img/库存货品查询.png" width="24%"/>
<img alt="打印文件设计" height="24%" src="./img/打印文件设计.png" width="24%"/>

## 内置主要功能

1. 采购管理：采购订单制作、采购单据制作、采购订单查询、采购单据查询
2. 销售管理：销售订单制作、销售单据制作、销售订单查询、销售单据查询
3. 库存管理：库存单据制作、库存调拨单据制作、库存盘点单据制作、库存单据查询、库存发生汇总、库存发生明细、库存货品查询、历史单据迁移
4. 售后管理：售后单据制作、售后单据查询
5. 基础数据：供应商资料、客户资料、仓库资料、货品资料、货品类型、文件共享
6. 打印管理：打印文件设计、打印文件查询

## 本地启动环境步骤

1. [VMware17安装Centos7 图文教程](https://blog.csdn.net/weixin_45807466/article/details/134276225)
2. [Centos7开机开启网络并固定IP地址](https://blog.csdn.net/weixin_45807466/article/details/137029183)
3. [Redhat7或Centos7自带Yum源卸载并安装国内Yum源](https://blog.csdn.net/weixin_45807466/article/details/115397778)
4. [Centos7下docker安装Mysql与Redis](https://blog.csdn.net/weixin_45807466/article/details/137208441)
5. 需执行jimureport.mysql5.7.create.sql与ks_20240320.sql
6. 替换Mysql与Redis配置IP
7. 前端：ks-vue3目录下输入'npm install','npm run dev'
8. 后端：ruoyi-admin→src→main→java→com→ruoyi→web→启动RuoYiApplication

## docker部署生产环境步骤

* [私有云Centos7从VMware搭建到Docker安装Jenkins部署Vue与Springboot生产环境全流程](https://blog.csdn.net/weixin_45807466/article/details/137029386)

## 常见问题解决方案

### 1、本地环境启动功能页面跳转空白处理

目录：ks-vue3/src/layout/components/AppMain.vue
操作：只置灰< transition > < /transition >
