-- ----------------------------
-- 0、创建库
-- ----------------------------
create DATABASE `KsDataBase`;

-- ----------------------------
-- 1、部门表
-- ----------------------------
drop table if exists sys_dept;
create table sys_dept (
  dept_id           bigint(20)      not null auto_increment    comment '部门id',
  parent_id         bigint(20)      default 0                  comment '父部门id',
  ancestors         varchar(50)     default ''                 comment '祖级列表',
  dept_name         varchar(30)     default ''                 comment '部门名称',
  order_num         int(4)          default 0                  comment '显示顺序',
  leader            varchar(20)     default null               comment '负责人',
  phone             varchar(11)     default null               comment '联系电话',
  email             varchar(50)     default null               comment '邮箱',
  status            char(1)         default '0'                comment '部门状态（0正常 1停用）',
  del_flag          char(1)         default '0'                comment '删除标志（0代表存在 2代表删除）',
  create_by         varchar(64)     default ''                 comment '创建者',
  create_time 	    datetime                                   comment '创建时间',
  update_by         varchar(64)     default ''                 comment '更新者',
  update_time       datetime                                   comment '更新时间',
  primary key (dept_id)
) engine=innodb auto_increment=200 comment = '部门表';

-- ----------------------------
-- 初始化-部门表数据
-- ----------------------------
insert into sys_dept values(100,  0,   '0',          '铠思进销存',   0, 'kc', '15888888888', 'ks@qq.com', '0', '0', 'admin', sysdate(), '', null);

-- ----------------------------
-- 2、用户信息表
-- ----------------------------
drop table if exists sys_user;
create table sys_user (
  user_id           bigint(20)      not null auto_increment    comment '用户id',
  dept_id           bigint(20)      default null               comment '部门id',
  user_name         varchar(30)     not null                   comment '用户账号',
  nick_name         varchar(30)     not null                   comment '用户昵称',
  user_type         varchar(2)      default '00'               comment '用户类型（00系统用户）',
  email             varchar(50)     default ''                 comment '用户邮箱',
  phonenumber       varchar(11)     default ''                 comment '手机号码',
  sex               char(1)         default '0'                comment '用户性别（0男 1女 2未知）',
  avatar            varchar(100)    default ''                 comment '头像地址',
  password          varchar(100)    default ''                 comment '密码',
  status            char(1)         default '0'                comment '帐号状态（0正常 1停用）',
  del_flag          char(1)         default '0'                comment '删除标志（0代表存在 2代表删除）',
  login_ip          varchar(128)    default ''                 comment '最后登录ip',
  login_date        datetime                                   comment '最后登录时间',
  create_by         varchar(64)     default ''                 comment '创建者',
  create_time       datetime                                   comment '创建时间',
  update_by         varchar(64)     default ''                 comment '更新者',
  update_time       datetime                                   comment '更新时间',
  remark            varchar(500)    default null               comment '备注',
  primary key (user_id)
) engine=innodb auto_increment=100 comment = '用户信息表';

-- ----------------------------
-- 初始化-用户信息表数据
-- ----------------------------
insert into sys_user values(1,  103, 'admin', 'kc', '00', 'kc@163.com', '15888888888', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', sysdate(), 'admin', sysdate(), '', null, '管理员');


-- ----------------------------
-- 3、岗位信息表
-- ----------------------------
drop table if exists sys_post;
create table sys_post
(
  post_id       bigint(20)      not null auto_increment    comment '岗位id',
  post_code     varchar(64)     not null                   comment '岗位编码',
  post_name     varchar(50)     not null                   comment '岗位名称',
  post_sort     int(4)          not null                   comment '显示顺序',
  status        char(1)         not null                   comment '状态（0正常 1停用）',
  create_by     varchar(64)     default ''                 comment '创建者',
  create_time   datetime                                   comment '创建时间',
  update_by     varchar(64)     default ''			       comment '更新者',
  update_time   datetime                                   comment '更新时间',
  remark        varchar(500)    default null               comment '备注',
  primary key (post_id)
) engine=innodb comment = '岗位信息表';

-- ----------------------------
-- 初始化-岗位信息表数据
-- ----------------------------
insert into sys_post values(1, 'ceo',  '董事长',    1, '0', 'admin', sysdate(), '', null, '');
insert into sys_post values(2, 'se',   '项目经理',  2, '0', 'admin', sysdate(), '', null, '');
insert into sys_post values(3, 'hr',   '人力资源',  3, '0', 'admin', sysdate(), '', null, '');
insert into sys_post values(4, 'user', '普通员工',  4, '0', 'admin', sysdate(), '', null, '');


-- ----------------------------
-- 4、角色信息表
-- ----------------------------
drop table if exists sys_role;
create table sys_role (
  role_id              bigint(20)      not null auto_increment    comment '角色id',
  role_name            varchar(30)     not null                   comment '角色名称',
  role_key             varchar(100)    not null                   comment '角色权限字符串',
  role_sort            int(4)          not null                   comment '显示顺序',
  data_scope           char(1)         default '1'                comment '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  menu_check_strictly  tinyint(1)      default 1                  comment '菜单树选择项是否关联显示',
  dept_check_strictly  tinyint(1)      default 1                  comment '部门树选择项是否关联显示',
  status               char(1)         not null                   comment '角色状态（0正常 1停用）',
  del_flag             char(1)         default '0'                comment '删除标志（0代表存在 2代表删除）',
  create_by            varchar(64)     default ''                 comment '创建者',
  create_time          datetime                                   comment '创建时间',
  update_by            varchar(64)     default ''                 comment '更新者',
  update_time          datetime                                   comment '更新时间',
  remark               varchar(500)    default null               comment '备注',
  primary key (role_id)
) engine=innodb auto_increment=100 comment = '角色信息表';

-- ----------------------------
-- 初始化-角色信息表数据
-- ----------------------------
insert into sys_role values('1', '超级管理员',		'admin',  1, 1, 1, 1, '0', '0', 'admin', sysdate(), '', null, '超级管理员');

-- ----------------------------
-- 5、菜单权限表
-- ----------------------------
drop table if exists sys_menu;
create table sys_menu (
  menu_id           bigint(20)      not null auto_increment    comment '菜单id',
  menu_name         varchar(50)     not null                   comment '菜单名称',
  parent_id         bigint(20)      default 0                  comment '父菜单id',
  order_num         int(4)          default 0                  comment '显示顺序',
  path              varchar(200)    default ''                 comment '路由地址',
  component         varchar(255)    default null               comment '组件路径',
  query             varchar(255)    default null               comment '路由参数',
  is_frame          int(1)          default 1                  comment '是否为外链（0是 1否）',
  is_cache          int(1)          default 0                  comment '是否缓存（0缓存 1不缓存）',
  menu_type         char(1)         default ''                 comment '菜单类型（m目录 c菜单 f按钮）',
  visible           char(1)         default 0                  comment '菜单状态（0显示 1隐藏）',
  status            char(1)         default 0                  comment '菜单状态（0正常 1停用）',
  perms             varchar(100)    default null               comment '权限标识',
  icon              varchar(100)    default '#'                comment '菜单图标',
  create_by         varchar(64)     default ''                 comment '创建者',
  create_time       datetime                                   comment '创建时间',
  update_by         varchar(64)     default ''                 comment '更新者',
  update_time       datetime                                   comment '更新时间',
  remark            varchar(500)    default ''                 comment '备注',
  primary key (menu_id)
) engine=innodb auto_increment=2000 comment = '菜单权限表';

-- ----------------------------
-- 初始化-菜单信息表数据
-- ----------------------------
-- 一级菜单
insert into sys_menu values(1,  '首页',    0, 1, 'home',        null, '', 1, 0, 'C', '1', '0', '', 'index',           'admin', sysdate(), '', null, '首页');
insert into sys_menu values(2,  '采购管理', 0, 2, 'purchase',     null, '', 1, 0, 'M', '0', '0', '', 'shopping',        'admin', sysdate(), '', null, '采购管理目录');
insert into sys_menu values(3,  '销售管理', 0, 3, 'sales',        null, '', 1, 0, 'M', '0', '0', '', 'form',            'admin', sysdate(), '', null, '销售管理目录');
insert into sys_menu values(4,  '库存管理', 0, 4, 'inventory',    null, '', 1, 0, 'M', '0', '0', '', 'tab',             'admin', sysdate(), '', null, '库存管理目录');
insert into sys_menu values(6,  '售后管理', 0, 6, 'afterSales',   null, '', 1, 0, 'M', '0', '0', '', 'form',            'admin', sysdate(), '', null, '售后管理目录');
insert into sys_menu values(7,  '现金管理', 0, 7, 'cash',         null, '', 1, 0, 'M', '1', '0', '', 'money',           'admin', sysdate(), '', null, '现金管理目录');
insert into sys_menu values(20, '基础数据', 0, 8, 'basedate',     null, '', 1, 0, 'M', '0', '0', '', 'documentation',   'admin', sysdate(), '', null, '基础数据目录');
insert into sys_menu values(21, '打印管理', 0, 9, 'printFile',    null, '', 1, 0, 'M', '0', '0', '', 'table',           'admin', sysdate(), '', null, '打印管理目录');
insert into sys_menu values(22, '系统管理', 0, 10, 'system',      null, '', 1, 0, 'M', '0', '0', '', 'system',   			  'admin', sysdate(), '', null, '系统管理目录');
insert into sys_menu values(23, '系统监控', 0, 11, 'monitor',     null, '', 1, 0, 'M', '0', '0', '', 'monitor',  			  'admin', sysdate(), '', null, '系统监控目录');
insert into sys_menu values(24, '系统工具', 0, 12, 'tool',        null, '', 1, 0, 'M', '0', '0', '', 'tool',     			  'admin', sysdate(), '', null, '系统工具目录');
insert into sys_menu values(25, '操作手册', 0, 13, 'manual',      'system/manual/index', null, 1, 0, 'C', '0', '0', '', 'discount',        'admin', sysdate(), '', null, '操作手册页面');
-- 二级菜单
-- 采购管理
insert into sys_menu values(30, '采购订单制作', 	2, 1, 'purchaseOrderProcessing',         'system/purchase/purchaseOrderProcessing',            null, 1, 1, 'C', '0', '0', '', 										'edit', 	'admin', sysdate(), '', null, '');
insert into sys_menu values(31, '采购单据制作', 	2, 2, 'purchaseDocumentProcessing',      'system/purchase/purchaseDocumentProcessing',         null, 1, 1, 'C', '0', '0', '', 										'shopping', 	'admin', sysdate(), '', null, '');
insert into sys_menu values(32, '采购订单查询', 	2, 3, 'purchaseOrderQuery',              'system/purchase/purchaseOrderQuery',                 null, 1, 0, 'C', '0', '0', '', 										'clipboard', 	'admin', sysdate(), '', null, '');
insert into sys_menu values(33, '采购单据查询', 	2, 4, 'purchaseDocumentQuery',           'system/purchase/purchaseDocumentQuery',              null, 1, 0, 'C', '0', '0', '', 										'search', 	'admin', sysdate(), '', null, '');
-- 销售管理
insert into sys_menu values(34, '销售订单制作', 	3, 1, 'salesOrderProcessing',            'system/sales/salesOrderProcessing',                  null, 1, 1, 'C', '0', '0', '', 										'edit', 	'admin', sysdate(), '', null, '');
insert into sys_menu values(35, '销售单据制作', 	3, 2, 'salesDocumentProcessing',         'system/sales/salesDocumentProcessing',               null, 1, 1, 'C', '0', '0', '', 										'shopping', 	'admin', sysdate(), '', null, '');
insert into sys_menu values(36, '销售订单查询', 	3, 3, 'salesOrderQuery',                 'system/sales/salesOrderQuery',                       null, 1, 0, 'C', '0', '0', '', 										'clipboard', 		'admin', sysdate(), '', null, '');
insert into sys_menu values(37, '销售单据查询', 	3, 4, 'salesDocumentQuery',              'system/sales/salesDocumentQuery',                    null, 1, 0, 'C', '0', '0', '', 										'search', 		'admin', sysdate(), '', null, '');
-- 库存管理
insert into sys_menu values(40, '库存单据制作', 	4, 1, 'inventoryDocumentProcessing',     'system/inventory/inventoryDocumentProcessing',       null, 1, 1, 'C', '0', '0', '', 										'nested', 	'admin', sysdate(), '', null, '');
insert into sys_menu values(41, '库存调拨单制作', 4, 2, 'inventoryTransfer',               'system/inventory/InventoryTransfer',                 null, 1, 1, 'C', '0', '0', '', 										'redis-list', 	'admin', sysdate(), '', null, '');
insert into sys_menu values(42, '库存盘点单制作', 4, 3, 'inventoryCounting',               'system/inventory/InventoryCounting',                 null, 1, 1, 'C', '0', '0', '', 										'table', 		'admin', sysdate(), '', null, '');
insert into sys_menu values(43, '库存单据查询', 	4, 4, 'inventoryDocumentQuery',          'system/inventory/InventoryDocumentQuery',            null, 1, 0, 'C', '0', '0', '', 										'swagger', 		'admin', sysdate(), '', null, '');
insert into sys_menu values(44, '库存发生汇总', 	4, 5, 'inventoryOccurrenceSummary',      'system/inventory/InventoryOccurrenceSummary',        null, 1, 0, 'C', '0', '0', '',										'tree-table', 	'admin', sysdate(), '', null, '');
insert into sys_menu values(45, '库存发生明细', 	4, 6, 'inventoryOccurrenceDetails',      'system/inventory/InventoryOccurrenceDetails',        null, 1, 0, 'C', '0', '0', '',										'tree', 		'admin', sysdate(), '', null, '');
insert into sys_menu values(46, '库存货品查询', 	4, 7, 'inventoryItemInquiry',            'system/inventory/InventoryItemInquiry',              null, 1, 0, 'C', '0', '0', '', 										'zip', 			'admin', sysdate(), '', null, '');
insert into sys_menu values(47, '历史单据迁移', 	4, 8, 'HistoricalDocuments',             'system/inventory/HistoricalDocuments',               null, 1, 0, 'C', '0', '0', '', 										'guide', 		'admin', sysdate(), '', null, '');
-- 售后管理
insert into sys_menu values(52, '售后单据制作', 	6, 1, 'afterSalesOrderProcessing',       'system/aftersales/afterSalesOrderProcessing',        null, 1, 1, 'C', '0', '0', '', 										'shopping', 	'admin', sysdate(), '', null, '');
insert into sys_menu values(53, '售后单据查询', 	6, 2, 'afterSalesOrderQuery',            'system/aftersales/afterSalesOrderQuery',             null, 1, 0, 'C', '0', '0', '', 										'search', 		'admin', sysdate(), '', null, '');
-- 基础数据
insert into sys_menu values(80, '供应商资料',    20, 1, 'supplier', 								'system/basedate/supplier', 					null, 1, 0, 'C', '0', '0', 'baseDate:supplier:list', 				'clipboard', 	'admin', sysdate(), '', null, '');
insert into sys_menu values(81, '客户资料',     20, 2, 'customer', 								'system/basedate/customer', 					null, 1, 0, 'C', '0', '0', 'baseDate:customer:list', 				'peoples', 		'admin', sysdate(), '', null, '');
insert into sys_menu values(82, '仓库资料',     20, 3, 'warehouse', 								'system/basedate/warehouse', 					null, 1, 0, 'C', '0', '0', 'baseDate:warehouse:list', 				'table', 		'admin', sysdate(), '', null, '');
insert into sys_menu values(83, '商品资料',     20, 4, 'commodity', 								'system/basedate/commodity', 					null, 0, 0, 'C', '1', '1', 'baseDate:commodity:list', 				'tab', 			'admin', sysdate(), '', null, '');
insert into sys_menu values(84, '商品类型',     20, 5, 'commodityType', 							'system/basedate/commodityType', 				null, 0, 0, 'C', '1', '1', 'baseDate:commodityType:list', 			'tree-table', 	'admin', sysdate(), '', null, '');
insert into sys_menu values(85, '货品资料',     20, 6, 'product', 								'system/basedate/product', 						null, 1, 0, 'C', '0', '0', 'baseDate:product:list', 				'tab', 			'admin', sysdate(), '', null, '');
insert into sys_menu values(86, '货品类型',     20, 7, 'producttype', 							'system/basedate/productType', 					null, 1, 0, 'C', '0', '0', 'baseDate:productType:list', 			'tree-table', 	'admin', sysdate(), '', null, '');
insert into sys_menu values(87, '文件共享',     20, 8, 'filesharing', 							'system/basedate/fileSharing', 					null, 1, 0, 'C', '0', '0', '', 										'excel', 		'admin', sysdate(), '', null, '');
-- 打印管理
insert into sys_menu values(90, '打印文件设计', 	21, 1, 'jmReport',                       'jimu/index',                                         null, 1, 0, 'C', '0', '0', '', 										'table', 		'admin', sysdate(), '', null, '');
insert into sys_menu values(91, '打印文件查询', 	21, 2, 'jmReportQuery',                  'system/printfile/jmReportQuery',                     null, 1, 0, 'C', '0', '0', '', 										'excel', 		'admin', sysdate(), '', null, '');
-- 系统管理
insert into sys_menu values('100',  '用户管理', 22,   '1', 'user',       'system/user/index',        '', 1, 0, 'C', '0', '0', 'system:user:list',        'user',          'admin', sysdate(), '', null, '用户管理菜单');
insert into sys_menu values('101',  '角色管理', 22,   '2', 'role',       'system/role/index',        '', 1, 0, 'C', '0', '0', 'system:role:list',        'peoples',       'admin', sysdate(), '', null, '角色管理菜单');
insert into sys_menu values('102',  '菜单管理', 22,   '3', 'menu',       'system/menu/index',        '', 1, 0, 'C', '0', '0', 'system:menu:list',        'tree-table',    'admin', sysdate(), '', null, '菜单管理菜单');
insert into sys_menu values('103',  '部门管理', 22,   '4', 'dept',       'system/dept/index',        '', 1, 0, 'C', '0', '0', 'system:dept:list',        'tree',          'admin', sysdate(), '', null, '部门管理菜单');
insert into sys_menu values('104',  '岗位管理', 22,   '5', 'post',       'system/post/index',        '', 1, 0, 'C', '0', '0', 'system:post:list',        'post',          'admin', sysdate(), '', null, '岗位管理菜单');
insert into sys_menu values('105',  '字典管理', 22,   '6', 'dict',       'system/dict/index',        '', 1, 0, 'C', '0', '0', 'system:dict:list',        'dict',          'admin', sysdate(), '', null, '字典管理菜单');
insert into sys_menu values('106',  '参数设置', 22,   '7', 'config',     'system/config/index',      '', 1, 0, 'C', '0', '0', 'system:config:list',      'edit',          'admin', sysdate(), '', null, '参数设置菜单');
insert into sys_menu values('107',  '通知公告', 22,   '8', 'notice',     'system/notice/index',      '', 1, 0, 'C', '0', '0', 'system:notice:list',      'message',       'admin', sysdate(), '', null, '通知公告菜单');
insert into sys_menu values('108',  '日志管理', 22,   '9', 'log',        '',                         '', 1, 0, 'M', '0', '0', '',                        'log',           'admin', sysdate(), '', null, '日志管理菜单');
insert into sys_menu values('109',  '在线用户', 23,   '1', 'online',     'monitor/online/index',     '', 1, 0, 'C', '0', '0', 'monitor:online:list',     'online',        'admin', sysdate(), '', null, '在线用户菜单');
insert into sys_menu values('110',  '定时任务', 23,   '2', 'job',        'monitor/job/index',        '', 1, 0, 'C', '0', '0', 'monitor:job:list',        'job',           'admin', sysdate(), '', null, '定时任务菜单');
insert into sys_menu values('111',  '数据监控', 23,   '3', 'druid',      'monitor/druid/index',      '', 1, 0, 'C', '0', '0', 'monitor:druid:list',      'druid',         'admin', sysdate(), '', null, '数据监控菜单');
insert into sys_menu values('112',  '服务监控', 23,   '4', 'server',     'monitor/server/index',     '', 1, 0, 'C', '0', '0', 'monitor:server:list',     'server',        'admin', sysdate(), '', null, '服务监控菜单');
insert into sys_menu values('113',  '缓存监控', 23,   '5', 'cache',      'monitor/cache/index',      '', 1, 0, 'C', '0', '0', 'monitor:cache:list',      'redis',         'admin', sysdate(), '', null, '缓存监控菜单');
insert into sys_menu values('114',  '缓存列表', 23,   '6', 'cachelist',  'monitor/cache/list',       '', 1, 0, 'C', '0', '0', 'monitor:cache:list',      'redis-list',    'admin', sysdate(), '', null, '缓存列表菜单');
insert into sys_menu values('115',  '表单构建', 24,   '1', 'build',      'tool/build/index',         '', 1, 0, 'C', '0', '0', 'tool:build:list',         'build',         'admin', sysdate(), '', null, '表单构建菜单');
insert into sys_menu values('116',  '代码生成', 24,   '2', 'gen',        'tool/gen/index',           '', 1, 0, 'C', '0', '0', 'tool:gen:list',           'code',          'admin', sysdate(), '', null, '代码生成菜单');
insert into sys_menu values('117',  '系统接口', 24,   '3', 'swagger',    'tool/swagger/index',       '', 1, 0, 'C', '0', '0', 'tool:swagger:list',       'swagger',       'admin', sysdate(), '', null, '系统接口菜单');
-- 三级菜单
-- 日志管理
insert into sys_menu values('500',  '操作日志', '108', '1', 'operlog',    'monitor/operlog/index',    '', 1, 0, 'C', '0', '0', 'monitor:operlog:list',    'form',          'admin', sysdate(), '', null, '操作日志菜单');
insert into sys_menu values('501',  '登录日志', '108', '2', 'logininfor', 'monitor/logininfor/index', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor',    'admin', sysdate(), '', null, '登录日志菜单');
-- 首页展示
insert into sys_menu values(700, '销售金额与毛利润查询',    1, 0, '', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryReceiptQuery:salesAmountQuery',      '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(701, '订单审核查询',          1, 1, '', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseOrderQuery:headQuery',      '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(702, '订单审核展示',          1, 2, '', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseOrderQuery:headShow',      '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(703, '单据审核查询',          1, 3, '', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryReceiptQuery:headQuery',      '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(704, '单据审核展示',          1, 4, '', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryReceiptQuery:headShow',      '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(705, '预警查询',             1, 5, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:product:list',      '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(706, '预警展示',             1, 6, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:product:show',      '#', 'admin', sysdate(), '', null, '');
-- 供应商资料按钮
insert into sys_menu values(800, '供应商查询',     80, 1, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:supplier:list',             '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(801, '供应商详情',     80, 2, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:supplier:query',            '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(802, '供应商新增',     80, 3, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:supplier:add',            '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(803, '供应商修改',     80, 4, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:supplier:update',           '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(804, '供应商删除',     80, 5, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:supplier:remove',           '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(805, '供应商导入',     80, 6, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:supplier:import',           '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(806, '供应商导出',     80, 7, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:supplier:export',           '#', 'admin', sysdate(), '', null, '');
-- 客户资料按钮
insert into sys_menu values(810, '客户查询',      81, 1, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:customer:list',             '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(811, '客户详情',      81, 2, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:customer:query',            '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(812, '客户新增',      81, 3, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:customer:add',            '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(813, '客户修改',      81, 4, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:customer:update',           '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(814, '客户删除',      81, 5, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:customer:remove',           '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(815, '客户导入',      81, 6, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:customer:import',           '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(816, '客户导出',      81, 7, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:customer:export',           '#', 'admin', sysdate(), '', null, '');
-- 仓库资料按钮
insert into sys_menu values(820, '仓库查询',      82, 1, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:warehouse:list',            '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(821, '仓库详情',      82, 2, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:warehouse:query',           '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(822, '仓库新增',      82, 3, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:warehouse:add',             '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(823, '仓库修改',      82, 4, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:warehouse:update',          '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(824, '仓库删除',      82, 5, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:warehouse:remove',          '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(825, '仓库导入',      82, 6, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:warehouse:import',          '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(826, '仓库导出',      82, 7, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:warehouse:export',          '#', 'admin', sysdate(), '', null, '');
-- 商品资料按钮
insert into sys_menu values(830, '商品类型',      83, 1, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:commodity:commodityTypeTree',     '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(831, '商品查询',      83, 2, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:commodity:list',            '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(832, '商品详情',      83, 3, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:commodity:query',           '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(833, '商品新增',      83, 4, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:commodity:add',             '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(834, '商品修改',      83, 5, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:commodity:update',          '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(835, '商品删除',      83, 6, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:commodity:remove',          '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(836, '商品导入',      83, 7, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:commodity:import',          '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(837, '商品导出',      83, 8, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:commodity:export',          '#', 'admin', sysdate(), '', null, '');
-- 商品类型按钮
insert into sys_menu values(840, '商品类型查询',    84, 1, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:commodityType:list',          '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(841, '商品类型详情',    84, 2, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:commodityType:query',         '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(842, '商品类型新增',    84, 3, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:commodityType:add',         '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(843, '商品类型修改',    84, 4, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:commodityType:edit',          '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(844, '商品类型删除',    84, 5, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:commodityType:remove',        '#', 'admin', sysdate(), '', null, '');
-- 货品资料按钮
insert into sys_menu values(850, '货品类型',      85, 1, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:product:productTypeTree',       '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(851, '货品查询',      85, 2, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:product:list',            '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(852, '货品详情',      85, 3, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:product:query',             '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(853, '货品新增',      85, 4, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:product:add',             '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(854, '货品修改',      85, 5, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:product:update',            '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(855, '货品删除',      85, 6, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:product:remove',            '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(856, '货品导入',      85, 7, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:product:import',            '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(857, '货品导出',      85, 8, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:product:export',            '#', 'admin', sysdate(), '', null, '');
-- 货品类型按钮
insert into sys_menu values(860, '货品类型查询',    86, 1, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:productType:list',          '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(861, '货品类型详情',    86, 2, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:productType:query',           '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(862, '货品类型新增',    86, 3, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:productType:add',           '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(863, '货品类型修改',    86, 4, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:productType:edit',          '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(864, '货品类型删除',    86, 5, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:productType:remove',          '#', 'admin', sysdate(), '', null, '');
-- 文件共享按钮
insert into sys_menu values(870, '文件共享查询',    87, 1, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:fileSharing:list',          '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(871, '文件共享详情',    87, 2, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:fileSharing:query',           '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(872, '文件共享上传',    87, 3, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:fileSharing:upload',          '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(873, '文件共享修改',    87, 4, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:fileSharing:update',          '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(874, '文件共享删除',    87, 5, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:fileSharing:remove',          '#', 'admin', sysdate(), '', null, '');
-- 用户管理按钮
insert into sys_menu values('1000', '用户查询', '100', '1',  '', '', '', 1, 0, 'F', '0', '0', 'system:user:query',          '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1001', '用户新增', '100', '2',  '', '', '', 1, 0, 'F', '0', '0', 'system:user:add',            '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1002', '用户修改', '100', '3',  '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit',           '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1003', '用户删除', '100', '4',  '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove',         '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1004', '用户导出', '100', '5',  '', '', '', 1, 0, 'F', '0', '0', 'system:user:export',         '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1005', '用户导入', '100', '6',  '', '', '', 1, 0, 'F', '0', '0', 'system:user:import',         '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1006', '重置密码', '100', '7',  '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetpwd',       '#', 'admin', sysdate(), '', null, '');
-- 角色管理按钮
insert into sys_menu values('1007', '角色查询', '101', '1',  '', '', '', 1, 0, 'F', '0', '0', 'system:role:query',          '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1008', '角色新增', '101', '2',  '', '', '', 1, 0, 'F', '0', '0', 'system:role:add',            '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1009', '角色修改', '101', '3',  '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit',           '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1010', '角色删除', '101', '4',  '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove',         '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1011', '角色导出', '101', '5',  '', '', '', 1, 0, 'F', '0', '0', 'system:role:export',         '#', 'admin', sysdate(), '', null, '');
-- 菜单管理按钮
insert into sys_menu values('1012', '菜单查询', '102', '1',  '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query',          '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1013', '菜单新增', '102', '2',  '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add',            '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1014', '菜单修改', '102', '3',  '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit',           '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1015', '菜单删除', '102', '4',  '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove',         '#', 'admin', sysdate(), '', null, '');
-- 部门管理按钮
insert into sys_menu values('1016', '部门查询', '103', '1',  '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query',          '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1017', '部门新增', '103', '2',  '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add',            '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1018', '部门修改', '103', '3',  '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit',           '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1019', '部门删除', '103', '4',  '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove',         '#', 'admin', sysdate(), '', null, '');
-- 岗位管理按钮
insert into sys_menu values('1020', '岗位查询', '104', '1',  '', '', '', 1, 0, 'F', '0', '0', 'system:post:query',          '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1021', '岗位新增', '104', '2',  '', '', '', 1, 0, 'F', '0', '0', 'system:post:add',            '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1022', '岗位修改', '104', '3',  '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit',           '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1023', '岗位删除', '104', '4',  '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove',         '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1024', '岗位导出', '104', '5',  '', '', '', 1, 0, 'F', '0', '0', 'system:post:export',         '#', 'admin', sysdate(), '', null, '');
-- 字典管理按钮
insert into sys_menu values('1025', '字典查询', '105', '1', '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:query',          '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1026', '字典新增', '105', '2', '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:add',            '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1027', '字典修改', '105', '3', '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit',           '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1028', '字典删除', '105', '4', '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove',         '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1029', '字典导出', '105', '5', '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:export',         '#', 'admin', sysdate(), '', null, '');
-- 参数设置按钮
insert into sys_menu values('1030', '参数查询', '106', '1', '#', '', '', 1, 0, 'F', '0', '0', 'system:config:query',        '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1031', '参数新增', '106', '2', '#', '', '', 1, 0, 'F', '0', '0', 'system:config:add',          '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1032', '参数修改', '106', '3', '#', '', '', 1, 0, 'F', '0', '0', 'system:config:edit',         '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1033', '参数删除', '106', '4', '#', '', '', 1, 0, 'F', '0', '0', 'system:config:remove',       '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1034', '参数导出', '106', '5', '#', '', '', 1, 0, 'F', '0', '0', 'system:config:export',       '#', 'admin', sysdate(), '', null, '');
-- 通知公告按钮
insert into sys_menu values('1035', '公告查询', '107', '1', '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:query',        '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1036', '公告新增', '107', '2', '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:add',          '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1037', '公告修改', '107', '3', '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit',         '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1038', '公告删除', '107', '4', '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove',       '#', 'admin', sysdate(), '', null, '');
-- 操作日志按钮
insert into sys_menu values('1039', '操作查询', '500', '1', '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query',      '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1040', '操作删除', '500', '2', '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove',     '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1041', '日志导出', '500', '3', '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export',     '#', 'admin', sysdate(), '', null, '');
-- 登录日志按钮
insert into sys_menu values('1042', '登录查询', '501', '1', '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query',   '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1043', '登录删除', '501', '2', '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove',  '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1044', '日志导出', '501', '3', '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export',  '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1045', '账户解锁', '501', '4', '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock',  '#', 'admin', sysdate(), '', null, '');
-- 在线用户按钮
insert into sys_menu values('1046', '在线查询', '109', '1', '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query',       '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1047', '批量强退', '109', '2', '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchlogout', '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1048', '单条强退', '109', '3', '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forcelogout', '#', 'admin', sysdate(), '', null, '');
-- 定时任务按钮
insert into sys_menu values('1049', '任务查询', '110', '1', '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query',          '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1050', '任务新增', '110', '2', '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add',            '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1051', '任务修改', '110', '3', '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit',           '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1052', '任务删除', '110', '4', '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove',         '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1053', '状态修改', '110', '5', '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changestatus',   '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1054', '任务导出', '110', '6', '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export',         '#', 'admin', sysdate(), '', null, '');
-- 代码生成按钮
insert into sys_menu values('1055', '生成查询', '116', '1', '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query',             '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1056', '生成修改', '116', '2', '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit',              '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1057', '生成删除', '116', '3', '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove',            '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1058', '导入代码', '116', '4', '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import',            '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1059', '预览代码', '116', '5', '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview',           '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1060', '生成代码', '116', '6', '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code',              '#', 'admin', sysdate(), '', null, '');
-- 采购订单制作按钮
insert into sys_menu values(1100, '销售订单跳转', 		30, 1, '', null, null, 1, 0, 'F', '0', '0', 'sales:salesOrderProcessing:orderFormType', 			'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1101, '采购订单仓库', 		30, 2, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:warehouse:list', 								'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1102, '采购订单供应商', 	30, 3, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:supplier:list', 								'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1103, '采购订单经手人', 	30, 4, '', null, null, 1, 0, 'F', '0', '0', 'system:user:list', 									'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1104, '选择经手人',      30, 5, '', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseOrderProcessing:selectUser',			'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1105, '采购订单货品', 		30, 6, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:product:list', 								'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1106, '采购订单新增', 		30, 7, '', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseOrderProcessing:add', 				'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1107, '采购订单明细', 		30, 8, '', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseOrderProcessing:detail', 				'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1108, '新增供应商保存', 	30, 9, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:supplier:add', 								'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1109, '新增货品保存', 		30, 10,'', null, null, 1, 0, 'F', '0', '0', 'baseDate:product:add', 								'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1110, '采购订单保存', 		30, 11,'', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseOrderProcessing:save', 				'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1111, '采购订单修改', 		30, 12,'', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseOrderProcessing:systematicOrderForm',	'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1112, '采购订单审核', 		30, 13,'', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseOrderProcessing:takeEffect', 			'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1113, '采购订单打印', 		30, 14,'', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseOrderProcessing:printOut', 			'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1114, '采购订单删除', 		30, 15,'', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseOrderProcessing:delete', 				'#', 'admin', sysdate(), '', null, '');
-- 采购单据制作按钮
insert into sys_menu values(1200, '采购入库选择', 		31, 1, '', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseReceiptProcessing:warehousing', 		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1201, '采购退库选择', 		31, 2, '', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseReceiptProcessing:retreat', 			'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1202, '采购单据仓库', 		31, 3, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:warehouse:list', 								'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1203, '采购单据供应商', 	31, 4, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:supplier:list', 								'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1204, '采购单据经手人', 	31, 5, '', null, null, 1, 0, 'F', '0', '0', 'system:user:list', 									'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1205, '选择经手人',      31, 6, '', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseReceiptProcessing:selectUser',		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1206, '采购单据货品', 		31, 7, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:product:list', 								'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1207, '采购单据新增', 		31, 8, '', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseReceiptProcessing:add', 				'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1208, '采购单据明细', 		31, 9, '', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseReceiptProcessing:detail', 			'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1209, '新增供应商保存', 	31, 10,'', null, null, 1, 0, 'F', '0', '0', 'baseDate:supplier:add', 								'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1210, '新增货品保存', 		31, 11,'', null, null, 1, 0, 'F', '0', '0', 'baseDate:product:add', 								'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1211, '采购单据保存', 		31, 12,'', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseReceiptProcessing:save', 				'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1212, '采购单据修改', 		31, 13,'', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseReceiptProcessing:systematicReceipt', '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1213, '采购单据审核', 		31, 14,'', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseReceiptProcessing:takeEffect', 		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1214, '采购单据打印', 		31, 15,'', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseReceiptProcessing:printOut', 			'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1215, '采购单据删除', 		31, 16,'', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseReceiptProcessing:delete', 			'#', 'admin', sysdate(), '', null, '');
-- 采购订单查询按钮
insert into sys_menu values(1300, '采购单据仓库', 		32, 1, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:warehouse:list', 								'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1301, '采购单据供应商', 	32, 2, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:supplier:list', 								'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1302, '采购单据经手人', 	32, 3, '', null, null, 1, 0, 'F', '0', '0', 'system:user:list', 									'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1303, '选择经手人',      32, 4, '', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseOrderQuery:selectUser',    			'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1304, '采购订单查询', 		32, 5, '', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseOrderQuery:headQuery', 				'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1305, '采购订单明细查询', 	32, 6, '', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseOrderQuery:detailQuery', 				'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1306, '采购订单导出', 		32, 7, '', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseOrderQuery:headExport',             	'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1307, '采购订单明细导出', 	32, 8, '', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseOrderQuery:detailExport',           	'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1308, '采购订单新增', 		32, 9, '', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseOrderQuery:add',               		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1309, '采购订单打印', 		32, 10,'', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseOrderQuery:printOut',               	'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1310, '采购订单修改', 		32, 11,'', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseOrderQuery:update',                 	'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1311, '采购订单删除', 		32, 12,'', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseOrderQuery:delete',                 	'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1312, '采购订单详情', 		32, 13,'', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseOrderQuery:systematicOrderForm',    	'#', 'admin', sysdate(), '', null, '');
-- 采购单据查询按钮
insert into sys_menu values(1400, '采购单据仓库', 		33, 1, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:warehouse:list', 								'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1401, '采购单据供应商', 	33, 2, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:supplier:list', 								'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1402, '采购单据经手人', 	33, 3, '', null, null, 1, 0, 'F', '0', '0', 'system:user:list', 									'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1403, '选择经手人',      33, 4, '', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseReceiptQuery:selectUser',    			'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1404, '采购单据查询', 		33, 5, '', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseReceiptQuery:headQuery', 				'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1405, '采购单据明细查询', 	33, 6, '', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseReceiptQuery:detailQuery', 			'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1406, '采购单据导出', 		33, 7, '', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseReceiptQuery:headExport', 			'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1407, '采购单据明细导出', 	33, 8, '', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseReceiptQuery:detailExport', 			'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1408, '采购单据新增', 		33, 9, '', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseReceiptQuery:add', 					'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1409, '采购单据打印', 		33, 10,'', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseReceiptQuery:printOut', 				'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1410, '采购单据修改', 		33, 11,'', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseReceiptQuery:update', 				'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1411, '采购单据删除', 		33, 12,'', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseReceiptQuery:delete', 				'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1412, '采购单据详情', 		33, 13,'', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseReceiptQuery:systematicReceipt', 		'#', 'admin', sysdate(), '', null, '');
-- 销售订单制作按钮
insert into sys_menu values(1500, '采购订单跳转', 		34, 1, '', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseOrderProcessing:orderFormType', 		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1501, '销售订单仓库', 		34, 2, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:warehouse:list', 								'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1502, '销售订单客户', 		34, 3, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:customer:list', 								'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1503, '销售订单经手人', 	34, 4, '', null, null, 1, 0, 'F', '0', '0', 'system:user:list', 									'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1504, '选择经手人',      34, 5, '', null, null, 1, 0, 'F', '0', '0', 'sales:salesOrderProcessing:selectUser',				'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1505, '销售订单货品', 		34, 6, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:product:list', 								'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1506, '销售订单新增', 		34, 7, '', null, null, 1, 0, 'F', '0', '0', 'sales:salesOrderProcessing:add', 						'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1507, '销售订单明细', 		34, 8, '', null, null, 1, 0, 'F', '0', '0', 'sales:salesOrderProcessing:detail', 					'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1508, '新增客户保存', 		34, 9, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:customer:add', 								'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1509, '新增货品保存', 		34, 10,'', null, null, 1, 0, 'F', '0', '0', 'baseDate:product:add', 								'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1510, '销售订单保存', 		34, 11,'', null, null, 1, 0, 'F', '0', '0', 'sales:salesOrderProcessing:save', 						'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1511, '销售订单修改', 		34, 12,'', null, null, 1, 0, 'F', '0', '0', 'sales:salesOrderProcessing:systematicOrderForm',		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1512, '销售订单审核', 		34, 13,'', null, null, 1, 0, 'F', '0', '0', 'sales:salesOrderProcessing:takeEffect', 				'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1513, '销售订单打印', 		34, 14,'', null, null, 1, 0, 'F', '0', '0', 'sales:salesOrderProcessing:printOut', 					'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1514, '销售订单删除', 		34, 15,'', null, null, 1, 0, 'F', '0', '0', 'sales:salesOrderProcessing:delete', 					'#', 'admin', sysdate(), '', null, '');
-- 销售单据制作按钮
insert into sys_menu values(1600, '销售出库选择', 		35, 1, '', null, null, 1, 0, 'F', '0', '0', 'sales:salesReceiptProcessing:Outbound', 				'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1601, '销售退库选择', 		35, 2, '', null, null, 1, 0, 'F', '0', '0', 'sales:salesReceiptProcessing:retreat', 				'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1602, '销售单据仓库', 		35, 3, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:warehouse:list', 								'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1603, '销售单据客户', 		35, 4, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:customer:list', 								'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1604, '销售单据经手人', 	35, 5, '', null, null, 1, 0, 'F', '0', '0', 'system:user:list', 									'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1605, '选择经手人',      35, 6, '', null, null, 1, 0, 'F', '0', '0', 'sales:salesReceiptProcessing:selectUser',				'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1606, '销售单据货品', 		35, 7, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:product:list', 								'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1607, '销售单据新增', 		35, 8, '', null, null, 1, 0, 'F', '0', '0', 'sales:salesReceiptProcessing:add', 					'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1608, '销售单据明细', 		35, 9, '', null, null, 1, 0, 'F', '0', '0', 'sales:salesReceiptProcessing:detail', 					'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1609, '新增客户保存', 		35, 10,'', null, null, 1, 0, 'F', '0', '0', 'baseDate:customer:add', 								'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1610, '新增货品保存', 		35, 11,'', null, null, 1, 0, 'F', '0', '0', 'baseDate:product:add', 								'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1611, '销售单据保存', 		35, 12,'', null, null, 1, 0, 'F', '0', '0', 'sales:salesReceiptProcessing:save', 					'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1612, '销售单据修改', 		35, 13,'', null, null, 1, 0, 'F', '0', '0', 'sales:salesReceiptProcessing:systematicReceipt', 		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1613, '销售单据审核', 		35, 14,'', null, null, 1, 0, 'F', '0', '0', 'sales:salesReceiptProcessing:takeEffect', 				'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1614, '销售单据打印', 		35, 15,'', null, null, 1, 0, 'F', '0', '0', 'sales:salesReceiptProcessing:printOut', 				'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1615, '销售单据删除', 		35, 16,'', null, null, 1, 0, 'F', '0', '0', 'sales:salesReceiptProcessing:delete', 					'#', 'admin', sysdate(), '', null, '');
-- 销售订单查询按钮
insert into sys_menu values(1700, '销售单据仓库', 		36, 3, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:warehouse:list', 								'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1701, '销售单据客户', 		36, 4, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:customer:list', 								'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1702, '销售单据经手人', 	36, 5, '', null, null, 1, 0, 'F', '0', '0', 'system:user:list', 									'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1703, '选择经手人',      36, 1, '', null, null, 1, 0, 'F', '0', '0', 'sales:salesOrderQuery:selectUser',    					'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1704, '销售订单查询', 		36, 1, '', null, null, 1, 0, 'F', '0', '0', 'sales:salesOrderQuery:headQuery', 						'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1705, '销售订单明细查询', 	36, 2, '', null, null, 1, 0, 'F', '0', '0', 'sales:salesOrderQuery:detailQuery', 					'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1706, '销售订单导出', 		36, 3, '', null, null, 1, 0, 'F', '0', '0', 'sales:salesOrderQuery:headExport',             		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1707, '销售订单明细导出', 	36, 4, '', null, null, 1, 0, 'F', '0', '0', 'sales:salesOrderQuery:detailExport',           		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1708, '销售订单新增', 		36, 5, '', null, null, 1, 0, 'F', '0', '0', 'sales:salesOrderQuery:add',               				'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1709, '销售订单打印', 		36, 5, '', null, null, 1, 0, 'F', '0', '0', 'sales:salesOrderQuery:printOut',               		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1710, '销售订单修改', 		36, 7, '', null, null, 1, 0, 'F', '0', '0', 'sales:salesOrderQuery:update',                 		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1711, '销售订单删除', 		36, 8, '', null, null, 1, 0, 'F', '0', '0', 'sales:salesOrderQuery:delete',                 		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1712, '销售订单详情', 		36, 9, '', null, null, 1, 0, 'F', '0', '0', 'sales:salesOrderQuery:systematicOrderForm',    		'#', 'admin', sysdate(), '', null, '');
-- 销售单据查询按钮
insert into sys_menu values(1800, '销售单据仓库', 		37, 1, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:warehouse:list', 								'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1801, '销售单据客户', 		37, 2, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:customer:list', 								'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1802, '销售单据经手人', 	37, 3, '', null, null, 1, 0, 'F', '0', '0', 'system:user:list', 									'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1803, '选择经手人',      37, 4, '', null, null, 1, 0, 'F', '0', '0', 'sales:salesReceiptQuery:selectUser',    				'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1804, '销售单据查询', 		37, 5, '', null, null, 1, 0, 'F', '0', '0', 'sales:salesReceiptQuery:headQuery', 					'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1805, '销售单据明细查询', 	37, 6, '', null, null, 1, 0, 'F', '0', '0', 'sales:salesReceiptQuery:detailQuery', 					'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1806, '销售单据导出', 		37, 7, '', null, null, 1, 0, 'F', '0', '0', 'sales:salesReceiptQuery:headExport', 					'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1807, '销售单据明细导出', 	37, 8, '', null, null, 1, 0, 'F', '0', '0', 'sales:salesReceiptQuery:detailExport', 				'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1808, '销售单据新增', 		37, 9, '', null, null, 1, 0, 'F', '0', '0', 'sales:salesReceiptQuery:add', 							'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1809, '销售单据打印', 		37, 10,'', null, null, 1, 0, 'F', '0', '0', 'sales:salesReceiptQuery:printOut', 					'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1810, '销售单据修改', 		37, 11,'', null, null, 1, 0, 'F', '0', '0', 'sales:salesReceiptQuery:update', 						'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1811, '销售单据删除', 		37, 12,'', null, null, 1, 0, 'F', '0', '0', 'sales:salesReceiptQuery:delete', 						'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1812, '销售单据详情', 		37, 13,'', null, null, 1, 0, 'F', '0', '0', 'sales:salesReceiptQuery:systematicReceipt', 			'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1813, '销售单据订单查询', 	37, 14,'', null, null, 1, 0, 'F', '0', '0', 'sales:salesReceiptQuery:orderQuery', 					'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1814, '销售单据售后查询', 	37, 15,'', null, null, 1, 0, 'F', '0', '0', 'sales:salesReceiptQuery:afterSalesQuery', 				'#', 'admin', sysdate(), '', null, '');
-- 库存单据制作按钮
insert into sys_menu values(1900, '库存入库选择', 		40, 1, '', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryReceiptProcessing:warehousing', 	'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1901, '库存出库选择', 		40, 2, '', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryReceiptProcessing:Outbound', 		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1902, '库存单据仓库', 		40, 3, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:warehouse:list', 								'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1903, '库存单据供应商', 	40, 4, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:supplier:list', 								'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1904, '库存单据客户', 		40, 5, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:customer:list', 								'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1905, '库存单据经手人', 	40, 6, '', null, null, 1, 0, 'F', '0', '0', 'system:user:list', 									'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1906, '选择经手人',      40, 7, '', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryReceiptProcessing:selectUser',		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1907, '库存单据货品', 		40, 8, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:product:list', 								'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1908, '库存单据新增', 		40, 9, '', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryReceiptProcessing:add', 			'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1909, '库存单据明细', 		40, 10,'', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryReceiptProcessing:detail', 			'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1910, '新增供应商保存', 	40, 11,'', null, null, 1, 0, 'F', '0', '0', 'baseDate:supplier:add', 								'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1911, '新增客户保存', 		40, 12,'', null, null, 1, 0, 'F', '0', '0', 'baseDate:customer:add', 								'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1912, '新增货品保存', 		40, 13,'', null, null, 1, 0, 'F', '0', '0', 'baseDate:product:add', 								'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1913, '库存单据保存', 		40, 14,'', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryReceiptProcessing:save', 			'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1914, '库存单据修改', 		40, 15,'', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryReceiptProcessing:systematicReceipt','#','admin', sysdate(), '', null, '');
insert into sys_menu values(1915, '库存单据审核', 		40, 16,'', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryReceiptProcessing:takeEffect', 		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1916, '库存单据打印', 		40, 17,'', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryReceiptProcessing:printOut', 		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1917, '库存订单删除', 		40, 18,'', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryReceiptProcessing:delete', 			'#', 'admin', sysdate(), '', null, '');
-- 库存调拨单制作按钮
insert into sys_menu values(2000, '调拨单据仓库', 		41, 1, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:warehouse:list', 								'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2001, '调拨单据供应商', 	41, 2, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:supplier:list', 								'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2002, '调拨单据客户', 		41, 3, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:customer:list', 								'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2003, '调拨单据经手人', 	41, 4, '', null, null, 1, 0, 'F', '0', '0', 'system:user:list', 									'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2004, '选择经手人',      41, 5, '', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryTransferProcessing:selectUser',		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2005, '调拨单据货品', 		41, 6, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:product:list', 								'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2006, '调拨单据新增', 		41, 7, '', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryTransferProcessing:add', 			'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2007, '调拨单据明细', 		41, 8, '', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryTransferProcessing:detail', 		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2008, '新增供应商保存', 	41, 9, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:supplier:add', 								'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2009, '新增客户保存', 		41, 10,'', null, null, 1, 0, 'F', '0', '0', 'baseDate:customer:add', 								'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2010, '新增货品保存', 		41, 11,'', null, null, 1, 0, 'F', '0', '0', 'baseDate:product:add', 								'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2011, '调拨单据保存', 		41, 12,'', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryTransferProcessing:save', 			'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2012, '调拨单据修改', 		41, 13,'', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryReceiptProcessing:systematicReceipt','#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2013, '调拨单据审核', 		41, 14,'', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryTransferProcessing:takeEffect', 	'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2014, '调拨单据打印', 		41, 15,'', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryTransferProcessing:printOut', 		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2015, '调拨订单删除', 		41, 16,'', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryReceiptProcessing:delete', 			'#', 'admin', sysdate(), '', null, '');
-- 库存盘点单制作按钮
insert into sys_menu values(2100, '盘点单据仓库', 		42, 1, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:warehouse:list', 								'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2101, '盘点单据经手人', 	42, 2, '', null, null, 1, 0, 'F', '0', '0', 'system:user:list', 									'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2102, '选择经手人',      42, 3, '', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryCountingProcessing:selectUser',		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2103, '盘点单据货品', 		42, 4, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:product:list', 								'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2104, '盘点单据新增', 		42, 5, '', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryCountingProcessing:add', 			'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2105, '盘点单据明细', 		42, 6, '', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryCountingProcessing:detail', 		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2106, '新增货品保存', 		42, 7, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:product:add', 								'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2107, '盘点单据保存', 		42, 8, '', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryCountingProcessing:save', 			'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2108, '盘点单据修改', 		42, 9, '', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryReceiptProcessing:systematicReceipt','#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2109, '盘点单据审核', 		42, 10,'', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryCountingProcessing:takeEffect', 	'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2110, '盘点单据打印', 		42, 11,'', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryCountingProcessing:printOut', 		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2111, '盘点订单删除', 		42, 12,'', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryReceiptProcessing:delete', 			'#', 'admin', sysdate(), '', null, '');
-- 库存单据查询按钮
insert into sys_menu values(2200, '库存单据仓库', 		43, 1, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:warehouse:list', 								'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2201, '库存单据供应商', 	43, 2, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:supplier:list', 								'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2202, '库存单据客户', 		43, 3, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:customer:list', 								'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2203, '库存单据经手人', 	43, 4, '', null, null, 1, 0, 'F', '0', '0', 'system:user:list', 									'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2204, '选择经手人', 		43, 5, '', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryReceiptQuery:selectUser',    		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2205, '库存单据查询', 		43, 6, '', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryReceiptQuery:headQuery', 			'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2206, '库存单据明细查询', 	43, 7, '', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryReceiptQuery:detailQuery', 			'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2207, '库存单据导出', 		43, 8, '', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryReceiptQuery:headExport', 			'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2208, '库存单据明细导出', 	43, 9, '', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryReceiptQuery:detailExport', 		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2209, '库存单据新增', 		43, 10,'', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryReceiptQuery:add', 					'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2210, '库存单据打印', 		43, 11,'', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryReceiptQuery:printOut', 			'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2211, '库存单据修改', 		43, 12,'', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryReceiptQuery:update', 				'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2212, '库存单据删除', 		43, 13,'', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryReceiptQuery:delete', 				'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2213, '库存单据详情', 		43, 14,'', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryReceiptQuery:systematicReceipt', 	'#', 'admin', sysdate(), '', null, '');
-- 库存发生汇总按钮
insert into sys_menu values(2300, '库存发生汇总查询', 	44, 1, '', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryOccurrenceSummary:list', 			'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2301, '库存发生汇总导出', 	44, 2, '', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryOccurrenceSummary:export', 			'#', 'admin', sysdate(), '', null, '');
-- 库存发生明细按钮
insert into sys_menu values(2400, '库存发生明细查询', 	45, 1, '', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryOccurrenceDetails:list', 			'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2401, '库存发生明细导出', 	45, 2, '', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryOccurrenceDetails:export', 			'#', 'admin', sysdate(), '', null, '');
-- 库存货品查询按钮
insert into sys_menu values(2500, '库存货品查询', 		46, 1, '', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryItemInquiry:list', 					'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2501, '库存货品导出', 		46, 2, '', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryItemInquiry:export', 				'#', 'admin', sysdate(), '', null, '');
-- 历史单据迁移
insert into sys_menu values(2600, '单据头表查询', 		47, 1, '', null, null, 1, 0, 'F', '0', '0', 'inventory:historicalDocuments:head', 					'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2601, '单据明细查询', 		47, 2, '', null, null, 1, 0, 'F', '0', '0', 'inventory:historicalDocuments:detail', 				'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2602, '单据详情',       47, 3, '', null, null, 1, 0, 'F', '0', '0', 'inventory:historicalDocuments:SystematicReceipt', 		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2603, '单据删除',       47, 4, '', null, null, 1, 0, 'F', '0', '0', 'inventory:historicalDocuments:delete', 				'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2604, '单据头表导入', 		47, 5, '', null, null, 1, 0, 'F', '0', '0', 'inventory:historicalDocuments:importHeadData', 		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2605, '单据明细导入', 		47, 6, '', null, null, 1, 0, 'F', '0', '0', 'inventory:historicalDocuments:importDetailData', 		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2606, '单据头表导出', 		47, 7, '', null, null, 1, 0, 'F', '0', '0', 'inventory:historicalDocuments:headReceiptExport', 		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2607, '单据明细导出', 		47, 8, '', null, null, 1, 0, 'F', '0', '0', 'inventory:historicalDocuments:detailReceiptExport',	'#', 'admin', sysdate(), '', null, '');
-- 售后安装单制作按钮
insert into sys_menu values(2902, '售后单据仓库', 		52, 1, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:warehouse:list', 								'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2903, '售后单据客户', 		52, 2, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:customer:list', 								'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2904, '售后单据经手人', 	52, 3, '', null, null, 1, 0, 'F', '0', '0', 'system:user:list', 									'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2905, '选择经手人',      52, 4, '', null, null, 1, 0, 'F', '0', '0', 'afterSales:afterSalesOrderProcessing:selectUser',		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2906, '售后单据货品', 		52, 5, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:product:list', 								'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2907, '售后单据新增', 		52, 6, '', null, null, 1, 0, 'F', '0', '0', 'afterSales:afterSalesOrderProcessing:add', 			'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2908, '售后单据明细', 		52, 7, '', null, null, 1, 0, 'F', '0', '0', 'afterSales:afterSalesOrderProcessing:detail', 			'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2909, '新增客户保存', 		52, 8, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:customer:add', 								'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2910, '新增货品保存', 		52, 9, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:product:add', 								'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2911, '售后单据保存', 		52, 10,'', null, null, 1, 0, 'F', '0', '0', 'afterSales:afterSalesOrderProcessing:save', 			'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2912, '售后单据修改', 		52, 11,'', null, null, 1, 0, 'F', '0', '0', 'afterSales:afterSalesOrderProcessing:systematicReceipt', '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2913, '售后单据审核', 		52, 12,'', null, null, 1, 0, 'F', '0', '0', 'afterSales:afterSalesOrderProcessing:takeEffect', 		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2914, '售后单据打印', 		52, 13,'', null, null, 1, 0, 'F', '0', '0', 'afterSales:afterSalesOrderProcessing:printOut', 		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2915, '售后单据删除', 		52, 14,'', null, null, 1, 0, 'F', '0', '0', 'afterSales:afterSalesOrderProcessing:delete', 			'#', 'admin', sysdate(), '', null, '');
-- 售后单据查询按钮
insert into sys_menu values(3000, '售后单据仓库', 		53, 1, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:warehouse:list', 								'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3001, '售后单据客户', 		53, 2, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:customer:list', 								'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3002, '售后单据经手人', 	53, 3, '', null, null, 1, 0, 'F', '0', '0', 'system:user:list', 									'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3003, '选择经手人',      53, 4, '', null, null, 1, 0, 'F', '0', '0', 'afterSales:afterSalesOrderQuery:selectUser',    		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3004, '售后单据查询', 		53, 5, '', null, null, 1, 0, 'F', '0', '0', 'afterSales:afterSalesOrderQuery:headQuery', 			'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3005, '售后单据明细查询', 	53, 6, '', null, null, 1, 0, 'F', '0', '0', 'afterSales:afterSalesOrderQuery:detailQuery', 			'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3006, '售后单据导出', 		53, 7, '', null, null, 1, 0, 'F', '0', '0', 'afterSales:afterSalesOrderQuery:headExport', 			'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3007, '售后单据明细导出', 	53, 8, '', null, null, 1, 0, 'F', '0', '0', 'afterSales:afterSalesOrderQuery:detailExport', 		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3008, '售后单据新增', 		53, 9, '', null, null, 1, 0, 'F', '0', '0', 'afterSales:afterSalesOrderQuery:add', 					'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3009, '售后单据打印', 		53, 10,'', null, null, 1, 0, 'F', '0', '0', 'afterSales:afterSalesOrderQuery:printOut', 			'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3010, '售后单据修改', 		53, 11,'', null, null, 1, 0, 'F', '0', '0', 'afterSales:afterSalesOrderQuery:update', 				'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3011, '售后单据删除', 		53, 12,'', null, null, 1, 0, 'F', '0', '0', 'afterSales:afterSalesOrderQuery:delete', 				'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3012, '售后单据详情', 		53, 13,'', null, null, 1, 0, 'F', '0', '0', 'afterSales:afterSalesOrderQuery:systematicReceipt', 	'#', 'admin', sysdate(), '', null, '');




-- ----------------------------
-- 6、用户和角色关联表  用户n-1角色
-- ----------------------------
drop table if exists sys_user_role;
create table sys_user_role (
  user_id   bigint(20) not null comment '用户id',
  role_id   bigint(20) not null comment '角色id',
  primary key(user_id, role_id)
) engine=innodb comment = '用户和角色关联表';

-- ----------------------------
-- 初始化-用户和角色关联表数据
-- ----------------------------
insert into sys_user_role values ('1', '1');


-- ----------------------------
-- 7、角色和菜单关联表  角色1-n菜单
-- ----------------------------
drop table if exists sys_role_menu;
create table sys_role_menu (
  role_id   bigint(20) not null comment '角色id',
  menu_id   bigint(20) not null comment '菜单id',
  primary key(role_id, menu_id)
) engine=innodb comment = '角色和菜单关联表';

-- ----------------------------
-- 初始化-角色和菜单关联表数据
-- ----------------------------

-- ----------------------------
-- 8、角色和部门关联表  角色1-n部门
-- ----------------------------
drop table if exists sys_role_dept;
create table sys_role_dept (
  role_id   bigint(20) not null comment '角色id',
  dept_id   bigint(20) not null comment '部门id',
  primary key(role_id, dept_id)
) engine=innodb comment = '角色和部门关联表';

-- ----------------------------
-- 初始化-角色和部门关联表数据
-- ----------------------------

-- ----------------------------
-- 9、用户与岗位关联表  用户1-n岗位
-- ----------------------------
drop table if exists sys_user_post;
create table sys_user_post
(
  user_id   bigint(20) not null comment '用户id',
  post_id   bigint(20) not null comment '岗位id',
  primary key (user_id, post_id)
) engine=innodb comment = '用户与岗位关联表';

-- ----------------------------
-- 初始化-用户与岗位关联表数据
-- ----------------------------
insert into sys_user_post values ('1', '1');


-- ----------------------------
-- 10、操作日志记录
-- ----------------------------
drop table if exists sys_oper_log;
create table sys_oper_log (
  oper_id           bigint(20)      not null auto_increment    comment '日志主键',
  title             varchar(50)     default ''                 comment '模块标题',
  business_type     int(2)          default 0                  comment '业务类型（0其它 1新增 2修改 3删除）',
  method            varchar(100)    default ''                 comment '方法名称',
  request_method    varchar(10)     default ''                 comment '请求方式',
  operator_type     int(1)          default 0                  comment '操作类别（0其它 1后台用户 2手机端用户）',
  oper_name         varchar(50)     default ''                 comment '操作人员',
  dept_name         varchar(50)     default ''                 comment '部门名称',
  oper_url          varchar(255)    default ''                 comment '请求url',
  oper_ip           varchar(128)    default ''                 comment '主机地址',
  oper_location     varchar(255)    default ''                 comment '操作地点',
  oper_param        varchar(2000)   default ''                 comment '请求参数',
  json_result       varchar(2000)   default ''                 comment '返回参数',
  status            int(1)          default 0                  comment '操作状态（0正常 1异常）',
  error_msg         varchar(2000)   default ''                 comment '错误消息',
  oper_time         datetime                                   comment '操作时间',
  cost_time         bigint(20)      default 0                  comment '消耗时间',
  primary key (oper_id),
  key idx_sys_oper_log_bt (business_type),
  key idx_sys_oper_log_s  (status),
  key idx_sys_oper_log_ot (oper_time)
) engine=innodb auto_increment=100 comment = '操作日志记录';


-- ----------------------------
-- 11、字典类型表
-- ----------------------------
drop table if exists sys_dict_type;
create table sys_dict_type
(
  dict_id          bigint(20)      not null auto_increment    comment '字典主键',
  dict_name        varchar(100)    default ''                 comment '字典名称',
  dict_type        varchar(100)    default ''                 comment '字典类型',
  status           char(1)         default '0'                comment '状态（0正常 1停用）',
  create_by        varchar(64)     default ''                 comment '创建者',
  create_time      datetime                                   comment '创建时间',
  update_by        varchar(64)     default ''                 comment '更新者',
  update_time      datetime                                   comment '更新时间',
  remark           varchar(500)    default null               comment '备注',
  primary key (dict_id),
  unique (dict_type)
) engine=innodb auto_increment=100 comment = '字典类型表';

-- ----------------------------
-- 初始化-字典类型表数据
-- ----------------------------
insert into sys_dict_type values(1,  '用户性别', 'sys_user_sex',        '0', 'admin', sysdate(), '', null, '用户性别列表');
insert into sys_dict_type values(2,  '菜单状态', 'sys_show_hide',       '0', 'admin', sysdate(), '', null, '菜单状态列表');
insert into sys_dict_type values(3,  '系统开关', 'sys_normal_disable',  '0', 'admin', sysdate(), '', null, '系统开关列表');
insert into sys_dict_type values(4,  '任务状态', 'sys_job_status',      '0', 'admin', sysdate(), '', null, '任务状态列表');
insert into sys_dict_type values(5,  '任务分组', 'sys_job_group',       '0', 'admin', sysdate(), '', null, '任务分组列表');
insert into sys_dict_type values(6,  '系统是否', 'sys_yes_no',          '0', 'admin', sysdate(), '', null, '系统是否列表');
insert into sys_dict_type values(7,  '通知类型', 'sys_notice_type',     '0', 'admin', sysdate(), '', null, '通知类型列表');
insert into sys_dict_type values(8,  '通知状态', 'sys_notice_status',   '0', 'admin', sysdate(), '', null, '通知状态列表');
insert into sys_dict_type values(9,  '操作类型', 'sys_oper_type',       '0', 'admin', sysdate(), '', null, '操作类型列表');
insert into sys_dict_type values(10, '系统状态', 'sys_common_status',   '0', 'admin', sysdate(), '', null, '登录状态列表');
insert into sys_dict_type values(11, '单据类型', 'receipt_type', 		  '0', 'admin', sysdate(), '', null, '单据类型列表');
insert into sys_dict_type values(12, '单据状态', 'receipt_status', 	  '0', 'admin', sysdate(), '', null, '单据状态列表');
insert into sys_dict_type values(13, '订单类型', 'order_form_type',	  '0', 'admin', sysdate(), '', null, '订单类型列表');
insert into sys_dict_type values(14, '订单状态', 'order_form_status',	  '0', 'admin', sysdate(), '', null, '订单状态列表');
insert into sys_dict_type values(15, '售后安装', 'after_sales_installation','0', 'admin', sysdate(), '', null, '售后安装列表');
insert into sys_dict_type values(16, '售单类型', 'service_type', 		  '0', 'admin', sysdate(), '', null, '售单类型列表');
insert into sys_dict_type values(17, '审核结果', 'finding_of_audit',	  '0', 'admin', sysdate(), '', null, '订单状态列表');
insert into sys_dict_type values(18, '打印指定文件', 'print_selected_files',	  '0', 'admin', sysdate(), '', null, '打印指定文件列表');
insert into sys_dict_type values(19, '打印文件页数', 'print_selected_sizes',    '0', 'admin', sysdate(), '', null, '打印文件页数列表');

-- ----------------------------
-- 12、字典数据表
-- ----------------------------
drop table if exists sys_dict_data;
create table sys_dict_data
(
  dict_code        bigint(20)      not null auto_increment    comment '字典编码',
  dict_sort        int(4)          default 0                  comment '字典排序',
  dict_label       varchar(100)    default ''                 comment '字典标签',
  dict_value       varchar(100)    default ''                 comment '字典键值',
  dict_type        varchar(100)    default ''                 comment '字典类型',
  css_class        varchar(100)    default null               comment '样式属性（其他样式扩展）',
  list_class       varchar(100)    default null               comment '表格回显样式',
  is_default       char(1)         default 'n'                comment '是否默认（y是 n否）',
  status           char(1)         default '0'                comment '状态（0正常 1停用）',
  create_by        varchar(64)     default ''                 comment '创建者',
  create_time      datetime                                   comment '创建时间',
  update_by        varchar(64)     default ''                 comment '更新者',
  update_time      datetime                                   comment '更新时间',
  remark           varchar(500)    default null               comment '备注',
  primary key (dict_code)
) engine=innodb auto_increment=100 comment = '字典数据表';

-- ----------------------------
-- 初始化-字典数据表数据
-- ----------------------------
insert into sys_dict_data values(1,  1,  '男',       '0',       'sys_user_sex',        '',   '',        'y', '0', 'admin', sysdate(), '', null, '性别男');
insert into sys_dict_data values(2,  2,  '女',       '1',       'sys_user_sex',        '',   '',        'n', '0', 'admin', sysdate(), '', null, '性别女');
insert into sys_dict_data values(3,  3,  '未知',     '2',       'sys_user_sex',        '',   '',        'n', '0', 'admin', sysdate(), '', null, '性别未知');
insert into sys_dict_data values(4,  1,  '显示',     '0',       'sys_show_hide',       '',   'primary', 'y', '0', 'admin', sysdate(), '', null, '显示菜单');
insert into sys_dict_data values(5,  2,  '隐藏',     '1',       'sys_show_hide',       '',   'danger',  'n', '0', 'admin', sysdate(), '', null, '隐藏菜单');
insert into sys_dict_data values(6,  1,  '正常',     '0',       'sys_normal_disable',  '',   'primary', 'y', '0', 'admin', sysdate(), '', null, '正常状态');
insert into sys_dict_data values(7,  2,  '停用',     '1',       'sys_normal_disable',  '',   'danger',  'n', '0', 'admin', sysdate(), '', null, '停用状态');
insert into sys_dict_data values(8,  1,  '正常',     '0',       'sys_job_status',      '',   'primary', 'y', '0', 'admin', sysdate(), '', null, '正常状态');
insert into sys_dict_data values(9,  2,  '暂停',     '1',       'sys_job_status',      '',   'danger',  'n', '0', 'admin', sysdate(), '', null, '停用状态');
insert into sys_dict_data values(10, 1,  '默认',     'default', 'sys_job_group',       '',   '',        'y', '0', 'admin', sysdate(), '', null, '默认分组');
insert into sys_dict_data values(11, 2,  '系统',     'system',  'sys_job_group',       '',   '',        'n', '0', 'admin', sysdate(), '', null, '系统分组');
insert into sys_dict_data values(12, 1,  '是',       'y',       'sys_yes_no',          '',   'primary', 'y', '0', 'admin', sysdate(), '', null, '系统默认是');
insert into sys_dict_data values(13, 2,  '否',       'n',       'sys_yes_no',          '',   'danger',  'n', '0', 'admin', sysdate(), '', null, '系统默认否');
insert into sys_dict_data values(14, 1,  '通知',     '1',       'sys_notice_type',     '',   'warning', 'y', '0', 'admin', sysdate(), '', null, '通知');
insert into sys_dict_data values(15, 2,  '公告',     '2',       'sys_notice_type',     '',   'success', 'n', '0', 'admin', sysdate(), '', null, '公告');
insert into sys_dict_data values(16, 1,  '正常',     '0',       'sys_notice_status',   '',   'primary', 'y', '0', 'admin', sysdate(), '', null, '正常状态');
insert into sys_dict_data values(17, 2,  '关闭',     '1',       'sys_notice_status',   '',   'danger',  'n', '0', 'admin', sysdate(), '', null, '关闭状态');
insert into sys_dict_data values(18, 99, '其他',     '0',       'sys_oper_type',       '',   'info',    'n', '0', 'admin', sysdate(), '', null, '其他操作');
insert into sys_dict_data values(19, 1,  '新增',     '1',       'sys_oper_type',       '',   'info',    'n', '0', 'admin', sysdate(), '', null, '新增操作');
insert into sys_dict_data values(20, 2,  '修改',     '2',       'sys_oper_type',       '',   'info',    'n', '0', 'admin', sysdate(), '', null, '修改操作');
insert into sys_dict_data values(21, 3,  '删除',     '3',       'sys_oper_type',       '',   'danger',  'n', '0', 'admin', sysdate(), '', null, '删除操作');
insert into sys_dict_data values(22, 4,  '授权',     '4',       'sys_oper_type',       '',   'primary', 'n', '0', 'admin', sysdate(), '', null, '授权操作');
insert into sys_dict_data values(23, 5,  '导出',     '5',       'sys_oper_type',       '',   'warning', 'n', '0', 'admin', sysdate(), '', null, '导出操作');
insert into sys_dict_data values(24, 6,  '导入',     '6',       'sys_oper_type',       '',   'warning', 'n', '0', 'admin', sysdate(), '', null, '导入操作');
insert into sys_dict_data values(25, 7,  '强退',     '7',       'sys_oper_type',       '',   'danger',  'n', '0', 'admin', sysdate(), '', null, '强退操作');
insert into sys_dict_data values(26, 8,  '生成代码', 	'8',       'sys_oper_type',       '',   'warning', 'n', '0', 'admin', sysdate(), '', null, '生成操作');
insert into sys_dict_data values(27, 9,  '清空数据', 	'9',       'sys_oper_type',       '',   'danger',  'n', '0', 'admin', sysdate(), '', null, '清空操作');
insert into sys_dict_data values(28, 1,  '成功',     '0',       'sys_common_status',   '',   'primary', 'n', '0', 'admin', sysdate(), '', null, '正常状态');
insert into sys_dict_data values(29, 2,  '失败',     '1',       'sys_common_status',   '',   'danger',  'n', '0', 'admin', sysdate(), '', null, '停用状态');
insert into sys_dict_data values(30, 0,  '采购入库', 								'1', 		'receipt_type', 	   '',   'success', 'n', '0', 'admin', sysdate(), '', null, null);
insert into sys_dict_data values(31, 1,  '采购退库', 								'2', 		'receipt_type', 	   '',   'danger',  'n', '0', 'admin', sysdate(), '', null, null);
insert into sys_dict_data values(32, 2,  '销售出库', 								'3',  	'receipt_type', 	   '',   'primary', 'n', '0', 'admin', sysdate(), '', null, null);
insert into sys_dict_data values(33, 3,  '销售退库', 								'4', 		'receipt_type', 	   '',   'warning', 'n', '0', 'admin', sysdate(), '', null, null);
insert into sys_dict_data values(34, 1,  '待审核',									'1', 		'receipt_status', 	   '',   'primary', 'n', '0', 'admin', sysdate(), '', null, null);
insert into sys_dict_data values(35, 2,  '已审核', 									'2', 		'receipt_status',	   '',   'success', 'n', '0', 'admin', sysdate(), '', null, null);
insert into sys_dict_data values(36, 4,  '其他入库', 								'5', 		'receipt_type',		   '',   'info',    'n', '0', 'admin', sysdate(), '', null, null);
insert into sys_dict_data values(37, 5,  '其他出库', 								'6', 		'receipt_type',        '',   'success', 'n', '0', 'admin', sysdate(), '', null, null);
insert into sys_dict_data values(38, 6,  '库存调拨', 								'7', 		'receipt_type',        '',   'danger',  'n', '0', 'admin', sysdate(), '', null, null);
insert into sys_dict_data values(39, 7,  '库存盘点', 								'8', 		'receipt_type',        '',   'primary', 'n', '0', 'admin', sysdate(), '', null, null);
insert into sys_dict_data values(40, 1,  '采购订单', 								'1', 		'order_form_type', 	   '',   'danger',  'n', '0', 'admin', sysdate(), '', null, null);
insert into sys_dict_data values(41, 2,  '销售订单', 								'2',  	'order_form_type', 	   '',   'primary', 'n', '0', 'admin', sysdate(), '', null, null);
insert into sys_dict_data values(42, 1,  '待审核',									'1', 		'order_form_status', 	   	'',   'primary', 'n', '0', 'admin', sysdate(), '', null, null);
insert into sys_dict_data values(43, 2,  '已审核', 									'2', 		'order_form_status',	   	'',   'success', 'n', '0', 'admin', sysdate(), '', null, null);
insert into sys_dict_data values(44, 1,  '是',	 										'0', 		'after_sales_installation', '',   'primary', 'n', '0', 'admin', sysdate(), '', null, null);
insert into sys_dict_data values(45, 2,  '否', 	 									'1', 		'after_sales_installation',	'',   'success', 'n', '0', 'admin', sysdate(), '', null, null);
insert into sys_dict_data values(46, 1,  '售后安装', 								'1', 		'service_type', 	   		'',   'success', 'n', '0', 'admin', sysdate(), '', null, null);
insert into sys_dict_data values(47, 1,  '通过',	 									'0', 		'finding_of_audit', 		'',   'success', 'n', '0', 'admin', sysdate(), '', null, null);
insert into sys_dict_data values(48, 2,  '不通过', 									'1', 		'finding_of_audit',			'',   'danger', 'n', '0', 'admin', sysdate(), '', null, null);
insert into sys_dict_data values(49, 1,  '982943988424843264',	 	'0', 		'print_selected_files', 	'',   '', 'n', '0', 'admin', sysdate(), '', null, '采购订单');
insert into sys_dict_data values(50, 2,  '983362128149422080',	 	'1', 		'print_selected_files', 	'',   '', 'n', '0', 'admin', sysdate(), '', null, '采购单据');
insert into sys_dict_data values(51, 3,  '983362412942663680',	 	'2', 		'print_selected_files', 	'',   '', 'n', '0', 'admin', sysdate(), '', null, '销售订单');
insert into sys_dict_data values(52, 4,  '983363237521858560',	 	'3', 		'print_selected_files', 	'',   '', 'n', '0', 'admin', sysdate(), '', null, '销售单据');
insert into sys_dict_data values(53, 5,  '983363617982980096',	 	'4', 		'print_selected_files', 	'',   '', 'n', '0', 'admin', sysdate(), '', null, '库存单据');
insert into sys_dict_data values(54, 6,  '983363836531384320',	 	'5', 		'print_selected_files', 	'',   '', 'n', '0', 'admin', sysdate(), '', null, '挑拨单据');
insert into sys_dict_data values(55, 7,  '983363988151279616',	 	'6', 		'print_selected_files', 	'',   '', 'n', '0', 'admin', sysdate(), '', null, '盘点单据');
insert into sys_dict_data values(56, 8,  '983365946211770368',	 	'7', 		'print_selected_files', 	'',   '', 'n', '0', 'admin', sysdate(), '', null, '家装单据');
insert into sys_dict_data values(57, 9,  '983365983805317120',    '8',    'print_selected_files',   '',   '', 'n', '0', 'admin', sysdate(), '', null, '售后单据');
insert into sys_dict_data values(58, 1,  '8',                     '0',    'print_selected_sizes',   '',   '', 'n', '0', 'admin', sysdate(), '', null, '采购订单打印页数');
insert into sys_dict_data values(59, 2,  '8',                     '1',    'print_selected_sizes',   '',   '', 'n', '0', 'admin', sysdate(), '', null, '采购单据打印页数');
insert into sys_dict_data values(60, 3,  '8',                     '2',    'print_selected_sizes',   '',   '', 'n', '0', 'admin', sysdate(), '', null, '销售订单打印页数');
insert into sys_dict_data values(61, 4,  '8',                     '3',    'print_selected_sizes',   '',   '', 'n', '0', 'admin', sysdate(), '', null, '销售单据打印页数');
insert into sys_dict_data values(62, 5,  '8',                     '4',    'print_selected_sizes',   '',   '', 'n', '0', 'admin', sysdate(), '', null, '库存单据打印页数');
insert into sys_dict_data values(63, 6,  '8',                     '5',    'print_selected_sizes',   '',   '', 'n', '0', 'admin', sysdate(), '', null, '挑拨单据打印页数');
insert into sys_dict_data values(64, 7,  '8',                     '6',    'print_selected_sizes',   '',   '', 'n', '0', 'admin', sysdate(), '', null, '盘点单据打印页数');
insert into sys_dict_data values(65, 8,  '8',                     '7',    'print_selected_sizes',   '',   '', 'n', '0', 'admin', sysdate(), '', null, '家装单据打印页数');
insert into sys_dict_data values(66, 9,  '8',                     '8',    'print_selected_sizes',   '',   '', 'n', '0', 'admin', sysdate(), '', null, '售后单据打印页数');

-- ----------------------------
-- 13、参数配置表
-- ----------------------------
drop table if exists sys_config;
create table sys_config (
  config_id         int(5)          not null auto_increment    comment '参数主键',
  config_name       varchar(100)    default ''                 comment '参数名称',
  config_key        varchar(100)    default ''                 comment '参数键名',
  config_value      varchar(500)    default ''                 comment '参数键值',
  config_type       char(1)         default 'n'                comment '系统内置（y是 n否）',
  create_by         varchar(64)     default ''                 comment '创建者',
  create_time       datetime                                   comment '创建时间',
  update_by         varchar(64)     default ''                 comment '更新者',
  update_time       datetime                                   comment '更新时间',
  remark            varchar(500)    default null               comment '备注',
  primary key (config_id)
) engine=innodb auto_increment=100 comment = '参数配置表';

-- ----------------------------
-- 初始化-参考配置表数据
-- ----------------------------
insert into sys_config values(1, '主框架页-默认皮肤样式名称',     'sys.index.skinname',            'skin-blue',     'y', 'admin', sysdate(), '', null, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow' );
insert into sys_config values(2, '用户管理-账号初始密码',         'sys.user.initpassword',         '123456',        'y', 'admin', sysdate(), '', null, '初始化密码 123456' );
insert into sys_config values(3, '主框架页-侧边栏主题',           'sys.index.sidetheme',           'theme-dark',    'y', 'admin', sysdate(), '', null, '深色主题theme-dark，浅色主题theme-light' );
insert into sys_config values(4, '账号自助-验证码开关',           'sys.account.captchaenabled',    'false',          'y', 'admin', sysdate(), '', null, '是否开启验证码功能（true开启，false关闭）');
insert into sys_config values(5, '账号自助-是否开启用户注册功能', 'sys.account.registeruser',      'false',         'y', 'admin', sysdate(), '', null, '是否开启注册用户功能（true开启，false关闭）');
insert into sys_config values(6, '用户登录-黑名单列表',           'sys.login.blackiplist',         '',              'y', 'admin', sysdate(), '', null, '设置登录ip黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）');


-- ----------------------------
-- 14、系统访问记录
-- ----------------------------
drop table if exists sys_logininfor;
create table sys_logininfor (
  info_id        bigint(20)     not null auto_increment   comment '访问id',
  user_name      varchar(50)    default ''                comment '用户账号',
  ipaddr         varchar(128)   default ''                comment '登录ip地址',
  login_location varchar(255)   default ''                comment '登录地点',
  browser        varchar(50)    default ''                comment '浏览器类型',
  os             varchar(50)    default ''                comment '操作系统',
  status         char(1)        default '0'               comment '登录状态（0成功 1失败）',
  msg            varchar(255)   default ''                comment '提示消息',
  login_time     datetime                                 comment '访问时间',
  primary key (info_id),
  key idx_sys_logininfor_s  (status),
  key idx_sys_logininfor_lt (login_time)
) engine=innodb auto_increment=100 comment = '系统访问记录';


-- ----------------------------
-- 15、定时任务调度表
-- ----------------------------
drop table if exists sys_job;
create table sys_job (
  job_id              bigint(20)    not null auto_increment    comment '任务id',
  job_name            varchar(64)   default ''                 comment '任务名称',
  job_group           varchar(64)   default 'default'          comment '任务组名',
  invoke_target       varchar(500)  not null                   comment '调用目标字符串',
  cron_expression     varchar(255)  default ''                 comment 'cron执行表达式',
  misfire_policy      varchar(20)   default '3'                comment '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  concurrent          char(1)       default '1'                comment '是否并发执行（0允许 1禁止）',
  status              char(1)       default '0'                comment '状态（0正常 1暂停）',
  create_by           varchar(64)   default ''                 comment '创建者',
  create_time         datetime                                 comment '创建时间',
  update_by           varchar(64)   default ''                 comment '更新者',
  update_time         datetime                                 comment '更新时间',
  remark              varchar(500)  default ''                 comment '备注信息',
  primary key (job_id, job_name, job_group)
) engine=innodb auto_increment=100 comment = '定时任务调度表';

-- ----------------------------
-- 初始化-定时任务调度表数据
-- ----------------------------
insert into sys_job values(1, '系统默认（无参）', 'default', 'rytask.rynoparams',        '0/10 * * * * ?', '3', '1', '1', 'admin', sysdate(), '', null, '');
insert into sys_job values(2, '系统默认（有参）', 'default', 'rytask.ryparams(\'ry\')',  '0/15 * * * * ?', '3', '1', '1', 'admin', sysdate(), '', null, '');
insert into sys_job values(3, '系统默认（多参）', 'default', 'rytask.rymultipleparams(\'ry\', true, 2000l, 316.50d, 100)',  '0/20 * * * * ?', '3', '1', '1', 'admin', sysdate(), '', null, '');


-- ----------------------------
-- 16、定时任务调度日志表
-- ----------------------------
drop table if exists sys_job_log;
create table sys_job_log (
  job_log_id          bigint(20)     not null auto_increment    comment '任务日志id',
  job_name            varchar(64)    not null                   comment '任务名称',
  job_group           varchar(64)    not null                   comment '任务组名',
  invoke_target       varchar(500)   not null                   comment '调用目标字符串',
  job_message         varchar(500)                              comment '日志信息',
  status              char(1)        default '0'                comment '执行状态（0正常 1失败）',
  exception_info      varchar(2000)  default ''                 comment '异常信息',
  create_time         datetime                                  comment '创建时间',
  primary key (job_log_id)
) engine=innodb comment = '定时任务调度日志表';


-- ----------------------------
-- 17、通知公告表
-- ----------------------------
drop table if exists sys_notice;
create table sys_notice (
  notice_id         int(4)          not null auto_increment    comment '公告id',
  notice_title      varchar(50)     not null                   comment '公告标题',
  notice_type       char(1)         not null                   comment '公告类型（1通知 2公告）',
  notice_content    longblob        default null               comment '公告内容',
  status            char(1)         default '0'                comment '公告状态（0正常 1关闭）',
  create_by         varchar(64)     default ''                 comment '创建者',
  create_time       datetime                                   comment '创建时间',
  update_by         varchar(64)     default ''                 comment '更新者',
  update_time       datetime                                   comment '更新时间',
  remark            varchar(255)    default null               comment '备注',
  primary key (notice_id)
) engine=innodb auto_increment=10 comment = '通知公告表';

-- ----------------------------
-- 初始化-公告信息表数据
-- ----------------------------
insert into sys_notice values('1', '温馨提醒：2024-07-20 铠思运营系统新版本发布啦', '2', '新版本内容', '0', 'admin', sysdate(), '', null, '管理员');


-- ----------------------------
-- 18、代码生成业务表
-- ----------------------------
drop table if exists gen_table;
create table gen_table (
  table_id          bigint(20)      not null auto_increment    comment '编号',
  table_name        varchar(200)    default ''                 comment '表名称',
  table_comment     varchar(500)    default ''                 comment '表描述',
  sub_table_name    varchar(64)     default null               comment '关联子表的表名',
  sub_table_fk_name varchar(64)     default null               comment '子表关联的外键名',
  class_name        varchar(100)    default ''                 comment '实体类名称',
  tpl_category      varchar(200)    default 'crud'             comment '使用的模板（crud单表操作 tree树表操作）',
  tpl_web_type      varchar(30)     default ''                 comment '前端模板类型（element-ui模版 element-plus模版）',
  package_name      varchar(100)                               comment '生成包路径',
  module_name       varchar(30)                                comment '生成模块名',
  business_name     varchar(30)                                comment '生成业务名',
  function_name     varchar(50)                                comment '生成功能名',
  function_author   varchar(50)                                comment '生成功能作者',
  gen_type          char(1)         default '0'                comment '生成代码方式（0zip压缩包 1自定义路径）',
  gen_path          varchar(200)    default '/'                comment '生成路径（不填默认项目路径）',
  options           varchar(1000)                              comment '其它生成选项',
  create_by         varchar(64)     default ''                 comment '创建者',
  create_time 	    datetime                                   comment '创建时间',
  update_by         varchar(64)     default ''                 comment '更新者',
  update_time       datetime                                   comment '更新时间',
  remark            varchar(500)    default null               comment '备注',
  primary key (table_id)
) engine=innodb auto_increment=1 comment = '代码生成业务表';


-- ----------------------------
-- 19、代码生成业务表字段
-- ----------------------------
drop table if exists gen_table_column;
create table gen_table_column (
  column_id         bigint(20)      not null auto_increment    comment '编号',
  table_id          bigint(20)                                 comment '归属表编号',
  column_name       varchar(200)                               comment '列名称',
  column_comment    varchar(500)                               comment '列描述',
  column_type       varchar(100)                               comment '列类型',
  java_type         varchar(500)                               comment 'JAVA类型',
  java_field        varchar(200)                               comment 'JAVA字段名',
  is_pk             char(1)                                    comment '是否主键（1是）',
  is_increment      char(1)                                    comment '是否自增（1是）',
  is_required       char(1)                                    comment '是否必填（1是）',
  is_insert         char(1)                                    comment '是否为插入字段（1是）',
  is_edit           char(1)                                    comment '是否编辑字段（1是）',
  is_list           char(1)                                    comment '是否列表字段（1是）',
  is_query          char(1)                                    comment '是否查询字段（1是）',
  query_type        varchar(200)    default 'EQ'               comment '查询方式（等于、不等于、大于、小于、范围）',
  html_type         varchar(200)                               comment '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  dict_type         varchar(200)    default ''                 comment '字典类型',
  sort              int                                        comment '排序',
  create_by         varchar(64)     default ''                 comment '创建者',
  create_time 	    datetime                                   comment '创建时间',
  update_by         varchar(64)     default ''                 comment '更新者',
  update_time       datetime                                   comment '更新时间',
  primary key (column_id)
) engine=innodb auto_increment=1 comment = '代码生成业务表字段';

-- ----------------------------
-- 20、订单头表
-- ----------------------------
drop table if exists head_order_form;
create table `head_order_form` (
  `systematic_id`		 		bigint		 	not null	 	auto_increment		comment '系统ID',
  `systematic_order_form` 		varchar(32) 	default null	 		      		comment '系统单号',
  `original_order_form` 		varchar(64) 	default null 						comment '原始单号',
  `order_form_type` 			char(1) 		default null 						comment '订单类型（1：采购订单，2：销售订单）',
  `order_form_status` 			char(1) 		default null 						comment '订单状态（1：待审核，2：已审核）',
  `order_date` 					date	 		default null 						comment '订货日期',
  `delivery_date` 				date	 		default null 						comment '开单日期',
  `warehousing_ids` 			int		 		default null 						comment '入库仓库id',
  `retrieval_ids` 				int		 		default null 						comment '出库仓库id',
  `user_ids` 					int		 		default null 						comment '经手人id',
  `supplier_ids` 				int		 		default null 						comment '供应商id',
  `customer_ids` 				int		 		default null 						comment '客户id',
  `plan_receipt` 				varchar(64) 	default null 						comment '计划单号',
  `order_form_notes` 			varchar(128) 	default null 						comment '备注',
  `deposit` 					decimal(14,2) 	default null 						comment '定金',
  `order_form_amount` 			decimal(14,2) 	default null 						comment '总金额',
  `order_capitalize_amount` 	varchar(64) 	default null 						comment '总金额(大写)',
  `after_sales_installation` 	int 			default null 						comment '售后安装（0：是，1：否）',
  `finding_of_audit` 			char(1) 		default null 						comment '审核结果',
  `review_comments` 			varchar(64) 	default null 						comment '审核意见',
  `create_by` 					varchar(32) 	default null 						comment '创建者',
  `create_time` 				datetime 		default null 						comment '创建时间',
  `update_by` 					varchar(32) 	default null 						comment '更新者',
  `update_time` 				datetime 		default null 						comment '更新时间',
  primary key (systematic_id)
) engine=innodb auto_increment=1 comment='订单头表';

-- ----------------------------
-- 21、订单明细表
-- ----------------------------
drop table if exists detail_order_form;
create table `detail_order_form` (
  `systematic_id`		 		bigint		 	not null auto_increment		comment '系统ID',
  `systematic_order_form` 		varchar(32) 	default null	      		comment '系统单号',
  `product_id` 					int			 	default null 				comment '货品ID', 
  `product_specifications` 		varchar(16) 	default null				comment '商品规格',
  `measure_unit` 				varchar(16) 	default null				comment '计量单位',
  `warehousing_id`				int		 		default null 				comment '入库仓库id',
  `retrieval_id` 				int		 		default null 				comment '出库仓库id',
  `supplier_id` 				int		 		default null 				comment '供应商id',
  `customer_id` 				int		 		default null 				comment '客户id',
  `current_inventory` 			bigint		 	default null 				comment '当前库存量',
  `actual_inventory` 			bigint		 	default null 				comment '实际库存量',
  `plan_quantity` 				bigint 			default null 				comment '数量',
  `univalence` 					decimal(14,2) 	default null 				comment '单价',
  `discount` 					decimal(5,2) 	default null 				comment '折扣',
  `money` 						decimal(14,2) 	default null 				comment '金额',
  `cost` 						decimal(14,2) 	default null 				comment '成本',
  `remarks` 					varchar(64) 	default null 				comment '备注',
  primary key (systematic_id)
) engine=innodb auto_increment=1 comment='订单明细表';

-- ----------------------------
-- 20、单据头表
-- ----------------------------
drop table if exists head_receipt;
create table `head_receipt` (
  `systematic_id`		 	bigint		 	not null 		auto_increment		comment '系统ID',
  `systematic_receipt` 		varchar(32) 	default null	 		      		comment '系统单号',
  `original_receipt` 		varchar(64) 	default null 						comment '原始单号',
  `receipt_category` 		char(1) 		default null 						comment '单据类别（1：采购单据，2：销售单据，3：库存单据）',
  `receipt_type` 			char(1) 		default null 						comment '单据类型（1：采购入库，2：采购退库，3：销售出库，4：销售退库，5：其他入库，6：其他出库，7：库存调拨，8：库存盘点）',
  `receipt_status` 			char(1) 		default null 						comment '单据状态（1：待审核，2：已审核）',
  `invoice_date` 			date		 	default null 						comment '开单日期',
  `warehousing_ids` 		int		 		default null 						comment '入库仓库id',
  `retrieval_ids` 			int		 		default null 						comment '出库仓库id',
  `user_ids` 				int		 		default null 						comment '经手人id',
  `supplier_ids` 			int		 		default null 						comment '供应商id',
  `customer_ids` 			int		 		default null 						comment '客户id',
  `plan_receipt` 			varchar(64) 	default null 						comment '计划单号',
  `receipt_notes` 			varchar(128) 	default null 						comment '备注',
  `deposit` 				decimal(14,2) 	default null 						comment '定金',
  `total_amount` 			decimal(14,2) 	default null 						comment '总金额',
  `capitalize_total_amount` varchar(64) 	default null 						comment '总金额(大写)',
  `after_sales_installation`int 			default null 						comment '售后安装（0：是，1：否）',
  `finding_of_audit` 		char(1) 		default null 						comment '审核结果',
  `review_comments` 		varchar(64) 	default null 						comment '审核意见',
  `create_by` 				varchar(32) 	default null 						comment '创建者',
  `create_time` 			datetime 		default null 						comment '创建时间',
  `update_by` 				varchar(32) 	default null 						comment '更新者',
  `update_time` 			datetime 		default null 						comment '更新时间',
  primary key (systematic_id)
) engine=innodb auto_increment=1 comment='单据头表';

-- ----------------------------
-- 21、单据明细表
-- ----------------------------
drop table if exists detail_receipt;
create table `detail_receipt` (
  `systematic_id`		 	bigint		 	not null 	auto_increment	comment '系统ID',
  `systematic_receipt` 		varchar(32) 	default null	      		comment '系统单号',
  `product_id` 				int			 	default null 				comment '货品ID',
  `product_specifications` 	varchar(16) 	default null				comment '商品规格',
  `measure_unit` 			varchar(16) 	default null				comment '计量单位',
  `warehousing_id`			int		 		default null 				comment '入库仓库ID',
  `retrieval_id` 			int		 		default null 				comment '出库仓库ID',
  `supplier_id` 			int		 		default null 				comment '供应商ID',
  `customer_id` 			int		 		default null 				comment '客户ID',
  `current_inventory` 		bigint		 	default null 				comment '当前库存量',
  `actual_inventory` 		bigint		 	default null 				comment '实际库存量',
  `plan_quantity` 			bigint 			default null 				comment '数量',
  `univalence` 				decimal(14,2) 	default null 				comment '单价',
  `discount` 				decimal(5,2) 	default null 				comment '折扣',
  `money` 					decimal(14,2) 	default null 				comment '金额',
  `cost` 					decimal(14,2) 	default null 				comment '成本',
  `remarks` 				varchar(64) 	default null 				comment '备注',
  primary key (systematic_id)
) engine=innodb auto_increment=1 comment='单据明细表';

-- ----------------------------
-- 20、售后单据头表
-- ----------------------------
drop table if exists head_service;
create table `head_service` (
  `systematic_id`		 	bigint		 	not null 			auto_increment	comment '系统ID',
  `systematic_receipt` 		varchar(32) 	default null	 		      		comment '系统单号',
  `original_receipt` 		varchar(64) 	default null 						comment '原始单号',
  `service_type` 			char(1) 		default null 						comment '单据类型（1：售后安装）',
  `receipt_status` 			char(1) 		default null 						comment '单据状态（1：待审核，2：已审核）',
  `invoice_date` 			date		 	default null 						comment '开单日期',
  `warehousing_ids` 		int		 		default null 						comment '入库仓库id',
  `retrieval_ids` 			int		 		default null 						comment '出库仓库id',
  `user_ids` 				int		 		default null 						comment '经手人id',
  `supplier_ids` 			int		 		default null 						comment '供应商id',
  `customer_ids` 			int		 		default null 						comment '客户id',
  `receipt_notes` 			varchar(128) 	default null 						comment '备注',
  `deposit` 				decimal(14,2) 	default null 						comment '定金',
  `total_amount` 			decimal(14,2) 	default null 						comment '总金额',
  `capitalize_total_amount` varchar(64) 	default null 						comment '总金额(大写)',
  `installer` 				varchar(32) 	default null 						comment '安装人员',
  `finding_of_audit` 		char(1) 		default null 						comment '审核结果',
  `review_comments` 		varchar(64) 	default null 						comment '审核意见',
  `create_by` 				varchar(32) 	default null 						comment '创建者',
  `create_time` 			datetime 		default null 						comment '创建时间',
  `update_by` 				varchar(32) 	default null 						comment '更新者',
  `update_time` 			datetime 		default null 						comment '更新时间',
  primary key (systematic_id)
) engine=innodb auto_increment=1 comment='售后单据头表';

-- ----------------------------
-- 21、售后单据明细表
-- ----------------------------
drop table if exists detail_service;
create table `detail_service` (
  `systematic_id`		 	bigint		 	not null 	auto_increment	comment '系统ID',
  `systematic_receipt` 		varchar(32) 	default null	      		comment '系统单号',
  `product_id` 				int			 	default null 				comment '货品ID',
  `product_specifications` 	varchar(16) 	default null				comment '商品规格',
  `measure_unit` 			varchar(16) 	default null				comment '计量单位',
  `warehousing_id`			int		 		default null 				comment '入库仓库id',
  `retrieval_id` 			int		 		default null 				comment '出库仓库id',
  `supplier_id` 			int		 		default null 				comment '供应商id',
  `customer_id` 			int		 		default null 				comment '客户id',
  `current_inventory` 		bigint		 	default null 				comment '当前库存量',
  `actual_inventory` 		bigint		 	default null 				comment '实际库存量',
  `plan_quantity` 			bigint 			default null 				comment '数量',
  `univalence` 				decimal(14,2) 	default null 				comment '单价',
  `discount` 				decimal(5,2) 	default null 				comment '折扣',
  `money` 					decimal(14,2) 	default null 				comment '金额',
  `cost` 					decimal(14,2) 	default null 				comment '成本',
  `remarks` 				varchar(64) 	default null 				comment '备注',
  primary key (systematic_id)
) engine=innodb auto_increment=1 comment='售后单据明细表';

-- ----------------------------
-- 20、家装工程单据头表
-- ----------------------------
drop table if exists head_engineering;
create table `head_engineering` (
  `systematic_id`		 	bigint		 	not null 		auto_increment		comment '系统ID',
  `systematic_receipt` 		varchar(32) 	default null	 		      		comment '系统单号',
  `original_receipt` 		varchar(64) 	default null 						comment '原始单号',
  `engineering_type` 		char(1) 		default null 						comment '单据类型（1：家装工程）',
  `receipt_status` 			char(1) 		default null 						comment '单据状态（1：待审核，2：已审核）',
  `invoice_date` 			date		 	default null 						comment '开单日期',
  `warehousing_ids` 		int 			default null 						comment '入库仓库id',
  `retrieval_ids` 			int 			default null 						comment '出库仓库id',
  `user_ids` 				int 			default null 						comment '经手人id',
  `supplier_ids` 			int 			default null 						comment '供应商id',
  `customer_ids` 			int 			default null 						comment '客户id',
  `receipt_notes` 			varchar(128) 	default null 						comment '备注',
  `deposit` 				decimal(14,2) 	default null 						comment '定金',
  `total_amount` 			decimal(14,2) 	default null 						comment '总金额',
  `capitalize_total_amount` varchar(64) 	default null 						comment '总金额(大写)',
  `finding_of_audit` 		int 			default null 						comment '审核结果',
  `review_comments` 		varchar(64) 	default null 						comment '审核意见',
  `create_by` 				varchar(32) 	default null 						comment '创建者',
  `create_time` 			datetime 		default null 						comment '创建时间',
  `update_by` 				varchar(32) 	default null 						comment '更新者',
  `update_time` 			datetime 		default null 						comment '更新时间',
  primary key (systematic_id)
) engine=innodb auto_increment=1 comment='售后单据头表';

-- ----------------------------
-- 21、家装工程单据明细表
-- ----------------------------
drop table if exists detail_engineering;
create table `detail_engineering` (
  `systematic_id`		 	bigint		 	not null 	auto_increment	comment '系统ID',
  `systematic_receipt` 		varchar(32) 	default null	      		comment '系统单号',
  `product_id` 				int			 	default null 				comment '货品ID',
  `product_specifications` 	varchar(16) 	default null				comment '商品规格',
  `measure_unit` 			varchar(16) 	default null				comment '计量单位',
  `warehousing_id`			int			 	default null 				comment '入库仓库id',
  `retrieval_id` 			int			 	default null 				comment '出库仓库id',
  `supplier_id` 			int			 	default null 				comment '供应商id',
  `customer_id` 			int			 	default null 				comment '客户id',
  `current_inventory` 		bigint		 	default null 				comment '当前库存量',
  `actual_inventory` 		bigint		 	default null 				comment '实际库存量',
  `plan_quantity` 			bigint		 	default null 				comment '数量',
  `univalence` 				decimal(14,2) 	default null 				comment '单价',
  `discount` 				decimal(5,2) 	default null 				comment '折扣',
  `money` 					decimal(14,2) 	default null 				comment '金额',
  `cost` 					decimal(14,2) 	default null 				comment '成本',
  `remarks` 				varchar(64) 	default null 				comment '备注',
  primary key (systematic_id)
) engine=innodb auto_increment=1 comment='售后单据明细表';

-- ----------------------------
-- 22、库存货品查询表
-- ----------------------------
drop table if exists inventory_product;
create table `inventory_product` (
  `inventory_id` 			bigint 			not null 		auto_increment 	comment '库存货品id',
  `product_id` 				int			 	default null 					comment '货品id',
  `warehouse_id` 			int			 	default null 					comment '仓库id',
  `supplier_id` 			int			 	default null 					comment '供应商id',
  `plan_quantity` 			bigint		 	default null 					comment '库存数量',
  `univalence` 				decimal(14,2) 	default null 					comment '库存单价',
  `discount` 				decimal(5,2) 	default null 					comment '库存折扣',
  `money` 					decimal(14,2) 	default null 					comment '库存金额',
  `create_by` 				varchar(32) 	default '' 						comment '创建者',
  `create_time` 			datetime 		default null 					comment '创建时间',
  `update_by` 				varchar(32) 	default '' 						comment '更新者',
  `update_time` 			datetime 		default null 					comment '更新时间',
  primary key (`inventory_id`)
) engine=innodb auto_increment=1 comment='库存货品查询表';

-- ----------------------------
-- 23、供应商资料表
-- ----------------------------
drop table if exists supplier;
create table `supplier` (
  `supplier_id` 					bigint 			not null 		auto_increment 			comment '供应商id',
  `supplier_code` 					varchar(64) 											comment '供应商编号',
  `supplier_name` 					varchar(64) 											comment '供应商名称',
  `supplier_sales_person` 			varchar(64) 											comment '业务员',
  `supplier_contacts` 				varchar(64) 											comment '联系人',
  `supplier_contact_number` 		varchar(64) 											comment '联系电话',
  `supplier_work_address` 			varchar(64) 											comment '单位地址',
  `supplier_postal_code` 			varchar(64) 											comment '邮编',
  `supplier_opening_debt` 			varchar(64) 											comment '期初欠款',
  `supplier_opening_bank` 			varchar(64) 											comment '开户银行',
  `supplier_account_number` 		varchar(64) 											comment '银行账号',
  `supplier_tax_id` 				varchar(64) 											comment '纳税号',
  `supplier_company_homepage` 		varchar(64) 											comment '公司主页',
  `supplier_email` 					varchar(64) 											comment '电子邮箱',
  `supplier_legal_person` 			varchar(64) 											comment '公司法人',
  `remarks` 						varchar(128) 											comment '备注',
  `status` 							char(1) 		default '0' 							comment '供应商状态（0正常 1停用）',
  `create_by` 						varchar(64) 	default '' 								comment '创建者',
  `create_time` 					datetime 		default null 							comment '创建时间',
  `update_by` 						varchar(64) 	default '' 								comment '更新者',
  `update_time` 					datetime 		default null 							comment '更新时间',
  primary key (`supplier_id`)
) engine=innodb auto_increment=1 comment='供应商资料表';

-- ----------------------------
-- 24、客户资料表
-- ----------------------------
drop table if exists customer;
create table `customer` (
  `customer_id` 				bigint(20) 		not null auto_increment 	comment '客户id',
  `customer_code` 				varchar(64)  								comment '客户编号',
  `customer_name` 				varchar(64)  								comment '客户名称',
  `customer_sales_person` 		varchar(64)  								comment '业务员',
  `customer_contacts` 			varchar(64)  								comment '联系人',
  `customer_contact_number` 	varchar(64)  								comment '联系电话',
  `customer_work_address` 		varchar(64)  								comment '单位地址',
  `customer_postal_code` 		varchar(64)  								comment '邮编',
  `customer_opening_debt` 		varchar(64)  								comment '期初欠款',
  `customer_opening_bank` 		varchar(64)  								comment '开户银行',
  `customer_account_number` 	varchar(64)  								comment '银行账号',
  `customer_tax_id` 			varchar(64)  								comment '纳税号',
  `customer_company_homepage` 	varchar(64)  								comment '公司主页',
  `customer_email` 				varchar(64)  								comment '电子邮箱',
  `customer_legal_person` 		varchar(64)  								comment '公司法人',
  `remarks` 					varchar(200)  								comment '备注',
  `status` 						char(1)  		default '0' 				comment '客户状态（0正常 1停用）',
  `create_by` 					varchar(64)   	default '' 					comment '创建者',
  `create_time` 				datetime 									comment '创建时间',
  `update_by` 					varchar(64)   	default '' 					comment '更新者',
  `update_time` 				datetime 									comment '更新时间',
  primary key (`customer_id`)
) engine=innodb auto_increment=1 comment='客户资料表';

-- ----------------------------
-- 25、仓库资料
-- ----------------------------
drop table if exists warehouse;
create table `warehouse` (
  `warehouse_id` 				bigint 					not null 			auto_increment 				comment '仓库id',
  `warehouse_name` 				varchar(64) 															comment '仓库名称',
  `warehouse_director` 			varchar(32) 															comment '仓库负责人',
  `warehouse_telephone` 		varchar(16) 															comment '负责人联系电话',
  `warehouse_address` 			varchar(64) 															comment '仓库地址',
  `warehouse_valid` 			char(1) 				not null 			default '0' 				comment '仓库是否有效（0正常 1停用）',
  `warehouse_notes` 			varchar(64) 															comment '仓库备注',
  `create_by` 					varchar(16) 			default '' 										comment '创建者',
  `create_time` 				datetime 				default null 									comment '创建时间',
  `update_by` 					varchar(16) 			default '' 										comment '更新者',
  `update_time` 				datetime 				default null 									comment '更新时间',
  primary key (`warehouse_id`)
) engine=innodb auto_increment=1 comment='仓库资料';

-- ----------------------------
-- 26、商品资料表
-- ----------------------------
drop table if exists commodity;
create table `commodity` (
  `commodity_id` 				bigint 				not null 		auto_increment 			comment '商品id',
  `commodity_code` 				varchar(64) 					 							comment '商品编号',
  `commodity_name` 				varchar(64) 												comment '商品名称',
  `commodity_type` 				varchar(64) 												comment '商品类型',
  `commodity_specifications` 	varchar(16) 												comment '商品规格',
  `measure_unit` 				varchar(16) 												comment '计量单位',
  `producer` 					varchar(16) 												comment '产地',
  `cost_price` 					int		 													comment '成本价',
  `price` 						char(20) 													comment '参考售价',
  `commodity_barcode` 			varchar(64) 												comment '商品条码',
  `upper_limit` 				int		 													comment '库存上限',
  `lower_limit` 				int		 													comment '库存下限',
  `default_warehouse` 			varchar(16) 												comment '默认仓库',
  `notes` 						varchar(64) 												comment '备注',
  `status` 						char(1) 			default '0' 							comment '商品状态（0正常 1停用）',
  `create_by` 					varchar(16) 		default '' 								comment '创建者',
  `create_time` 				datetime 			default null 							comment '创建时间',
  `update_by` 					varchar(16) 		default '' 								comment '更新者',
  `update_time` 				datetime 			default null 							comment '更新时间',
  primary key (`commodity_id`)
) engine=innodb auto_increment=1 comment='商品资料表';

-- ----------------------------
-- 27、商品类型表
-- ----------------------------
drop table if exists commodity_type;
create table `commodity_type` (
  `commodity_type_id` 			bigint 				not null 		auto_increment 			comment '商品类型id',
  `parent_id` 					bigint 				default '0' 							comment '父商品类型id',
  `ancestors` 					varchar(50) 												comment '祖级列表',
  `commodity_type_name` 		varchar(30) 												comment '商品类型名称',
  `order_num` 					int 				default '0' 							comment '显示顺序',
  `status` 						char(1) 			default '0' 							comment '商品类型状态（0正常 1停用）',
  `del_flag` 					char(1) 			default '0' 							comment '删除标志（0代表存在 2代表删除）',
  `create_by` 					varchar(64) 		default '' 								comment '创建者',
  `create_time` 				datetime 			default null 							comment '创建时间',
  `update_by` 					varchar(64) 		default '' 								comment '更新者',
  `update_time` 				datetime 			default null 							comment '更新时间',
  primary key (`commodity_type_id`)
) engine=innodb auto_increment=1 comment='商品类型表';

-- ----------------------------
-- 初始化-商品类型表数据
-- ----------------------------
insert into commodity_type values(1, 0, '0', '商品类型', 0, '0', '0', 'admin', sysdate(), '', null);

-- ----------------------------
-- 26、货品资料表
-- ----------------------------
drop table if exists product;
create table `product` (
  `product_id` 					bigint 				not null 		auto_increment 			comment '货品id',
  `product_code` 				varchar(64) 					 							comment '货品编号',
  `product_name` 				varchar(64) 												comment '货品名称',
  `product_type` 				bigint 														comment '货品类型',
  `product_specifications` 		varchar(16) 												comment '商品规格',
  `measure_unit` 				varchar(16) 												comment '计量单位',
  `producer` 					varchar(16) 												comment '产地',
  `cost_price` 					decimal(10,2)		default 0.00							comment '成本价',
  `univalence` 					decimal(10,2) 		default 0.00							comment '参考售价',
  `discount` 					decimal(10,2) 		default 1.00							comment '销售折扣',
  `product_barcode` 			varchar(64) 												comment '货品条码',
  `inventory_qty` 				bigint 				default 0								comment '库存数量',
  `upper_limit` 				bigint	 			default 0								comment '库存上限',
  `lower_limit` 				bigint	 			default 0								comment '库存下限',
  `default_warehouse` 			varchar(16) 												comment '默认仓库',
  `notes` 						varchar(64) 												comment '备注',
  `status` 						char(1) 			default 0 								comment '货品状态（0正常 1停用）',
  `create_by` 					varchar(16) 		default '' 								comment '创建者',
  `create_time` 				datetime 			default null 							comment '创建时间',
  `update_by` 					varchar(16) 		default '' 								comment '更新者',
  `update_time` 				datetime 			default null 							comment '更新时间',
  primary key (`product_id`)
) engine=innodb auto_increment=1 comment='货品资料表';

-- ----------------------------
-- 27、货品类型表
-- ----------------------------
drop table if exists product_type;
create table `product_type` (
  `product_type_id` 			bigint 				not null 		auto_increment 			comment '货品类型id',
  `parent_id` 					bigint 				default '0' 							comment '父货品类型id',
  `ancestors` 					varchar(50) 												comment '祖级列表',
  `product_type_name` 			varchar(30) 												comment '货品类型名称',
  `order_num` 					int 				default '0' 							comment '显示顺序',
  `status` 						char(1) 			default '0' 							comment '货品类型状态（0正常 1停用）',
  `del_flag` 					char(1) 			default '0' 							comment '删除标志（0代表存在 2代表删除）',
  `create_by` 					varchar(64) 		default '' 								comment '创建者',
  `create_time` 				datetime 			default null 							comment '创建时间',
  `update_by` 					varchar(64) 		default '' 								comment '更新者',
  `update_time` 				datetime 			default null 							comment '更新时间',
  primary key (`product_type_id`)
) engine=innodb auto_increment=1 comment='货品类型表';

-- ----------------------------
-- 初始化-货品类型表数据
-- ----------------------------
insert into product_type values(1, 0, '0', '货品类型', 0, '0', '0', 'admin', sysdate(), '', null);

-- ----------------------------
-- 28、文件共享表
-- ----------------------------
drop table if exists template_file;
create table `template_file` (
  `file_id` 				bigint 				not null 			auto_increment 				comment '文件id',
  `file_name` 				varchar(64) 														comment '文件名称',
  `file_url` 				varchar(128) 														comment '文件路径',
  `create_by` 				varchar(32) 		default '' 										comment '创建者',
  `create_time` 			datetime 			default null 									comment '创建时间',
  `update_by` 				varchar(32) 		default '' 										comment '更新者',
  `update_time` 			datetime 			default null 									comment '更新时间',
  primary key (`file_id`)
) engine=innodb auto_increment=1 comment='文件共享表';

-- ----------------------------
-- 29、在线excel设计器
-- ----------------------------
DROP TABLE IF EXISTS jimu_report;
CREATE TABLE `jimu_report`  (
  `id` 					varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `code` 				varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '编码',
  `name` 				varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `note` 				varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '说明',
  `status` 				varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '状态',
  `type` 				varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '类型',
  `json_str` 			longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT 'json字符串',
  `api_url` 			varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求地址',
  `thumb` 				text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '缩略图',
  `create_by` 			varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` 		datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` 			varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` 		datetime NULL DEFAULT NULL COMMENT '修改时间',
  `del_flag` 			tinyint(1) NULL DEFAULT NULL COMMENT '删除标识0-正常,1-已删除',
  `api_method` 			varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求方法0-get,1-post',
  `api_code` 			varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求编码',
  `template` 			tinyint(1) NULL DEFAULT NULL COMMENT '是否是模板 0-是,1-不是',
  `view_count` 			bigint(15) NULL DEFAULT 0 COMMENT '浏览次数',
  `css_str` 			text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT 'css增强',
  `js_str` 				text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT 'js增强',
  `py_str` 				text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT 'py增强',
  `tenant_id` 			varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '多租户标识',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uniq_jmreport_code`(`code`) USING BTREE,
  INDEX `uniq_jmreport_createby`(`create_by`) USING BTREE,
  INDEX `uniq_jmreport_delflag`(`del_flag`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '在线excel设计器' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- 初始化-在线excel设计器表数据
-- ----------------------------
INSERT INTO jimu_report VALUES('957623614502789120', '20240603232403', '送货结算单', NULL, NULL, 'printinfo', '{"loopBlockList":[],"printConfig":{"paper":"A4","width":210,"height":297,"definition":5,"isBackend":false,"marginX":10,"marginY":10,"layout":"portrait","printCallBackUrl":"","paginationShow":false,"paginationLocation":"middle"},"hidden":{"rows":[],"cols":[]},"dbexps":[],"dicts":[],"freeze":"A1","dataRectWidth":660,"completeBlankRowList":[{"db":"detailReceipt","field":"product_code","rows":"8"}],"autofilter":{},"validations":[],"cols":{"0":{"width":25},"1":{"width":86},"2":{"width":193},"3":{"width":40},"4":{"width":40},"5":{"width":42},"6":{"width":63},"7":{"width":71},"len":50},"area":{"sri":6,"sci":5,"eri":6,"eci":5,"width":42,"height":25},"pyGroupEngine":false,"excel_config_id":"957623614502789120","hiddenCells":[],"zonedEditionList":[],"rows":{"0":{"cells":{"1":{"text":""},"2":{"text":""},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{"text":"No"},"8":{"text":""}}},"1":{"cells":{"1":{"merge":[2,4],"style":61,"text":"东莞市铠思科技\\n送货(结算)单","height":75},"2":{"text":""},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{"text":"系统编号："},"8":{"rendered":"","config":"","text":"${headReceipt.systematic_receipt}","merge":[0,1],"height":25}}},"2":{"cells":{"1":{"text":""},"2":{"text":""},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{"text":"开单日期："},"8":{"text":"${headReceipt.invoice_date}","merge":[0,1],"height":25}}},"3":{"cells":{"1":{"text":""},"2":{"text":""},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{"text":"送货日期："},"8":{"text":"${headReceipt.invoice_date}","merge":[0,1],"height":25}}},"4":{"cells":{"1":{"text":"客户名称："},"2":{"text":"${headReceipt.customer_name}"},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{"text":""},"8":{"text":""}}},"5":{"cells":{"1":{"style":23,"text":"商品编号"},"2":{"style":23,"text":"名称/型号/规格"},"3":{"style":23,"text":"颜色"},"4":{"style":23,"text":"单位"},"5":{"style":23,"text":"数量"},"6":{"style":23,"text":"单价"},"7":{"style":23,"text":"金额"},"8":{"style":23,"text":"备注"}}},"6":{"cells":{"1":{"style":13,"text":"#{detailReceipt.product_code}","completeBlankStatus":true,"completeBlankRow":"8","aggregate":"","rendered":"","config":"","display":"normal"},"2":{"style":13,"text":"#{detailReceipt.product_name}","completeBlankStatus":false,"completeBlankRow":"8","rendered":"","config":""},"3":{"style":13,"text":"#{detailReceipt.product_specifications}"},"4":{"style":13,"text":"#{detailReceipt.measure_unit}","completeBlankStatus":false,"completeBlankRow":"8","rendered":"","config":""},"5":{"style":13,"text":"#{detailReceipt.plan_quantity}","completeBlankStatus":false,"completeBlankRow":"8"},"6":{"style":13,"text":"#{detailReceipt.discount}","completeBlankStatus":false,"completeBlankRow":"8"},"7":{"style":13,"text":"#{detailReceipt.money}","completeBlankStatus":false,"completeBlankRow":"8"},"8":{"funcname":"-1","rendered":"","subtotal":"-1","style":13,"text":"#{detailReceipt.remarks}","config":"","completeBlankStatus":false,"completeBlankRow":"8"}}},"7":{"cells":{"1":{"merge":[0,4],"style":13,"height":25,"text":"合计（大写）：${headReceipt.capitalize_total_amount}"},"2":{"text":""},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"rendered":"","merge":[0,2],"display":"number","style":13,"config":"","height":25,"text":"（小写）：￥${headReceipt.total_amount}"},"7":{"text":""},"8":{"text":""}}},"8":{"cells":{"1":{"merge":[1,4],"style":22,"height":50,"text":"备注：${headReceipt.receipt_notes}"},"2":{},"3":{},"4":{},"5":{},"6":{"merge":[0,2],"style":13,"height":25,"rendered":"","config":"","text":"已收定金：￥${headReceipt.deposit}"},"7":{"text":""},"8":{"text":""}}},"9":{"cells":{"1":{},"2":{},"3":{},"4":{},"5":{},"6":{"merge":[0,2],"style":13,"height":25,"rendered":"","config":"","text":"应收余款：￥=SUM(${headReceipt.total_amount}-${headReceipt.deposit})"},"7":{"text":""},"8":{"text":""}}},"10":{"cells":{"1":{"merge":[2,0],"style":34,"text":"顾客须知","height":75},"2":{"merge":[0,4],"style":13,"text":"1、禁止恶意损坏物品","height":25},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{"merge":[2,1],"style":41,"text":"顾客签名：","height":75},"8":{}}},"11":{"cells":{"1":{"text":""},"2":{"merge":[0,4],"style":42,"text":"2、商品验收后无质量问题不予退货","height":25},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{},"8":{}}},"12":{"cells":{"1":{"text":""},"2":{"merge":[0,4],"style":39,"text":"3、客户验收核对所购买产品无误","height":25},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{},"8":{}}},"14":{"cells":{"2":{"rendered":"","config":""},"3":{},"4":{},"7":{}}},"15":{"cells":{"2":{},"4":{}}},"16":{"cells":{"3":{"text":"","rendered":"","config":""}}},"len":88,"":{"cells":{"":{"text":"","completeBlankRow":"8"}}}},"rpbar":{"show":true,"pageSize":"","btnList":[]},"fixedPrintHeadRows":[],"fixedPrintTailRows":[],"displayConfig":{},"background":false,"name":"sheet1","styles":[{"align":"center"},{"align":"center","font":{"size":26}},{"font":{"size":26}},{"align":"center","font":{"size":42}},{"font":{"size":42}},{"border":{"top":["thin","#000"],"left":["thin","#000"]}},{"border":{"top":["thin","#000"]}},{"border":{"top":["thin","#000"],"right":["thin","#000"]}},{"border":{"left":["thin","#000"]}},{"border":{"right":["thin","#000"]}},{"border":{"left":["thin","#000"],"bottom":["thin","#000"]}},{"border":{"bottom":["thin","#000"]}},{"border":{"bottom":["thin","#000"],"right":["thin","#000"]}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"font":{"size":15}},{"font":{"size":15}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"font":{"size":18}},{"font":{"size":18}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"font":{"size":26}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"font":{"size":16}},{"font":{"size":16}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"align":"left"},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","align":"left"},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"align":"center"},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"middle","font":{"size":16}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","font":{"size":16}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":true,"font":{"size":16}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":false,"font":{"size":16}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":true,"font":{"size":18}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":true,"font":{"size":26}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":true,"font":{"size":24}},{"font":{"size":24}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":true,"font":{"size":22}},{"font":{"size":22}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":true,"align":"center","font":{"size":22}},{},{"border":{"right":["thin","#ffffff"]}},{"border":{"top":["thin","#ffffff"],"right":["thin","#ffffff"]}},{"border":{"top":["thin","#ffffff"],"bottom":["thin","#ffffff"],"right":["thin","#ffffff"]}},{"border":{"top":["thin","#ffffff"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]}},{"border":{"top":["thin","#ffffff"],"left":["thin","#ffffff"],"bottom":["thin","#ffffff"],"right":["thin","#ffffff"]},"valign":"top","align":"left"},{"border":{"top":["thin","#000100"],"left":["thin","#000100"],"bottom":["thin","#000100"],"right":["thin","#000100"]},"valign":"top","align":"left"},{"border":{"top":["thin","#000100"],"left":["thin","#000100"],"bottom":["thin","#000100"],"right":["thin","#000100"]}},{"textwrap":true,"align":"center","font":{"size":42}},{"textwrap":false,"align":"center","font":{"size":42}},{"textwrap":false,"align":"center","font":{"size":14}},{"font":{"size":14}},{"textwrap":false,"align":"center","font":{"size":18}},{"textwrap":false,"align":"center","font":{"size":22}},{"textwrap":false,"align":"center","font":{"size":22,"bold":true}},{"font":{"size":22,"bold":true}},{"textwrap":false,"align":"center","font":{"size":22,"bold":false}},{"font":{"size":22,"bold":false}},{"textwrap":false,"align":"center","font":{"size":22,"name":"Microsoft YaHei","bold":true}},{"font":{"size":22,"name":"Microsoft YaHei","bold":true}},{"textwrap":false,"align":"center","font":{"size":22,"name":"宋体","bold":true}},{"font":{"size":22,"name":"宋体","bold":true}},{"textwrap":false,"align":"center","font":{"size":22,"name":"Source Sans Pro","bold":true}},{"font":{"size":22,"name":"Source Sans Pro","bold":true}},{"textwrap":false,"align":"center","font":{"size":22,"name":"Lato","bold":true}},{"font":{"size":22,"name":"Lato","bold":true}},{"textwrap":false,"align":"center","font":{"size":24,"name":"Microsoft YaHei","bold":true}},{"font":{"size":24,"name":"Microsoft YaHei","bold":true}}],"freezeLineColor":"rgb(185, 185, 185)","merges":["B2:F4","I2:J2","I3:J3","I4:J4","B8:F8","G8:I8","B9:F10","G9:I9","G10:I10","B11:B13","C11:G11","H11:I13","C12:G12","C13:G13"]}', NULL, NULL, '', NULL, '', NULL, 0, NULL, NULL, 0, 111, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report VALUES('982943988424843264', '20240603232403__8722', '采购订单', NULL, NULL, 'printinfo', '{"loopBlockList":[],"printConfig":{"paper":"A4","width":210,"height":297,"definition":5,"isBackend":false,"marginX":10,"marginY":10,"layout":"portrait","printCallBackUrl":"","paginationShow":false,"paginationLocation":"middle"},"hidden":{"rows":[],"cols":[]},"dbexps":[],"dicts":[],"freeze":"A1","dataRectWidth":660,"completeBlankRowList":[{"db":"detailOrder","field":"product_code","rows":"8"}],"autofilter":{},"validations":[],"cols":{"0":{"width":25},"1":{"width":86},"2":{"width":193},"3":{"width":40},"4":{"width":40},"5":{"width":42},"6":{"width":63},"7":{"width":71},"len":50},"area":false,"pyGroupEngine":false,"excel_config_id":"982943988424843264","hiddenCells":[],"zonedEditionList":[],"rows":{"0":{"cells":{"1":{"text":""},"2":{"text":""},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{},"8":{"text":""}}},"1":{"cells":{"1":{"merge":[2,4],"style":61,"height":75,"text":"东莞市铠思科技\\n采购订单"},"2":{"text":""},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{"text":"系统编号："},"8":{"rendered":"","config":"","text":"${headOrder.systematic_order_form}","merge":[0,1],"height":25}}},"2":{"cells":{"1":{"text":""},"2":{"text":""},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{"text":"开单日期："},"8":{"text":"${headOrder.delivery_date}","merge":[0,1],"height":25}}},"3":{"cells":{"1":{"text":""},"2":{"text":""},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{"text":"送货日期："},"8":{"text":"${headOrder.delivery_date}","merge":[0,1],"height":25}}},"4":{"cells":{"1":{"text":"客户名称："},"2":{"text":"${headOrder.customer_name}"},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{"text":""},"8":{"text":""}}},"5":{"cells":{"1":{"style":23,"text":"商品编号"},"2":{"style":23,"text":"名称/型号/规格"},"3":{"style":23,"text":"颜色"},"4":{"style":23,"text":"单位"},"5":{"style":23,"text":"数量"},"6":{"style":23,"text":"单价"},"7":{"style":23,"text":"金额"},"8":{"style":23,"text":"备注"}}},"6":{"cells":{"1":{"style":13,"text":"#{detailOrder.product_code}","completeBlankStatus":true,"completeBlankRow":"8","aggregate":"","rendered":"","config":"","display":"normal"},"2":{"style":13,"text":"#{detailOrder.product_name}","completeBlankStatus":false,"completeBlankRow":"8","rendered":"","config":""},"3":{"style":13,"text":"#{detailOrder.product_specifications}"},"4":{"style":13,"completeBlankStatus":false,"completeBlankRow":"8","rendered":"","config":"","text":"#{detailOrder.measure_unit}"},"5":{"style":13,"text":"#{detailOrder.plan_quantity}","completeBlankStatus":false,"completeBlankRow":"8"},"6":{"style":13,"text":"#{detailOrder.univalence}","completeBlankStatus":false,"completeBlankRow":"8"},"7":{"style":13,"text":"#{detailOrder.money}","completeBlankStatus":false,"completeBlankRow":"8"},"8":{"funcname":"-1","rendered":"","subtotal":"-1","style":13,"text":"#{detailOrder.remarks}","config":"","completeBlankStatus":false,"completeBlankRow":"8"}}},"7":{"cells":{"1":{"merge":[0,4],"style":13,"height":25,"text":"合计（大写）：${headOrder.order_capitalize_amount}"},"2":{"text":""},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"rendered":"","merge":[0,2],"display":"number","style":13,"config":"","height":25,"text":"（小写）：￥${headOrder.order_form_amount}"},"7":{"text":""},"8":{"text":""}}},"8":{"cells":{"1":{"merge":[1,4],"style":22,"height":50,"text":"备注：${headOrder.order_form_notes}"},"2":{},"3":{},"4":{},"5":{},"6":{"merge":[0,2],"style":13,"height":25,"rendered":"","config":"","text":"已收定金：￥${headOrder.deposit}"},"7":{"text":""},"8":{"text":""}}},"9":{"cells":{"1":{},"2":{},"3":{},"4":{},"5":{},"6":{"merge":[0,2],"style":13,"height":25,"rendered":"","config":"","text":"应收余款：￥=SUM(${headOrder.order_form_amount}-${headOrder.deposit})"},"7":{"text":""},"8":{"text":""}}},"10":{"cells":{"1":{"merge":[2,0],"style":34,"text":"顾客须知","height":75},"2":{"merge":[0,4],"style":13,"text":"1、禁止恶意损坏物品","height":25},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{"merge":[2,1],"style":41,"text":"顾客签名：","height":75},"8":{}}},"11":{"cells":{"1":{"text":""},"2":{"merge":[0,4],"style":42,"text":"2、商品验收后无质量问题不予退货","height":25},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{},"8":{}}},"12":{"cells":{"1":{"text":""},"2":{"merge":[0,4],"style":39,"text":"3、客户验收核对所购买产品无误","height":25},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{},"8":{}}},"14":{"cells":{"2":{"rendered":"","config":""},"3":{},"4":{},"7":{}}},"15":{"cells":{"2":{},"4":{}}},"16":{"cells":{"3":{"text":"","rendered":"","config":""}}},"len":88},"rpbar":{"show":true,"pageSize":"","btnList":[]},"fixedPrintHeadRows":[],"fixedPrintTailRows":[],"displayConfig":{},"background":false,"name":"sheet1","styles":[{"align":"center"},{"align":"center","font":{"size":26}},{"font":{"size":26}},{"align":"center","font":{"size":42}},{"font":{"size":42}},{"border":{"top":["thin","#000"],"left":["thin","#000"]}},{"border":{"top":["thin","#000"]}},{"border":{"top":["thin","#000"],"right":["thin","#000"]}},{"border":{"left":["thin","#000"]}},{"border":{"right":["thin","#000"]}},{"border":{"left":["thin","#000"],"bottom":["thin","#000"]}},{"border":{"bottom":["thin","#000"]}},{"border":{"bottom":["thin","#000"],"right":["thin","#000"]}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"font":{"size":15}},{"font":{"size":15}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"font":{"size":18}},{"font":{"size":18}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"font":{"size":26}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"font":{"size":16}},{"font":{"size":16}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"align":"left"},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","align":"left"},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"align":"center"},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"middle","font":{"size":16}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","font":{"size":16}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":true,"font":{"size":16}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":false,"font":{"size":16}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":true,"font":{"size":18}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":true,"font":{"size":26}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":true,"font":{"size":24}},{"font":{"size":24}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":true,"font":{"size":22}},{"font":{"size":22}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":true,"align":"center","font":{"size":22}},{},{"border":{"right":["thin","#ffffff"]}},{"border":{"top":["thin","#ffffff"],"right":["thin","#ffffff"]}},{"border":{"top":["thin","#ffffff"],"bottom":["thin","#ffffff"],"right":["thin","#ffffff"]}},{"border":{"top":["thin","#ffffff"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]}},{"border":{"top":["thin","#ffffff"],"left":["thin","#ffffff"],"bottom":["thin","#ffffff"],"right":["thin","#ffffff"]},"valign":"top","align":"left"},{"border":{"top":["thin","#000100"],"left":["thin","#000100"],"bottom":["thin","#000100"],"right":["thin","#000100"]},"valign":"top","align":"left"},{"border":{"top":["thin","#000100"],"left":["thin","#000100"],"bottom":["thin","#000100"],"right":["thin","#000100"]}},{"textwrap":true,"align":"center","font":{"size":42}},{"textwrap":false,"align":"center","font":{"size":42}},{"textwrap":false,"align":"center","font":{"size":14}},{"font":{"size":14}},{"textwrap":false,"align":"center","font":{"size":18}},{"textwrap":false,"align":"center","font":{"size":22}},{"textwrap":false,"align":"center","font":{"size":22,"bold":true}},{"font":{"size":22,"bold":true}},{"textwrap":false,"align":"center","font":{"size":22,"bold":false}},{"font":{"size":22,"bold":false}},{"textwrap":false,"align":"center","font":{"size":22,"name":"Microsoft YaHei","bold":true}},{"font":{"size":22,"name":"Microsoft YaHei","bold":true}},{"textwrap":false,"align":"center","font":{"size":22,"name":"宋体","bold":true}},{"font":{"size":22,"name":"宋体","bold":true}},{"textwrap":false,"align":"center","font":{"size":22,"name":"Source Sans Pro","bold":true}},{"font":{"size":22,"name":"Source Sans Pro","bold":true}},{"textwrap":false,"align":"center","font":{"size":22,"name":"Lato","bold":true}},{"font":{"size":22,"name":"Lato","bold":true}},{"textwrap":false,"align":"center","font":{"size":24,"name":"Microsoft YaHei","bold":true}},{"font":{"size":24,"name":"Microsoft YaHei","bold":true}}],"freezeLineColor":"rgb(185, 185, 185)","merges":["B2:F4","I2:J2","I3:J3","I4:J4","B8:F8","G8:I8","B9:F10","G9:I9","G10:I10","B11:B13","C11:G11","H11:I13","C12:G12","C13:G13"]}', NULL, NULL, '', NULL, '', NULL, 0, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report VALUES('983362128149422080', '20240603232403__6990', '销售订单', NULL, NULL, 'printinfo', '{"loopBlockList":[],"printConfig":{"paper":"A4","width":210,"height":297,"definition":5,"isBackend":false,"marginX":10,"marginY":10,"layout":"portrait","printCallBackUrl":"","paginationShow":false,"paginationLocation":"middle"},"hidden":{"rows":[],"cols":[]},"dbexps":[],"dicts":[],"freeze":"A1","dataRectWidth":660,"completeBlankRowList":[{"db":"detailOrder","field":"product_code","rows":"8"}],"autofilter":{},"validations":[],"cols":{"0":{"width":25},"1":{"width":86},"2":{"width":193},"3":{"width":40},"4":{"width":40},"5":{"width":42},"6":{"width":63},"7":{"width":71},"len":50},"area":{"sri":11,"sci":2,"eri":11,"eci":6,"width":378,"height":25},"pyGroupEngine":false,"excel_config_id":"983362128149422080","hiddenCells":[],"zonedEditionList":[],"rows":{"0":{"cells":{"1":{"text":""},"2":{"text":""},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{},"8":{"text":""}}},"1":{"cells":{"1":{"merge":[2,4],"style":61,"height":75,"text":"东莞市铠思科技\\n销售订单"},"2":{"text":""},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{"text":"系统编号："},"8":{"rendered":"","config":"","text":"${headOrder.systematic_order_form}","merge":[0,1],"height":25}}},"2":{"cells":{"1":{"text":""},"2":{"text":""},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{"text":"开单日期："},"8":{"text":"${headOrder.delivery_date}","merge":[0,1],"height":25}}},"3":{"cells":{"1":{"text":""},"2":{"text":""},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{"text":"送货日期："},"8":{"text":"${headOrder.delivery_date}","merge":[0,1],"height":25}}},"4":{"cells":{"1":{"text":"客户名称："},"2":{"text":"${headOrder.customer_name}"},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{"text":""},"8":{"text":""}}},"5":{"cells":{"1":{"style":23,"text":"商品编号"},"2":{"style":23,"text":"名称/型号/规格"},"3":{"style":23,"text":"颜色"},"4":{"style":23,"text":"单位"},"5":{"style":23,"text":"数量"},"6":{"style":23,"text":"单价"},"7":{"style":23,"text":"金额"},"8":{"style":23,"text":"备注"}}},"6":{"cells":{"1":{"style":13,"text":"#{detailOrder.product_code}","completeBlankStatus":true,"completeBlankRow":"8","aggregate":"","rendered":"","config":"","display":"normal"},"2":{"style":13,"text":"#{detailOrder.product_name}","completeBlankStatus":false,"completeBlankRow":"8","rendered":"","config":""},"3":{"style":13,"text":"#{detailOrder.product_specifications}"},"4":{"style":13,"completeBlankStatus":false,"completeBlankRow":"8","rendered":"","config":"","text":"#{detailOrder.measure_unit}"},"5":{"style":13,"text":"#{detailOrder.plan_quantity}","completeBlankStatus":false,"completeBlankRow":"8"},"6":{"style":13,"text":"#{detailOrder.univalence}","completeBlankStatus":false,"completeBlankRow":"8"},"7":{"style":13,"text":"#{detailOrder.money}","completeBlankStatus":false,"completeBlankRow":"8"},"8":{"funcname":"-1","rendered":"","subtotal":"-1","style":13,"text":"#{detailOrder.remarks}","config":"","completeBlankStatus":false,"completeBlankRow":"8"}}},"7":{"cells":{"1":{"merge":[0,4],"style":13,"height":25,"text":"合计（大写）：${headOrder.order_capitalize_amount}"},"2":{"text":""},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"rendered":"","merge":[0,2],"display":"number","style":13,"config":"","height":25,"text":"（小写）：￥${headOrder.order_form_amount}"},"7":{"text":""},"8":{"text":""}}},"8":{"cells":{"1":{"merge":[1,4],"style":22,"height":50,"text":"备注：${headOrder.order_form_notes}"},"2":{},"3":{},"4":{},"5":{},"6":{"merge":[0,2],"style":13,"height":25,"rendered":"","config":"","text":"已收定金：￥${headOrder.deposit}"},"7":{"text":""},"8":{"text":""}}},"9":{"cells":{"1":{},"2":{},"3":{},"4":{},"5":{},"6":{"merge":[0,2],"style":13,"height":25,"rendered":"","config":"","text":"应收余款：￥=SUM(${headOrder.order_form_amount}-${headOrder.deposit})"},"7":{"text":""},"8":{"text":""}}},"10":{"cells":{"1":{"merge":[2,0],"style":34,"text":"顾客须知","height":75},"2":{"merge":[0,4],"style":13,"text":"1、禁止恶意损坏物品","height":25},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{"merge":[2,1],"style":41,"text":"顾客签名：","height":75},"8":{}}},"11":{"cells":{"1":{"text":""},"2":{"merge":[0,4],"style":42,"text":"2、商品验收后无质量问题不予退货","height":25},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{},"8":{}}},"12":{"cells":{"1":{"text":""},"2":{"merge":[0,4],"style":39,"text":"3、客户验收核对所购买产品无误","height":25},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{},"8":{}}},"14":{"cells":{"2":{"rendered":"","config":""},"3":{},"4":{},"7":{}}},"15":{"cells":{"2":{},"4":{}}},"16":{"cells":{"3":{"text":"","rendered":"","config":""}}},"len":88},"rpbar":{"show":true,"pageSize":"","btnList":[]},"fixedPrintHeadRows":[],"fixedPrintTailRows":[],"displayConfig":{},"background":false,"name":"sheet1","styles":[{"align":"center"},{"align":"center","font":{"size":26}},{"font":{"size":26}},{"align":"center","font":{"size":42}},{"font":{"size":42}},{"border":{"top":["thin","#000"],"left":["thin","#000"]}},{"border":{"top":["thin","#000"]}},{"border":{"top":["thin","#000"],"right":["thin","#000"]}},{"border":{"left":["thin","#000"]}},{"border":{"right":["thin","#000"]}},{"border":{"left":["thin","#000"],"bottom":["thin","#000"]}},{"border":{"bottom":["thin","#000"]}},{"border":{"bottom":["thin","#000"],"right":["thin","#000"]}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"font":{"size":15}},{"font":{"size":15}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"font":{"size":18}},{"font":{"size":18}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"font":{"size":26}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"font":{"size":16}},{"font":{"size":16}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"align":"left"},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","align":"left"},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"align":"center"},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"middle","font":{"size":16}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","font":{"size":16}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":true,"font":{"size":16}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":false,"font":{"size":16}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":true,"font":{"size":18}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":true,"font":{"size":26}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":true,"font":{"size":24}},{"font":{"size":24}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":true,"font":{"size":22}},{"font":{"size":22}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":true,"align":"center","font":{"size":22}},{},{"border":{"right":["thin","#ffffff"]}},{"border":{"top":["thin","#ffffff"],"right":["thin","#ffffff"]}},{"border":{"top":["thin","#ffffff"],"bottom":["thin","#ffffff"],"right":["thin","#ffffff"]}},{"border":{"top":["thin","#ffffff"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]}},{"border":{"top":["thin","#ffffff"],"left":["thin","#ffffff"],"bottom":["thin","#ffffff"],"right":["thin","#ffffff"]},"valign":"top","align":"left"},{"border":{"top":["thin","#000100"],"left":["thin","#000100"],"bottom":["thin","#000100"],"right":["thin","#000100"]},"valign":"top","align":"left"},{"border":{"top":["thin","#000100"],"left":["thin","#000100"],"bottom":["thin","#000100"],"right":["thin","#000100"]}},{"textwrap":true,"align":"center","font":{"size":42}},{"textwrap":false,"align":"center","font":{"size":42}},{"textwrap":false,"align":"center","font":{"size":14}},{"font":{"size":14}},{"textwrap":false,"align":"center","font":{"size":18}},{"textwrap":false,"align":"center","font":{"size":22}},{"textwrap":false,"align":"center","font":{"size":22,"bold":true}},{"font":{"size":22,"bold":true}},{"textwrap":false,"align":"center","font":{"size":22,"bold":false}},{"font":{"size":22,"bold":false}},{"textwrap":false,"align":"center","font":{"size":22,"name":"Microsoft YaHei","bold":true}},{"font":{"size":22,"name":"Microsoft YaHei","bold":true}},{"textwrap":false,"align":"center","font":{"size":22,"name":"宋体","bold":true}},{"font":{"size":22,"name":"宋体","bold":true}},{"textwrap":false,"align":"center","font":{"size":22,"name":"Source Sans Pro","bold":true}},{"font":{"size":22,"name":"Source Sans Pro","bold":true}},{"textwrap":false,"align":"center","font":{"size":22,"name":"Lato","bold":true}},{"font":{"size":22,"name":"Lato","bold":true}},{"textwrap":false,"align":"center","font":{"size":24,"name":"Microsoft YaHei","bold":true}},{"font":{"size":24,"name":"Microsoft YaHei","bold":true}}],"freezeLineColor":"rgb(185, 185, 185)","merges":["B2:F4","I2:J2","I3:J3","I4:J4","B8:F8","G8:I8","B9:F10","G9:I9","G10:I10","B11:B13","C11:G11","H11:I13","C12:G12","C13:G13"]}', NULL, NULL, '', NULL, '', NULL, 0, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report VALUES('983362412942663680', '20240603232403__8594', '采购单据', NULL, NULL, 'printinfo', '{"loopBlockList":[],"printConfig":{"paper":"A4","width":210,"height":297,"definition":5,"isBackend":false,"marginX":10,"marginY":10,"layout":"portrait","printCallBackUrl":"","paginationShow":false,"paginationLocation":"middle"},"hidden":{"rows":[],"cols":[]},"dbexps":[],"dicts":[],"freeze":"A1","dataRectWidth":660,"completeBlankRowList":[{"db":"detailReceipt","field":"product_code","rows":"8"}],"autofilter":{},"validations":[],"cols":{"0":{"width":25},"1":{"width":86},"2":{"width":193},"3":{"width":40},"4":{"width":40},"5":{"width":42},"6":{"width":63},"7":{"width":71},"len":50},"area":{"sri":7,"sci":1,"eri":7,"eci":5,"width":401,"height":25},"pyGroupEngine":false,"excel_config_id":"983362412942663680","hiddenCells":[],"zonedEditionList":[],"rows":{"0":{"cells":{"1":{"text":""},"2":{"text":""},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{"text":"No"},"8":{"text":""}}},"1":{"cells":{"1":{"merge":[2,4],"style":61,"height":75,"text":"东莞市铠思科技\\n采购单据"},"2":{"text":""},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{"text":"系统编号："},"8":{"rendered":"","config":"","text":"${headReceipt.systematic_receipt}","merge":[0,1],"height":25}}},"2":{"cells":{"1":{"text":""},"2":{"text":""},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{"text":"开单日期："},"8":{"text":"${headReceipt.invoice_date}","merge":[0,1],"height":25}}},"3":{"cells":{"1":{"text":""},"2":{"text":""},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{"text":"送货日期："},"8":{"text":"${headReceipt.invoice_date}","merge":[0,1],"height":25}}},"4":{"cells":{"1":{"text":"客户名称："},"2":{"text":"${headReceipt.customer_name}"},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{"text":""},"8":{"text":""}}},"5":{"cells":{"1":{"style":23,"text":"商品编号"},"2":{"style":23,"text":"名称/型号/规格"},"3":{"style":23,"text":"颜色"},"4":{"style":23,"text":"单位"},"5":{"style":23,"text":"数量"},"6":{"style":23,"text":"单价"},"7":{"style":23,"text":"金额"},"8":{"style":23,"text":"备注"}}},"6":{"cells":{"1":{"style":13,"text":"#{detailReceipt.product_code}","completeBlankStatus":true,"completeBlankRow":"8","aggregate":"","rendered":"","config":"","display":"normal"},"2":{"style":13,"text":"#{detailReceipt.product_name}","completeBlankStatus":false,"completeBlankRow":"8","rendered":"","config":""},"3":{"style":13,"text":"#{detailReceipt.product_specifications}"},"4":{"style":13,"text":"#{detailReceipt.measure_unit}","completeBlankStatus":false,"completeBlankRow":"8","rendered":"","config":""},"5":{"style":13,"text":"#{detailReceipt.plan_quantity}","completeBlankStatus":false,"completeBlankRow":"8"},"6":{"style":13,"text":"#{detailReceipt.discount}","completeBlankStatus":false,"completeBlankRow":"8"},"7":{"style":13,"text":"#{detailReceipt.money}","completeBlankStatus":false,"completeBlankRow":"8"},"8":{"funcname":"-1","rendered":"","subtotal":"-1","style":13,"text":"#{detailReceipt.remarks}","config":"","completeBlankStatus":false,"completeBlankRow":"8"}}},"7":{"cells":{"1":{"merge":[0,4],"style":13,"height":25,"text":"合计（大写）：${headReceipt.capitalize_total_amount}"},"2":{"text":""},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"rendered":"","merge":[0,2],"display":"number","style":13,"config":"","height":25,"text":"（小写）：￥${headReceipt.total_amount}"},"7":{"text":""},"8":{"text":""}}},"8":{"cells":{"1":{"merge":[1,4],"style":22,"height":50,"text":"备注：${headReceipt.receipt_notes}"},"2":{},"3":{},"4":{},"5":{},"6":{"merge":[0,2],"style":13,"height":25,"rendered":"","config":"","text":"已收定金：￥${headReceipt.deposit}"},"7":{"text":""},"8":{"text":""}}},"9":{"cells":{"1":{},"2":{},"3":{},"4":{},"5":{},"6":{"merge":[0,2],"style":13,"height":25,"rendered":"","config":"","text":"应收余款：￥=SUM(${headReceipt.total_amount}-${headReceipt.deposit})"},"7":{"text":""},"8":{"text":""}}},"10":{"cells":{"1":{"merge":[2,0],"style":34,"text":"顾客须知","height":75},"2":{"merge":[0,4],"style":13,"text":"1、禁止恶意损坏物品","height":25},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{"merge":[2,1],"style":41,"text":"顾客签名：","height":75},"8":{}}},"11":{"cells":{"1":{"text":""},"2":{"merge":[0,4],"style":42,"text":"2、商品验收后无质量问题不予退货","height":25},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{},"8":{}}},"12":{"cells":{"1":{"text":""},"2":{"merge":[0,4],"style":39,"text":"3、客户验收核对所购买产品无误","height":25},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{},"8":{}}},"14":{"cells":{"2":{"rendered":"","config":""},"3":{},"4":{},"7":{}}},"15":{"cells":{"2":{},"4":{}}},"16":{"cells":{"3":{"text":"","rendered":"","config":""}}},"len":88,"":{"cells":{"":{"text":"","completeBlankRow":"8"}}}},"rpbar":{"show":true,"pageSize":"","btnList":[]},"fixedPrintHeadRows":[],"fixedPrintTailRows":[],"displayConfig":{},"background":false,"name":"sheet1","styles":[{"align":"center"},{"align":"center","font":{"size":26}},{"font":{"size":26}},{"align":"center","font":{"size":42}},{"font":{"size":42}},{"border":{"top":["thin","#000"],"left":["thin","#000"]}},{"border":{"top":["thin","#000"]}},{"border":{"top":["thin","#000"],"right":["thin","#000"]}},{"border":{"left":["thin","#000"]}},{"border":{"right":["thin","#000"]}},{"border":{"left":["thin","#000"],"bottom":["thin","#000"]}},{"border":{"bottom":["thin","#000"]}},{"border":{"bottom":["thin","#000"],"right":["thin","#000"]}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"font":{"size":15}},{"font":{"size":15}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"font":{"size":18}},{"font":{"size":18}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"font":{"size":26}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"font":{"size":16}},{"font":{"size":16}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"align":"left"},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","align":"left"},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"align":"center"},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"middle","font":{"size":16}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","font":{"size":16}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":true,"font":{"size":16}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":false,"font":{"size":16}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":true,"font":{"size":18}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":true,"font":{"size":26}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":true,"font":{"size":24}},{"font":{"size":24}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":true,"font":{"size":22}},{"font":{"size":22}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":true,"align":"center","font":{"size":22}},{},{"border":{"right":["thin","#ffffff"]}},{"border":{"top":["thin","#ffffff"],"right":["thin","#ffffff"]}},{"border":{"top":["thin","#ffffff"],"bottom":["thin","#ffffff"],"right":["thin","#ffffff"]}},{"border":{"top":["thin","#ffffff"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]}},{"border":{"top":["thin","#ffffff"],"left":["thin","#ffffff"],"bottom":["thin","#ffffff"],"right":["thin","#ffffff"]},"valign":"top","align":"left"},{"border":{"top":["thin","#000100"],"left":["thin","#000100"],"bottom":["thin","#000100"],"right":["thin","#000100"]},"valign":"top","align":"left"},{"border":{"top":["thin","#000100"],"left":["thin","#000100"],"bottom":["thin","#000100"],"right":["thin","#000100"]}},{"textwrap":true,"align":"center","font":{"size":42}},{"textwrap":false,"align":"center","font":{"size":42}},{"textwrap":false,"align":"center","font":{"size":14}},{"font":{"size":14}},{"textwrap":false,"align":"center","font":{"size":18}},{"textwrap":false,"align":"center","font":{"size":22}},{"textwrap":false,"align":"center","font":{"size":22,"bold":true}},{"font":{"size":22,"bold":true}},{"textwrap":false,"align":"center","font":{"size":22,"bold":false}},{"font":{"size":22,"bold":false}},{"textwrap":false,"align":"center","font":{"size":22,"name":"Microsoft YaHei","bold":true}},{"font":{"size":22,"name":"Microsoft YaHei","bold":true}},{"textwrap":false,"align":"center","font":{"size":22,"name":"宋体","bold":true}},{"font":{"size":22,"name":"宋体","bold":true}},{"textwrap":false,"align":"center","font":{"size":22,"name":"Source Sans Pro","bold":true}},{"font":{"size":22,"name":"Source Sans Pro","bold":true}},{"textwrap":false,"align":"center","font":{"size":22,"name":"Lato","bold":true}},{"font":{"size":22,"name":"Lato","bold":true}},{"textwrap":false,"align":"center","font":{"size":24,"name":"Microsoft YaHei","bold":true}},{"font":{"size":24,"name":"Microsoft YaHei","bold":true}}],"freezeLineColor":"rgb(185, 185, 185)","merges":["B2:F4","I2:J2","I3:J3","I4:J4","B8:F8","G8:I8","B9:F10","G9:I9","G10:I10","B11:B13","C11:G11","H11:I13","C12:G12","C13:G13"]}', NULL, NULL, '', NULL, '', NULL, 0, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report VALUES('983363237521858560', '20240603232403__6357', '销售单据', NULL, NULL, 'printinfo', '{"loopBlockList":[],"printConfig":{"paper":"A4","width":210,"height":297,"definition":5,"isBackend":false,"marginX":10,"marginY":10,"layout":"portrait","printCallBackUrl":"","paginationShow":false,"paginationLocation":"middle"},"hidden":{"rows":[],"cols":[]},"dbexps":[],"dicts":[],"freeze":"A1","dataRectWidth":660,"completeBlankRowList":[{"db":"detailReceipt","field":"product_code","rows":"8"}],"autofilter":{},"validations":[],"cols":{"0":{"width":25},"1":{"width":86},"2":{"width":193},"3":{"width":40},"4":{"width":40},"5":{"width":42},"6":{"width":63},"7":{"width":71},"len":50},"area":{"sri":7,"sci":1,"eri":7,"eci":5,"width":401,"height":25},"pyGroupEngine":false,"excel_config_id":"983363237521858560","hiddenCells":[],"zonedEditionList":[],"rows":{"0":{"cells":{"1":{"text":""},"2":{"text":""},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{"text":"No"},"8":{"text":""}}},"1":{"cells":{"1":{"merge":[2,4],"style":61,"height":75,"text":"东莞市铠思科技\\n销售单据"},"2":{"text":""},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{"text":"系统编号："},"8":{"rendered":"","config":"","text":"${headReceipt.systematic_receipt}","merge":[0,1],"height":25}}},"2":{"cells":{"1":{"text":""},"2":{"text":""},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{"text":"开单日期："},"8":{"text":"${headReceipt.invoice_date}","merge":[0,1],"height":25}}},"3":{"cells":{"1":{"text":""},"2":{"text":""},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{"text":"送货日期："},"8":{"text":"${headReceipt.invoice_date}","merge":[0,1],"height":25}}},"4":{"cells":{"1":{"text":"客户名称："},"2":{"text":"${headReceipt.customer_name}"},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{"text":""},"8":{"text":""}}},"5":{"cells":{"1":{"style":23,"text":"商品编号"},"2":{"style":23,"text":"名称/型号/规格"},"3":{"style":23,"text":"颜色"},"4":{"style":23,"text":"单位"},"5":{"style":23,"text":"数量"},"6":{"style":23,"text":"单价"},"7":{"style":23,"text":"金额"},"8":{"style":23,"text":"备注"}}},"6":{"cells":{"1":{"style":13,"text":"#{detailReceipt.product_code}","completeBlankStatus":true,"completeBlankRow":"8","aggregate":"","rendered":"","config":"","display":"normal"},"2":{"style":13,"text":"#{detailReceipt.product_name}","completeBlankStatus":false,"completeBlankRow":"8","rendered":"","config":""},"3":{"style":13,"text":"#{detailReceipt.product_specifications}"},"4":{"style":13,"text":"#{detailReceipt.measure_unit}","completeBlankStatus":false,"completeBlankRow":"8","rendered":"","config":""},"5":{"style":13,"text":"#{detailReceipt.plan_quantity}","completeBlankStatus":false,"completeBlankRow":"8"},"6":{"style":13,"text":"#{detailReceipt.discount}","completeBlankStatus":false,"completeBlankRow":"8"},"7":{"style":13,"text":"#{detailReceipt.money}","completeBlankStatus":false,"completeBlankRow":"8"},"8":{"funcname":"-1","rendered":"","subtotal":"-1","style":13,"text":"#{detailReceipt.remarks}","config":"","completeBlankStatus":false,"completeBlankRow":"8"}}},"7":{"cells":{"1":{"merge":[0,4],"style":13,"height":25,"text":"合计（大写）：${headReceipt.capitalize_total_amount}"},"2":{"text":""},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"rendered":"","merge":[0,2],"display":"number","style":13,"config":"","height":25,"text":"（小写）：￥${headReceipt.total_amount}"},"7":{"text":""},"8":{"text":""}}},"8":{"cells":{"1":{"merge":[1,4],"style":22,"height":50,"text":"备注：${headReceipt.receipt_notes}"},"2":{},"3":{},"4":{},"5":{},"6":{"merge":[0,2],"style":13,"height":25,"rendered":"","config":"","text":"已收定金：￥${headReceipt.deposit}"},"7":{"text":""},"8":{"text":""}}},"9":{"cells":{"1":{},"2":{},"3":{},"4":{},"5":{},"6":{"merge":[0,2],"style":13,"height":25,"rendered":"","config":"","text":"应收余款：￥=SUM(${headReceipt.total_amount}-${headReceipt.deposit})"},"7":{"text":""},"8":{"text":""}}},"10":{"cells":{"1":{"merge":[2,0],"style":34,"text":"顾客须知","height":75},"2":{"merge":[0,4],"style":13,"text":"1、禁止恶意损坏物品","height":25},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{"merge":[2,1],"style":41,"text":"顾客签名：","height":75},"8":{}}},"11":{"cells":{"1":{"text":""},"2":{"merge":[0,4],"style":42,"text":"2、商品验收后无质量问题不予退货","height":25},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{},"8":{}}},"12":{"cells":{"1":{"text":""},"2":{"merge":[0,4],"style":39,"text":"3、客户验收核对所购买产品无误","height":25},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{},"8":{}}},"14":{"cells":{"2":{"rendered":"","config":""},"3":{},"4":{},"7":{}}},"15":{"cells":{"2":{},"4":{}}},"16":{"cells":{"3":{"text":"","rendered":"","config":""}}},"len":88,"":{"cells":{"":{"text":"","completeBlankRow":"8"}}}},"rpbar":{"show":true,"pageSize":"","btnList":[]},"fixedPrintHeadRows":[],"fixedPrintTailRows":[],"displayConfig":{},"background":false,"name":"sheet1","styles":[{"align":"center"},{"align":"center","font":{"size":26}},{"font":{"size":26}},{"align":"center","font":{"size":42}},{"font":{"size":42}},{"border":{"top":["thin","#000"],"left":["thin","#000"]}},{"border":{"top":["thin","#000"]}},{"border":{"top":["thin","#000"],"right":["thin","#000"]}},{"border":{"left":["thin","#000"]}},{"border":{"right":["thin","#000"]}},{"border":{"left":["thin","#000"],"bottom":["thin","#000"]}},{"border":{"bottom":["thin","#000"]}},{"border":{"bottom":["thin","#000"],"right":["thin","#000"]}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"font":{"size":15}},{"font":{"size":15}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"font":{"size":18}},{"font":{"size":18}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"font":{"size":26}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"font":{"size":16}},{"font":{"size":16}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"align":"left"},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","align":"left"},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"align":"center"},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"middle","font":{"size":16}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","font":{"size":16}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":true,"font":{"size":16}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":false,"font":{"size":16}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":true,"font":{"size":18}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":true,"font":{"size":26}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":true,"font":{"size":24}},{"font":{"size":24}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":true,"font":{"size":22}},{"font":{"size":22}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":true,"align":"center","font":{"size":22}},{},{"border":{"right":["thin","#ffffff"]}},{"border":{"top":["thin","#ffffff"],"right":["thin","#ffffff"]}},{"border":{"top":["thin","#ffffff"],"bottom":["thin","#ffffff"],"right":["thin","#ffffff"]}},{"border":{"top":["thin","#ffffff"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]}},{"border":{"top":["thin","#ffffff"],"left":["thin","#ffffff"],"bottom":["thin","#ffffff"],"right":["thin","#ffffff"]},"valign":"top","align":"left"},{"border":{"top":["thin","#000100"],"left":["thin","#000100"],"bottom":["thin","#000100"],"right":["thin","#000100"]},"valign":"top","align":"left"},{"border":{"top":["thin","#000100"],"left":["thin","#000100"],"bottom":["thin","#000100"],"right":["thin","#000100"]}},{"textwrap":true,"align":"center","font":{"size":42}},{"textwrap":false,"align":"center","font":{"size":42}},{"textwrap":false,"align":"center","font":{"size":14}},{"font":{"size":14}},{"textwrap":false,"align":"center","font":{"size":18}},{"textwrap":false,"align":"center","font":{"size":22}},{"textwrap":false,"align":"center","font":{"size":22,"bold":true}},{"font":{"size":22,"bold":true}},{"textwrap":false,"align":"center","font":{"size":22,"bold":false}},{"font":{"size":22,"bold":false}},{"textwrap":false,"align":"center","font":{"size":22,"name":"Microsoft YaHei","bold":true}},{"font":{"size":22,"name":"Microsoft YaHei","bold":true}},{"textwrap":false,"align":"center","font":{"size":22,"name":"宋体","bold":true}},{"font":{"size":22,"name":"宋体","bold":true}},{"textwrap":false,"align":"center","font":{"size":22,"name":"Source Sans Pro","bold":true}},{"font":{"size":22,"name":"Source Sans Pro","bold":true}},{"textwrap":false,"align":"center","font":{"size":22,"name":"Lato","bold":true}},{"font":{"size":22,"name":"Lato","bold":true}},{"textwrap":false,"align":"center","font":{"size":24,"name":"Microsoft YaHei","bold":true}},{"font":{"size":24,"name":"Microsoft YaHei","bold":true}}],"freezeLineColor":"rgb(185, 185, 185)","merges":["B2:F4","I2:J2","I3:J3","I4:J4","B8:F8","G8:I8","B9:F10","G9:I9","G10:I10","B11:B13","C11:G11","H11:I13","C12:G12","C13:G13"]}', NULL, NULL, '', NULL, '', NULL, 0, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report VALUES('983363617982980096', '20240603232403__1123', '库存单据', NULL, NULL, 'printinfo', '{"loopBlockList":[],"printConfig":{"paper":"A4","width":210,"height":297,"definition":5,"isBackend":false,"marginX":10,"marginY":10,"layout":"portrait","printCallBackUrl":"","paginationShow":false,"paginationLocation":"middle"},"hidden":{"rows":[],"cols":[]},"dbexps":[],"dicts":[],"freeze":"A1","dataRectWidth":660,"completeBlankRowList":[{"db":"detailReceipt","field":"product_code","rows":"8"}],"autofilter":{},"validations":[],"cols":{"0":{"width":25},"1":{"width":86},"2":{"width":193},"3":{"width":40},"4":{"width":40},"5":{"width":42},"6":{"width":63},"7":{"width":71},"len":50},"area":{"sri":7,"sci":1,"eri":7,"eci":5,"width":401,"height":25},"pyGroupEngine":false,"excel_config_id":"983363617982980096","hiddenCells":[],"zonedEditionList":[],"rows":{"0":{"cells":{"1":{"text":""},"2":{"text":""},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{"text":"No"},"8":{"text":""}}},"1":{"cells":{"1":{"merge":[2,4],"style":61,"height":75,"text":"东莞市铠思科技\\n库存单据"},"2":{"text":""},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{"text":"系统编号："},"8":{"rendered":"","config":"","text":"${headReceipt.systematic_receipt}","merge":[0,1],"height":25}}},"2":{"cells":{"1":{"text":""},"2":{"text":""},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{"text":"开单日期："},"8":{"text":"${headReceipt.invoice_date}","merge":[0,1],"height":25}}},"3":{"cells":{"1":{"text":""},"2":{"text":""},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{"text":"送货日期："},"8":{"text":"${headReceipt.invoice_date}","merge":[0,1],"height":25}}},"4":{"cells":{"1":{"text":"客户名称："},"2":{"text":"${headReceipt.customer_name}"},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{"text":""},"8":{"text":""}}},"5":{"cells":{"1":{"style":23,"text":"商品编号"},"2":{"style":23,"text":"名称/型号/规格"},"3":{"style":23,"text":"颜色"},"4":{"style":23,"text":"单位"},"5":{"style":23,"text":"数量"},"6":{"style":23,"text":"单价"},"7":{"style":23,"text":"金额"},"8":{"style":23,"text":"备注"}}},"6":{"cells":{"1":{"style":13,"text":"#{detailReceipt.product_code}","completeBlankStatus":true,"completeBlankRow":"8","aggregate":"","rendered":"","config":"","display":"normal"},"2":{"style":13,"text":"#{detailReceipt.product_name}","completeBlankStatus":false,"completeBlankRow":"8","rendered":"","config":""},"3":{"style":13,"text":"#{detailReceipt.product_specifications}"},"4":{"style":13,"text":"#{detailReceipt.measure_unit}","completeBlankStatus":false,"completeBlankRow":"8","rendered":"","config":""},"5":{"style":13,"text":"#{detailReceipt.plan_quantity}","completeBlankStatus":false,"completeBlankRow":"8"},"6":{"style":13,"text":"#{detailReceipt.discount}","completeBlankStatus":false,"completeBlankRow":"8"},"7":{"style":13,"text":"#{detailReceipt.money}","completeBlankStatus":false,"completeBlankRow":"8"},"8":{"funcname":"-1","rendered":"","subtotal":"-1","style":13,"text":"#{detailReceipt.remarks}","config":"","completeBlankStatus":false,"completeBlankRow":"8"}}},"7":{"cells":{"1":{"merge":[0,4],"style":13,"height":25,"text":"合计（大写）：${headReceipt.capitalize_total_amount}"},"2":{"text":""},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"rendered":"","merge":[0,2],"display":"number","style":13,"config":"","height":25,"text":"（小写）：￥${headReceipt.total_amount}"},"7":{"text":""},"8":{"text":""}}},"8":{"cells":{"1":{"merge":[1,4],"style":22,"height":50,"text":"备注：${headReceipt.receipt_notes}"},"2":{},"3":{},"4":{},"5":{},"6":{"merge":[0,2],"style":13,"height":25,"rendered":"","config":"","text":"已收定金：￥${headReceipt.deposit}"},"7":{"text":""},"8":{"text":""}}},"9":{"cells":{"1":{},"2":{},"3":{},"4":{},"5":{},"6":{"merge":[0,2],"style":13,"height":25,"rendered":"","config":"","text":"应收余款：￥=SUM(${headReceipt.total_amount}-${headReceipt.deposit})"},"7":{"text":""},"8":{"text":""}}},"10":{"cells":{"1":{"merge":[2,0],"style":34,"text":"顾客须知","height":75},"2":{"merge":[0,4],"style":13,"text":"1、禁止恶意损坏物品","height":25},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{"merge":[2,1],"style":41,"text":"顾客签名：","height":75},"8":{}}},"11":{"cells":{"1":{"text":""},"2":{"merge":[0,4],"style":42,"text":"2、商品验收后无质量问题不予退货","height":25},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{},"8":{}}},"12":{"cells":{"1":{"text":""},"2":{"merge":[0,4],"style":39,"text":"3、客户验收核对所购买产品无误","height":25},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{},"8":{}}},"14":{"cells":{"2":{"rendered":"","config":""},"3":{},"4":{},"7":{}}},"15":{"cells":{"2":{},"4":{}}},"16":{"cells":{"3":{"text":"","rendered":"","config":""}}},"len":88,"":{"cells":{"":{"text":"","completeBlankRow":"8"}}}},"rpbar":{"show":true,"pageSize":"","btnList":[]},"fixedPrintHeadRows":[],"fixedPrintTailRows":[],"displayConfig":{},"background":false,"name":"sheet1","styles":[{"align":"center"},{"align":"center","font":{"size":26}},{"font":{"size":26}},{"align":"center","font":{"size":42}},{"font":{"size":42}},{"border":{"top":["thin","#000"],"left":["thin","#000"]}},{"border":{"top":["thin","#000"]}},{"border":{"top":["thin","#000"],"right":["thin","#000"]}},{"border":{"left":["thin","#000"]}},{"border":{"right":["thin","#000"]}},{"border":{"left":["thin","#000"],"bottom":["thin","#000"]}},{"border":{"bottom":["thin","#000"]}},{"border":{"bottom":["thin","#000"],"right":["thin","#000"]}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"font":{"size":15}},{"font":{"size":15}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"font":{"size":18}},{"font":{"size":18}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"font":{"size":26}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"font":{"size":16}},{"font":{"size":16}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"align":"left"},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","align":"left"},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"align":"center"},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"middle","font":{"size":16}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","font":{"size":16}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":true,"font":{"size":16}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":false,"font":{"size":16}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":true,"font":{"size":18}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":true,"font":{"size":26}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":true,"font":{"size":24}},{"font":{"size":24}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":true,"font":{"size":22}},{"font":{"size":22}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":true,"align":"center","font":{"size":22}},{},{"border":{"right":["thin","#ffffff"]}},{"border":{"top":["thin","#ffffff"],"right":["thin","#ffffff"]}},{"border":{"top":["thin","#ffffff"],"bottom":["thin","#ffffff"],"right":["thin","#ffffff"]}},{"border":{"top":["thin","#ffffff"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]}},{"border":{"top":["thin","#ffffff"],"left":["thin","#ffffff"],"bottom":["thin","#ffffff"],"right":["thin","#ffffff"]},"valign":"top","align":"left"},{"border":{"top":["thin","#000100"],"left":["thin","#000100"],"bottom":["thin","#000100"],"right":["thin","#000100"]},"valign":"top","align":"left"},{"border":{"top":["thin","#000100"],"left":["thin","#000100"],"bottom":["thin","#000100"],"right":["thin","#000100"]}},{"textwrap":true,"align":"center","font":{"size":42}},{"textwrap":false,"align":"center","font":{"size":42}},{"textwrap":false,"align":"center","font":{"size":14}},{"font":{"size":14}},{"textwrap":false,"align":"center","font":{"size":18}},{"textwrap":false,"align":"center","font":{"size":22}},{"textwrap":false,"align":"center","font":{"size":22,"bold":true}},{"font":{"size":22,"bold":true}},{"textwrap":false,"align":"center","font":{"size":22,"bold":false}},{"font":{"size":22,"bold":false}},{"textwrap":false,"align":"center","font":{"size":22,"name":"Microsoft YaHei","bold":true}},{"font":{"size":22,"name":"Microsoft YaHei","bold":true}},{"textwrap":false,"align":"center","font":{"size":22,"name":"宋体","bold":true}},{"font":{"size":22,"name":"宋体","bold":true}},{"textwrap":false,"align":"center","font":{"size":22,"name":"Source Sans Pro","bold":true}},{"font":{"size":22,"name":"Source Sans Pro","bold":true}},{"textwrap":false,"align":"center","font":{"size":22,"name":"Lato","bold":true}},{"font":{"size":22,"name":"Lato","bold":true}},{"textwrap":false,"align":"center","font":{"size":24,"name":"Microsoft YaHei","bold":true}},{"font":{"size":24,"name":"Microsoft YaHei","bold":true}}],"freezeLineColor":"rgb(185, 185, 185)","merges":["B2:F4","I2:J2","I3:J3","I4:J4","B8:F8","G8:I8","B9:F10","G9:I9","G10:I10","B11:B13","C11:G11","H11:I13","C12:G12","C13:G13"]}', NULL, NULL, '', NULL, '', NULL, 0, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report VALUES('983363836531384320', '20240603232403__4057', '调拨单据', NULL, NULL, 'printinfo', '{"loopBlockList":[],"printConfig":{"paper":"A4","width":210,"height":297,"definition":5,"isBackend":false,"marginX":10,"marginY":10,"layout":"portrait","printCallBackUrl":"","paginationShow":false,"paginationLocation":"middle"},"hidden":{"rows":[],"cols":[]},"dbexps":[],"dicts":[],"freeze":"A1","dataRectWidth":660,"completeBlankRowList":[{"db":"detailReceipt","field":"product_code","rows":"8"}],"autofilter":{},"validations":[],"cols":{"0":{"width":25},"1":{"width":86},"2":{"width":193},"3":{"width":40},"4":{"width":40},"5":{"width":42},"6":{"width":63},"7":{"width":71},"len":50},"area":{"sri":1,"sci":1,"eri":3,"eci":5,"width":401,"height":75},"pyGroupEngine":false,"excel_config_id":"983363836531384320","hiddenCells":[],"zonedEditionList":[],"rows":{"0":{"cells":{"1":{"text":""},"2":{"text":""},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{"text":"No"},"8":{"text":""}}},"1":{"cells":{"1":{"merge":[2,4],"style":61,"height":75,"text":"东莞市铠思科技\\n调拨单据"},"2":{"text":""},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{"text":"系统编号："},"8":{"rendered":"","config":"","text":"${headReceipt.systematic_receipt}","merge":[0,1],"height":25}}},"2":{"cells":{"1":{"text":""},"2":{"text":""},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{"text":"开单日期："},"8":{"text":"${headReceipt.invoice_date}","merge":[0,1],"height":25}}},"3":{"cells":{"1":{"text":""},"2":{"text":""},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{"text":"送货日期："},"8":{"text":"${headReceipt.invoice_date}","merge":[0,1],"height":25}}},"4":{"cells":{"1":{"text":"客户名称："},"2":{"text":"${headReceipt.customer_name}"},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{"text":""},"8":{"text":""}}},"5":{"cells":{"1":{"style":23,"text":"商品编号"},"2":{"style":23,"text":"名称/型号/规格"},"3":{"style":23,"text":"颜色"},"4":{"style":23,"text":"单位"},"5":{"style":23,"text":"数量"},"6":{"style":23,"text":"单价"},"7":{"style":23,"text":"金额"},"8":{"style":23,"text":"备注"}}},"6":{"cells":{"1":{"style":13,"text":"#{detailReceipt.product_code}","completeBlankStatus":true,"completeBlankRow":"8","aggregate":"","rendered":"","config":"","display":"normal"},"2":{"style":13,"text":"#{detailReceipt.product_name}","completeBlankStatus":false,"completeBlankRow":"8","rendered":"","config":""},"3":{"style":13,"text":"#{detailReceipt.product_specifications}"},"4":{"style":13,"text":"#{detailReceipt.measure_unit}","completeBlankStatus":false,"completeBlankRow":"8","rendered":"","config":""},"5":{"style":13,"text":"#{detailReceipt.plan_quantity}","completeBlankStatus":false,"completeBlankRow":"8"},"6":{"style":13,"text":"#{detailReceipt.discount}","completeBlankStatus":false,"completeBlankRow":"8"},"7":{"style":13,"text":"#{detailReceipt.money}","completeBlankStatus":false,"completeBlankRow":"8"},"8":{"funcname":"-1","rendered":"","subtotal":"-1","style":13,"text":"#{detailReceipt.remarks}","config":"","completeBlankStatus":false,"completeBlankRow":"8"}}},"7":{"cells":{"1":{"merge":[0,4],"style":13,"height":25,"text":"合计（大写）：${headReceipt.capitalize_total_amount}"},"2":{"text":""},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"rendered":"","merge":[0,2],"display":"number","style":13,"config":"","height":25,"text":"（小写）：￥${headReceipt.total_amount}"},"7":{"text":""},"8":{"text":""}}},"8":{"cells":{"1":{"merge":[1,4],"style":22,"height":50,"text":"备注：${headReceipt.receipt_notes}"},"2":{},"3":{},"4":{},"5":{},"6":{"merge":[0,2],"style":13,"height":25,"rendered":"","config":"","text":"已收定金：￥${headReceipt.deposit}"},"7":{"text":""},"8":{"text":""}}},"9":{"cells":{"1":{},"2":{},"3":{},"4":{},"5":{},"6":{"merge":[0,2],"style":13,"height":25,"rendered":"","config":"","text":"应收余款：￥=SUM(${headReceipt.total_amount}-${headReceipt.deposit})"},"7":{"text":""},"8":{"text":""}}},"10":{"cells":{"1":{"merge":[2,0],"style":34,"text":"顾客须知","height":75},"2":{"merge":[0,4],"style":13,"text":"1、禁止恶意损坏物品","height":25},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{"merge":[2,1],"style":41,"text":"顾客签名：","height":75},"8":{}}},"11":{"cells":{"1":{"text":""},"2":{"merge":[0,4],"style":42,"text":"2、商品验收后无质量问题不予退货","height":25},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{},"8":{}}},"12":{"cells":{"1":{"text":""},"2":{"merge":[0,4],"style":39,"text":"3、客户验收核对所购买产品无误","height":25},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{},"8":{}}},"14":{"cells":{"2":{"rendered":"","config":""},"3":{},"4":{},"7":{}}},"15":{"cells":{"2":{},"4":{}}},"16":{"cells":{"3":{"text":"","rendered":"","config":""}}},"len":88,"":{"cells":{"":{"text":"","completeBlankRow":"8"}}}},"rpbar":{"show":true,"pageSize":"","btnList":[]},"fixedPrintHeadRows":[],"fixedPrintTailRows":[],"displayConfig":{},"background":false,"name":"sheet1","styles":[{"align":"center"},{"align":"center","font":{"size":26}},{"font":{"size":26}},{"align":"center","font":{"size":42}},{"font":{"size":42}},{"border":{"top":["thin","#000"],"left":["thin","#000"]}},{"border":{"top":["thin","#000"]}},{"border":{"top":["thin","#000"],"right":["thin","#000"]}},{"border":{"left":["thin","#000"]}},{"border":{"right":["thin","#000"]}},{"border":{"left":["thin","#000"],"bottom":["thin","#000"]}},{"border":{"bottom":["thin","#000"]}},{"border":{"bottom":["thin","#000"],"right":["thin","#000"]}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"font":{"size":15}},{"font":{"size":15}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"font":{"size":18}},{"font":{"size":18}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"font":{"size":26}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"font":{"size":16}},{"font":{"size":16}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"align":"left"},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","align":"left"},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"align":"center"},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"middle","font":{"size":16}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","font":{"size":16}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":true,"font":{"size":16}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":false,"font":{"size":16}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":true,"font":{"size":18}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":true,"font":{"size":26}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":true,"font":{"size":24}},{"font":{"size":24}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":true,"font":{"size":22}},{"font":{"size":22}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":true,"align":"center","font":{"size":22}},{},{"border":{"right":["thin","#ffffff"]}},{"border":{"top":["thin","#ffffff"],"right":["thin","#ffffff"]}},{"border":{"top":["thin","#ffffff"],"bottom":["thin","#ffffff"],"right":["thin","#ffffff"]}},{"border":{"top":["thin","#ffffff"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]}},{"border":{"top":["thin","#ffffff"],"left":["thin","#ffffff"],"bottom":["thin","#ffffff"],"right":["thin","#ffffff"]},"valign":"top","align":"left"},{"border":{"top":["thin","#000100"],"left":["thin","#000100"],"bottom":["thin","#000100"],"right":["thin","#000100"]},"valign":"top","align":"left"},{"border":{"top":["thin","#000100"],"left":["thin","#000100"],"bottom":["thin","#000100"],"right":["thin","#000100"]}},{"textwrap":true,"align":"center","font":{"size":42}},{"textwrap":false,"align":"center","font":{"size":42}},{"textwrap":false,"align":"center","font":{"size":14}},{"font":{"size":14}},{"textwrap":false,"align":"center","font":{"size":18}},{"textwrap":false,"align":"center","font":{"size":22}},{"textwrap":false,"align":"center","font":{"size":22,"bold":true}},{"font":{"size":22,"bold":true}},{"textwrap":false,"align":"center","font":{"size":22,"bold":false}},{"font":{"size":22,"bold":false}},{"textwrap":false,"align":"center","font":{"size":22,"name":"Microsoft YaHei","bold":true}},{"font":{"size":22,"name":"Microsoft YaHei","bold":true}},{"textwrap":false,"align":"center","font":{"size":22,"name":"宋体","bold":true}},{"font":{"size":22,"name":"宋体","bold":true}},{"textwrap":false,"align":"center","font":{"size":22,"name":"Source Sans Pro","bold":true}},{"font":{"size":22,"name":"Source Sans Pro","bold":true}},{"textwrap":false,"align":"center","font":{"size":22,"name":"Lato","bold":true}},{"font":{"size":22,"name":"Lato","bold":true}},{"textwrap":false,"align":"center","font":{"size":24,"name":"Microsoft YaHei","bold":true}},{"font":{"size":24,"name":"Microsoft YaHei","bold":true}}],"freezeLineColor":"rgb(185, 185, 185)","merges":["B2:F4","I2:J2","I3:J3","I4:J4","B8:F8","G8:I8","B9:F10","G9:I9","G10:I10","B11:B13","C11:G11","H11:I13","C12:G12","C13:G13"]}', NULL, NULL, '', NULL, '', NULL, 0, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report VALUES('983363988151279616', '20240603232403__5217', '盘点单据', NULL, NULL, 'printinfo', '{"loopBlockList":[],"printConfig":{"paper":"A4","width":210,"height":297,"definition":5,"isBackend":false,"marginX":10,"marginY":10,"layout":"portrait","printCallBackUrl":"","paginationShow":false,"paginationLocation":"middle"},"hidden":{"rows":[],"cols":[]},"dbexps":[],"dicts":[],"freeze":"A1","dataRectWidth":660,"completeBlankRowList":[{"db":"detailReceipt","field":"product_code","rows":"8"}],"autofilter":{},"validations":[],"cols":{"0":{"width":25},"1":{"width":86},"2":{"width":193},"3":{"width":40},"4":{"width":40},"5":{"width":42},"6":{"width":63},"7":{"width":71},"len":50},"area":{"sri":1,"sci":1,"eri":3,"eci":5,"width":401,"height":75},"pyGroupEngine":false,"excel_config_id":"983363988151279616","hiddenCells":[],"zonedEditionList":[],"rows":{"0":{"cells":{"1":{"text":""},"2":{"text":""},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{"text":"No"},"8":{"text":""}}},"1":{"cells":{"1":{"merge":[2,4],"style":61,"height":75,"text":"东莞市铠思科技\\n盘点单据"},"2":{"text":""},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{"text":"系统编号："},"8":{"rendered":"","config":"","text":"${headReceipt.systematic_receipt}","merge":[0,1],"height":25}}},"2":{"cells":{"1":{"text":""},"2":{"text":""},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{"text":"开单日期："},"8":{"text":"${headReceipt.invoice_date}","merge":[0,1],"height":25}}},"3":{"cells":{"1":{"text":""},"2":{"text":""},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{"text":"送货日期："},"8":{"text":"${headReceipt.invoice_date}","merge":[0,1],"height":25}}},"4":{"cells":{"1":{"text":"客户名称："},"2":{"text":"${headReceipt.customer_name}"},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{"text":""},"8":{"text":""}}},"5":{"cells":{"1":{"style":23,"text":"商品编号"},"2":{"style":23,"text":"名称/型号/规格"},"3":{"style":23,"text":"颜色"},"4":{"style":23,"text":"单位"},"5":{"style":23,"text":"数量"},"6":{"style":23,"text":"单价"},"7":{"style":23,"text":"金额"},"8":{"style":23,"text":"备注"}}},"6":{"cells":{"1":{"style":13,"text":"#{detailReceipt.product_code}","completeBlankStatus":true,"completeBlankRow":"8","aggregate":"","rendered":"","config":"","display":"normal"},"2":{"style":13,"text":"#{detailReceipt.product_name}","completeBlankStatus":false,"completeBlankRow":"8","rendered":"","config":""},"3":{"style":13,"text":"#{detailReceipt.product_specifications}"},"4":{"style":13,"text":"#{detailReceipt.measure_unit}","completeBlankStatus":false,"completeBlankRow":"8","rendered":"","config":""},"5":{"style":13,"text":"#{detailReceipt.plan_quantity}","completeBlankStatus":false,"completeBlankRow":"8"},"6":{"style":13,"text":"#{detailReceipt.discount}","completeBlankStatus":false,"completeBlankRow":"8"},"7":{"style":13,"text":"#{detailReceipt.money}","completeBlankStatus":false,"completeBlankRow":"8"},"8":{"funcname":"-1","rendered":"","subtotal":"-1","style":13,"text":"#{detailReceipt.remarks}","config":"","completeBlankStatus":false,"completeBlankRow":"8"}}},"7":{"cells":{"1":{"merge":[0,4],"style":13,"height":25,"text":"合计（大写）：${headReceipt.capitalize_total_amount}"},"2":{"text":""},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"rendered":"","merge":[0,2],"display":"number","style":13,"config":"","height":25,"text":"（小写）：￥${headReceipt.total_amount}"},"7":{"text":""},"8":{"text":""}}},"8":{"cells":{"1":{"merge":[1,4],"style":22,"height":50,"text":"备注：${headReceipt.receipt_notes}"},"2":{},"3":{},"4":{},"5":{},"6":{"merge":[0,2],"style":13,"height":25,"rendered":"","config":"","text":"已收定金：￥${headReceipt.deposit}"},"7":{"text":""},"8":{"text":""}}},"9":{"cells":{"1":{},"2":{},"3":{},"4":{},"5":{},"6":{"merge":[0,2],"style":13,"height":25,"rendered":"","config":"","text":"应收余款：￥=SUM(${headReceipt.total_amount}-${headReceipt.deposit})"},"7":{"text":""},"8":{"text":""}}},"10":{"cells":{"1":{"merge":[2,0],"style":34,"text":"顾客须知","height":75},"2":{"merge":[0,4],"style":13,"text":"1、禁止恶意损坏物品","height":25},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{"merge":[2,1],"style":41,"text":"顾客签名：","height":75},"8":{}}},"11":{"cells":{"1":{"text":""},"2":{"merge":[0,4],"style":42,"text":"2、商品验收后无质量问题不予退货","height":25},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{},"8":{}}},"12":{"cells":{"1":{"text":""},"2":{"merge":[0,4],"style":39,"text":"3、客户验收核对所购买产品无误","height":25},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{},"8":{}}},"14":{"cells":{"2":{"rendered":"","config":""},"3":{},"4":{},"7":{}}},"15":{"cells":{"2":{},"4":{}}},"16":{"cells":{"3":{"text":"","rendered":"","config":""}}},"len":88,"":{"cells":{"":{"text":"","completeBlankRow":"8"}}}},"rpbar":{"show":true,"pageSize":"","btnList":[]},"fixedPrintHeadRows":[],"fixedPrintTailRows":[],"displayConfig":{},"background":false,"name":"sheet1","styles":[{"align":"center"},{"align":"center","font":{"size":26}},{"font":{"size":26}},{"align":"center","font":{"size":42}},{"font":{"size":42}},{"border":{"top":["thin","#000"],"left":["thin","#000"]}},{"border":{"top":["thin","#000"]}},{"border":{"top":["thin","#000"],"right":["thin","#000"]}},{"border":{"left":["thin","#000"]}},{"border":{"right":["thin","#000"]}},{"border":{"left":["thin","#000"],"bottom":["thin","#000"]}},{"border":{"bottom":["thin","#000"]}},{"border":{"bottom":["thin","#000"],"right":["thin","#000"]}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"font":{"size":15}},{"font":{"size":15}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"font":{"size":18}},{"font":{"size":18}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"font":{"size":26}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"font":{"size":16}},{"font":{"size":16}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"align":"left"},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","align":"left"},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"align":"center"},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"middle","font":{"size":16}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","font":{"size":16}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":true,"font":{"size":16}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":false,"font":{"size":16}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":true,"font":{"size":18}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":true,"font":{"size":26}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":true,"font":{"size":24}},{"font":{"size":24}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":true,"font":{"size":22}},{"font":{"size":22}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":true,"align":"center","font":{"size":22}},{},{"border":{"right":["thin","#ffffff"]}},{"border":{"top":["thin","#ffffff"],"right":["thin","#ffffff"]}},{"border":{"top":["thin","#ffffff"],"bottom":["thin","#ffffff"],"right":["thin","#ffffff"]}},{"border":{"top":["thin","#ffffff"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]}},{"border":{"top":["thin","#ffffff"],"left":["thin","#ffffff"],"bottom":["thin","#ffffff"],"right":["thin","#ffffff"]},"valign":"top","align":"left"},{"border":{"top":["thin","#000100"],"left":["thin","#000100"],"bottom":["thin","#000100"],"right":["thin","#000100"]},"valign":"top","align":"left"},{"border":{"top":["thin","#000100"],"left":["thin","#000100"],"bottom":["thin","#000100"],"right":["thin","#000100"]}},{"textwrap":true,"align":"center","font":{"size":42}},{"textwrap":false,"align":"center","font":{"size":42}},{"textwrap":false,"align":"center","font":{"size":14}},{"font":{"size":14}},{"textwrap":false,"align":"center","font":{"size":18}},{"textwrap":false,"align":"center","font":{"size":22}},{"textwrap":false,"align":"center","font":{"size":22,"bold":true}},{"font":{"size":22,"bold":true}},{"textwrap":false,"align":"center","font":{"size":22,"bold":false}},{"font":{"size":22,"bold":false}},{"textwrap":false,"align":"center","font":{"size":22,"name":"Microsoft YaHei","bold":true}},{"font":{"size":22,"name":"Microsoft YaHei","bold":true}},{"textwrap":false,"align":"center","font":{"size":22,"name":"宋体","bold":true}},{"font":{"size":22,"name":"宋体","bold":true}},{"textwrap":false,"align":"center","font":{"size":22,"name":"Source Sans Pro","bold":true}},{"font":{"size":22,"name":"Source Sans Pro","bold":true}},{"textwrap":false,"align":"center","font":{"size":22,"name":"Lato","bold":true}},{"font":{"size":22,"name":"Lato","bold":true}},{"textwrap":false,"align":"center","font":{"size":24,"name":"Microsoft YaHei","bold":true}},{"font":{"size":24,"name":"Microsoft YaHei","bold":true}}],"freezeLineColor":"rgb(185, 185, 185)","merges":["B2:F4","I2:J2","I3:J3","I4:J4","B8:F8","G8:I8","B9:F10","G9:I9","G10:I10","B11:B13","C11:G11","H11:I13","C12:G12","C13:G13"]}', NULL, NULL, '', NULL, '', NULL, 0, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report VALUES('983365946211770368', '20240603232403__2083', '家装工程单据', NULL, NULL, 'printinfo', '{"loopBlockList":[],"printConfig":{"paper":"A4","width":210,"height":297,"definition":5,"isBackend":false,"marginX":10,"marginY":10,"layout":"portrait","printCallBackUrl":"","paginationShow":false,"paginationLocation":"middle"},"hidden":{"rows":[],"cols":[]},"dbexps":[],"dicts":[],"freeze":"A1","dataRectWidth":660,"completeBlankRowList":[{"db":"detailEngineering","field":"product_code","rows":"8"}],"autofilter":{},"validations":[],"cols":{"0":{"width":25},"1":{"width":86},"2":{"width":193},"3":{"width":40},"4":{"width":40},"5":{"width":42},"6":{"width":63},"7":{"width":71},"len":50},"area":{"sri":14,"sci":7,"eri":14,"eci":7,"width":71,"height":25},"pyGroupEngine":false,"excel_config_id":"983365946211770368","hiddenCells":[],"zonedEditionList":[],"rows":{"0":{"cells":{"1":{"text":""},"2":{"text":""},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{"text":"No"},"8":{"text":""}}},"1":{"cells":{"1":{"merge":[2,4],"style":61,"height":75,"text":"东莞市铠思科技\\n家装工程单据"},"2":{"text":""},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{"text":"系统编号："},"8":{"rendered":"","config":"","text":"${headEngineering.systematic_receipt}","merge":[0,1],"height":25}}},"2":{"cells":{"1":{"text":""},"2":{"text":""},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{"text":"开单日期："},"8":{"text":"${headEngineering.invoice_date}","merge":[0,1],"height":25}}},"3":{"cells":{"1":{"text":""},"2":{"text":""},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{"text":"送货日期："},"8":{"text":"${headEngineering.invoice_date}","merge":[0,1],"height":25}}},"4":{"cells":{"1":{"text":"客户名称："},"2":{"text":"${headEngineering.customer_name}"},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{"text":""},"8":{"text":""}}},"5":{"cells":{"1":{"style":23,"text":"商品编号"},"2":{"style":23,"text":"名称/型号/规格"},"3":{"style":23,"text":"颜色"},"4":{"style":23,"text":"单位"},"5":{"style":23,"text":"数量"},"6":{"style":23,"text":"单价"},"7":{"style":23,"text":"金额"},"8":{"style":23,"text":"备注"}}},"6":{"cells":{"1":{"style":13,"text":"#{detailEngineering.product_code}","completeBlankStatus":true,"completeBlankRow":"8","aggregate":"","rendered":"","config":"","display":"normal"},"2":{"style":13,"text":"#{detailEngineering.product_name}","completeBlankStatus":false,"completeBlankRow":"8","rendered":"","config":""},"3":{"style":13,"text":"#{detailEngineering.product_specifications}"},"4":{"style":13,"text":"#{detailEngineering.measure_unit}","completeBlankStatus":false,"completeBlankRow":"8","rendered":"","config":""},"5":{"style":13,"text":"#{detailEngineering.plan_quantity}","completeBlankStatus":false,"completeBlankRow":"8"},"6":{"style":13,"text":"#{detailEngineering.univalence}","completeBlankStatus":false,"completeBlankRow":"8"},"7":{"style":13,"text":"#{detailEngineering.money}","completeBlankStatus":false,"completeBlankRow":"8"},"8":{"funcname":"-1","rendered":"","subtotal":"-1","style":13,"text":"#{detailEngineering.remarks}","config":"","completeBlankStatus":false,"completeBlankRow":"8"}}},"7":{"cells":{"1":{"merge":[0,4],"style":13,"height":25,"text":"合计（大写）：${headReceipt.capitalize_total_amount}"},"2":{"text":""},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"rendered":"","merge":[0,2],"display":"number","style":13,"config":"","height":25,"text":"（小写）：￥${headEngineering.total_amount}"},"7":{"text":""},"8":{"text":""}}},"8":{"cells":{"1":{"merge":[1,4],"style":22,"height":50,"text":"备注：${headEngineering.receipt_notes}"},"2":{},"3":{},"4":{},"5":{},"6":{"merge":[0,2],"style":13,"height":25,"rendered":"","config":"","text":"已收定金：￥${headEngineering.deposit}"},"7":{"text":""},"8":{"text":""}}},"9":{"cells":{"1":{},"2":{},"3":{},"4":{},"5":{},"6":{"merge":[0,2],"style":13,"height":25,"rendered":"","config":"","text":"应收余款：￥=SUM(${headEngineering.total_amount}-${headEngineering.deposit})"},"7":{"text":""},"8":{"text":""}}},"10":{"cells":{"1":{"merge":[2,0],"style":34,"text":"顾客须知","height":75},"2":{"merge":[0,4],"style":13,"text":"1、禁止恶意损坏物品","height":25},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{"merge":[2,1],"style":41,"text":"顾客签名：","height":75},"8":{}}},"11":{"cells":{"1":{"text":""},"2":{"merge":[0,4],"style":42,"text":"2、商品验收后无质量问题不予退货","height":25},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{},"8":{}}},"12":{"cells":{"1":{"text":""},"2":{"merge":[0,4],"style":39,"text":"3、客户验收核对所购买产品无误","height":25},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{},"8":{}}},"14":{"cells":{"2":{"rendered":"","config":""},"3":{},"4":{"rendered":"","config":""},"7":{}}},"15":{"cells":{"2":{},"4":{}}},"16":{"cells":{"2":{},"3":{"text":"","rendered":"","config":""}}},"len":88,"":{"cells":{"":{"text":"","completeBlankRow":"8"}}}},"rpbar":{"show":true,"pageSize":"","btnList":[]},"fixedPrintHeadRows":[],"fixedPrintTailRows":[],"displayConfig":{},"background":false,"name":"sheet1","styles":[{"align":"center"},{"align":"center","font":{"size":26}},{"font":{"size":26}},{"align":"center","font":{"size":42}},{"font":{"size":42}},{"border":{"top":["thin","#000"],"left":["thin","#000"]}},{"border":{"top":["thin","#000"]}},{"border":{"top":["thin","#000"],"right":["thin","#000"]}},{"border":{"left":["thin","#000"]}},{"border":{"right":["thin","#000"]}},{"border":{"left":["thin","#000"],"bottom":["thin","#000"]}},{"border":{"bottom":["thin","#000"]}},{"border":{"bottom":["thin","#000"],"right":["thin","#000"]}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"font":{"size":15}},{"font":{"size":15}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"font":{"size":18}},{"font":{"size":18}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"font":{"size":26}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"font":{"size":16}},{"font":{"size":16}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"align":"left"},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","align":"left"},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"align":"center"},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"middle","font":{"size":16}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","font":{"size":16}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":true,"font":{"size":16}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":false,"font":{"size":16}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":true,"font":{"size":18}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":true,"font":{"size":26}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":true,"font":{"size":24}},{"font":{"size":24}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":true,"font":{"size":22}},{"font":{"size":22}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":true,"align":"center","font":{"size":22}},{},{"border":{"right":["thin","#ffffff"]}},{"border":{"top":["thin","#ffffff"],"right":["thin","#ffffff"]}},{"border":{"top":["thin","#ffffff"],"bottom":["thin","#ffffff"],"right":["thin","#ffffff"]}},{"border":{"top":["thin","#ffffff"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]}},{"border":{"top":["thin","#ffffff"],"left":["thin","#ffffff"],"bottom":["thin","#ffffff"],"right":["thin","#ffffff"]},"valign":"top","align":"left"},{"border":{"top":["thin","#000100"],"left":["thin","#000100"],"bottom":["thin","#000100"],"right":["thin","#000100"]},"valign":"top","align":"left"},{"border":{"top":["thin","#000100"],"left":["thin","#000100"],"bottom":["thin","#000100"],"right":["thin","#000100"]}},{"textwrap":true,"align":"center","font":{"size":42}},{"textwrap":false,"align":"center","font":{"size":42}},{"textwrap":false,"align":"center","font":{"size":14}},{"font":{"size":14}},{"textwrap":false,"align":"center","font":{"size":18}},{"textwrap":false,"align":"center","font":{"size":22}},{"textwrap":false,"align":"center","font":{"size":22,"bold":true}},{"font":{"size":22,"bold":true}},{"textwrap":false,"align":"center","font":{"size":22,"bold":false}},{"font":{"size":22,"bold":false}},{"textwrap":false,"align":"center","font":{"size":22,"name":"Microsoft YaHei","bold":true}},{"font":{"size":22,"name":"Microsoft YaHei","bold":true}},{"textwrap":false,"align":"center","font":{"size":22,"name":"宋体","bold":true}},{"font":{"size":22,"name":"宋体","bold":true}},{"textwrap":false,"align":"center","font":{"size":22,"name":"Source Sans Pro","bold":true}},{"font":{"size":22,"name":"Source Sans Pro","bold":true}},{"textwrap":false,"align":"center","font":{"size":22,"name":"Lato","bold":true}},{"font":{"size":22,"name":"Lato","bold":true}},{"textwrap":false,"align":"center","font":{"size":24,"name":"Microsoft YaHei","bold":true}},{"font":{"size":24,"name":"Microsoft YaHei","bold":true}}],"freezeLineColor":"rgb(185, 185, 185)","merges":["B2:F4","I2:J2","I3:J3","I4:J4","B8:F8","G8:I8","B9:F10","G9:I9","G10:I10","B11:B13","C11:G11","H11:I13","C12:G12","C13:G13"]}', NULL, NULL, '', NULL, '', NULL, 0, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report VALUES('983365983805317120', '20240603232403__4241', '售后单据', NULL, NULL, 'printinfo', '{"loopBlockList":[],"printConfig":{"paper":"A4","width":210,"height":297,"definition":5,"isBackend":false,"marginX":10,"marginY":10,"layout":"portrait","printCallBackUrl":"","paginationShow":false,"paginationLocation":"middle"},"hidden":{"rows":[],"cols":[]},"dbexps":[],"dicts":[],"freeze":"A1","dataRectWidth":660,"completeBlankRowList":[{"db":"detailAfterSales","field":"product_code","rows":"8"}],"autofilter":{},"validations":[],"cols":{"0":{"width":25},"1":{"width":86},"2":{"width":193},"3":{"width":40},"4":{"width":40},"5":{"width":42},"6":{"width":63},"7":{"width":71},"len":50},"area":{"sri":16,"sci":2,"eri":16,"eci":2,"width":193,"height":25},"pyGroupEngine":false,"excel_config_id":"983365983805317120","hiddenCells":[],"zonedEditionList":[],"rows":{"0":{"cells":{"1":{"text":""},"2":{"text":""},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{"text":"No"},"8":{"text":""}}},"1":{"cells":{"1":{"merge":[2,4],"style":61,"height":75,"text":"东莞市铠思科技\\n售后单据"},"2":{"text":""},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{"text":"系统编号："},"8":{"rendered":"","config":"","text":"${headAfterSales.systematic_receipt}","merge":[0,1],"height":25}}},"2":{"cells":{"1":{"text":""},"2":{"text":""},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{"text":"开单日期："},"8":{"text":"${headAfterSales.invoice_date}","merge":[0,1],"height":25}}},"3":{"cells":{"1":{"text":""},"2":{"text":""},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{"text":"送货日期："},"8":{"text":"${headAfterSales.invoice_date}","merge":[0,1],"height":25}}},"4":{"cells":{"1":{"text":"客户名称："},"2":{"text":"${headAfterSales.customer_name}"},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{"text":""},"8":{"text":""}}},"5":{"cells":{"1":{"style":23,"text":"商品编号"},"2":{"style":23,"text":"名称/型号/规格"},"3":{"style":23,"text":"颜色"},"4":{"style":23,"text":"单位"},"5":{"style":23,"text":"数量"},"6":{"style":23,"text":"单价"},"7":{"style":23,"text":"金额"},"8":{"style":23,"text":"备注"}}},"6":{"cells":{"1":{"style":13,"text":"#{detailAfterSales.product_code}","completeBlankStatus":true,"completeBlankRow":"8","aggregate":"","rendered":"","config":"","display":"normal"},"2":{"style":13,"text":"#{detailAfterSales.product_name}","completeBlankStatus":false,"completeBlankRow":"8","rendered":"","config":""},"3":{"style":13,"text":"#{detailAfterSales.product_specifications}"},"4":{"style":13,"text":"#{detailAfterSales.measure_unit}","completeBlankStatus":false,"completeBlankRow":"8","rendered":"","config":""},"5":{"style":13,"text":"#{detailAfterSales.plan_quantity}","completeBlankStatus":false,"completeBlankRow":"8"},"6":{"style":13,"text":"#{detailAfterSales.univalence}","completeBlankStatus":false,"completeBlankRow":"8"},"7":{"style":13,"text":"#{detailAfterSales.money}","completeBlankStatus":false,"completeBlankRow":"8"},"8":{"funcname":"-1","rendered":"","subtotal":"-1","style":13,"text":"#{detailAfterSales.remarks}","config":"","completeBlankStatus":false,"completeBlankRow":"8"}}},"7":{"cells":{"1":{"merge":[0,4],"style":13,"height":25,"text":"合计（大写）：${headAfterSales.capitalize_total_amount}"},"2":{"text":""},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"rendered":"","merge":[0,2],"display":"number","style":13,"config":"","height":25,"text":"（小写）：￥${headAfterSales.total_amount}"},"7":{"text":""},"8":{"text":""}}},"8":{"cells":{"1":{"merge":[1,4],"style":22,"height":50,"text":"备注：${headAfterSales.receipt_notes}"},"2":{},"3":{},"4":{},"5":{},"6":{"merge":[0,2],"style":13,"height":25,"rendered":"","config":"","text":"已收定金：￥${headAfterSales.deposit}"},"7":{"text":""},"8":{"text":""}}},"9":{"cells":{"1":{},"2":{},"3":{},"4":{},"5":{},"6":{"merge":[0,2],"style":13,"height":25,"rendered":"","config":"","text":"应收余款：￥=SUM(${headAfterSales.total_amount}-${headAfterSales.deposit})"},"7":{"text":""},"8":{"text":""}}},"10":{"cells":{"1":{"merge":[2,0],"style":34,"text":"顾客须知","height":75},"2":{"merge":[0,4],"style":13,"text":"1、禁止恶意损坏物品","height":25},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{"merge":[2,1],"style":41,"text":"顾客签名：","height":75},"8":{}}},"11":{"cells":{"1":{"text":""},"2":{"merge":[0,4],"style":42,"text":"2、商品验收后无质量问题不予退货","height":25},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{},"8":{}}},"12":{"cells":{"1":{"text":""},"2":{"merge":[0,4],"style":39,"text":"3、客户验收核对所购买产品无误","height":25},"3":{"text":""},"4":{"text":""},"5":{"text":""},"6":{"text":""},"7":{},"8":{}}},"14":{"cells":{"2":{"rendered":"","config":""},"3":{},"4":{},"7":{}}},"15":{"cells":{"2":{},"4":{}}},"16":{"cells":{"2":{},"3":{"text":"","rendered":"","config":""}}},"len":88,"":{"cells":{"":{"text":"","completeBlankRow":"8"}}}},"rpbar":{"show":true,"pageSize":"","btnList":[]},"fixedPrintHeadRows":[],"fixedPrintTailRows":[],"displayConfig":{},"background":false,"name":"sheet1","styles":[{"align":"center"},{"align":"center","font":{"size":26}},{"font":{"size":26}},{"align":"center","font":{"size":42}},{"font":{"size":42}},{"border":{"top":["thin","#000"],"left":["thin","#000"]}},{"border":{"top":["thin","#000"]}},{"border":{"top":["thin","#000"],"right":["thin","#000"]}},{"border":{"left":["thin","#000"]}},{"border":{"right":["thin","#000"]}},{"border":{"left":["thin","#000"],"bottom":["thin","#000"]}},{"border":{"bottom":["thin","#000"]}},{"border":{"bottom":["thin","#000"],"right":["thin","#000"]}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"font":{"size":15}},{"font":{"size":15}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"font":{"size":18}},{"font":{"size":18}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"font":{"size":26}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"font":{"size":16}},{"font":{"size":16}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"align":"left"},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","align":"left"},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"align":"center"},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"middle","font":{"size":16}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","font":{"size":16}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":true,"font":{"size":16}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":false,"font":{"size":16}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":true,"font":{"size":18}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":true,"font":{"size":26}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":true,"font":{"size":24}},{"font":{"size":24}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":true,"font":{"size":22}},{"font":{"size":22}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","textwrap":true,"align":"center","font":{"size":22}},{},{"border":{"right":["thin","#ffffff"]}},{"border":{"top":["thin","#ffffff"],"right":["thin","#ffffff"]}},{"border":{"top":["thin","#ffffff"],"bottom":["thin","#ffffff"],"right":["thin","#ffffff"]}},{"border":{"top":["thin","#ffffff"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]}},{"border":{"top":["thin","#ffffff"],"left":["thin","#ffffff"],"bottom":["thin","#ffffff"],"right":["thin","#ffffff"]},"valign":"top","align":"left"},{"border":{"top":["thin","#000100"],"left":["thin","#000100"],"bottom":["thin","#000100"],"right":["thin","#000100"]},"valign":"top","align":"left"},{"border":{"top":["thin","#000100"],"left":["thin","#000100"],"bottom":["thin","#000100"],"right":["thin","#000100"]}},{"textwrap":true,"align":"center","font":{"size":42}},{"textwrap":false,"align":"center","font":{"size":42}},{"textwrap":false,"align":"center","font":{"size":14}},{"font":{"size":14}},{"textwrap":false,"align":"center","font":{"size":18}},{"textwrap":false,"align":"center","font":{"size":22}},{"textwrap":false,"align":"center","font":{"size":22,"bold":true}},{"font":{"size":22,"bold":true}},{"textwrap":false,"align":"center","font":{"size":22,"bold":false}},{"font":{"size":22,"bold":false}},{"textwrap":false,"align":"center","font":{"size":22,"name":"Microsoft YaHei","bold":true}},{"font":{"size":22,"name":"Microsoft YaHei","bold":true}},{"textwrap":false,"align":"center","font":{"size":22,"name":"宋体","bold":true}},{"font":{"size":22,"name":"宋体","bold":true}},{"textwrap":false,"align":"center","font":{"size":22,"name":"Source Sans Pro","bold":true}},{"font":{"size":22,"name":"Source Sans Pro","bold":true}},{"textwrap":false,"align":"center","font":{"size":22,"name":"Lato","bold":true}},{"font":{"size":22,"name":"Lato","bold":true}},{"textwrap":false,"align":"center","font":{"size":24,"name":"Microsoft YaHei","bold":true}},{"font":{"size":24,"name":"Microsoft YaHei","bold":true}}],"freezeLineColor":"rgb(185, 185, 185)","merges":["B2:F4","I2:J2","I3:J3","I4:J4","B8:F8","G8:I8","B9:F10","G9:I9","G10:I10","B11:B13","C11:G11","H11:I13","C12:G12","C13:G13"]}', NULL, NULL, '', NULL, '', NULL, 0, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL);
-- ----------------------------
-- 30、数据集管理
-- ----------------------------
DROP TABLE IF EXISTS `jimu_report_db_param`;
CREATE TABLE `jimu_report_db_param`  (
  `id` 						varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `jimu_report_head_id` 	varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '动态报表ID',
  `param_name` 				varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '参数字段',
  `param_txt` 				varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '参数文本',
  `param_value` 			varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '参数默认值',
  `order_num` 				int(11) NULL DEFAULT NULL COMMENT '排序',
  `create_by` 				varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人登录名称',
  `create_time` 			datetime NULL DEFAULT NULL COMMENT '创建日期',
  `update_by` 				varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人登录名称',
  `update_time` 			datetime NULL DEFAULT NULL COMMENT '更新日期',
  `search_flag` 			int(1) NULL DEFAULT NULL COMMENT '查询标识0否1是 默认0',
  `widget_type` 			varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '查询控件类型',
  `search_mode` 			int(1) NULL DEFAULT NULL COMMENT '查询模式1简单2范围',
  `dict_code` 				varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典',
  `search_format` 			varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '查询时间格式化表达式',
  `ext_json` 				text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '参数配置',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_jmrheadid`(`jimu_report_head_id`) USING BTREE,
  INDEX `idx_jrdp_jimu_report_head_id`(`jimu_report_head_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '数据集管理' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- 初始化-数据集管理表数据
-- ----------------------------
INSERT INTO jimu_report_db_param VALUES('957638707881893888', '957638707491823616', 'systematicReceipt', 'systematicReceipt', '', 1, 'admin', '2024-06-04 00:01:10', NULL, NULL, 0, NULL, NULL, NULL, NULL, '');
INSERT INTO jimu_report_db_param VALUES('957987696342917120', '957987695822823424', 'systematicReceipt', 'systematicReceipt', '', 1, 'admin', '2024-06-04 23:07:56', NULL, NULL, 0, NULL, NULL, NULL, NULL, '');
INSERT INTO jimu_report_db_param VALUES('982943990089981952', '982943988802330624', 'systematicReceipt', 'systematicReceipt', '', 1, 'admin', '2024-06-04 00:01:10', NULL, NULL, 0, NULL, NULL, NULL, NULL, '');
INSERT INTO jimu_report_db_param VALUES('982943991251804160', '982943990199033856', 'systematicReceipt', 'systematicReceipt', '', 1, 'admin', '2024-06-04 23:07:56', NULL, NULL, 0, NULL, NULL, NULL, NULL, '');
INSERT INTO jimu_report_db_param VALUES('982960589970808832', '982960588796403712', 'systematicOrderForm', 'systematicOrderForm', '', 1, 'admin', '2024-08-12 21:01:17', NULL, NULL, 0, NULL, NULL, NULL, NULL, '');
INSERT INTO jimu_report_db_param VALUES('982963350774947840', '982963349839618048', 'systematicOrderForm', 'systematicOrderForm', '', 1, 'admin', '2024-08-12 21:12:16', NULL, NULL, 0, NULL, NULL, NULL, NULL, '');
INSERT INTO jimu_report_db_param VALUES('983362129919418368', '983362128434634752', 'systematicReceipt', 'systematicReceipt', '', 1, 'admin', '2024-06-04 00:01:10', NULL, NULL, 0, NULL, NULL, NULL, NULL, '');
INSERT INTO jimu_report_db_param VALUES('983362131001548800', '983362130011693056', 'systematicReceipt', 'systematicReceipt', '', 1, 'admin', '2024-06-04 23:07:56', NULL, NULL, 0, NULL, NULL, NULL, NULL, '');
INSERT INTO jimu_report_db_param VALUES('983362131957850112', '983362131064463360', 'systematicOrderForm', 'systematicOrderForm', '', 1, 'admin', '2024-08-12 21:01:17', NULL, NULL, 0, NULL, NULL, NULL, NULL, '');
INSERT INTO jimu_report_db_param VALUES('983362132905762816', '983362132024958976', 'systematicOrderForm', 'systematicOrderForm', '', 1, 'admin', '2024-08-12 21:12:16', NULL, NULL, 0, NULL, NULL, NULL, NULL, '');
INSERT INTO jimu_report_db_param VALUES('983362413840244736', '983362413034938368', 'systematicReceipt', 'systematicReceipt', '', 1, 'admin', '2024-06-04 00:01:10', NULL, NULL, 0, NULL, NULL, NULL, NULL, '');
INSERT INTO jimu_report_db_param VALUES('983362414758797312', '983362413898964992', 'systematicReceipt', 'systematicReceipt', '', 1, 'admin', '2024-06-04 23:07:56', NULL, NULL, 0, NULL, NULL, NULL, NULL, '');
INSERT INTO jimu_report_db_param VALUES('983363238557851648', '983363237651881984', 'systematicReceipt', 'systematicReceipt', '', 1, 'admin', '2024-06-04 00:01:10', NULL, NULL, 0, NULL, NULL, NULL, NULL, '');
INSERT INTO jimu_report_db_param VALUES('983363239556096000', '983363238620766208', 'systematicReceipt', 'systematicReceipt', '', 1, 'admin', '2024-06-04 23:07:56', NULL, NULL, 0, NULL, NULL, NULL, NULL, '');
INSERT INTO jimu_report_db_param VALUES('983363618750537728', '983363618054283264', 'systematicReceipt', 'systematicReceipt', '', 1, 'admin', '2024-06-04 00:01:10', NULL, NULL, 0, NULL, NULL, NULL, NULL, '');
INSERT INTO jimu_report_db_param VALUES('983363619711033344', '983363618872172544', 'systematicReceipt', 'systematicReceipt', '', 1, 'admin', '2024-06-04 23:07:56', NULL, NULL, 0, NULL, NULL, NULL, NULL, '');
INSERT INTO jimu_report_db_param VALUES('983363837416382464', '983363836606881792', 'systematicReceipt', 'systematicReceipt', '', 1, 'admin', '2024-06-04 00:01:10', NULL, NULL, 0, NULL, NULL, NULL, NULL, '');
INSERT INTO jimu_report_db_param VALUES('983363838376878080', '983363837462519808', 'systematicReceipt', 'systematicReceipt', '', 1, 'admin', '2024-06-04 23:07:56', NULL, NULL, 0, NULL, NULL, NULL, NULL, '');
INSERT INTO jimu_report_db_param VALUES('983363988902060032', '983363988218388480', 'systematicReceipt', 'systematicReceipt', '', 1, 'admin', '2024-06-04 00:01:10', NULL, NULL, 0, NULL, NULL, NULL, NULL, '');
INSERT INTO jimu_report_db_param VALUES('983363989971607552', '983363989032083456', 'systematicReceipt', 'systematicReceipt', '', 1, 'admin', '2024-06-04 23:07:56', NULL, NULL, 0, NULL, NULL, NULL, NULL, '');
INSERT INTO jimu_report_db_param VALUES('983365947084185600', '983365946278879232', 'systematicReceipt', 'systematicReceipt', '', 1, 'admin', '2024-06-04 00:01:10', NULL, NULL, 0, NULL, NULL, NULL, NULL, '');
INSERT INTO jimu_report_db_param VALUES('983365948086624256', '983365947130322944', 'systematicReceipt', 'systematicReceipt', '', 1, 'admin', '2024-06-04 23:07:56', NULL, NULL, 0, NULL, NULL, NULL, NULL, '');
INSERT INTO jimu_report_db_param VALUES('983365984581263360', '983365983868231680', 'systematicReceipt', 'systematicReceipt', '', 1, 'admin', '2024-06-04 00:01:10', NULL, NULL, 0, NULL, NULL, NULL, NULL, '');
INSERT INTO jimu_report_db_param VALUES('983365985571119104', '983365984702898176', 'systematicReceipt', 'systematicReceipt', '', 1, 'admin', '2024-06-04 23:07:56', NULL, NULL, 0, NULL, NULL, NULL, NULL, '');
INSERT INTO jimu_report_db_param VALUES('983706959258263552', '983706957387603968', 'systematicOrderForm', 'systematicOrderForm', '', 1, 'admin', '2024-08-14 22:27:06', NULL, NULL, 0, NULL, NULL, NULL, NULL, '');
INSERT INTO jimu_report_db_param VALUES('983706959350538240', '983706957387603968', 'systematicReceipt', 'systematicReceipt', '', 2, 'admin', '2024-08-14 22:27:06', NULL, NULL, 0, NULL, NULL, NULL, NULL, '');
INSERT INTO jimu_report_db_param VALUES('983708142169432064', '983708141288628224', 'systematicReceipt', 'systematicReceipt', '', 1, 'admin', '2024-08-14 22:31:48', NULL, NULL, 0, NULL, NULL, NULL, NULL, '');
INSERT INTO jimu_report_db_param VALUES('983709599769763840', '983709598914125824', 'systematicReceipt', 'systematicReceipt', '', 1, 'admin', '2024-08-14 22:37:35', NULL, NULL, 0, NULL, NULL, NULL, NULL, '');
INSERT INTO jimu_report_db_param VALUES('983710283672002560', '983710282757644288', 'systematicReceipt', 'systematicReceipt', '', 1, 'admin', '2024-08-14 22:40:18', NULL, NULL, 0, NULL, NULL, NULL, NULL, '');
-- ----------------------------
-- 31、数据集明细信息
-- ----------------------------
DROP TABLE IF EXISTS `jimu_report_db`;
CREATE TABLE `jimu_report_db`  (
  `id` 						varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'id',
  `jimu_report_id` 			varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '主键字段',
  `create_by` 				varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人登录名称',
  `update_by` 				varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人登录名称',
  `create_time` 			datetime NULL DEFAULT NULL COMMENT '创建日期',
  `update_time` 			datetime NULL DEFAULT NULL COMMENT '更新日期',
  `db_code` 				varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据集编码',
  `db_ch_name` 				varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据集名字',
  `db_type` 				varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据源类型',
  `db_table_name` 			varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据库表名',
  `db_dyn_sql` 				longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '动态查询SQL',
  `db_key` 					varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据源KEY',
  `tb_db_key` 				varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '填报数据源',
  `tb_db_table_name` 		varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '填报数据表',
  `java_type` 				varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'java类数据集  类型（spring:springkey,class:java类名）',
  `java_value` 				varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'java类数据源  数值（bean key/java类名）',
  `api_url` 				varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求地址',
  `api_method` 				varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求方法0-get,1-post',
  `is_list` 				varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '是否是列表0否1是 默认0',
  `is_page` 				varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否作为分页,0:不分页，1:分页',
  `db_source` 				varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据源',
  `db_source_type` 			varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据库类型 MYSQL ORACLE SQLSERVER',
  `json_data` 				text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT 'json数据，直接解析json内容',
  `api_convert` 			varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'api转换器',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_jmreportdb_db_key`(`db_key`) USING BTREE,
  INDEX `idx_jimu_report_id`(`jimu_report_id`) USING BTREE,
  INDEX `idx_db_source_id`(`db_source`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '数据集明细信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- 初始化-数据集明细信息表数据
-- ----------------------------
INSERT INTO jimu_report_db VALUES('957638707491823616', '957623614502789120', 'admin', 'admin', '2024-08-11 17:06:22', '2024-08-11 17:06:22', 'headReceipt', '单据头信息', '0', NULL, 'SELECT
        hr.systematic_receipt, hr.original_receipt, hr.invoice_date, hr.receipt_notes, hr.deposit, hr.total_amount, 
        hr.capitalize_total_amount, hr.review_comments, hr.create_by, hr.create_time, hr.update_by, hr.update_time,
        (SELECT w1.warehouse_name FROM warehouse w1 WHERE w1.warehouse_id = hr.warehousing_ids) AS warehousing_name,
        (SELECT w2.warehouse_name FROM warehouse w2 WHERE w2.warehouse_id = hr.retrieval_ids) AS retrieval_name,
        (SELECT s.supplier_name FROM supplier s WHERE hr.supplier_ids = s.supplier_id) AS supplier_name,
        (SELECT c.customer_name FROM customer c WHERE hr.customer_ids = c.customer_id) AS customer_name,
        su.user_name
        FROM head_receipt hr
        JOIN sys_user su ON su.user_id = hr.user_ids
        WHERE hr.systematic_receipt = ''${systematicReceipt}''', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', '', 'mysql', '', '');
INSERT INTO jimu_report_db VALUES('957987695822823424', '957623614502789120', 'admin', 'admin', '2024-08-11 17:17:10', '2024-08-11 17:17:10', 'detailReceipt', '单据明细信息', '0', NULL, 'SELECT
        dr.systematic_receipt, dr.current_inventory, dr.actual_inventory, dr.plan_quantity, dr.univalence, dr.discount, 
        dr.money, dr.cost, dr.remarks, dr.product_specifications, dr.measure_unit,
        (SELECT w1.warehouse_name FROM warehouse w1 WHERE w1.warehouse_id = hr.warehousing_ids) AS warehousing_name,
        (SELECT w2.warehouse_name FROM warehouse w2 WHERE w2.warehouse_id = hr.retrieval_ids) AS retrieval_name,
        (SELECT s.supplier_name FROM supplier s WHERE hr.supplier_ids = s.supplier_id) AS supplier_name,
        (SELECT c.customer_name FROM customer c WHERE hr.customer_ids = c.customer_id) AS customer_name,
        p.product_code, p.product_name, p.producer, p.inventory_qty, pt.product_type_name
        FROM head_receipt hr
        JOIN detail_receipt dr ON dr.systematic_receipt = hr.systematic_receipt
        JOIN product p ON p.product_id = dr.product_id
        JOIN product_type pt ON pt.product_type_id = p.product_type
        WHERE hr.systematic_receipt = ''${systematicReceipt}''', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', '1', '', 'mysql', '', '');
INSERT INTO jimu_report_db VALUES('982943988802330624', '982943988424843264', 'admin', 'admin', '2024-08-11 17:06:22', '2024-08-11 17:06:22', 'headReceipt', '单据头信息', '0', NULL, 'SELECT
        hr.systematic_receipt, hr.original_receipt, hr.invoice_date, hr.receipt_notes, hr.deposit, hr.total_amount, 
        hr.capitalize_total_amount, hr.review_comments, hr.create_by, hr.create_time, hr.update_by, hr.update_time,
        (SELECT w1.warehouse_name FROM warehouse w1 WHERE w1.warehouse_id = hr.warehousing_ids) AS warehousing_name,
        (SELECT w2.warehouse_name FROM warehouse w2 WHERE w2.warehouse_id = hr.retrieval_ids) AS retrieval_name,
        (SELECT s.supplier_name FROM supplier s WHERE hr.supplier_ids = s.supplier_id) AS supplier_name,
        (SELECT c.customer_name FROM customer c WHERE hr.customer_ids = c.customer_id) AS customer_name,
        su.user_name
        FROM head_receipt hr
        JOIN sys_user su ON su.user_id = hr.user_ids
        WHERE hr.systematic_receipt = ''${systematicReceipt}''', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', '', 'mysql', '', '');
INSERT INTO jimu_report_db VALUES('982943990199033856', '982943988424843264', 'admin', 'admin', '2024-08-11 17:17:10', '2024-08-11 17:17:10', 'detailReceipt', '单据明细信息', '0', NULL, 'SELECT
        dr.systematic_receipt, dr.current_inventory, dr.actual_inventory, dr.plan_quantity, dr.univalence, dr.discount, 
        dr.money, dr.cost, dr.remarks, dr.product_specifications, dr.measure_unit,
        (SELECT w1.warehouse_name FROM warehouse w1 WHERE w1.warehouse_id = hr.warehousing_ids) AS warehousing_name,
        (SELECT w2.warehouse_name FROM warehouse w2 WHERE w2.warehouse_id = hr.retrieval_ids) AS retrieval_name,
        (SELECT s.supplier_name FROM supplier s WHERE hr.supplier_ids = s.supplier_id) AS supplier_name,
        (SELECT c.customer_name FROM customer c WHERE hr.customer_ids = c.customer_id) AS customer_name,
        p.product_code, p.product_name, p.producer, p.inventory_qty, pt.product_type_name
        FROM head_receipt hr
        JOIN detail_receipt dr ON dr.systematic_receipt = hr.systematic_receipt
        JOIN product p ON p.product_id = dr.product_id
        JOIN product_type pt ON pt.product_type_id = p.product_type
        WHERE hr.systematic_receipt = ''${systematicReceipt}''', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', '0', '', 'mysql', '', '');
INSERT INTO jimu_report_db VALUES('982960588796403712', '982943988424843264', 'admin', 'admin', '2024-08-12 21:01:17', '2024-08-12 21:01:17', 'headOrder', '订单头信息', '0', NULL, 'SELECT
        hof.systematic_order_form, hof.original_order_form, hof.order_date, hof.delivery_date, 
        hof.plan_receipt, hof.order_form_notes, hof.deposit, hof.order_form_amount, hof.order_capitalize_amount,
        hof.review_comments, hof.create_by, hof.create_time, hof.update_by, hof.update_time, su.user_name,
        (SELECT w1.warehouse_name FROM warehouse w1 WHERE w1.warehouse_id = hof.warehousing_ids) AS warehousing_name,
        (SELECT w2.warehouse_name FROM warehouse w2 WHERE w2.warehouse_id = hof.retrieval_ids) AS retrieval_name,
        (SELECT s.supplier_name FROM supplier s WHERE hof.supplier_ids = s.supplier_id) AS supplier_name,
        (SELECT c.customer_name FROM customer c WHERE hof.customer_ids = c.customer_id) AS customer_name
        FROM head_order_form hof
        JOIN detail_order_form dof ON dof.systematic_order_form = hof.systematic_order_form
        JOIN sys_user su ON su.user_id = hof.user_ids
        WHERE hof.systematic_order_form = ''${systematicOrderForm}''', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', '', 'mysql', '', '');
INSERT INTO jimu_report_db VALUES('982963349839618048', '982943988424843264', 'admin', NULL, '2024-08-12 21:12:15', '2024-08-12 21:12:15', 'detailOrder', '订单明细信息', '0', NULL, 'SELECT
        dof.systematic_order_form, dof.plan_quantity, dof.univalence, 
        dof.discount, dof.money, dof.cost, dof.remarks, dof.product_specifications, dof.measure_unit,
        p.product_code, p.product_name, p.producer, p.inventory_qty, pt.product_type_name, su.user_name,
        (SELECT w1.warehouse_name FROM warehouse w1 WHERE w1.warehouse_id = hof.warehousing_ids) AS warehousing_name,
        (SELECT w2.warehouse_name FROM warehouse w2 WHERE w2.warehouse_id = hof.retrieval_ids) AS retrieval_name,
        (SELECT s.supplier_name FROM supplier s WHERE hof.supplier_ids = s.supplier_id) AS supplier_name,
        (SELECT c.customer_name FROM customer c WHERE hof.customer_ids = c.customer_id) AS customer_name
        FROM head_order_form hof
        JOIN detail_order_form dof ON dof.systematic_order_form = hof.systematic_order_form
        JOIN product p ON p.product_id = dof.product_id
        JOIN sys_user su ON su.user_id = hof.user_ids
        JOIN product_type pt ON pt.product_type_id = p.product_type
        WHERE hof.systematic_order_form = ''${systematicOrderForm}''', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', '1', '', 'mysql', '', '');
INSERT INTO jimu_report_db VALUES('983362128434634752', '983362128149422080', 'admin', 'admin', '2024-08-11 17:06:22', '2024-08-11 17:06:22', 'headReceipt', '单据头信息', '0', NULL, 'SELECT
        hr.systematic_receipt, hr.original_receipt, hr.invoice_date, hr.receipt_notes, hr.deposit, hr.total_amount, 
        hr.capitalize_total_amount, hr.review_comments, hr.create_by, hr.create_time, hr.update_by, hr.update_time,
        (SELECT w1.warehouse_name FROM warehouse w1 WHERE w1.warehouse_id = hr.warehousing_ids) AS warehousing_name,
        (SELECT w2.warehouse_name FROM warehouse w2 WHERE w2.warehouse_id = hr.retrieval_ids) AS retrieval_name,
        (SELECT s.supplier_name FROM supplier s WHERE hr.supplier_ids = s.supplier_id) AS supplier_name,
        (SELECT c.customer_name FROM customer c WHERE hr.customer_ids = c.customer_id) AS customer_name,
        su.user_name
        FROM head_receipt hr
        JOIN sys_user su ON su.user_id = hr.user_ids
        WHERE hr.systematic_receipt = ''${systematicReceipt}''', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', '', 'mysql', '', '');
INSERT INTO jimu_report_db VALUES('983362130011693056', '983362128149422080', 'admin', 'admin', '2024-08-11 17:17:10', '2024-08-11 17:17:10', 'detailReceipt', '单据明细信息', '0', NULL, 'SELECT
        dr.systematic_receipt, dr.current_inventory, dr.actual_inventory, dr.plan_quantity, dr.univalence, dr.discount, 
        dr.money, dr.cost, dr.remarks, dr.product_specifications, dr.measure_unit,
        (SELECT w1.warehouse_name FROM warehouse w1 WHERE w1.warehouse_id = hr.warehousing_ids) AS warehousing_name,
        (SELECT w2.warehouse_name FROM warehouse w2 WHERE w2.warehouse_id = hr.retrieval_ids) AS retrieval_name,
        (SELECT s.supplier_name FROM supplier s WHERE hr.supplier_ids = s.supplier_id) AS supplier_name,
        (SELECT c.customer_name FROM customer c WHERE hr.customer_ids = c.customer_id) AS customer_name,
        p.product_code, p.product_name, p.producer, p.inventory_qty, pt.product_type_name
        FROM head_receipt hr
        JOIN detail_receipt dr ON dr.systematic_receipt = hr.systematic_receipt
        JOIN product p ON p.product_id = dr.product_id
        JOIN product_type pt ON pt.product_type_id = p.product_type
        WHERE hr.systematic_receipt = ''${systematicReceipt}''', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', '0', '', 'mysql', '', '');
INSERT INTO jimu_report_db VALUES('983362131064463360', '983362128149422080', 'admin', 'admin', '2024-08-12 21:01:17', '2024-08-12 21:01:17', 'headOrder', '订单头信息', '0', NULL, 'SELECT
        hof.systematic_order_form, hof.original_order_form, hof.order_date, hof.delivery_date, 
        hof.plan_receipt, hof.order_form_notes, hof.deposit, hof.order_form_amount, hof.order_capitalize_amount,
        hof.review_comments, hof.create_by, hof.create_time, hof.update_by, hof.update_time, su.user_name,
        (SELECT w1.warehouse_name FROM warehouse w1 WHERE w1.warehouse_id = hof.warehousing_ids) AS warehousing_name,
        (SELECT w2.warehouse_name FROM warehouse w2 WHERE w2.warehouse_id = hof.retrieval_ids) AS retrieval_name,
        (SELECT s.supplier_name FROM supplier s WHERE hof.supplier_ids = s.supplier_id) AS supplier_name,
        (SELECT c.customer_name FROM customer c WHERE hof.customer_ids = c.customer_id) AS customer_name
        FROM head_order_form hof
        JOIN detail_order_form dof ON dof.systematic_order_form = hof.systematic_order_form
        JOIN sys_user su ON su.user_id = hof.user_ids
        WHERE hof.systematic_order_form = ''${systematicOrderForm}''', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', '', 'mysql', '', '');
INSERT INTO jimu_report_db VALUES('983362132024958976', '983362128149422080', 'admin', NULL, '2024-08-12 21:12:15', '2024-08-12 21:12:15', 'detailOrder', '订单明细信息', '0', NULL, 'SELECT
        dof.systematic_order_form, dof.plan_quantity, dof.univalence, 
        dof.discount, dof.money, dof.cost, dof.remarks, dof.product_specifications, dof.measure_unit,
        p.product_code, p.product_name, p.producer, p.inventory_qty, pt.product_type_name, su.user_name,
        (SELECT w1.warehouse_name FROM warehouse w1 WHERE w1.warehouse_id = hof.warehousing_ids) AS warehousing_name,
        (SELECT w2.warehouse_name FROM warehouse w2 WHERE w2.warehouse_id = hof.retrieval_ids) AS retrieval_name,
        (SELECT s.supplier_name FROM supplier s WHERE hof.supplier_ids = s.supplier_id) AS supplier_name,
        (SELECT c.customer_name FROM customer c WHERE hof.customer_ids = c.customer_id) AS customer_name
        FROM head_order_form hof
        JOIN detail_order_form dof ON dof.systematic_order_form = hof.systematic_order_form
        JOIN product p ON p.product_id = dof.product_id
        JOIN sys_user su ON su.user_id = hof.user_ids
        JOIN product_type pt ON pt.product_type_id = p.product_type
        WHERE hof.systematic_order_form = ''${systematicOrderForm}''', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', '1', '', 'mysql', '', '');
INSERT INTO jimu_report_db VALUES('983362413034938368', '983362412942663680', 'admin', 'admin', '2024-08-11 17:06:22', '2024-08-11 17:06:22', 'headReceipt', '单据头信息', '0', NULL, 'SELECT
        hr.systematic_receipt, hr.original_receipt, hr.invoice_date, hr.receipt_notes, hr.deposit, hr.total_amount, 
        hr.capitalize_total_amount, hr.review_comments, hr.create_by, hr.create_time, hr.update_by, hr.update_time,
        (SELECT w1.warehouse_name FROM warehouse w1 WHERE w1.warehouse_id = hr.warehousing_ids) AS warehousing_name,
        (SELECT w2.warehouse_name FROM warehouse w2 WHERE w2.warehouse_id = hr.retrieval_ids) AS retrieval_name,
        (SELECT s.supplier_name FROM supplier s WHERE hr.supplier_ids = s.supplier_id) AS supplier_name,
        (SELECT c.customer_name FROM customer c WHERE hr.customer_ids = c.customer_id) AS customer_name,
        su.user_name
        FROM head_receipt hr
        JOIN sys_user su ON su.user_id = hr.user_ids
        WHERE hr.systematic_receipt = ''${systematicReceipt}''', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', '', 'mysql', '', '');
INSERT INTO jimu_report_db VALUES('983362413898964992', '983362412942663680', 'admin', 'admin', '2024-08-11 17:17:10', '2024-08-11 17:17:10', 'detailReceipt', '单据明细信息', '0', NULL, 'SELECT
        dr.systematic_receipt, dr.current_inventory, dr.actual_inventory, dr.plan_quantity, dr.univalence, dr.discount, 
        dr.money, dr.cost, dr.remarks, dr.product_specifications, dr.measure_unit,
        (SELECT w1.warehouse_name FROM warehouse w1 WHERE w1.warehouse_id = hr.warehousing_ids) AS warehousing_name,
        (SELECT w2.warehouse_name FROM warehouse w2 WHERE w2.warehouse_id = hr.retrieval_ids) AS retrieval_name,
        (SELECT s.supplier_name FROM supplier s WHERE hr.supplier_ids = s.supplier_id) AS supplier_name,
        (SELECT c.customer_name FROM customer c WHERE hr.customer_ids = c.customer_id) AS customer_name,
        p.product_code, p.product_name, p.producer, p.inventory_qty, pt.product_type_name
        FROM head_receipt hr
        JOIN detail_receipt dr ON dr.systematic_receipt = hr.systematic_receipt
        JOIN product p ON p.product_id = dr.product_id
        JOIN product_type pt ON pt.product_type_id = p.product_type
        WHERE hr.systematic_receipt = ''${systematicReceipt}''', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', '1', '', 'mysql', '', '');
INSERT INTO jimu_report_db VALUES('983363237651881984', '983363237521858560', 'admin', 'admin', '2024-08-11 17:06:22', '2024-08-11 17:06:22', 'headReceipt', '单据头信息', '0', NULL, 'SELECT
        hr.systematic_receipt, hr.original_receipt, hr.invoice_date, hr.receipt_notes, hr.deposit, hr.total_amount, 
        hr.capitalize_total_amount, hr.review_comments, hr.create_by, hr.create_time, hr.update_by, hr.update_time,
        (SELECT w1.warehouse_name FROM warehouse w1 WHERE w1.warehouse_id = hr.warehousing_ids) AS warehousing_name,
        (SELECT w2.warehouse_name FROM warehouse w2 WHERE w2.warehouse_id = hr.retrieval_ids) AS retrieval_name,
        (SELECT s.supplier_name FROM supplier s WHERE hr.supplier_ids = s.supplier_id) AS supplier_name,
        (SELECT c.customer_name FROM customer c WHERE hr.customer_ids = c.customer_id) AS customer_name,
        su.user_name
        FROM head_receipt hr
        JOIN sys_user su ON su.user_id = hr.user_ids
        WHERE hr.systematic_receipt = ''${systematicReceipt}''', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', '', 'mysql', '', '');
INSERT INTO jimu_report_db VALUES('983363238620766208', '983363237521858560', 'admin', 'admin', '2024-08-11 17:17:10', '2024-08-11 17:17:10', 'detailReceipt', '单据明细信息', '0', NULL, 'SELECT
        dr.systematic_receipt, dr.current_inventory, dr.actual_inventory, dr.plan_quantity, dr.univalence, dr.discount, 
        dr.money, dr.cost, dr.remarks, dr.product_specifications, dr.measure_unit,
        (SELECT w1.warehouse_name FROM warehouse w1 WHERE w1.warehouse_id = hr.warehousing_ids) AS warehousing_name,
        (SELECT w2.warehouse_name FROM warehouse w2 WHERE w2.warehouse_id = hr.retrieval_ids) AS retrieval_name,
        (SELECT s.supplier_name FROM supplier s WHERE hr.supplier_ids = s.supplier_id) AS supplier_name,
        (SELECT c.customer_name FROM customer c WHERE hr.customer_ids = c.customer_id) AS customer_name,
        p.product_code, p.product_name, p.producer, p.inventory_qty, pt.product_type_name
        FROM head_receipt hr
        JOIN detail_receipt dr ON dr.systematic_receipt = hr.systematic_receipt
        JOIN product p ON p.product_id = dr.product_id
        JOIN product_type pt ON pt.product_type_id = p.product_type
        WHERE hr.systematic_receipt = ''${systematicReceipt}''', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', '1', '', 'mysql', '', '');
INSERT INTO jimu_report_db VALUES('983363618054283264', '983363617982980096', 'admin', 'admin', '2024-08-11 17:06:22', '2024-08-11 17:06:22', 'headReceipt', '单据头信息', '0', NULL, 'SELECT
        hr.systematic_receipt, hr.original_receipt, hr.invoice_date, hr.receipt_notes, hr.deposit, hr.total_amount, 
        hr.capitalize_total_amount, hr.review_comments, hr.create_by, hr.create_time, hr.update_by, hr.update_time,
        (SELECT w1.warehouse_name FROM warehouse w1 WHERE w1.warehouse_id = hr.warehousing_ids) AS warehousing_name,
        (SELECT w2.warehouse_name FROM warehouse w2 WHERE w2.warehouse_id = hr.retrieval_ids) AS retrieval_name,
        (SELECT s.supplier_name FROM supplier s WHERE hr.supplier_ids = s.supplier_id) AS supplier_name,
        (SELECT c.customer_name FROM customer c WHERE hr.customer_ids = c.customer_id) AS customer_name,
        su.user_name
        FROM head_receipt hr
        JOIN sys_user su ON su.user_id = hr.user_ids
        WHERE hr.systematic_receipt = ''${systematicReceipt}''', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', '', 'mysql', '', '');
INSERT INTO jimu_report_db VALUES('983363618872172544', '983363617982980096', 'admin', 'admin', '2024-08-11 17:17:10', '2024-08-11 17:17:10', 'detailReceipt', '单据明细信息', '0', NULL, 'SELECT
        dr.systematic_receipt, dr.current_inventory, dr.actual_inventory, dr.plan_quantity, dr.univalence, dr.discount, 
        dr.money, dr.cost, dr.remarks, dr.product_specifications, dr.measure_unit,
        (SELECT w1.warehouse_name FROM warehouse w1 WHERE w1.warehouse_id = hr.warehousing_ids) AS warehousing_name,
        (SELECT w2.warehouse_name FROM warehouse w2 WHERE w2.warehouse_id = hr.retrieval_ids) AS retrieval_name,
        (SELECT s.supplier_name FROM supplier s WHERE hr.supplier_ids = s.supplier_id) AS supplier_name,
        (SELECT c.customer_name FROM customer c WHERE hr.customer_ids = c.customer_id) AS customer_name,
        p.product_code, p.product_name, p.producer, p.inventory_qty, pt.product_type_name
        FROM head_receipt hr
        JOIN detail_receipt dr ON dr.systematic_receipt = hr.systematic_receipt
        JOIN product p ON p.product_id = dr.product_id
        JOIN product_type pt ON pt.product_type_id = p.product_type
        WHERE hr.systematic_receipt = ''${systematicReceipt}''', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', '1', '', 'mysql', '', '');
INSERT INTO jimu_report_db VALUES('983363836606881792', '983363836531384320', 'admin', 'admin', '2024-08-11 17:06:22', '2024-08-11 17:06:22', 'headReceipt', '单据头信息', '0', NULL, 'SELECT
        hr.systematic_receipt, hr.original_receipt, hr.invoice_date, hr.receipt_notes, hr.deposit, hr.total_amount, 
        hr.capitalize_total_amount, hr.review_comments, hr.create_by, hr.create_time, hr.update_by, hr.update_time,
        (SELECT w1.warehouse_name FROM warehouse w1 WHERE w1.warehouse_id = hr.warehousing_ids) AS warehousing_name,
        (SELECT w2.warehouse_name FROM warehouse w2 WHERE w2.warehouse_id = hr.retrieval_ids) AS retrieval_name,
        (SELECT s.supplier_name FROM supplier s WHERE hr.supplier_ids = s.supplier_id) AS supplier_name,
        (SELECT c.customer_name FROM customer c WHERE hr.customer_ids = c.customer_id) AS customer_name,
        su.user_name
        FROM head_receipt hr
        JOIN sys_user su ON su.user_id = hr.user_ids
        WHERE hr.systematic_receipt = ''${systematicReceipt}''', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', '', 'mysql', '', '');
INSERT INTO jimu_report_db VALUES('983363837462519808', '983363836531384320', 'admin', 'admin', '2024-08-11 17:17:10', '2024-08-11 17:17:10', 'detailReceipt', '单据明细信息', '0', NULL, 'SELECT
        dr.systematic_receipt, dr.current_inventory, dr.actual_inventory, dr.plan_quantity, dr.univalence, dr.discount, 
        dr.money, dr.cost, dr.remarks, dr.product_specifications, dr.measure_unit,
        (SELECT w1.warehouse_name FROM warehouse w1 WHERE w1.warehouse_id = hr.warehousing_ids) AS warehousing_name,
        (SELECT w2.warehouse_name FROM warehouse w2 WHERE w2.warehouse_id = hr.retrieval_ids) AS retrieval_name,
        (SELECT s.supplier_name FROM supplier s WHERE hr.supplier_ids = s.supplier_id) AS supplier_name,
        (SELECT c.customer_name FROM customer c WHERE hr.customer_ids = c.customer_id) AS customer_name,
        p.product_code, p.product_name, p.producer, p.inventory_qty, pt.product_type_name
        FROM head_receipt hr
        JOIN detail_receipt dr ON dr.systematic_receipt = hr.systematic_receipt
        JOIN product p ON p.product_id = dr.product_id
        JOIN product_type pt ON pt.product_type_id = p.product_type
        WHERE hr.systematic_receipt = ''${systematicReceipt}''', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', '1', '', 'mysql', '', '');
INSERT INTO jimu_report_db VALUES('983363988218388480', '983363988151279616', 'admin', 'admin', '2024-08-11 17:06:22', '2024-08-11 17:06:22', 'headReceipt', '单据头信息', '0', NULL, 'SELECT
        hr.systematic_receipt, hr.original_receipt, hr.invoice_date, hr.receipt_notes, hr.deposit, hr.total_amount, 
        hr.capitalize_total_amount, hr.review_comments, hr.create_by, hr.create_time, hr.update_by, hr.update_time,
        (SELECT w1.warehouse_name FROM warehouse w1 WHERE w1.warehouse_id = hr.warehousing_ids) AS warehousing_name,
        (SELECT w2.warehouse_name FROM warehouse w2 WHERE w2.warehouse_id = hr.retrieval_ids) AS retrieval_name,
        (SELECT s.supplier_name FROM supplier s WHERE hr.supplier_ids = s.supplier_id) AS supplier_name,
        (SELECT c.customer_name FROM customer c WHERE hr.customer_ids = c.customer_id) AS customer_name,
        su.user_name
        FROM head_receipt hr
        JOIN sys_user su ON su.user_id = hr.user_ids
        WHERE hr.systematic_receipt = ''${systematicReceipt}''', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', '', 'mysql', '', '');
INSERT INTO jimu_report_db VALUES('983363989032083456', '983363988151279616', 'admin', 'admin', '2024-08-11 17:17:10', '2024-08-11 17:17:10', 'detailReceipt', '单据明细信息', '0', NULL, 'SELECT
        dr.systematic_receipt, dr.current_inventory, dr.actual_inventory, dr.plan_quantity, dr.univalence, dr.discount, 
        dr.money, dr.cost, dr.remarks, dr.product_specifications, dr.measure_unit,
        (SELECT w1.warehouse_name FROM warehouse w1 WHERE w1.warehouse_id = hr.warehousing_ids) AS warehousing_name,
        (SELECT w2.warehouse_name FROM warehouse w2 WHERE w2.warehouse_id = hr.retrieval_ids) AS retrieval_name,
        (SELECT s.supplier_name FROM supplier s WHERE hr.supplier_ids = s.supplier_id) AS supplier_name,
        (SELECT c.customer_name FROM customer c WHERE hr.customer_ids = c.customer_id) AS customer_name,
        p.product_code, p.product_name, p.producer, p.inventory_qty, pt.product_type_name
        FROM head_receipt hr
        JOIN detail_receipt dr ON dr.systematic_receipt = hr.systematic_receipt
        JOIN product p ON p.product_id = dr.product_id
        JOIN product_type pt ON pt.product_type_id = p.product_type
        WHERE hr.systematic_receipt = ''${systematicReceipt}''', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', '1', '', 'mysql', '', '');
INSERT INTO jimu_report_db VALUES('983365946278879232', '983365946211770368', 'admin', 'admin', '2024-08-11 17:06:22', '2024-08-11 17:06:22', 'headReceipt', '单据头信息', '0', NULL, 'SELECT
        hr.systematic_receipt, hr.original_receipt, hr.invoice_date, hr.receipt_notes, hr.deposit, hr.total_amount, 
        hr.capitalize_total_amount, hr.review_comments, hr.create_by, hr.create_time, hr.update_by, hr.update_time,
        (SELECT w1.warehouse_name FROM warehouse w1 WHERE w1.warehouse_id = hr.warehousing_ids) AS warehousing_name,
        (SELECT w2.warehouse_name FROM warehouse w2 WHERE w2.warehouse_id = hr.retrieval_ids) AS retrieval_name,
        (SELECT s.supplier_name FROM supplier s WHERE hr.supplier_ids = s.supplier_id) AS supplier_name,
        (SELECT c.customer_name FROM customer c WHERE hr.customer_ids = c.customer_id) AS customer_name,
        su.user_name
        FROM head_receipt hr
        JOIN sys_user su ON su.user_id = hr.user_ids
        WHERE hr.systematic_receipt = ''${systematicReceipt}''', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', '', 'mysql', '', '');
INSERT INTO jimu_report_db VALUES('983365947130322944', '983365946211770368', 'admin', 'admin', '2024-08-11 17:17:10', '2024-08-11 17:17:10', 'detailReceipt', '单据明细信息', '0', NULL, 'SELECT
        dr.systematic_receipt, dr.current_inventory, dr.actual_inventory, dr.plan_quantity, dr.univalence, dr.discount, 
        dr.money, dr.cost, dr.remarks, dr.product_specifications, dr.measure_unit,
        (SELECT w1.warehouse_name FROM warehouse w1 WHERE w1.warehouse_id = hr.warehousing_ids) AS warehousing_name,
        (SELECT w2.warehouse_name FROM warehouse w2 WHERE w2.warehouse_id = hr.retrieval_ids) AS retrieval_name,
        (SELECT s.supplier_name FROM supplier s WHERE hr.supplier_ids = s.supplier_id) AS supplier_name,
        (SELECT c.customer_name FROM customer c WHERE hr.customer_ids = c.customer_id) AS customer_name,
        p.product_code, p.product_name, p.producer, p.inventory_qty, pt.product_type_name
        FROM head_receipt hr
        JOIN detail_receipt dr ON dr.systematic_receipt = hr.systematic_receipt
        JOIN product p ON p.product_id = dr.product_id
        JOIN product_type pt ON pt.product_type_id = p.product_type
        WHERE hr.systematic_receipt = ''${systematicReceipt}''', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', '0', '', 'mysql', '', '');
INSERT INTO jimu_report_db VALUES('983365983868231680', '983365983805317120', 'admin', 'admin', '2024-08-11 17:06:22', '2024-08-11 17:06:22', 'headReceipt', '单据头信息', '0', NULL, 'SELECT
        hr.systematic_receipt, hr.original_receipt, hr.invoice_date, hr.receipt_notes, hr.deposit, hr.total_amount, 
        hr.capitalize_total_amount, hr.review_comments, hr.create_by, hr.create_time, hr.update_by, hr.update_time,
        (SELECT w1.warehouse_name FROM warehouse w1 WHERE w1.warehouse_id = hr.warehousing_ids) AS warehousing_name,
        (SELECT w2.warehouse_name FROM warehouse w2 WHERE w2.warehouse_id = hr.retrieval_ids) AS retrieval_name,
        (SELECT s.supplier_name FROM supplier s WHERE hr.supplier_ids = s.supplier_id) AS supplier_name,
        (SELECT c.customer_name FROM customer c WHERE hr.customer_ids = c.customer_id) AS customer_name,
        su.user_name
        FROM head_receipt hr
        JOIN sys_user su ON su.user_id = hr.user_ids
        WHERE hr.systematic_receipt = ''${systematicReceipt}''', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', '', 'mysql', '', '');
INSERT INTO jimu_report_db VALUES('983365984702898176', '983365983805317120', 'admin', 'admin', '2024-08-11 17:17:10', '2024-08-11 17:17:10', 'detailReceipt', '单据明细信息', '0', NULL, 'SELECT
        dr.systematic_receipt, dr.current_inventory, dr.actual_inventory, dr.plan_quantity, dr.univalence, dr.discount, 
        dr.money, dr.cost, dr.remarks, dr.product_specifications, dr.measure_unit,
        (SELECT w1.warehouse_name FROM warehouse w1 WHERE w1.warehouse_id = hr.warehousing_ids) AS warehousing_name,
        (SELECT w2.warehouse_name FROM warehouse w2 WHERE w2.warehouse_id = hr.retrieval_ids) AS retrieval_name,
        (SELECT s.supplier_name FROM supplier s WHERE hr.supplier_ids = s.supplier_id) AS supplier_name,
        (SELECT c.customer_name FROM customer c WHERE hr.customer_ids = c.customer_id) AS customer_name,
        p.product_code, p.product_name, p.producer, p.inventory_qty, pt.product_type_name
        FROM head_receipt hr
        JOIN detail_receipt dr ON dr.systematic_receipt = hr.systematic_receipt
        JOIN product p ON p.product_id = dr.product_id
        JOIN product_type pt ON pt.product_type_id = p.product_type
        WHERE hr.systematic_receipt = ''${systematicReceipt}''', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', '0', '', 'mysql', '', '');
INSERT INTO jimu_report_db VALUES('983706957387603968', '983365946211770368', 'admin', 'admin', '2024-08-14 22:27:57', '2024-08-14 22:27:57', 'headEngineering', '家装头信息', '0', NULL, 'SELECT
        he.systematic_receipt, he.original_receipt, he.invoice_date,
        he.receipt_notes, he.deposit, he.total_amount, he.capitalize_total_amount,
        he.review_comments, he.create_by, he.create_time, he.update_by, he.update_time, su.user_name,
        (SELECT w1.warehouse_name FROM warehouse w1 WHERE w1.warehouse_id = he.warehousing_ids) AS warehousing_name,
        (SELECT w2.warehouse_name FROM warehouse w2 WHERE w2.warehouse_id = he.retrieval_ids) AS retrieval_name,
        (SELECT s.supplier_name FROM supplier s WHERE he.supplier_ids = s.supplier_id) AS supplier_name,
        (SELECT c.customer_name FROM customer c WHERE he.customer_ids = c.customer_id) AS customer_name
        FROM head_engineering he
        JOIN sys_user su ON su.user_id = he.user_ids
        WHERE he.systematic_receipt = ''${systematicReceipt}''', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', '', 'mysql', '', '');
INSERT INTO jimu_report_db VALUES('983708141288628224', '983365946211770368', 'admin', NULL, '2024-08-14 22:31:47', '2024-08-14 22:31:47', 'detailEngineering', '家装明细信息', '0', NULL, 'SELECT
        ds.systematic_receipt, ds.plan_quantity, ds.univalence, ds.discount, ds.money, ds.cost,
        ds.remarks, ds.product_specifications, ds.measure_unit,
        p.product_code, p.product_name, p.producer, p.inventory_qty, pt.product_type_name, su.user_name,
        (SELECT w1.warehouse_name FROM warehouse w1 WHERE w1.warehouse_id = he.warehousing_ids) AS warehousing_name,
        (SELECT w2.warehouse_name FROM warehouse w2 WHERE w2.warehouse_id = he.retrieval_ids) AS retrieval_name,
        (SELECT s.supplier_name FROM supplier s WHERE he.supplier_ids = s.supplier_id) AS supplier_name,
        (SELECT c.customer_name FROM customer c WHERE he.customer_ids = c.customer_id) AS customer_name
        FROM head_engineering he
        JOIN detail_engineering ds ON ds.systematic_receipt = he.systematic_receipt
        JOIN product p ON p.product_id = ds.product_id
        JOIN sys_user su ON su.user_id = he.user_ids
        JOIN product_type pt ON pt.product_type_id = p.product_type
        WHERE he.systematic_receipt = ''${systematicReceipt}''', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', '1', '', 'mysql', '', '');
INSERT INTO jimu_report_db VALUES('983709598914125824', '983365983805317120', 'admin', 'admin', '2024-08-14 22:37:35', '2024-08-14 22:37:35', 'headAfterSales', '售后头信息', '0', NULL, 'SELECT
        hs.systematic_receipt, hs.original_receipt, hs.invoice_date, hs.receipt_notes, hs.deposit, hs.total_amount, 
        hs.capitalize_total_amount, hs.installer, hs.review_comments, hs.create_by, hs.create_time, hs.update_by, 
        hs.update_time, su.user_name,
        (SELECT w1.warehouse_name FROM warehouse w1 WHERE w1.warehouse_id = hs.warehousing_ids) AS warehousing_name,
        (SELECT w2.warehouse_name FROM warehouse w2 WHERE w2.warehouse_id = hs.retrieval_ids) AS retrieval_name,
        (SELECT s.supplier_name FROM supplier s WHERE hs.supplier_ids = s.supplier_id) AS supplier_name,
        (SELECT c.customer_name FROM customer c WHERE hs.customer_ids = c.customer_id) AS customer_name
        FROM head_service hs
        JOIN sys_user su ON su.user_id = hs.user_ids
        WHERE hs.systematic_receipt = ''${systematicReceipt}''', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0', '0', '', 'mysql', '', '');
INSERT INTO jimu_report_db VALUES('983710282757644288', '983365983805317120', 'admin', NULL, '2024-08-14 22:40:18', '2024-08-14 22:40:18', 'detailAfterSales', '售后明细信息', '0', NULL, 'SELECT
        ds.systematic_receipt, ds.plan_quantity, ds.univalence, ds.discount, ds.money, ds.cost,
        ds.remarks, ds.product_specifications, ds.measure_unit, p.product_code, p.product_name, p.producer,
        p.inventory_qty, pt.product_type_name, su.user_name,
        (SELECT w1.warehouse_name FROM warehouse w1 WHERE w1.warehouse_id = hs.warehousing_ids) AS warehousing_name,
        (SELECT w2.warehouse_name FROM warehouse w2 WHERE w2.warehouse_id = hs.retrieval_ids) AS retrieval_name,
        (SELECT s.supplier_name FROM supplier s WHERE hs.supplier_ids = s.supplier_id) AS supplier_name,
        (SELECT c.customer_name FROM customer c WHERE hs.customer_ids = c.customer_id) AS customer_name
        FROM head_service hs
        JOIN detail_service ds ON ds.systematic_receipt = hs.systematic_receipt
        JOIN product p ON p.product_id = ds.product_id
        JOIN sys_user su ON su.user_id = hs.user_ids
        JOIN product_type pt ON pt.product_type_id = p.product_type
        WHERE hs.systematic_receipt = ''${systematicReceipt}''', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', '1', '', 'mysql', '', '');
-- ----------------------------
-- 32、报表字段明细
-- ----------------------------
DROP TABLE IF EXISTS `jimu_report_db_field`;
CREATE TABLE `jimu_report_db_field`  (
  `id` 					varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'id',
  `create_by` 			varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人登录名称',
  `create_time` 		datetime NULL DEFAULT NULL COMMENT '创建日期',
  `update_by` 			varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人登录名称',
  `update_time` 		datetime NULL DEFAULT NULL COMMENT '更新日期',
  `jimu_report_db_id` 	varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据源ID',
  `field_name` 			varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字段名',
  `field_text` 			varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字段文本',
  `widget_type` 		varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '控件类型',
  `widget_width` 		int(10) NULL DEFAULT NULL COMMENT '控件宽度',
  `order_num` 			int(3) NULL DEFAULT NULL COMMENT '排序',
  `search_flag` 		int(3) NULL DEFAULT 0 COMMENT '查询标识0否1是 默认0',
  `search_mode` 		int(3) NULL DEFAULT NULL COMMENT '查询模式1简单2范围',
  `dict_code` 			varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典编码支持从表中取数据',
  `search_value` 		varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '查询默认值',
  `search_format` 		varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '查询时间格式化表达式',
  `ext_json` 			text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '参数配置',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_jrdf_jimu_report_db_id`(`jimu_report_db_id`) USING BTREE,
  INDEX `idx_dbfield_order_num`(`order_num`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '报表字段明细' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- 初始化-报表字段明细表数据
-- ----------------------------
INSERT INTO jimu_report_db_field VALUES('957638707546349568', 'admin', '2024-06-04 00:01:10', NULL, NULL, '957638707491823616', 'systematic_receipt', '系统单号', 'String', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957638707584098304', 'admin', '2024-06-04 00:01:10', NULL, NULL, '957638707491823616', 'original_receipt', '原始单号', 'String', NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957638707684761600', 'admin', '2024-06-04 00:01:10', NULL, NULL, '957638707491823616', 'invoice_date', '开单日期', 'String', NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957638707772841984', 'admin', '2024-06-04 00:01:10', NULL, NULL, '957638707491823616', 'receipt_notes', '备注', 'String', NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957638707789619200', 'admin', '2024-06-04 00:01:10', NULL, NULL, '957638707491823616', 'create_by', '创建者', 'String', NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957638707802202112', 'admin', '2024-06-04 00:01:10', NULL, NULL, '957638707491823616', 'create_time', '创建时间', 'String', NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957638707814785024', 'admin', '2024-06-04 00:01:10', NULL, NULL, '957638707491823616', 'update_by', '更新者', 'String', NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957638707835756544', 'admin', '2024-06-04 00:01:10', NULL, NULL, '957638707491823616', 'update_time', '更新时间', 'String', NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957987275691974656', 'admin', '2024-06-04 23:06:15', NULL, NULL, '957638707491823616', 'user_name', '经手人', 'String', NULL, 8, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957987275842969600', 'admin', '2024-06-04 23:06:15', NULL, NULL, '957638707491823616', 'customer_name', '客户名称', 'String', NULL, 9, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957987695860572160', 'admin', '2024-06-04 23:07:55', NULL, NULL, '957987695822823424', 'systematic_receipt', '系统单号', 'String', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957987695982206976', 'admin', '2024-06-04 23:07:55', NULL, NULL, '957987695822823424', 'current_inventory', '当前库存量', 'String', NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957987695994789888', 'admin', '2024-06-04 23:07:56', NULL, NULL, '957987695822823424', 'actual_inventory', '实际库存量', 'String', NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957987696028344320', 'admin', '2024-06-04 23:07:56', NULL, NULL, '957987695822823424', 'plan_quantity', '数量', 'String', NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957987696040927232', 'admin', '2024-06-04 23:07:56', NULL, NULL, '957987695822823424', 'univalence', '单价', 'String', NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957987696053510144', 'admin', '2024-06-04 23:07:56', NULL, NULL, '957987695822823424', 'discount', '折扣', 'String', NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957987696066093056', 'admin', '2024-06-04 23:07:56', NULL, NULL, '957987695822823424', 'money', '金额', 'String', NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957987696103841792', 'admin', '2024-06-04 23:07:56', NULL, NULL, '957987695822823424', 'cost', '成本', 'String', NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957987696124813312', 'admin', '2024-06-04 23:07:56', NULL, NULL, '957987695822823424', 'remarks', '备注', 'String', NULL, 8, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957987696141590528', 'admin', '2024-06-04 23:07:56', NULL, NULL, '957987695822823424', 'product_code', '货品编码', 'String', NULL, 9, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957987696212893696', 'admin', '2024-06-04 23:07:56', NULL, NULL, '957987695822823424', 'product_name', '货品名称', 'String', NULL, 10, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957987696242253824', 'admin', '2024-06-04 23:07:56', NULL, NULL, '957987695822823424', 'product_specifications', '商品规格', 'String', NULL, 11, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957987696254836736', 'admin', '2024-06-04 23:07:56', NULL, NULL, '957987695822823424', 'measure_unit', '单位', 'String', NULL, 12, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957987696267419648', 'admin', '2024-06-04 23:07:56', NULL, NULL, '957987695822823424', 'producer', '产地', 'String', NULL, 13, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('959088554749124608', 'admin', '2024-06-08 00:02:21', NULL, NULL, '957638707491823616', 'deposit', '定金', 'String', NULL, 10, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('959088554761707520', 'admin', '2024-06-08 00:02:21', NULL, NULL, '957638707491823616', 'total_amount', '总金额', 'String', NULL, 11, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('959088554782679040', 'admin', '2024-06-08 00:02:21', NULL, NULL, '957638707491823616', 'capitalize_total_amount', '总金额（大写）', 'String', NULL, 12, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982539084346630144', 'admin', '2024-08-11 17:06:23', NULL, NULL, '957638707491823616', 'review_comments', '审核意见', 'String', NULL, 13, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982539084409544704', 'admin', '2024-08-11 17:06:23', NULL, NULL, '957638707491823616', 'warehousing_name', '调入仓库名称', 'String', NULL, 14, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982539084455682048', 'admin', '2024-08-11 17:06:23', NULL, NULL, '957638707491823616', 'retrieval_name', '调出仓库名称', 'String', NULL, 15, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982539084497625088', 'admin', '2024-08-11 17:06:23', NULL, NULL, '957638707491823616', 'supplier_name', '供应商名称', 'String', NULL, 16, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982541799613210624', 'admin', '2024-08-11 17:17:10', NULL, NULL, '957987695822823424', 'warehousing_name', '调入仓库名称', 'String', NULL, 14, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982541799663542272', 'admin', '2024-08-11 17:17:10', NULL, NULL, '957987695822823424', 'retrieval_name', '调出仓库名称', 'String', NULL, 15, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982541799697096704', 'admin', '2024-08-11 17:17:10', NULL, NULL, '957987695822823424', 'supplier_name', '供应商名称', 'String', NULL, 16, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982541799734845440', 'admin', '2024-08-11 17:17:10', NULL, NULL, '957987695822823424', 'customer_name', '客户名称', 'String', NULL, 17, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982541799772594176', 'admin', '2024-08-11 17:17:10', NULL, NULL, '957987695822823424', 'inventory_qty', '库存数量', 'String', NULL, 18, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982541799810342912', 'admin', '2024-08-11 17:17:10', NULL, NULL, '957987695822823424', 'product_type_name', '货品类型', 'String', NULL, 19, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982943988936548352', 'admin', '2024-06-04 00:01:10', NULL, NULL, '982943988802330624', 'systematic_receipt', '系统单号', 'String', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982943989020434432', 'admin', '2024-06-04 00:01:10', NULL, NULL, '982943988802330624', 'original_receipt', '原始单号', 'String', NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982943989095931904', 'admin', '2024-06-04 00:01:10', NULL, NULL, '982943988802330624', 'invoice_date', '开单日期', 'String', NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982943989167235072', 'admin', '2024-06-04 00:01:10', NULL, NULL, '982943988802330624', 'receipt_notes', '备注', 'String', NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982943989225955328', 'admin', '2024-06-04 00:01:10', NULL, NULL, '982943988802330624', 'create_by', '创建者', 'String', NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982943989288869888', 'admin', '2024-06-04 00:01:10', NULL, NULL, '982943988802330624', 'create_time', '创建时间', 'String', NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982943989351784448', 'admin', '2024-06-04 00:01:10', NULL, NULL, '982943988802330624', 'update_by', '更新者', 'String', NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982943989410504704', 'admin', '2024-06-04 00:01:10', NULL, NULL, '982943988802330624', 'update_time', '更新时间', 'String', NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982943989481807872', 'admin', '2024-06-04 23:06:15', NULL, NULL, '982943988802330624', 'user_name', '经手人', 'String', NULL, 8, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982943989557305344', 'admin', '2024-06-04 23:06:15', NULL, NULL, '982943988802330624', 'customer_name', '客户名称', 'String', NULL, 9, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982943989620219904', 'admin', '2024-06-08 00:02:21', NULL, NULL, '982943988802330624', 'deposit', '定金', 'String', NULL, 10, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982943989678940160', 'admin', '2024-06-08 00:02:21', NULL, NULL, '982943988802330624', 'total_amount', '总金额', 'String', NULL, 11, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982943989746049024', 'admin', '2024-06-08 00:02:21', NULL, NULL, '982943988802330624', 'capitalize_total_amount', '总金额（大写）', 'String', NULL, 12, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982943989813157888', 'admin', '2024-08-11 17:06:23', NULL, NULL, '982943988802330624', 'review_comments', '审核意见', 'String', NULL, 13, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982943989880266752', 'admin', '2024-08-11 17:06:23', NULL, NULL, '982943988802330624', 'warehousing_name', '调入仓库名称', 'String', NULL, 14, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982943989955764224', 'admin', '2024-08-11 17:06:23', NULL, NULL, '982943988802330624', 'retrieval_name', '调出仓库名称', 'String', NULL, 15, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982943990022873088', 'admin', '2024-08-11 17:06:23', NULL, NULL, '982943988802330624', 'supplier_name', '供应商名称', 'String', NULL, 16, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982943990274531328', 'admin', '2024-06-04 23:07:55', NULL, NULL, '982943990199033856', 'systematic_receipt', '系统单号', 'String', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982943990320668672', 'admin', '2024-06-04 23:07:55', NULL, NULL, '982943990199033856', 'current_inventory', '当前库存量', 'String', NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982943990375194624', 'admin', '2024-06-04 23:07:56', NULL, NULL, '982943990199033856', 'actual_inventory', '实际库存量', 'String', NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982943990425526272', 'admin', '2024-06-04 23:07:56', NULL, NULL, '982943990199033856', 'plan_quantity', '数量', 'String', NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982943990480052224', 'admin', '2024-06-04 23:07:56', NULL, NULL, '982943990199033856', 'univalence', '单价', 'String', NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982943990534578176', 'admin', '2024-06-04 23:07:56', NULL, NULL, '982943990199033856', 'discount', '折扣', 'String', NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982943990580715520', 'admin', '2024-06-04 23:07:56', NULL, NULL, '982943990199033856', 'money', '金额', 'String', NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982943990626852864', 'admin', '2024-06-04 23:07:56', NULL, NULL, '982943990199033856', 'cost', '成本', 'String', NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982943990672990208', 'admin', '2024-06-04 23:07:56', NULL, NULL, '982943990199033856', 'remarks', '备注', 'String', NULL, 8, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982943990723321856', 'admin', '2024-06-04 23:07:56', NULL, NULL, '982943990199033856', 'product_code', '货品编码', 'String', NULL, 9, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982943990773653504', 'admin', '2024-06-04 23:07:56', NULL, NULL, '982943990199033856', 'product_name', '货品名称', 'String', NULL, 10, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982943990828179456', 'admin', '2024-06-04 23:07:56', NULL, NULL, '982943990199033856', 'product_specifications', '商品规格', 'String', NULL, 11, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982943990870122496', 'admin', '2024-06-04 23:07:56', NULL, NULL, '982943990199033856', 'measure_unit', '单位', 'String', NULL, 12, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982943990916259840', 'admin', '2024-06-04 23:07:56', NULL, NULL, '982943990199033856', 'producer', '产地', 'String', NULL, 13, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982943990966591488', 'admin', '2024-08-11 17:17:10', NULL, NULL, '982943990199033856', 'warehousing_name', '调入仓库名称', 'String', NULL, 14, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982943991021117440', 'admin', '2024-08-11 17:17:10', NULL, NULL, '982943990199033856', 'retrieval_name', '调出仓库名称', 'String', NULL, 15, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982943991067254784', 'admin', '2024-08-11 17:17:10', NULL, NULL, '982943990199033856', 'supplier_name', '供应商名称', 'String', NULL, 16, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982943991113392128', 'admin', '2024-08-11 17:17:10', NULL, NULL, '982943990199033856', 'customer_name', '客户名称', 'String', NULL, 17, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982943991163723776', 'admin', '2024-08-11 17:17:10', NULL, NULL, '982943990199033856', 'inventory_qty', '库存数量', 'String', NULL, 18, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982943991201472512', 'admin', '2024-08-11 17:17:10', NULL, NULL, '982943990199033856', 'product_type_name', '货品类型', 'String', NULL, 19, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982960588897067008', 'admin', '2024-08-12 21:01:17', NULL, NULL, '982960588796403712', 'systematic_order_form', '系统单号', 'String', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982960588959981568', 'admin', '2024-08-12 21:01:17', NULL, NULL, '982960588796403712', 'original_order_form', '原始单号', 'String', NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982960589018701824', 'admin', '2024-08-12 21:01:17', NULL, NULL, '982960588796403712', 'order_date', '订货日期', 'String', NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982960589073227776', 'admin', '2024-08-12 21:01:17', NULL, NULL, '982960588796403712', 'delivery_date', '开单日期', 'String', NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982960589127753728', 'admin', '2024-08-12 21:01:17', NULL, NULL, '982960588796403712', 'plan_receipt', '计划单号', 'String', NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982960589190668288', 'admin', '2024-08-12 21:01:17', NULL, NULL, '982960588796403712', 'order_form_notes', '备注', 'String', NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982960589257777152', 'admin', '2024-08-12 21:01:17', NULL, NULL, '982960588796403712', 'deposit', '定金', 'String', NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982960589320691712', 'admin', '2024-08-12 21:01:17', NULL, NULL, '982960588796403712', 'order_form_amount', '总金额', 'String', NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982960589375217664', 'admin', '2024-08-12 21:01:17', NULL, NULL, '982960588796403712', 'order_capitalize_amount', '总金额（大写）', 'String', NULL, 8, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982960589433937920', 'admin', '2024-08-12 21:01:17', NULL, NULL, '982960588796403712', 'review_comments', '审核意见', 'String', NULL, 9, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982960589492658176', 'admin', '2024-08-12 21:01:17', NULL, NULL, '982960588796403712', 'create_by', '创建者', 'String', NULL, 10, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982960589547184128', 'admin', '2024-08-12 21:01:17', NULL, NULL, '982960588796403712', 'create_time', '创建时间', 'String', NULL, 11, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982960589601710080', 'admin', '2024-08-12 21:01:17', NULL, NULL, '982960588796403712', 'update_by', '更新者', 'String', NULL, 12, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982960589656236032', 'admin', '2024-08-12 21:01:17', NULL, NULL, '982960588796403712', 'update_time', '更新时间', 'String', NULL, 13, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982960589710761984', 'admin', '2024-08-12 21:01:17', NULL, NULL, '982960588796403712', 'user_name', '经手人名称', 'String', NULL, 14, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982960589761093632', 'admin', '2024-08-12 21:01:17', NULL, NULL, '982960588796403712', 'warehousing_name', '调入仓库名称', 'String', NULL, 15, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982960589807230976', 'admin', '2024-08-12 21:01:17', NULL, NULL, '982960588796403712', 'retrieval_name', '调出仓库名称', 'String', NULL, 16, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982960589861756928', 'admin', '2024-08-12 21:01:17', NULL, NULL, '982960588796403712', 'supplier_name', '供应商名称', 'String', NULL, 17, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982960589916282880', 'admin', '2024-08-12 21:01:17', NULL, NULL, '982960588796403712', 'customer_name', '客户名称', 'String', NULL, 18, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982963349906726912', 'admin', '2024-08-12 21:12:15', NULL, NULL, '982963349839618048', 'systematic_order_form', '系统单号', 'String', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982963349952864256', 'admin', '2024-08-12 21:12:15', NULL, NULL, '982963349839618048', 'plan_quantity', '数量', 'String', NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982963349999001600', 'admin', '2024-08-12 21:12:15', NULL, NULL, '982963349839618048', 'univalence', '单价', 'String', NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982963350074499072', 'admin', '2024-08-12 21:12:15', NULL, NULL, '982963349839618048', 'discount', '折扣', 'String', NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982963350116442112', 'admin', '2024-08-12 21:12:15', NULL, NULL, '982963349839618048', 'money', '金额', 'String', NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982963350154190848', 'admin', '2024-08-12 21:12:15', NULL, NULL, '982963349839618048', 'cost', '成本', 'String', NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982963350191939584', 'admin', '2024-08-12 21:12:15', NULL, NULL, '982963349839618048', 'remarks', '备注', 'String', NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982963350225494016', 'admin', '2024-08-12 21:12:16', NULL, NULL, '982963349839618048', 'product_specifications', '商品规格', 'String', NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982963350271631360', 'admin', '2024-08-12 21:12:16', NULL, NULL, '982963349839618048', 'measure_unit', '计量单位', 'String', NULL, 8, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982963350305185792', 'admin', '2024-08-12 21:12:16', NULL, NULL, '982963349839618048', 'product_code', '货品编号', 'String', NULL, 9, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982963350351323136', 'admin', '2024-08-12 21:12:16', NULL, NULL, '982963349839618048', 'product_name', '货品名称', 'String', NULL, 10, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982963350389071872', 'admin', '2024-08-12 21:12:16', NULL, NULL, '982963349839618048', 'producer', '产地', 'String', NULL, 11, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982963350435209216', 'admin', '2024-08-12 21:12:16', NULL, NULL, '982963349839618048', 'inventory_qty', '库存数量', 'String', NULL, 12, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982963350468763648', 'admin', '2024-08-12 21:12:16', NULL, NULL, '982963349839618048', 'product_type_name', '商品类型', 'String', NULL, 13, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982963350506512384', 'admin', '2024-08-12 21:12:16', NULL, NULL, '982963349839618048', 'user_name', '经手人名称', 'String', NULL, 14, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982963350540066816', 'admin', '2024-08-12 21:12:16', NULL, NULL, '982963349839618048', 'warehousing_name', '调入仓库名称', 'String', NULL, 15, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982963350582009856', 'admin', '2024-08-12 21:12:16', NULL, NULL, '982963349839618048', 'retrieval_name', '调出仓库名称', 'String', NULL, 16, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982963350691061760', 'admin', '2024-08-12 21:12:16', NULL, NULL, '982963349839618048', 'supplier_name', '供应商名称', 'String', NULL, 17, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('982963350720421888', 'admin', '2024-08-12 21:12:16', NULL, NULL, '982963349839618048', 'customer_name', '客户名称', 'String', NULL, 18, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362128598212608', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983362128434634752', 'systematic_receipt', '系统单号', 'String', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362128711458816', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983362128434634752', 'original_receipt', '原始单号', 'String', NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362128799539200', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983362128434634752', 'invoice_date', '开单日期', 'String', NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362128883425280', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983362128434634752', 'receipt_notes', '备注', 'String', NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362128967311360', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983362128434634752', 'create_by', '创建者', 'String', NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362129042808832', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983362128434634752', 'create_time', '创建时间', 'String', NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362129130889216', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983362128434634752', 'update_by', '更新者', 'String', NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362129218969600', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983362128434634752', 'update_time', '更新时间', 'String', NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362129307049984', 'admin', '2024-06-04 23:06:15', NULL, NULL, '983362128434634752', 'user_name', '经手人', 'String', NULL, 8, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362129399324672', 'admin', '2024-06-04 23:06:15', NULL, NULL, '983362128434634752', 'customer_name', '客户名称', 'String', NULL, 9, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362129479016448', 'admin', '2024-06-08 00:02:21', NULL, NULL, '983362128434634752', 'deposit', '定金', 'String', NULL, 10, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362129558708224', 'admin', '2024-06-08 00:02:21', NULL, NULL, '983362128434634752', 'total_amount', '总金额', 'String', NULL, 11, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362129630011392', 'admin', '2024-06-08 00:02:21', NULL, NULL, '983362128434634752', 'capitalize_total_amount', '总金额（大写）', 'String', NULL, 12, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362129697120256', 'admin', '2024-08-11 17:06:23', NULL, NULL, '983362128434634752', 'review_comments', '审核意见', 'String', NULL, 13, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362129751646208', 'admin', '2024-08-11 17:06:23', NULL, NULL, '983362128434634752', 'warehousing_name', '调入仓库名称', 'String', NULL, 14, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362129810366464', 'admin', '2024-08-11 17:06:23', NULL, NULL, '983362128434634752', 'retrieval_name', '调出仓库名称', 'String', NULL, 15, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362129860698112', 'admin', '2024-08-11 17:06:23', NULL, NULL, '983362128434634752', 'supplier_name', '供应商名称', 'String', NULL, 16, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362130082996224', 'admin', '2024-06-04 23:07:55', NULL, NULL, '983362130011693056', 'systematic_receipt', '系统单号', 'String', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362130133327872', 'admin', '2024-06-04 23:07:55', NULL, NULL, '983362130011693056', 'current_inventory', '当前库存量', 'String', NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362130187853824', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983362130011693056', 'actual_inventory', '实际库存量', 'String', NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362130238185472', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983362130011693056', 'plan_quantity', '数量', 'String', NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362130284322816', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983362130011693056', 'univalence', '单价', 'String', NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362130326265856', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983362130011693056', 'discount', '折扣', 'String', NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362130368208896', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983362130011693056', 'money', '金额', 'String', NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362130414346240', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983362130011693056', 'cost', '成本', 'String', NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362130460483584', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983362130011693056', 'remarks', '备注', 'String', NULL, 8, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362130502426624', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983362130011693056', 'product_code', '货品编码', 'String', NULL, 9, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362130544369664', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983362130011693056', 'product_name', '货品名称', 'String', NULL, 10, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362130590507008', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983362130011693056', 'product_specifications', '商品规格', 'String', NULL, 11, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362130632450048', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983362130011693056', 'measure_unit', '单位', 'String', NULL, 12, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362130670198784', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983362130011693056', 'producer', '产地', 'String', NULL, 13, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362130712141824', 'admin', '2024-08-11 17:17:10', NULL, NULL, '983362130011693056', 'warehousing_name', '调入仓库名称', 'String', NULL, 14, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362130762473472', 'admin', '2024-08-11 17:17:10', NULL, NULL, '983362130011693056', 'retrieval_name', '调出仓库名称', 'String', NULL, 15, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362130808610816', 'admin', '2024-08-11 17:17:10', NULL, NULL, '983362130011693056', 'supplier_name', '供应商名称', 'String', NULL, 16, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362130854748160', 'admin', '2024-08-11 17:17:10', NULL, NULL, '983362130011693056', 'customer_name', '客户名称', 'String', NULL, 17, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362130905079808', 'admin', '2024-08-11 17:17:10', NULL, NULL, '983362130011693056', 'inventory_qty', '库存数量', 'String', NULL, 18, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362130955411456', 'admin', '2024-08-11 17:17:10', NULL, NULL, '983362130011693056', 'product_type_name', '货品类型', 'String', NULL, 19, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362131123183616', 'admin', '2024-08-12 21:01:17', NULL, NULL, '983362131064463360', 'systematic_order_form', '系统单号', 'String', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362131160932352', 'admin', '2024-08-12 21:01:17', NULL, NULL, '983362131064463360', 'original_order_form', '原始单号', 'String', NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362131202875392', 'admin', '2024-08-12 21:01:17', NULL, NULL, '983362131064463360', 'order_date', '订货日期', 'String', NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362131236429824', 'admin', '2024-08-12 21:01:17', NULL, NULL, '983362131064463360', 'delivery_date', '开单日期', 'String', NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362131274178560', 'admin', '2024-08-12 21:01:17', NULL, NULL, '983362131064463360', 'plan_receipt', '计划单号', 'String', NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362131311927296', 'admin', '2024-08-12 21:01:17', NULL, NULL, '983362131064463360', 'order_form_notes', '备注', 'String', NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362131358064640', 'admin', '2024-08-12 21:01:17', NULL, NULL, '983362131064463360', 'deposit', '定金', 'String', NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362131400007680', 'admin', '2024-08-12 21:01:17', NULL, NULL, '983362131064463360', 'order_form_amount', '总金额', 'String', NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362131500670976', 'admin', '2024-08-12 21:01:17', NULL, NULL, '983362131064463360', 'order_capitalize_amount', '总金额（大写）', 'String', NULL, 8, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362131542614016', 'admin', '2024-08-12 21:01:17', NULL, NULL, '983362131064463360', 'review_comments', '审核意见', 'String', NULL, 9, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362131588751360', 'admin', '2024-08-12 21:01:17', NULL, NULL, '983362131064463360', 'create_by', '创建者', 'String', NULL, 10, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362131630694400', 'admin', '2024-08-12 21:01:17', NULL, NULL, '983362131064463360', 'create_time', '创建时间', 'String', NULL, 11, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362131676831744', 'admin', '2024-08-12 21:01:17', NULL, NULL, '983362131064463360', 'update_by', '更新者', 'String', NULL, 12, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362131718774784', 'admin', '2024-08-12 21:01:17', NULL, NULL, '983362131064463360', 'update_time', '更新时间', 'String', NULL, 13, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362131764912128', 'admin', '2024-08-12 21:01:17', NULL, NULL, '983362131064463360', 'user_name', '经手人名称', 'String', NULL, 14, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362131802660864', 'admin', '2024-08-12 21:01:17', NULL, NULL, '983362131064463360', 'warehousing_name', '调入仓库名称', 'String', NULL, 15, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362131848798208', 'admin', '2024-08-12 21:01:17', NULL, NULL, '983362131064463360', 'retrieval_name', '调出仓库名称', 'String', NULL, 16, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362131886546944', 'admin', '2024-08-12 21:01:17', NULL, NULL, '983362131064463360', 'supplier_name', '供应商名称', 'String', NULL, 17, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362131924295680', 'admin', '2024-08-12 21:01:17', NULL, NULL, '983362131064463360', 'customer_name', '客户名称', 'String', NULL, 18, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362132079484928', 'admin', '2024-08-12 21:12:15', NULL, NULL, '983362132024958976', 'systematic_order_form', '系统单号', 'String', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362132125622272', 'admin', '2024-08-12 21:12:15', NULL, NULL, '983362132024958976', 'plan_quantity', '数量', 'String', NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362132163371008', 'admin', '2024-08-12 21:12:15', NULL, NULL, '983362132024958976', 'univalence', '单价', 'String', NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362132196925440', 'admin', '2024-08-12 21:12:15', NULL, NULL, '983362132024958976', 'discount', '折扣', 'String', NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362132234674176', 'admin', '2024-08-12 21:12:15', NULL, NULL, '983362132024958976', 'money', '金额', 'String', NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362132272422912', 'admin', '2024-08-12 21:12:15', NULL, NULL, '983362132024958976', 'cost', '成本', 'String', NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362132310171648', 'admin', '2024-08-12 21:12:15', NULL, NULL, '983362132024958976', 'remarks', '备注', 'String', NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362132402446336', 'admin', '2024-08-12 21:12:16', NULL, NULL, '983362132024958976', 'product_specifications', '商品规格', 'String', NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362132448583680', 'admin', '2024-08-12 21:12:16', NULL, NULL, '983362132024958976', 'measure_unit', '计量单位', 'String', NULL, 8, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362132482138112', 'admin', '2024-08-12 21:12:16', NULL, NULL, '983362132024958976', 'product_code', '货品编号', 'String', NULL, 9, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362132515692544', 'admin', '2024-08-12 21:12:16', NULL, NULL, '983362132024958976', 'product_name', '货品名称', 'String', NULL, 10, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362132549246976', 'admin', '2024-08-12 21:12:16', NULL, NULL, '983362132024958976', 'producer', '产地', 'String', NULL, 11, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362132578607104', 'admin', '2024-08-12 21:12:16', NULL, NULL, '983362132024958976', 'inventory_qty', '库存数量', 'String', NULL, 12, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362132612161536', 'admin', '2024-08-12 21:12:16', NULL, NULL, '983362132024958976', 'product_type_name', '商品类型', 'String', NULL, 13, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362132645715968', 'admin', '2024-08-12 21:12:16', NULL, NULL, '983362132024958976', 'user_name', '经手人名称', 'String', NULL, 14, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362132683464704', 'admin', '2024-08-12 21:12:16', NULL, NULL, '983362132024958976', 'warehousing_name', '调入仓库名称', 'String', NULL, 15, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362132792516608', 'admin', '2024-08-12 21:12:16', NULL, NULL, '983362132024958976', 'retrieval_name', '调出仓库名称', 'String', NULL, 16, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362132830265344', 'admin', '2024-08-12 21:12:16', NULL, NULL, '983362132024958976', 'supplier_name', '供应商名称', 'String', NULL, 17, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362132859625472', 'admin', '2024-08-12 21:12:16', NULL, NULL, '983362132024958976', 'customer_name', '客户名称', 'String', NULL, 18, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362413089464320', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983362413034938368', 'systematic_receipt', '系统单号', 'String', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362413127213056', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983362413034938368', 'original_receipt', '原始单号', 'String', NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362413164961792', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983362413034938368', 'invoice_date', '开单日期', 'String', NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362413211099136', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983362413034938368', 'receipt_notes', '备注', 'String', NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362413244653568', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983362413034938368', 'create_by', '创建者', 'String', NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362413274013696', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983362413034938368', 'create_time', '创建时间', 'String', NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362413307568128', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983362413034938368', 'update_by', '更新者', 'String', NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362413341122560', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983362413034938368', 'update_time', '更新时间', 'String', NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362413408231424', 'admin', '2024-06-04 23:06:15', NULL, NULL, '983362413034938368', 'user_name', '经手人', 'String', NULL, 8, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362413479534592', 'admin', '2024-06-04 23:06:15', NULL, NULL, '983362413034938368', 'customer_name', '客户名称', 'String', NULL, 9, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362413517283328', 'admin', '2024-06-08 00:02:21', NULL, NULL, '983362413034938368', 'deposit', '定金', 'String', NULL, 10, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362413550837760', 'admin', '2024-06-08 00:02:21', NULL, NULL, '983362413034938368', 'total_amount', '总金额', 'String', NULL, 11, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362413588586496', 'admin', '2024-06-08 00:02:21', NULL, NULL, '983362413034938368', 'capitalize_total_amount', '总金额（大写）', 'String', NULL, 12, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362413617946624', 'admin', '2024-08-11 17:06:23', NULL, NULL, '983362413034938368', 'review_comments', '审核意见', 'String', NULL, 13, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362413655695360', 'admin', '2024-08-11 17:06:23', NULL, NULL, '983362413034938368', 'warehousing_name', '调入仓库名称', 'String', NULL, 14, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362413689249792', 'admin', '2024-08-11 17:06:23', NULL, NULL, '983362413034938368', 'retrieval_name', '调出仓库名称', 'String', NULL, 15, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362413806690304', 'admin', '2024-08-11 17:06:23', NULL, NULL, '983362413034938368', 'supplier_name', '供应商名称', 'String', NULL, 16, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362413945102336', 'admin', '2024-06-04 23:07:55', NULL, NULL, '983362413898964992', 'systematic_receipt', '系统单号', 'String', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362413974462464', 'admin', '2024-06-04 23:07:55', NULL, NULL, '983362413898964992', 'current_inventory', '当前库存量', 'String', NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362414003822592', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983362413898964992', 'actual_inventory', '实际库存量', 'String', NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362414049959936', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983362413898964992', 'plan_quantity', '数量', 'String', NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362414079320064', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983362413898964992', 'univalence', '单价', 'String', NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362414117068800', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983362413898964992', 'discount', '折扣', 'String', NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362414171594752', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983362413898964992', 'money', '金额', 'String', NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362414259675136', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983362413898964992', 'cost', '成本', 'String', NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362414301618176', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983362413898964992', 'remarks', '备注', 'String', NULL, 8, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362414339366912', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983362413898964992', 'product_code', '货品编码', 'String', NULL, 9, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362414377115648', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983362413898964992', 'product_name', '货品名称', 'String', NULL, 10, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362414410670080', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983362413898964992', 'product_specifications', '商品规格', 'String', NULL, 11, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362414444224512', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983362413898964992', 'measure_unit', '单位', 'String', NULL, 12, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362414477778944', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983362413898964992', 'producer', '产地', 'String', NULL, 13, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362414586830848', 'admin', '2024-08-11 17:17:10', NULL, NULL, '983362413898964992', 'warehousing_name', '调入仓库名称', 'String', NULL, 14, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362414616190976', 'admin', '2024-08-11 17:17:10', NULL, NULL, '983362413898964992', 'retrieval_name', '调出仓库名称', 'String', NULL, 15, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362414645551104', 'admin', '2024-08-11 17:17:10', NULL, NULL, '983362413898964992', 'supplier_name', '供应商名称', 'String', NULL, 16, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362414674911232', 'admin', '2024-08-11 17:17:10', NULL, NULL, '983362413898964992', 'customer_name', '客户名称', 'String', NULL, 17, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362414700077056', 'admin', '2024-08-11 17:17:10', NULL, NULL, '983362413898964992', 'inventory_qty', '库存数量', 'String', NULL, 18, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983362414729437184', 'admin', '2024-08-11 17:17:10', NULL, NULL, '983362413898964992', 'product_type_name', '货品类型', 'String', NULL, 19, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363237765128192', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983363237651881984', 'systematic_receipt', '系统单号', 'String', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363237849014272', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983363237651881984', 'original_receipt', '原始单号', 'String', NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363237890957312', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983363237651881984', 'invoice_date', '开单日期', 'String', NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363237928706048', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983363237651881984', 'receipt_notes', '备注', 'String', NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363237995814912', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983363237651881984', 'create_by', '创建者', 'String', NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363238033563648', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983363237651881984', 'create_time', '创建时间', 'String', NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363238062923776', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983363237651881984', 'update_by', '更新者', 'String', NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363238088089600', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983363237651881984', 'update_time', '更新时间', 'String', NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363238121644032', 'admin', '2024-06-04 23:06:15', NULL, NULL, '983363237651881984', 'user_name', '经手人', 'String', NULL, 8, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363238151004160', 'admin', '2024-06-04 23:06:15', NULL, NULL, '983363237651881984', 'customer_name', '客户名称', 'String', NULL, 9, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363238180364288', 'admin', '2024-06-08 00:02:21', NULL, NULL, '983363237651881984', 'deposit', '定金', 'String', NULL, 10, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363238293610496', 'admin', '2024-06-08 00:02:21', NULL, NULL, '983363237651881984', 'total_amount', '总金额', 'String', NULL, 11, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363238322970624', 'admin', '2024-06-08 00:02:21', NULL, NULL, '983363237651881984', 'capitalize_total_amount', '总金额（大写）', 'String', NULL, 12, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363238343942144', 'admin', '2024-08-11 17:06:23', NULL, NULL, '983363237651881984', 'review_comments', '审核意见', 'String', NULL, 13, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363238394273792', 'admin', '2024-08-11 17:06:23', NULL, NULL, '983363237651881984', 'warehousing_name', '调入仓库名称', 'String', NULL, 14, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363238469771264', 'admin', '2024-08-11 17:06:23', NULL, NULL, '983363237651881984', 'retrieval_name', '调出仓库名称', 'String', NULL, 15, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363238520102912', 'admin', '2024-08-11 17:06:23', NULL, NULL, '983363237651881984', 'supplier_name', '供应商名称', 'String', NULL, 16, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363238683680768', 'admin', '2024-06-04 23:07:55', NULL, NULL, '983363238620766208', 'systematic_receipt', '系统单号', 'String', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363238717235200', 'admin', '2024-06-04 23:07:55', NULL, NULL, '983363238620766208', 'current_inventory', '当前库存量', 'String', NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363238750789632', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983363238620766208', 'actual_inventory', '实际库存量', 'String', NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363238788538368', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983363238620766208', 'plan_quantity', '数量', 'String', NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363238826287104', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983363238620766208', 'univalence', '单价', 'String', NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363238864035840', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983363238620766208', 'discount', '折扣', 'String', NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363238977282048', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983363238620766208', 'money', '金额', 'String', NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363239015030784', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983363238620766208', 'cost', '成本', 'String', NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363239048585216', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983363238620766208', 'remarks', '备注', 'String', NULL, 8, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363239082139648', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983363238620766208', 'product_code', '货品编码', 'String', NULL, 9, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363239115694080', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983363238620766208', 'product_name', '货品名称', 'String', NULL, 10, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363239153442816', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983363238620766208', 'product_specifications', '商品规格', 'String', NULL, 11, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363239245717504', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983363238620766208', 'measure_unit', '单位', 'String', NULL, 12, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363239279271936', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983363238620766208', 'producer', '产地', 'String', NULL, 13, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363239308632064', 'admin', '2024-08-11 17:17:10', NULL, NULL, '983363238620766208', 'warehousing_name', '调入仓库名称', 'String', NULL, 14, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363239333797888', 'admin', '2024-08-11 17:17:10', NULL, NULL, '983363238620766208', 'retrieval_name', '调出仓库名称', 'String', NULL, 15, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363239363158016', 'admin', '2024-08-11 17:17:10', NULL, NULL, '983363238620766208', 'supplier_name', '供应商名称', 'String', NULL, 16, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363239392518144', 'admin', '2024-08-11 17:17:10', NULL, NULL, '983363238620766208', 'customer_name', '客户名称', 'String', NULL, 17, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363239497375744', 'admin', '2024-08-11 17:17:10', NULL, NULL, '983363238620766208', 'inventory_qty', '库存数量', 'String', NULL, 18, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363239526735872', 'admin', '2024-08-11 17:17:10', NULL, NULL, '983363238620766208', 'product_type_name', '货品类型', 'String', NULL, 19, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363618096226304', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983363618054283264', 'systematic_receipt', '系统单号', 'String', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363618133975040', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983363618054283264', 'original_receipt', '原始单号', 'String', NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363618163335168', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983363618054283264', 'invoice_date', '开单日期', 'String', NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363618192695296', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983363618054283264', 'receipt_notes', '备注', 'String', NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363618217861120', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983363618054283264', 'create_by', '创建者', 'String', NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363618331107328', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983363618054283264', 'create_time', '创建时间', 'String', NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363618356273152', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983363618054283264', 'update_by', '更新者', 'String', NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363618381438976', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983363618054283264', 'update_time', '更新时间', 'String', NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363618414993408', 'admin', '2024-06-04 23:06:15', NULL, NULL, '983363618054283264', 'user_name', '经手人', 'String', NULL, 8, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363618444353536', 'admin', '2024-06-04 23:06:15', NULL, NULL, '983363618054283264', 'customer_name', '客户名称', 'String', NULL, 9, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363618473713664', 'admin', '2024-06-08 00:02:21', NULL, NULL, '983363618054283264', 'deposit', '定金', 'String', NULL, 10, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363618528239616', 'admin', '2024-06-08 00:02:21', NULL, NULL, '983363618054283264', 'total_amount', '总金额', 'String', NULL, 11, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363618607931392', 'admin', '2024-06-08 00:02:21', NULL, NULL, '983363618054283264', 'capitalize_total_amount', '总金额（大写）', 'String', NULL, 12, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363618633097216', 'admin', '2024-08-11 17:06:23', NULL, NULL, '983363618054283264', 'review_comments', '审核意见', 'String', NULL, 13, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363618662457344', 'admin', '2024-08-11 17:06:23', NULL, NULL, '983363618054283264', 'warehousing_name', '调入仓库名称', 'String', NULL, 14, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363618691817472', 'admin', '2024-08-11 17:06:23', NULL, NULL, '983363618054283264', 'retrieval_name', '调出仓库名称', 'String', NULL, 15, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363618721177600', 'admin', '2024-08-11 17:06:23', NULL, NULL, '983363618054283264', 'supplier_name', '供应商名称', 'String', NULL, 16, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363618914115584', 'admin', '2024-06-04 23:07:55', NULL, NULL, '983363618872172544', 'systematic_receipt', '系统单号', 'String', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363618939281408', 'admin', '2024-06-04 23:07:55', NULL, NULL, '983363618872172544', 'current_inventory', '当前库存量', 'String', NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363618964447232', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983363618872172544', 'actual_inventory', '实际库存量', 'String', NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363618993807360', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983363618872172544', 'plan_quantity', '数量', 'String', NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363619048333312', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983363618872172544', 'univalence', '单价', 'String', NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363619115442176', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983363618872172544', 'discount', '折扣', 'String', NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363619144802304', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983363618872172544', 'money', '金额', 'String', NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363619169968128', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983363618872172544', 'cost', '成本', 'String', NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363619199328256', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983363618872172544', 'remarks', '备注', 'String', NULL, 8, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363619228688384', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983363618872172544', 'product_code', '货品编码', 'String', NULL, 9, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363619258048512', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983363618872172544', 'product_name', '货品名称', 'String', NULL, 10, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363619371294720', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983363618872172544', 'product_specifications', '商品规格', 'String', NULL, 11, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363619396460544', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983363618872172544', 'measure_unit', '单位', 'String', NULL, 12, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363619425820672', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983363618872172544', 'producer', '产地', 'String', NULL, 13, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363619450986496', 'admin', '2024-08-11 17:17:10', NULL, NULL, '983363618872172544', 'warehousing_name', '调入仓库名称', 'String', NULL, 14, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363619480346624', 'admin', '2024-08-11 17:17:10', NULL, NULL, '983363618872172544', 'retrieval_name', '调出仓库名称', 'String', NULL, 15, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363619505512448', 'admin', '2024-08-11 17:17:10', NULL, NULL, '983363618872172544', 'supplier_name', '供应商名称', 'String', NULL, 16, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363619622952960', 'admin', '2024-08-11 17:17:10', NULL, NULL, '983363618872172544', 'customer_name', '客户名称', 'String', NULL, 17, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363619656507392', 'admin', '2024-08-11 17:17:10', NULL, NULL, '983363618872172544', 'inventory_qty', '库存数量', 'String', NULL, 18, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363619681673216', 'admin', '2024-08-11 17:17:10', NULL, NULL, '983363618872172544', 'product_type_name', '货品类型', 'String', NULL, 19, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363836661407744', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983363836606881792', 'systematic_receipt', '系统单号', 'String', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363836694962176', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983363836606881792', 'original_receipt', '原始单号', 'String', NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363836728516608', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983363836606881792', 'invoice_date', '开单日期', 'String', NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363836762071040', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983363836606881792', 'receipt_notes', '备注', 'String', NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363836837568512', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983363836606881792', 'create_by', '创建者', 'String', NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363836892094464', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983363836606881792', 'create_time', '创建时间', 'String', NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363836921454592', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983363836606881792', 'update_by', '更新者', 'String', NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363836950814720', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983363836606881792', 'update_time', '更新时间', 'String', NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363837064060928', 'admin', '2024-06-04 23:06:15', NULL, NULL, '983363836606881792', 'user_name', '经手人', 'String', NULL, 8, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363837093421056', 'admin', '2024-06-04 23:06:15', NULL, NULL, '983363836606881792', 'customer_name', '客户名称', 'String', NULL, 9, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363837118586880', 'admin', '2024-06-08 00:02:21', NULL, NULL, '983363836606881792', 'deposit', '定金', 'String', NULL, 10, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363837147947008', 'admin', '2024-06-08 00:02:21', NULL, NULL, '983363836606881792', 'total_amount', '总金额', 'String', NULL, 11, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363837177307136', 'admin', '2024-06-08 00:02:21', NULL, NULL, '983363836606881792', 'capitalize_total_amount', '总金额（大写）', 'String', NULL, 12, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363837215055872', 'admin', '2024-08-11 17:06:23', NULL, NULL, '983363836606881792', 'review_comments', '审核意见', 'String', NULL, 13, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363837332496384', 'admin', '2024-08-11 17:06:23', NULL, NULL, '983363836606881792', 'warehousing_name', '调入仓库名称', 'String', NULL, 14, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363837357662208', 'admin', '2024-08-11 17:06:23', NULL, NULL, '983363836606881792', 'retrieval_name', '调出仓库名称', 'String', NULL, 15, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363837382828032', 'admin', '2024-08-11 17:06:23', NULL, NULL, '983363836606881792', 'supplier_name', '供应商名称', 'String', NULL, 16, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363837517045760', 'admin', '2024-06-04 23:07:55', NULL, NULL, '983363837462519808', 'systematic_receipt', '系统单号', 'String', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363837546405888', 'admin', '2024-06-04 23:07:55', NULL, NULL, '983363837462519808', 'current_inventory', '当前库存量', 'String', NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363837605126144', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983363837462519808', 'actual_inventory', '实际库存量', 'String', NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363837680623616', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983363837462519808', 'plan_quantity', '数量', 'String', NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363837714178048', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983363837462519808', 'univalence', '单价', 'String', NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363837743538176', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983363837462519808', 'discount', '折扣', 'String', NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363837789675520', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983363837462519808', 'money', '金额', 'String', NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363837823229952', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983363837462519808', 'cost', '成本', 'String', NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363837852590080', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983363837462519808', 'remarks', '备注', 'String', NULL, 8, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363837881950208', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983363837462519808', 'product_code', '货品编码', 'String', NULL, 9, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363837919698944', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983363837462519808', 'product_name', '货品名称', 'String', NULL, 10, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363838020362240', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983363837462519808', 'product_specifications', '商品规格', 'String', NULL, 11, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363838058110976', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983363837462519808', 'measure_unit', '单位', 'String', NULL, 12, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363838091665408', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983363837462519808', 'producer', '产地', 'String', NULL, 13, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363838125219840', 'admin', '2024-08-11 17:17:10', NULL, NULL, '983363837462519808', 'warehousing_name', '调入仓库名称', 'String', NULL, 14, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363838150385664', 'admin', '2024-08-11 17:17:10', NULL, NULL, '983363837462519808', 'retrieval_name', '调出仓库名称', 'String', NULL, 15, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363838183940096', 'admin', '2024-08-11 17:17:10', NULL, NULL, '983363837462519808', 'supplier_name', '供应商名称', 'String', NULL, 16, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363838280409088', 'admin', '2024-08-11 17:17:10', NULL, NULL, '983363837462519808', 'customer_name', '客户名称', 'String', NULL, 17, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363838309769216', 'admin', '2024-08-11 17:17:10', NULL, NULL, '983363837462519808', 'inventory_qty', '库存数量', 'String', NULL, 18, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363838347517952', 'admin', '2024-08-11 17:17:10', NULL, NULL, '983363837462519808', 'product_type_name', '货品类型', 'String', NULL, 19, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363988264525824', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983363988218388480', 'systematic_receipt', '系统单号', 'String', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363988293885952', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983363988218388480', 'original_receipt', '原始单号', 'String', NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363988323246080', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983363988218388480', 'invoice_date', '开单日期', 'String', NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363988352606208', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983363988218388480', 'receipt_notes', '备注', 'String', NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363988381966336', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983363988218388480', 'create_by', '创建者', 'String', NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363988482629632', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983363988218388480', 'create_time', '创建时间', 'String', NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363988516184064', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983363988218388480', 'update_by', '更新者', 'String', NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363988541349888', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983363988218388480', 'update_time', '更新时间', 'String', NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363988570710016', 'admin', '2024-06-04 23:06:15', NULL, NULL, '983363988218388480', 'user_name', '经手人', 'String', NULL, 8, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363988600070144', 'admin', '2024-06-04 23:06:15', NULL, NULL, '983363988218388480', 'customer_name', '客户名称', 'String', NULL, 9, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363988629430272', 'admin', '2024-06-08 00:02:21', NULL, NULL, '983363988218388480', 'deposit', '定金', 'String', NULL, 10, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363988662984704', 'admin', '2024-06-08 00:02:21', NULL, NULL, '983363988218388480', 'total_amount', '总金额', 'String', NULL, 11, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363988767842304', 'admin', '2024-06-08 00:02:21', NULL, NULL, '983363988218388480', 'capitalize_total_amount', '总金额（大写）', 'String', NULL, 12, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363988793008128', 'admin', '2024-08-11 17:06:23', NULL, NULL, '983363988218388480', 'review_comments', '审核意见', 'String', NULL, 13, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363988822368256', 'admin', '2024-08-11 17:06:23', NULL, NULL, '983363988218388480', 'warehousing_name', '调入仓库名称', 'String', NULL, 14, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363988847534080', 'admin', '2024-08-11 17:06:23', NULL, NULL, '983363988218388480', 'retrieval_name', '调出仓库名称', 'String', NULL, 15, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363988876894208', 'admin', '2024-08-11 17:06:23', NULL, NULL, '983363988218388480', 'supplier_name', '供应商名称', 'String', NULL, 16, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363989078220800', 'admin', '2024-06-04 23:07:55', NULL, NULL, '983363989032083456', 'systematic_receipt', '系统单号', 'String', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363989103386624', 'admin', '2024-06-04 23:07:55', NULL, NULL, '983363989032083456', 'current_inventory', '当前库存量', 'String', NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363989132746752', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983363989032083456', 'actual_inventory', '实际库存量', 'String', NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363989162106880', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983363989032083456', 'plan_quantity', '数量', 'String', NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363989271158784', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983363989032083456', 'univalence', '单价', 'String', NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363989296324608', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983363989032083456', 'discount', '折扣', 'String', NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363989321490432', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983363989032083456', 'money', '金额', 'String', NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363989355044864', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983363989032083456', 'cost', '成本', 'String', NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363989459902464', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983363989032083456', 'remarks', '备注', 'String', NULL, 8, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363989489262592', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983363989032083456', 'product_code', '货品编码', 'String', NULL, 9, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363989518622720', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983363989032083456', 'product_name', '货品名称', 'String', NULL, 10, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363989547982848', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983363989032083456', 'product_specifications', '商品规格', 'String', NULL, 11, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363989577342976', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983363989032083456', 'measure_unit', '单位', 'String', NULL, 12, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363989610897408', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983363989032083456', 'producer', '产地', 'String', NULL, 13, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363989719949312', 'admin', '2024-08-11 17:17:10', NULL, NULL, '983363989032083456', 'warehousing_name', '调入仓库名称', 'String', NULL, 14, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363989753503744', 'admin', '2024-08-11 17:17:10', NULL, NULL, '983363989032083456', 'retrieval_name', '调出仓库名称', 'String', NULL, 15, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363989782863872', 'admin', '2024-08-11 17:17:10', NULL, NULL, '983363989032083456', 'supplier_name', '供应商名称', 'String', NULL, 16, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363989812224000', 'admin', '2024-08-11 17:17:10', NULL, NULL, '983363989032083456', 'customer_name', '客户名称', 'String', NULL, 17, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363989841584128', 'admin', '2024-08-11 17:17:10', NULL, NULL, '983363989032083456', 'inventory_qty', '库存数量', 'String', NULL, 18, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983363989879332864', 'admin', '2024-08-11 17:17:10', NULL, NULL, '983363989032083456', 'product_type_name', '货品类型', 'String', NULL, 19, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365946320822272', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983365946278879232', 'systematic_receipt', '系统单号', 'String', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365946379542528', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983365946278879232', 'original_receipt', '原始单号', 'String', NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365946404708352', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983365946278879232', 'invoice_date', '开单日期', 'String', NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365946429874176', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983365946278879232', 'receipt_notes', '备注', 'String', NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365946455040000', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983365946278879232', 'create_by', '创建者', 'String', NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365946559897600', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983365946278879232', 'create_time', '创建时间', 'String', NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365946585063424', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983365946278879232', 'update_by', '更新者', 'String', NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365946606034944', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983365946278879232', 'update_time', '更新时间', 'String', NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365946643783680', 'admin', '2024-06-04 23:06:15', NULL, NULL, '983365946278879232', 'user_name', '经手人', 'String', NULL, 8, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365946736058368', 'admin', '2024-06-04 23:06:15', NULL, NULL, '983365946278879232', 'customer_name', '客户名称', 'String', NULL, 9, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365946761224192', 'admin', '2024-06-08 00:02:21', NULL, NULL, '983365946278879232', 'deposit', '定金', 'String', NULL, 10, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365946786390016', 'admin', '2024-06-08 00:02:21', NULL, NULL, '983365946278879232', 'total_amount', '总金额', 'String', NULL, 11, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365946815750144', 'admin', '2024-06-08 00:02:21', NULL, NULL, '983365946278879232', 'capitalize_total_amount', '总金额（大写）', 'String', NULL, 12, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365946912219136', 'admin', '2024-08-11 17:06:23', NULL, NULL, '983365946278879232', 'review_comments', '审核意见', 'String', NULL, 13, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365946937384960', 'admin', '2024-08-11 17:06:23', NULL, NULL, '983365946278879232', 'warehousing_name', '调入仓库名称', 'String', NULL, 14, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365946962550784', 'admin', '2024-08-11 17:06:23', NULL, NULL, '983365946278879232', 'retrieval_name', '调出仓库名称', 'String', NULL, 15, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365947008688128', 'admin', '2024-08-11 17:06:23', NULL, NULL, '983365946278879232', 'supplier_name', '供应商名称', 'String', NULL, 16, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365947172265984', 'admin', '2024-06-04 23:07:55', NULL, NULL, '983365947130322944', 'systematic_receipt', '系统单号', 'String', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365947201626112', 'admin', '2024-06-04 23:07:55', NULL, NULL, '983365947130322944', 'current_inventory', '当前库存量', 'String', NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365947226791936', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983365947130322944', 'actual_inventory', '实际库存量', 'String', NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365947310678016', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983365947130322944', 'plan_quantity', '数量', 'String', NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365947348426752', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983365947130322944', 'univalence', '单价', 'String', NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365947373592576', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983365947130322944', 'discount', '折扣', 'String', NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365947402952704', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983365947130322944', 'money', '金额', 'String', NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365947507810304', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983365947130322944', 'cost', '成本', 'String', NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365947537170432', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983365947130322944', 'remarks', '备注', 'String', NULL, 8, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365947562336256', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983365947130322944', 'product_code', '货品编码', 'String', NULL, 9, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365947591696384', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983365947130322944', 'product_name', '货品名称', 'String', NULL, 10, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365947696553984', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983365947130322944', 'product_specifications', '商品规格', 'String', NULL, 11, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365947721719808', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983365947130322944', 'measure_unit', '单位', 'String', NULL, 12, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365947746885632', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983365947130322944', 'producer', '产地', 'String', NULL, 13, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365947809800192', 'admin', '2024-08-11 17:17:10', NULL, NULL, '983365947130322944', 'warehousing_name', '调入仓库名称', 'String', NULL, 14, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365947872714752', 'admin', '2024-08-11 17:17:10', NULL, NULL, '983365947130322944', 'retrieval_name', '调出仓库名称', 'String', NULL, 15, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365947897880576', 'admin', '2024-08-11 17:17:10', NULL, NULL, '983365947130322944', 'supplier_name', '供应商名称', 'String', NULL, 16, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365947923046400', 'admin', '2024-08-11 17:17:10', NULL, NULL, '983365947130322944', 'customer_name', '客户名称', 'String', NULL, 17, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365948036292608', 'admin', '2024-08-11 17:17:10', NULL, NULL, '983365947130322944', 'inventory_qty', '库存数量', 'String', NULL, 18, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365948061458432', 'admin', '2024-08-11 17:17:10', NULL, NULL, '983365947130322944', 'product_type_name', '货品类型', 'String', NULL, 19, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365983905980416', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983365983868231680', 'systematic_receipt', '系统单号', 'String', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365983935340544', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983365983868231680', 'original_receipt', '原始单号', 'String', NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365983964700672', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983365983868231680', 'invoice_date', '开单日期', 'String', NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365983989866496', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983365983868231680', 'receipt_notes', '备注', 'String', NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365984015032320', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983365983868231680', 'create_by', '创建者', 'String', NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365984040198144', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983365983868231680', 'create_time', '创建时间', 'String', NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365984145055744', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983365983868231680', 'update_by', '更新者', 'String', NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365984174415872', 'admin', '2024-06-04 00:01:10', NULL, NULL, '983365983868231680', 'update_time', '更新时间', 'String', NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365984199581696', 'admin', '2024-06-04 23:06:15', NULL, NULL, '983365983868231680', 'user_name', '经手人', 'String', NULL, 8, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365984224747520', 'admin', '2024-06-04 23:06:15', NULL, NULL, '983365983868231680', 'customer_name', '客户名称', 'String', NULL, 9, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365984329605120', 'admin', '2024-06-08 00:02:21', NULL, NULL, '983365983868231680', 'deposit', '定金', 'String', NULL, 10, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365984354770944', 'admin', '2024-06-08 00:02:21', NULL, NULL, '983365983868231680', 'total_amount', '总金额', 'String', NULL, 11, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365984379936768', 'admin', '2024-06-08 00:02:21', NULL, NULL, '983365983868231680', 'capitalize_total_amount', '总金额（大写）', 'String', NULL, 12, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365984413491200', 'admin', '2024-08-11 17:06:23', NULL, NULL, '983365983868231680', 'review_comments', '审核意见', 'String', NULL, 13, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365984505765888', 'admin', '2024-08-11 17:06:23', NULL, NULL, '983365983868231680', 'warehousing_name', '调入仓库名称', 'String', NULL, 14, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365984530931712', 'admin', '2024-08-11 17:06:23', NULL, NULL, '983365983868231680', 'retrieval_name', '调出仓库名称', 'String', NULL, 15, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365984551903232', 'admin', '2024-08-11 17:06:23', NULL, NULL, '983365983868231680', 'supplier_name', '供应商名称', 'String', NULL, 16, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365984749035520', 'admin', '2024-06-04 23:07:55', NULL, NULL, '983365984702898176', 'systematic_receipt', '系统单号', 'String', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365984778395648', 'admin', '2024-06-04 23:07:55', NULL, NULL, '983365984702898176', 'current_inventory', '当前库存量', 'String', NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365984803561472', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983365984702898176', 'actual_inventory', '实际库存量', 'String', NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365984828727296', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983365984702898176', 'plan_quantity', '数量', 'String', NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365984946167808', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983365984702898176', 'univalence', '单价', 'String', NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365984971333632', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983365984702898176', 'discount', '折扣', 'String', NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365985000693760', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983365984702898176', 'money', '金额', 'String', NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365985025859584', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983365984702898176', 'cost', '成本', 'String', NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365985055219712', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983365984702898176', 'remarks', '备注', 'String', NULL, 8, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365985076191232', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983365984702898176', 'product_code', '货品编码', 'String', NULL, 9, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365985172660224', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983365984702898176', 'product_name', '货品名称', 'String', NULL, 10, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365985210408960', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983365984702898176', 'product_specifications', '商品规格', 'String', NULL, 11, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365985235574784', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983365984702898176', 'measure_unit', '单位', 'String', NULL, 12, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365985277517824', 'admin', '2024-06-04 23:07:56', NULL, NULL, '983365984702898176', 'producer', '产地', 'String', NULL, 13, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365985373986816', 'admin', '2024-08-11 17:17:10', NULL, NULL, '983365984702898176', 'warehousing_name', '调入仓库名称', 'String', NULL, 14, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365985411735552', 'admin', '2024-08-11 17:17:10', NULL, NULL, '983365984702898176', 'retrieval_name', '调出仓库名称', 'String', NULL, 15, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365985436901376', 'admin', '2024-08-11 17:17:10', NULL, NULL, '983365984702898176', 'supplier_name', '供应商名称', 'String', NULL, 16, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365985491427328', 'admin', '2024-08-11 17:17:10', NULL, NULL, '983365984702898176', 'customer_name', '客户名称', 'String', NULL, 17, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365985520787456', 'admin', '2024-08-11 17:17:10', NULL, NULL, '983365984702898176', 'inventory_qty', '库存数量', 'String', NULL, 18, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983365985550147584', 'admin', '2024-08-11 17:17:10', NULL, NULL, '983365984702898176', 'product_type_name', '货品类型', 'String', NULL, 19, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983706957601513472', 'admin', '2024-08-14 22:27:05', NULL, NULL, '983706957387603968', 'original_receipt', '原始单号', 'String', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983706957727342592', 'admin', '2024-08-14 22:27:05', NULL, NULL, '983706957387603968', 'create_time', '创建时间', 'String', NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983706957836394496', 'admin', '2024-08-14 22:27:05', NULL, NULL, '983706957387603968', 'user_name', '经手人名称', 'String', NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983706957945446400', 'admin', '2024-08-14 22:27:05', NULL, NULL, '983706957387603968', 'review_comments', '审核意见', 'String', NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983706958046109696', 'admin', '2024-08-14 22:27:05', NULL, NULL, '983706957387603968', 'warehousing_name', '调入仓库名称', 'String', NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983706958142578688', 'admin', '2024-08-14 22:27:05', NULL, NULL, '983706957387603968', 'invoice_date', '开单日期', 'String', NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983706958230659072', 'admin', '2024-08-14 22:27:05', NULL, NULL, '983706957387603968', 'capitalize_total_amount', '总金额（大写）', 'String', NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983706958343905280', 'admin', '2024-08-14 22:27:06', NULL, NULL, '983706957387603968', 'create_by', '创建人', 'String', NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983706958444568576', 'admin', '2024-08-14 22:27:06', NULL, NULL, '983706957387603968', 'update_time', '更新时间', 'String', NULL, 8, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983706958541037568', 'admin', '2024-08-14 22:27:06', NULL, NULL, '983706957387603968', 'total_amount', '总金额', 'String', NULL, 9, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983706958616535040', 'admin', '2024-08-14 22:27:06', NULL, NULL, '983706957387603968', 'deposit', '定金', 'String', NULL, 10, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983706958700421120', 'admin', '2024-08-14 22:27:06', NULL, NULL, '983706957387603968', 'receipt_notes', '备注', 'String', NULL, 11, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983706958792695808', 'admin', '2024-08-14 22:27:06', NULL, NULL, '983706957387603968', 'customer_name', '客户名称', 'String', NULL, 12, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983706958872387584', 'admin', '2024-08-14 22:27:06', NULL, NULL, '983706957387603968', 'update_by', '更新人', 'String', NULL, 13, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983706958960467968', 'admin', '2024-08-14 22:27:06', NULL, NULL, '983706957387603968', 'supplier_name', '供应商名称', 'String', NULL, 14, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983706959040159744', 'admin', '2024-08-14 22:27:06', NULL, NULL, '983706957387603968', 'systematic_receipt', '系统单号', 'String', NULL, 15, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983706959119851520', 'admin', '2024-08-14 22:27:06', NULL, NULL, '983706957387603968', 'retrieval_name', '调出仓库名称', 'String', NULL, 16, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983708141347348480', 'admin', '2024-08-14 22:31:48', NULL, NULL, '983708141288628224', 'cost', '成本', 'String', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983708141389291520', 'admin', '2024-08-14 22:31:48', NULL, NULL, '983708141288628224', 'univalence', '单价', 'String', NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983708141422845952', 'admin', '2024-08-14 22:31:48', NULL, NULL, '983708141288628224', 'user_name', '经手人名称', 'String', NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983708141456400384', 'admin', '2024-08-14 22:31:48', NULL, NULL, '983708141288628224', 'plan_quantity', '数量', 'String', NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983708141502537728', 'admin', '2024-08-14 22:31:48', NULL, NULL, '983708141288628224', 'discount', '折扣', 'String', NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983708141590618112', 'admin', '2024-08-14 22:31:48', NULL, NULL, '983708141288628224', 'inventory_qty', '库存数量', 'String', NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983708141624172544', 'admin', '2024-08-14 22:31:48', NULL, NULL, '983708141288628224', 'product_code', '货品编号', 'String', NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983708141657726976', 'admin', '2024-08-14 22:31:48', NULL, NULL, '983708141288628224', 'product_name', '货品名称', 'String', NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983708141691281408', 'admin', '2024-08-14 22:31:48', NULL, NULL, '983708141288628224', 'warehousing_name', '调入仓库名称', 'String', NULL, 8, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983708141729030144', 'admin', '2024-08-14 22:31:48', NULL, NULL, '983708141288628224', 'measure_unit', '计量单位', 'String', NULL, 9, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983708141762584576', 'admin', '2024-08-14 22:31:48', NULL, NULL, '983708141288628224', 'money', '金额', 'String', NULL, 10, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983708141800333312', 'admin', '2024-08-14 22:31:48', NULL, NULL, '983708141288628224', 'product_type_name', '货品类型', 'String', NULL, 11, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983708141842276352', 'admin', '2024-08-14 22:31:48', NULL, NULL, '983708141288628224', 'product_specifications', '货品规格', 'String', NULL, 12, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983708141947133952', 'admin', '2024-08-14 22:31:48', NULL, NULL, '983708141288628224', 'producer', '产地', 'String', NULL, 13, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983708141984882688', 'admin', '2024-08-14 22:31:48', NULL, NULL, '983708141288628224', 'customer_name', '客户名称', 'String', NULL, 14, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983708142018437120', 'admin', '2024-08-14 22:31:48', NULL, NULL, '983708141288628224', 'supplier_name', '供应商名称', 'String', NULL, 15, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983708142051991552', 'admin', '2024-08-14 22:31:48', NULL, NULL, '983708141288628224', 'systematic_receipt', '系统单号', 'String', NULL, 16, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983708142089740288', 'admin', '2024-08-14 22:31:48', NULL, NULL, '983708141288628224', 'retrieval_name', '调出仓库名称', 'String', NULL, 17, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983708142123294720', 'admin', '2024-08-14 22:31:48', NULL, NULL, '983708141288628224', 'remarks', '备注', 'String', NULL, 18, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983709598972846080', 'admin', '2024-08-14 22:37:35', NULL, NULL, '983709598914125824', 'original_receipt', '原始单号', 'String', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983709599010594816', 'admin', '2024-08-14 22:37:35', NULL, NULL, '983709598914125824', 'create_time', '创建时间', 'String', NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983709599052537856', 'admin', '2024-08-14 22:37:35', NULL, NULL, '983709598914125824', 'user_name', '经手人名称', 'String', NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983709599081897984', 'admin', '2024-08-14 22:37:35', NULL, NULL, '983709598914125824', 'review_comments', '审核意见', 'String', NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983709599123841024', 'admin', '2024-08-14 22:37:35', NULL, NULL, '983709598914125824', 'warehousing_name', '调入仓库信息', 'String', NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983709599161589760', 'admin', '2024-08-14 22:37:35', NULL, NULL, '983709598914125824', 'invoice_date', '开单日期', 'String', NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983709599195144192', 'admin', '2024-08-14 22:37:35', NULL, NULL, '983709598914125824', 'capitalize_total_amount', '总金额（大写）', 'String', NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983709599228698624', 'admin', '2024-08-14 22:37:35', NULL, NULL, '983709598914125824', 'create_by', '创建人', 'String', NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983709599262253056', 'admin', '2024-08-14 22:37:35', NULL, NULL, '983709598914125824', 'update_time', '更新时间', 'String', NULL, 8, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983709599350333440', 'admin', '2024-08-14 22:37:35', NULL, NULL, '983709598914125824', 'installer', '安装师傅', 'String', NULL, 9, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983709599396470784', 'admin', '2024-08-14 22:37:35', NULL, NULL, '983709598914125824', 'total_amount', '总金额', 'String', NULL, 10, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983709599434219520', 'admin', '2024-08-14 22:37:35', NULL, NULL, '983709598914125824', 'deposit', '定金', 'String', NULL, 11, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983709599476162560', 'admin', '2024-08-14 22:37:35', NULL, NULL, '983709598914125824', 'receipt_notes', '备注', 'String', NULL, 12, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983709599509716992', 'admin', '2024-08-14 22:37:35', NULL, NULL, '983709598914125824', 'customer_name', '客户名称', 'String', NULL, 13, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983709599543271424', 'admin', '2024-08-14 22:37:35', NULL, NULL, '983709598914125824', 'update_by', '更新人', 'String', NULL, 14, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983709599576825856', 'admin', '2024-08-14 22:37:35', NULL, NULL, '983709598914125824', 'supplier_name', '供应商名称', 'String', NULL, 15, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983709599610380288', 'admin', '2024-08-14 22:37:35', NULL, NULL, '983709598914125824', 'systematic_receipt', '系统单号', 'String', NULL, 16, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983709599732015104', 'admin', '2024-08-14 22:37:35', NULL, NULL, '983709598914125824', 'retrieval_name', '调出仓库名称', 'String', NULL, 17, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983710282816364544', 'admin', '2024-08-14 22:40:18', NULL, NULL, '983710282757644288', 'cost', '成本', 'String', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983710282858307584', 'admin', '2024-08-14 22:40:18', NULL, NULL, '983710282757644288', 'univalence', '单价', 'String', NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983710282891862016', 'admin', '2024-08-14 22:40:18', NULL, NULL, '983710282757644288', 'user_name', '经手人名称', 'String', NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983710282933805056', 'admin', '2024-08-14 22:40:18', NULL, NULL, '983710282757644288', 'plan_quantity', '数量', 'String', NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983710282967359488', 'admin', '2024-08-14 22:40:18', NULL, NULL, '983710282757644288', 'discount', '折扣', 'String', NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983710283076411392', 'admin', '2024-08-14 22:40:18', NULL, NULL, '983710282757644288', 'inventory_qty', '库存数量', 'String', NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983710283109965824', 'admin', '2024-08-14 22:40:18', NULL, NULL, '983710282757644288', 'product_code', '货品编号', 'String', NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983710283147714560', 'admin', '2024-08-14 22:40:18', NULL, NULL, '983710282757644288', 'product_name', '货品名称', 'String', NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983710283181268992', 'admin', '2024-08-14 22:40:18', NULL, NULL, '983710282757644288', 'warehousing_name', '调入仓库名称', 'String', NULL, 8, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983710283223212032', 'admin', '2024-08-14 22:40:18', NULL, NULL, '983710282757644288', 'measure_unit', '计量单位', 'String', NULL, 9, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983710283256766464', 'admin', '2024-08-14 22:40:18', NULL, NULL, '983710282757644288', 'money', '金额', 'String', NULL, 10, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983710283298709504', 'admin', '2024-08-14 22:40:18', NULL, NULL, '983710282757644288', 'product_type_name', '货品类型', 'String', NULL, 11, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983710283336458240', 'admin', '2024-08-14 22:40:18', NULL, NULL, '983710282757644288', 'product_specifications', '货品规格', 'String', NULL, 12, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983710283370012672', 'admin', '2024-08-14 22:40:18', NULL, NULL, '983710282757644288', 'producer', '产地', 'String', NULL, 13, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983710283399372800', 'admin', '2024-08-14 22:40:18', NULL, NULL, '983710282757644288', 'customer_name', '客户名称', 'String', NULL, 14, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983710283521007616', 'admin', '2024-08-14 22:40:18', NULL, NULL, '983710282757644288', 'supplier_name', '供应商名称', 'String', NULL, 15, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983710283554562048', 'admin', '2024-08-14 22:40:18', NULL, NULL, '983710282757644288', 'systematic_receipt', '系统单号', 'String', NULL, 16, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983710283592310784', 'admin', '2024-08-14 22:40:18', NULL, NULL, '983710282757644288', 'retrieval_name', '调出仓库名称', 'String', NULL, 17, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('983710283630059520', 'admin', '2024-08-14 22:40:18', NULL, NULL, '983710282757644288', 'remarks', '备注', 'String', NULL, 18, NULL, NULL, NULL, NULL, NULL, NULL);
-- ----------------------------
-- Table structure for jimu_dict
-- ----------------------------
DROP TABLE IF EXISTS `jimu_dict`;
CREATE TABLE `jimu_dict`  (
  `id` 					varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `dict_name` 			varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典名称',
  `dict_code` 			varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典编码',
  `description` 		varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `del_flag` 			int(1) NULL DEFAULT NULL COMMENT '删除状态',
  `create_by` 			varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` 		datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` 			varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` 		datetime NULL DEFAULT NULL COMMENT '更新时间',
  `type` 				int(1) UNSIGNED ZEROFILL NULL DEFAULT 0 COMMENT '字典类型0为string,1为number',
  `tenant_id` 			varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '多租户标识',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_sd_dict_code`(`dict_code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for jimu_dict_item
-- ----------------------------
DROP TABLE IF EXISTS `jimu_dict_item`;
CREATE TABLE `jimu_dict_item`  (
  `id` 					varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `dict_id` 			varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典id',
  `item_text` 			varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典项文本',
  `item_value` 			varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典项值',
  `description` 		varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `sort_order` 			int(10) NULL DEFAULT NULL COMMENT '排序',
  `status` 				int(11) NULL DEFAULT NULL COMMENT '状态（1启用 0不启用）',
  `create_by` 			varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` 		datetime NULL DEFAULT NULL,
  `update_by` 			varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` 		datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_sdi_role_dict_id`(`dict_id`) USING BTREE,
  INDEX `idx_sdi_role_sort_order`(`sort_order`) USING BTREE,
  INDEX `idx_sdi_status`(`status`) USING BTREE,
  INDEX `idx_sdi_dict_val`(`dict_id`, `item_value`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for jimu_report_data_source
-- ----------------------------
DROP TABLE IF EXISTS `jimu_report_data_source`;
CREATE TABLE `jimu_report_data_source`  (
  `id` 					varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `name` 				varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '数据源名称',
  `report_id` 			varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '报表_id',
  `code` 				varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '编码',
  `remark` 				varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `db_type` 			varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '数据库类型',
  `db_driver` 			varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '驱动类',
  `db_url` 				varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '数据源地址',
  `db_username` 		varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `db_password` 		varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '密码',
  `create_by` 			varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` 		datetime NULL DEFAULT NULL COMMENT '创建日期',
  `update_by` 			varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` 		datetime NULL DEFAULT NULL COMMENT '更新日期',
  `connect_times` 		int(1) UNSIGNED NULL DEFAULT 0 COMMENT '连接失败次数',
  `tenant_id` 			varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '多租户标识',
  `type` 				varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '类型(report:报表;drag:仪表盘)',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_jmdatasource_report_id`(`report_id`) USING BTREE,
  INDEX `idx_jmdatasource_code`(`code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '在线excel数据源' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for jimu_report_share
-- ----------------------------
DROP TABLE IF EXISTS `jimu_report_share`;
CREATE TABLE `jimu_report_share`  (
  `id` 					varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '主键',
  `report_id` 			varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '在线excel设计器id',
  `preview_url` 		varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '预览地址',
  `preview_lock` 		varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '密码锁',
  `last_update_time` 	datetime NULL DEFAULT NULL COMMENT '最后更新时间',
  `term_of_validity` 	varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '有效期(0:永久有效，1:1天，2:7天)',
  `status` 				varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否过期(0未过期，1已过期)',
  `preview_lock_status` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '密码锁状态(0不存在密码锁，1存在密码锁)',
  `share_token` 		varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '分享token',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uniq_report_id`(`report_id`) USING BTREE,
  UNIQUE INDEX `uniq_jrs_share_token`(`share_token`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '积木报表预览权限表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for jimu_report_link
-- ----------------------------
DROP TABLE IF EXISTS `jimu_report_link`;
CREATE TABLE `jimu_report_link`  (
  `id` 					varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '主键id',
  `report_id` 			varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '积木设计器id',
  `parameter` 			text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '参数',
  `eject_type` 			varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '弹出方式（0 当前页面 1 新窗口）',
  `link_name` 			varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '链接名称',
  `api_method` 			varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '请求方法0-get,1-post',
  `link_type` 			varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '链接方式(0 网络报表 1 网络连接 2 图表联动)',
  `api_url` 			varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '外网api',
  `link_chart_id` 		varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联动图表的ID',
  `expression` 			varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表达式',
  `requirement` 		varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '条件',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `uniq_link_reportid`(`report_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '超链接配置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for jimu_report_map
-- ----------------------------
DROP TABLE IF EXISTS `jimu_report_map`;
CREATE TABLE `jimu_report_map`  (
  `id` 					varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `label` 				varchar(125) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '地图名称',
  `name` 				varchar(125) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '地图编码',
  `data` 				longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '地图数据',
  `create_by` 			varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` 		datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` 			varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` 		datetime NULL DEFAULT NULL COMMENT '修改时间',
  `del_flag` 			varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '0表示未删除,1表示删除',
  `sys_org_code` 		varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属部门',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uniq_jmreport_map_name`(`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '地图配置表' ROW_FORMAT = DYNAMIC;
