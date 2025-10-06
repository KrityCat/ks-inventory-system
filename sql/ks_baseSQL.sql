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
insert into sys_dept values(100,  0,   '0',          '铠思',   0, 'kc', '15888888888', 'ks@qq.com', '0', '0', 'admin', sysdate(), '', null);

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
insert into sys_menu values(1,  '首页',    0, 1, 'home',         null, '', 1, 0, 'C', '1', '0', '', 'index',           'admin', sysdate(), '', null, '首页');
insert into sys_menu values(2,  '采购管理', 0, 2, 'purchase',     null, '', 1, 0, 'M', '0', '0', '', 'edit',            'admin', sysdate(), '', null, '采购管理目录');
insert into sys_menu values(3,  '销售管理', 0, 3, 'sales',        null, '', 1, 0, 'M', '0', '0', '', 'shopping',        'admin', sysdate(), '', null, '销售管理目录');
insert into sys_menu values(4,  '库存管理', 0, 4, 'inventory',    null, '', 1, 0, 'M', '0', '0', '', 'tab',             'admin', sysdate(), '', null, '库存管理目录');
insert into sys_menu values(5,  '家装工程', 0, 5, 'engineering',  null, '', 1, 0, 'M', '0', '0', '', 'tool',            'admin', sysdate(), '', null, '家装工程目录');
insert into sys_menu values(6,  '售后管理', 0, 6, 'afterSales',   null, '', 1, 0, 'M', '0', '0', '', 'post',            'admin', sysdate(), '', null, '售后管理目录');
insert into sys_menu values(20, '基础数据', 0, 20, 'basedate',    null, '', 1, 0, 'M', '0', '0', '', 'documentation',   'admin', sysdate(), '', null, '基础数据目录');
insert into sys_menu values(21, '打印管理', 0, 21, 'PrintManage', null, '', 1, 0, 'M', '0', '0', '', 'tab',             'admin', sysdate(), '', null, '打印管理目录');
insert into sys_menu values(22, '系统管理', 0, 22, 'system',      null, '', 1, 0, 'M', '0', '0', '', 'system',   			  'admin', sysdate(), '', null, '系统管理目录');
insert into sys_menu values(23, '系统监控', 0, 23, 'monitor',     null, '', 1, 0, 'M', '0', '0', '', 'monitor',  			  'admin', sysdate(), '', null, '系统监控目录');
insert into sys_menu values(24, '系统工具', 0, 24, 'tool',        null, '', 1, 0, 'M', '0', '0', '', 'tool',     			  'admin', sysdate(), '', null, '系统工具目录');
insert into sys_menu values(25, '在线表格', 0, 25, 'excelEditor', 'system/manual/excelEditor',  null, 1, 0, 'C', '0', '0', '', 'excel',       'admin', sysdate(), '', null, '在线表格页面');
insert into sys_menu values(26, '操作手册', 0, 26, 'operating',   'system/manual/operating',    null, 1, 0, 'C', '0', '0', '', 'table',       'admin', sysdate(), '', null, '操作手册页面');
-- 二级菜单
-- 采购管理
insert into sys_menu values(120, '采购订单制作',   2, 1, 'purchaseOrderProcessing',         'system/purchase/purchaseOrderProcessing',            null, 1, 1, 'C', '1', '1', '',                    'shopping', 	'admin', sysdate(), '', null, '');
insert into sys_menu values(121, '采购单据制作',   2, 2, 'purchaseDocumentProcessing',      'system/purchase/purchaseDocumentProcessing',         null, 1, 1, 'C', '0', '0', '',                    'shopping', 	'admin', sysdate(), '', null, '');
insert into sys_menu values(123, '采购订单查询',   2, 4, 'purchaseOrderQuery',              'system/purchase/purchaseOrderQuery',                 null, 1, 0, 'C', '1', '1', '',                    'search', 	'admin', sysdate(), '', null, '');
insert into sys_menu values(124, '采购单据查询',   2, 5, 'purchaseDocumentQuery',           'system/purchase/purchaseDocumentQuery',              null, 1, 0, 'C', '0', '0', '',                    'search', 	'admin', sysdate(), '', null, '');
-- 销售管理
insert into sys_menu values(130, '销售订单制作',   3, 1, 'salesOrderProcessing',            'system/sales/salesOrderProcessing',                  null, 1, 1, 'C', '1', '1', '', 										'shopping', 	'admin', sysdate(), '', null, '');
insert into sys_menu values(131, '销售单据制作',   3, 2, 'salesDocumentProcessing',         'system/sales/salesDocumentProcessing',               null, 1, 1, 'C', '0', '0', '', 										'shopping', 	'admin', sysdate(), '', null, '');
insert into sys_menu values(133, '销售订单查询',   3, 4, 'salesOrderQuery',                 'system/sales/salesOrderQuery',                       null, 1, 0, 'C', '1', '1', '', 										'search', 		'admin', sysdate(), '', null, '');
insert into sys_menu values(134, '销售单据查询',   3, 5, 'salesDocumentQuery',              'system/sales/salesDocumentQuery',                    null, 1, 0, 'C', '0', '0', '', 										'search', 		'admin', sysdate(), '', null, '');
-- 库存管理
insert into sys_menu values(140, '库存单据制作',    4, 1, 'inventoryDocumentProcessing',     'system/inventory/inventoryDocumentProcessing',      null, 1, 1, 'C', '0', '0', '', 										'shopping', 	'admin', sysdate(), '', null, '');
insert into sys_menu values(141, '报损单据制作',    4, 2, 'reportingLossesProcessing',       'system/inventory/reportingLossesProcessing',        null, 1, 1, 'C', '0', '0', '',                     'shopping',   'admin', sysdate(), '', null, '');
insert into sys_menu values(142, '报溢单据制作',    4, 3, 'reportOverflowProcessing',        'system/inventory/reportOverflowProcessing',         null, 1, 1, 'C', '0', '0', '',                     'shopping',   'admin', sysdate(), '', null, '');
insert into sys_menu values(143, '库存调拨制作',    4, 4, 'inventoryTransfer',               'system/inventory/InventoryTransfer',                null, 1, 1, 'C', '0', '0', '', 										'shopping', 	'admin', sysdate(), '', null, '');
insert into sys_menu values(144, '库存盘点制作',    4, 5, 'inventoryCounting',               'system/inventory/InventoryCounting',                null, 1, 1, 'C', '0', '0', '', 										'shopping', 		'admin', sysdate(), '', null, '');
insert into sys_menu values(145, '组装拆分制作',    4, 6, 'assemblyAndDisassemblyProcessing','system/inventory/assemblyAndDisassemblyProcessing',  null, 1, 1, 'C', '0', '0', '',                     'shopping',   'admin', sysdate(), '', null, '');
insert into sys_menu values(146, '库存单据查询',    4, 7, 'inventoryDocumentQuery',          'system/inventory/InventoryDocumentQuery',            null, 1, 0, 'C', '0', '0', '', 										'search', 		'admin', sysdate(), '', null, '');
insert into sys_menu values(147, '库存发生汇总',    4, 8, 'inventoryOccurrenceSummary',      'system/inventory/InventoryOccurrenceSummary',        null, 1, 0, 'C', '0', '0', '',										  'tree-table', 	'admin', sysdate(), '', null, '');
insert into sys_menu values(148, '库存发生明细',    4, 9, 'inventoryOccurrenceDetails',      'system/inventory/InventoryOccurrenceDetails',        null, 1, 0, 'C', '0', '0', '',										  'tree', 		'admin', sysdate(), '', null, '');
insert into sys_menu values(149, '库存货品查询',    4, 10,'inventoryItemInquiry',            'system/inventory/InventoryItemInquiry',             null, 1, 0, 'C', '0', '0', '', 										'zip', 			'admin', sysdate(), '', null, '');
insert into sys_menu values(150, '库存积压查询',    4, 11,'inventoryBacklogQuery',           'system/inventory/inventoryBacklogQuery',              null, 1, 0, 'C', '0', '0', '',                    'search',    'admin', sysdate(), '', null, '');
insert into sys_menu values(151, '历史单据迁移',    4, 12,'HistoricalDocuments',             'system/inventory/HistoricalDocuments',              null, 1, 0, 'C', '1', '0', '', 										'guide', 		'admin', sysdate(), '', null, '');
insert into sys_menu values(152, '配件查询',       4, 13,'AccessoryQuery',                  'system/inventory/accessoryQuery',                    null, 1, 0, 'C', '0', '0', '',                    'search',    'admin', sysdate(), '', null, '');
-- 售后管理
insert into sys_menu values(210, '售后单据制作', 	6, 1, 'afterSalesOrderProcessing',       'system/aftersales/afterSalesOrderProcessing',        null, 1, 1, 'C', '0', '0', '', 										'shopping', 	'admin', sysdate(), '', null, '');
insert into sys_menu values(211, '售后单据查询', 	6, 2, 'afterSalesOrderQuery',            'system/aftersales/afterSalesOrderQuery',             null, 1, 0, 'C', '0', '0', '', 										'search', 		'admin', sysdate(), '', null, '');
-- 基础数据
insert into sys_menu values(400, '供应商资料',    20, 1, 'supplier', 								'system/basedate/supplier', 					null, 1, 0, 'C', '0', '0', 'baseDate:supplier:list', 				'clipboard', 	'admin', sysdate(), '', null, '');
insert into sys_menu values(401, '客户资料',     20, 2, 'customer', 								'system/basedate/customer', 					null, 1, 0, 'C', '0', '0', 'baseDate:customer:list', 				'peoples', 		'admin', sysdate(), '', null, '');
insert into sys_menu values(402, '仓库资料',     20, 3, 'warehouse', 								'system/basedate/warehouse', 					null, 1, 0, 'C', '0', '0', 'baseDate:warehouse:list', 				'table', 		'admin', sysdate(), '', null, '');
insert into sys_menu values(403, '商品资料',     20, 4, 'commodity', 								'system/basedate/commodity', 					null, 0, 0, 'C', '1', '1', 'baseDate:commodity:list', 				'tab', 			'admin', sysdate(), '', null, '');
insert into sys_menu values(404, '商品类型',     20, 5, 'commodityType', 							'system/basedate/commodityType', 				null, 0, 0, 'C', '1', '1', 'baseDate:commodityType:list', 			'tree-table', 	'admin', sysdate(), '', null, '');
insert into sys_menu values(405, '货品资料',     20, 6, 'product', 								'system/basedate/product', 						null, 1, 0, 'C', '0', '0', 'baseDate:product:list', 				'tab', 			'admin', sysdate(), '', null, '');
insert into sys_menu values(406, '货品类型',     20, 7, 'producttype', 							'system/basedate/productType', 					null, 1, 0, 'C', '0', '0', 'baseDate:productType:list', 			'tree-table', 	'admin', sysdate(), '', null, '');
insert into sys_menu values(407, '文件共享',     20, 8, 'filesharing', 							'system/basedate/fileSharing', 					null, 1, 0, 'C', '0', '0', '', 										'excel', 		'admin', sysdate(), '', null, '');

-- 打印管理
insert into sys_menu values(450, '模板查询',    21, 1, 'printList',              'system/printconfig/printList',          null, 1, 0, 'C', '0', '0', '',  'tree-table',   'admin', sysdate(), '', null, '');
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
insert into sys_menu values('116',  '代码生成', 24,   '2', 'gen',        'tool/gen/index',           '', 1, 0, 'C', '1', '1', 'tool:gen:list',           'code',          'admin', sysdate(), '', null, '代码生成菜单');
insert into sys_menu values('117',  '系统接口', 24,   '3', 'swagger',    'tool/swagger/index',       '', 1, 0, 'C', '0', '0', 'tool:swagger:list',       'swagger',       'admin', sysdate(), '', null, '系统接口菜单');
-- 三级菜单
-- 日志管理
insert into sys_menu values('500',  '操作日志', '108', '1', 'operlog',    'monitor/operlog/index',    '', 1, 0, 'C', '0', '0', 'monitor:operlog:list',    'form',          'admin', sysdate(), '', null, '操作日志菜单');
insert into sys_menu values('501',  '登录日志', '108', '2', 'logininfor', 'monitor/logininfor/index', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor',    'admin', sysdate(), '', null, '登录日志菜单');
-- 首页展示
insert into sys_menu values(700, '销售金额与毛利润查询',     1, 1, '', null, null, 1, 0, 'F', '0', '0', 'index:salesAmountQuery',      '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(701, '待审核单据查询',         1, 2, '', null, null, 1, 0, 'F', '0', '0', 'index:salesNotTakeEffectQuery', '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(702, '货品库存预警查询',        1, 3, '', null, null, 1, 0, 'F', '0', '0', 'index:overstockList',      '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(703, '货品库存未出库时间预警查询', 1, 4, '', null, null, 1, 0, 'F', '0', '0', 'index:monthOverstockList',      '#', 'admin', sysdate(), '', null, '');
-- 供应商资料按钮
insert into sys_menu values(800, '供应商查询',     400, 1, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:supplier:list',             '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(801, '供应商详情',     400, 2, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:supplier:query',            '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(802, '供应商新增',     400, 3, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:supplier:add',            '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(803, '供应商修改',     400, 4, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:supplier:update',           '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(804, '供应商删除',     400, 5, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:supplier:remove',           '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(805, '供应商导入',     400, 6, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:supplier:import',           '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(806, '供应商导出',     400, 7, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:supplier:export',           '#', 'admin', sysdate(), '', null, '');
-- 客户资料按钮
insert into sys_menu values(810, '客户查询',      401, 1, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:customer:list',             '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(811, '客户详情',      401, 2, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:customer:query',            '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(812, '客户新增',      401, 3, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:customer:add',            '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(813, '客户修改',      401, 4, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:customer:update',           '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(814, '客户删除',      401, 5, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:customer:remove',           '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(815, '客户导入',      401, 6, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:customer:import',           '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(816, '客户导出',      401, 7, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:customer:export',           '#', 'admin', sysdate(), '', null, '');
-- 仓库资料按钮
insert into sys_menu values(820, '仓库查询',      402, 1, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:warehouse:list',            '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(821, '仓库详情',      402, 2, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:warehouse:query',           '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(822, '仓库新增',      402, 3, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:warehouse:add',             '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(823, '仓库修改',      402, 4, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:warehouse:update',          '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(824, '仓库删除',      402, 5, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:warehouse:remove',          '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(825, '仓库导入',      402, 6, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:warehouse:import',          '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(826, '仓库导出',      402, 7, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:warehouse:export',          '#', 'admin', sysdate(), '', null, '');
-- 商品资料按钮
insert into sys_menu values(830, '商品类型',      403, 1, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:commodity:commodityTypeTree',     '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(831, '商品查询',      403, 2, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:commodity:list',            '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(832, '商品详情',      403, 3, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:commodity:query',           '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(833, '商品新增',      403, 4, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:commodity:add',             '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(834, '商品修改',      403, 5, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:commodity:update',          '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(835, '商品删除',      403, 6, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:commodity:remove',          '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(836, '商品导入',      403, 7, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:commodity:import',          '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(837, '商品导出',      403, 8, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:commodity:export',          '#', 'admin', sysdate(), '', null, '');
-- 商品类型按钮
insert into sys_menu values(840, '商品类型查询',    404, 1, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:commodityType:list',          '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(841, '商品类型详情',    404, 2, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:commodityType:query',         '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(842, '商品类型新增',    404, 3, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:commodityType:add',         '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(843, '商品类型修改',    404, 4, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:commodityType:edit',          '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(844, '商品类型删除',    404, 5, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:commodityType:remove',        '#', 'admin', sysdate(), '', null, '');
-- 货品资料按钮
insert into sys_menu values(850, '货品类型',      405, 1, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:product:productTypeTree',       '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(851, '货品查询',      405, 2, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:product:list',            '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(852, '货品详情',      405, 3, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:product:query',             '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(853, '货品新增',      405, 4, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:product:add',             '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(854, '货品修改',      405, 5, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:product:update',            '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(855, '货品删除',      405, 6, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:product:remove',            '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(856, '货品导入',      405, 7, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:product:import',            '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(857, '货品导出',      405, 8, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:product:export',            '#', 'admin', sysdate(), '', null, '');
-- 货品类型按钮
insert into sys_menu values(860, '货品类型查询',    406, 1, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:productType:list',          '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(861, '货品类型详情',    406, 2, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:productType:query',           '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(862, '货品类型新增',    406, 3, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:productType:add',           '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(863, '货品类型修改',    406, 4, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:productType:edit',          '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(864, '货品类型删除',    406, 5, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:productType:remove',          '#', 'admin', sysdate(), '', null, '');
-- 文件共享按钮
insert into sys_menu values(870, '文件共享查询',    407, 1, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:fileSharing:list',          '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(871, '文件共享详情',    407, 2, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:fileSharing:query',           '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(872, '文件共享上传',    407, 3, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:fileSharing:upload',          '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(873, '文件共享修改',    407, 4, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:fileSharing:update',          '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(874, '文件共享删除',    407, 5, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:fileSharing:remove',          '#', 'admin', sysdate(), '', null, '');
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
insert into sys_menu values(1100, '下拉选项查询',     120, 1, '', null, null, 1, 0, 'F', '0', '0', 'common:commonReceipt:list',                               '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1101, '销售订单跳转', 		120, 2, '', null, null, 1, 0, 'F', '0', '0', 'sales:salesOrderProcessing:orderFormType',                '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1102, '选择经手人',      120, 3, '', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseOrderProcessing:selectUser',			        '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1103, '采购订单新增', 		120, 4, '', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseOrderProcessing:add',                    '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1104, '采购订单明细', 		120, 5, '', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseOrderProcessing:detail',                 '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1105, '新增供应商保存', 	  120, 6, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:supplier:add',                                   '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1106, '新增货品保存', 		120, 7,'', null, null, 1, 0, 'F', '0', '0', 'baseDate:product:add',                                    '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1107, '采购订单保存', 		120, 8,'', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseOrderProcessing:save',                   '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1108, '采购订单修改', 		120, 9,'', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseOrderProcessing:systematicOrderForm',    '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1109, '采购订单审核', 		120, 10,'', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseOrderProcessing:takeEffect',             '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1110, '采购订单打印', 		120, 11,'', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseOrderProcessing:printOut',               '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1111, '采购订单删除', 		120, 12,'', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseOrderProcessing:delete',                 '#', 'admin', sysdate(), '', null, '');
-- 采购单据制作按钮
insert into sys_menu values(1200, '下拉选项查询',     121, 1, '', null, null, 1, 0, 'F', '0', '0', 'common:commonReceipt:list',                               '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1201, '采购入库选择', 		121, 2, '', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseReceiptProcessing:warehousing',          '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1202, '采购退库选择', 		121, 3, '', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseReceiptProcessing:retreat',              '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1203, '选择经手人',      121, 4, '', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseReceiptProcessing:selectUser',           '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1204, '库存明细查看',     121, 5, '', null, null, 1, 0, 'F', '0', '0', 'common:commonReceipt:selectInventoryQtyQuery',             '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1205, '入库锁单明细查看',  121, 6, '', null, null, 1, 0, 'F', '0', '0', 'common:commonReceipt:selectLockInventoryQtyQuery',       '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1206, '已锁单明细查看',    121, 7, '', null, null, 1, 0, 'F', '0', '0', 'common:commonReceipt:selectLockQtyQuery',                '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1207, '采购单据新增', 		121, 8, '', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseReceiptProcessing:add',                  '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1208, '采购单据明细', 		121, 9, '', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseReceiptProcessing:detail',               '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1209, '新增供应商保存', 	  121, 10,'', null, null, 1, 0, 'F', '0', '0', 'baseDate:supplier:add',                                   '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1210, '新增货品保存', 		121, 11,'', null, null, 1, 0, 'F', '0', '0', 'baseDate:product:add',                                    '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1211, '采购单据保存', 		121, 12,'', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseReceiptProcessing:save',                 '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1212, '采购单据修改', 		121, 13,'', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseReceiptProcessing:systematicReceipt',    '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1213, '采购单据审核', 		121, 14,'', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseReceiptProcessing:takeEffect',           '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1214, '采购单据打印', 		121, 15,'', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseReceiptProcessing:printOut',             '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1215, '采购单据删除', 		121, 16,'', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseReceiptProcessing:delete',               '#', 'admin', sysdate(), '', null, '');
-- 付款单据制作按钮
-- 采购订单查询按钮
insert into sys_menu values(1400, '下拉选项查询',     123, 1, '', null, null, 1, 0, 'F', '0', '0', 'common:commonReceipt:list',                               '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1401, '选择经手人',      123, 2, '', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseOrderQuery:selectUser',                  '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1402, '采购订单查询', 		123, 3, '', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseOrderQuery:headQuery',                   '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1403, '采购订单明细查询', 	123, 4, '', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseOrderQuery:detailQuery',                 '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1404, '采购订单导出', 		123, 5, '', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseOrderQuery:headExport',             	    '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1405, '采购订单明细导出', 	123, 6, '', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseOrderQuery:detailExport',           	   '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1406, '采购订单新增', 		123, 7, '', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseOrderQuery:add',               		      '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1407, '采购订单打印', 		123, 8,'', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseOrderQuery:printOut',               	   '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1408, '采购订单修改', 		123, 9,'', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseOrderQuery:update',                 	   '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1409, '采购订单删除', 		123, 10,'', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseOrderQuery:delete',                 	    '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1410, '采购订单详情', 		123, 11,'', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseOrderQuery:systematicOrderForm',    	    '#', 'admin', sysdate(), '', null, '');
-- 采购单据查询按钮
insert into sys_menu values(1500, '下拉选项查询',     124, 1, '', null, null, 1, 0, 'F', '0', '0', 'common:commonReceipt:list',                               '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1501, '选择经手人',      124, 2, '', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseReceiptQuery:selectUser',                '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1502, '采购单据查询', 		124, 3, '', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseReceiptQuery:headQuery', 				        '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1503, '采购单据明细查询', 	124, 4, '', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseReceiptQuery:detailQuery', 			        '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1504, '采购单据导出', 		124, 5, '', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseReceiptQuery:headExport', 			          '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1505, '采购单据明细导出', 	124, 6, '', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseReceiptQuery:detailExport', 			         '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1506, '采购单据新增', 		124, 7, '', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseReceiptQuery:add', 					             '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1507, '采购单据打印', 		124, 8,'', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseReceiptQuery:printOut', 				          '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1508, '采购单据修改', 		124, 9,'', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseReceiptQuery:update', 				            '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1509, '采购单据删除', 		124, 10,'', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseReceiptQuery:delete', 				             '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(1510, '采购单据详情', 		124, 11,'', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseReceiptQuery:systematicReceipt', 		    '#', 'admin', sysdate(), '', null, '');
-- 付款单据查询按钮
-- 销售订单制作按钮
insert into sys_menu values(2000, '下拉选项查询',     130, 1, '', null, null, 1, 0, 'F', '0', '0', 'common:commonReceipt:list',                               '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2001, '采购订单跳转', 		130, 2, '', null, null, 1, 0, 'F', '0', '0', 'purchase:purchaseOrderProcessing:orderFormType', 		       '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2002, '选择经手人',      130, 3, '', null, null, 1, 0, 'F', '0', '0', 'sales:salesOrderProcessing:selectUser',				             '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2003, '销售订单新增', 		130, 4, '', null, null, 1, 0, 'F', '0', '0', 'sales:salesOrderProcessing:add', 						               '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2004, '销售订单明细', 		130, 5, '', null, null, 1, 0, 'F', '0', '0', 'sales:salesOrderProcessing:detail', 					             '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2005, '新增客户保存', 		130, 6, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:customer:add', 								                  '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2006, '新增货品保存', 		130, 7, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:product:add', 								                    '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2007, '销售订单保存', 		130, 8, '', null, null, 1, 0, 'F', '0', '0', 'sales:salesOrderProcessing:save', 						            '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2008, '销售订单修改', 		130, 9, '', null, null, 1, 0, 'F', '0', '0', 'sales:salesOrderProcessing:systematicOrderForm',		      '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2009, '销售订单审核', 		130, 10,'', null, null, 1, 0, 'F', '0', '0', 'sales:salesOrderProcessing:takeEffect', 				          '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2010, '销售订单打印', 		130, 11,'', null, null, 1, 0, 'F', '0', '0', 'sales:salesOrderProcessing:printOut', 					           '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2011, '销售订单删除', 		130, 12,'', null, null, 1, 0, 'F', '0', '0', 'sales:salesOrderProcessing:delete', 					             '#', 'admin', sysdate(), '', null, '');
-- 销售单据制作按钮
insert into sys_menu values(2100, '下拉选项查询',     131, 1, '', null, null, 1, 0, 'F', '0', '0', 'common:commonReceipt:list',                               '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2101, '销售出库选择', 		131, 2, '', null, null, 1, 0, 'F', '0', '0', 'sales:salesReceiptProcessing:Outbound', 				          '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2102, '销售退库选择', 		131, 3, '', null, null, 1, 0, 'F', '0', '0', 'sales:salesReceiptProcessing:retreat', 				             '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2103, '选择经手人',      131, 4, '', null, null, 1, 0, 'F', '0', '0', 'sales:salesReceiptProcessing:selectUser',				           '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2104, '库存明细查看',     131, 5, '', null, null, 1, 0, 'F', '0', '0', 'common:commonReceipt:selectInventoryQtyQuery',             '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2105, '入库锁单明细查看',  131, 6, '', null, null, 1, 0, 'F', '0', '0', 'common:commonReceipt:selectLockInventoryQtyQuery',         '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2106, '已锁单明细查看',    131, 7, '', null, null, 1, 0, 'F', '0', '0', 'common:commonReceipt:selectLockQtyQuery',                 '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2107, '货品明细数量修改',  131, 8, '', null, null, 1, 0, 'F', '0', '0', 'sales:salesReceiptProcessing:planQuantity',                '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2108, '销售单据新增', 		131, 9, '', null, null, 1, 0, 'F', '0', '0', 'sales:salesReceiptProcessing:add', 					              '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2109, '销售单据明细', 		131, 10, '', null, null, 1, 0, 'F', '0', '0', 'sales:salesReceiptProcessing:detail', 					          '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2110, '新增客户保存', 		131, 11,'', null, null, 1, 0, 'F', '0', '0', 'baseDate:customer:add', 								                  '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2111, '新增货品保存', 		131, 12,'', null, null, 1, 0, 'F', '0', '0', 'baseDate:product:add', 								                     '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2112, '销售单据保存', 		131, 13,'', null, null, 1, 0, 'F', '0', '0', 'sales:salesReceiptProcessing:save', 					             '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2113, '销售单据修改', 		131, 14,'', null, null, 1, 0, 'F', '0', '0', 'sales:salesReceiptProcessing:systematicReceipt', 		       '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2114, '销售单据审核', 		131, 15,'', null, null, 1, 0, 'F', '0', '0', 'sales:salesReceiptProcessing:takeEffect', 				        '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2115, '销售单据打印', 		131, 16,'', null, null, 1, 0, 'F', '0', '0', 'sales:salesReceiptProcessing:printOut', 				          '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2116, '销售单据删除', 		131, 17,'', null, null, 1, 0, 'F', '0', '0', 'sales:salesReceiptProcessing:delete', 					           '#', 'admin', sysdate(), '', null, '');
-- 收款单据制作按钮
-- 销售订单查询按钮
insert into sys_menu values(2300, '下拉选项查询',     133, 1, '', null, null, 1, 0, 'F', '0', '0', 'common:commonReceipt:list',                       '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2301, '选择经手人',      133, 2, '', null, null, 1, 0, 'F', '0', '0', 'sales:salesOrderQuery:selectUser',    					   '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2302, '销售订单查询', 		133, 3, '', null, null, 1, 0, 'F', '0', '0', 'sales:salesOrderQuery:headQuery', 						    '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2303, '销售订单明细查询', 	133, 4, '', null, null, 1, 0, 'F', '0', '0', 'sales:salesOrderQuery:detailQuery', 					    '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2304, '销售订单导出', 		133, 5, '', null, null, 1, 0, 'F', '0', '0', 'sales:salesOrderQuery:headExport',             		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2305, '销售订单明细导出', 	133, 6, '', null, null, 1, 0, 'F', '0', '0', 'sales:salesOrderQuery:detailExport',           		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2306, '销售订单新增', 		133, 7, '', null, null, 1, 0, 'F', '0', '0', 'sales:salesOrderQuery:add',               				'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2307, '销售订单打印', 		133, 8, '', null, null, 1, 0, 'F', '0', '0', 'sales:salesOrderQuery:printOut',               		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2308, '销售订单修改', 		133, 9, '', null, null, 1, 0, 'F', '0', '0', 'sales:salesOrderQuery:update',                 		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2309, '销售订单删除', 		133, 10, '', null, null, 1, 0, 'F', '0', '0', 'sales:salesOrderQuery:delete',                 		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2310, '销售订单详情', 		133, 11, '', null, null, 1, 0, 'F', '0', '0', 'sales:salesOrderQuery:systematicOrderForm',    		'#', 'admin', sysdate(), '', null, '');
-- 销售单据查询按钮
insert into sys_menu values(2400, '下拉选项查询',     134, 1, '', null, null, 1, 0, 'F', '0', '0', 'common:commonReceipt:list',                       '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2401, '选择经手人',      134, 4, '', null, null, 1, 0, 'F', '0', '0', 'sales:salesReceiptQuery:selectUser',    				    '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2404, '销售单据查询', 		134, 5, '', null, null, 1, 0, 'F', '0', '0', 'sales:salesReceiptQuery:headQuery', 					     '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2405, '销售单据明细查询', 	134, 6, '', null, null, 1, 0, 'F', '0', '0', 'sales:salesReceiptQuery:detailQuery', 					  '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2406, '销售单据导出', 		134, 7, '', null, null, 1, 0, 'F', '0', '0', 'sales:salesReceiptQuery:headExport', 					    '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2407, '销售单据明细导出', 	134, 8, '', null, null, 1, 0, 'F', '0', '0', 'sales:salesReceiptQuery:detailExport', 				    '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2408, '销售单据新增', 		134, 9, '', null, null, 1, 0, 'F', '0', '0', 'sales:salesReceiptQuery:add', 							       '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2409, '销售单据打印', 		134, 10,'', null, null, 1, 0, 'F', '0', '0', 'sales:salesReceiptQuery:printOut', 					      '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2410, '销售单据修改', 		134, 11,'', null, null, 1, 0, 'F', '0', '0', 'sales:salesReceiptQuery:update', 						       '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2411, '销售单据删除', 		134, 12,'', null, null, 1, 0, 'F', '0', '0', 'sales:salesReceiptQuery:delete', 						       '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2412, '销售单据详情', 		134, 13,'', null, null, 1, 0, 'F', '0', '0', 'sales:salesReceiptQuery:systematicReceipt', 			'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2413, '销售单据订单查询', 	134, 14,'', null, null, 1, 0, 'F', '0', '0', 'sales:salesReceiptQuery:orderQuery', 					     '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(2414, '销售单据售后查询', 	134, 15,'', null, null, 1, 0, 'F', '0', '0', 'sales:salesReceiptQuery:afterSalesQuery', 				'#', 'admin', sysdate(), '', null, '');
-- 收款单据查询按钮
-- 库存单据制作按钮
insert into sys_menu values(3000, '下拉选项查询',     140, 1, '', null, null, 1, 0, 'F', '0', '0', 'common:commonReceipt:list',                         '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3001, '库存入库选择', 		140, 2, '', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryReceiptProcessing:warehousing', 	'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3002, '库存出库选择', 		140, 3, '', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryReceiptProcessing:Outbound', 		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3003, '选择经手人',      140, 4, '', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryReceiptProcessing:selectUser',		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3004, '库存单据新增', 		140, 5, '', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryReceiptProcessing:add', 			    '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3005, '库存单据明细', 		140, 6, '', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryReceiptProcessing:detail', 			'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3006, '新增供应商保存', 	  140, 7, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:supplier:add', 								            '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3007, '新增客户保存', 		140, 8, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:customer:add', 								            '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3008, '新增货品保存', 		140, 9, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:product:add', 								              '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3009, '库存单据保存', 		140, 10,'', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryReceiptProcessing:save', 			   '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3010, '库存单据修改', 		140, 11,'', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryReceiptProcessing:systematicReceipt','#','admin', sysdate(), '', null, '');
insert into sys_menu values(3011, '库存单据审核', 		140, 12,'', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryReceiptProcessing:takeEffect', 		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3012, '库存单据打印', 		140, 13,'', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryReceiptProcessing:printOut', 		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3013, '库存单据删除', 		140, 14,'', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryReceiptProcessing:delete', 			'#', 'admin', sysdate(), '', null, '');
-- 报损单据制作按钮
insert into sys_menu values(3100, '下拉选项查询',     141, 1, '', null, null, 1, 0, 'F', '0', '0', 'common:commonReceipt:list',                           '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3101, '选择经手人',      141, 2, '', null, null, 1, 0, 'F', '0', '0', 'inventory:reportingLossesProcessing:selectUser',      '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3102, '报损单据新增',     141, 3, '', null, null, 1, 0, 'F', '0', '0', 'inventory:reportingLossesProcessing:add',             '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3103, '报损单据明细',     141, 4, '', null, null, 1, 0, 'F', '0', '0', 'inventory:reportingLossesProcessing:detail',          '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3104, '新增货品保存',     141, 5, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:product:add',                                '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3105, '报损单据保存',     141, 6, '', null, null, 1, 0, 'F', '0', '0', 'inventory:reportingLossesProcessing:save',            '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3106, '报损单据修改',     141, 7, '', null, null, 1, 0, 'F', '0', '0', 'inventory:reportingLossesProcessing:systematicReceipt','#','admin', sysdate(), '', null, '');
insert into sys_menu values(3107, '报损单据审核',     141, 8, '', null, null, 1, 0, 'F', '0', '0', 'inventory:reportingLossesProcessing:takeEffect',      '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3108, '报损单据打印',     141, 9, '', null, null, 1, 0, 'F', '0', '0', 'inventory:reportingLossesProcessing:printOut',        '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3109, '报损单据删除',     141, 10,'', null, null, 1, 0, 'F', '0', '0', 'inventory:reportingLossesProcessing:delete',          '#', 'admin', sysdate(), '', null, '');
-- 报溢单据制作按钮
insert into sys_menu values(3200, '下拉选项查询',     142, 1, '', null, null, 1, 0, 'F', '0', '0', 'common:commonReceipt:list',                           '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3201, '选择经手人',      142, 2, '', null, null, 1, 0, 'F', '0', '0', 'inventory:reportOverflowProcessing:selectUser',       '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3202, '报溢单据新增',     142, 3, '', null, null, 1, 0, 'F', '0', '0', 'inventory:reportOverflowProcessing:add',              '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3203, '报溢单据明细',     142, 4, '', null, null, 1, 0, 'F', '0', '0', 'inventory:reportOverflowProcessing:detail',           '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3204, '新增货品保存',     142, 5, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:product:add',                                '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3205, '报溢单据保存',     142, 6, '', null, null, 1, 0, 'F', '0', '0', 'inventory:reportOverflowProcessing:save',             '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3206, '报溢单据修改',     142, 7, '', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryReceiptProcessing:systematicReceipt','#','admin', sysdate(), '', null, '');
insert into sys_menu values(3207, '报溢单据审核',     142, 8, '', null, null, 1, 0, 'F', '0', '0', 'inventory:reportOverflowProcessing:takeEffect',       '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3208, '报溢单据打印',     142, 9, '', null, null, 1, 0, 'F', '0', '0', 'inventory:reportOverflowProcessing:printOut',         '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3209, '报溢单据删除',     142, 10,'', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryReceiptProcessing:delete',           '#', 'admin', sysdate(), '', null, '');
-- 库存调拨单制作按钮
insert into sys_menu values(3300, '下拉选项查询',     143, 1, '', null, null, 1, 0, 'F', '0', '0', 'common:commonReceipt:list',                           '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3301, '选择经手人',      143, 2, '', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryTransferProcessing:selectUser',		  '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3302, '调拨单据新增', 		143, 3, '', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryTransferProcessing:add', 			     '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3303, '调拨单据明细', 		143, 4, '', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryTransferProcessing:detail', 		     '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3304, '新增供应商保存', 	  143, 5, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:supplier:add', 								              '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3305, '新增客户保存', 		143, 6, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:customer:add', 								              '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3306, '新增货品保存', 		143, 7, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:product:add', 								                 '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3307, '调拨单据保存', 		143, 8, '', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryTransferProcessing:save', 			    '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3308, '调拨单据修改', 		143, 9, '', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryReceiptProcessing:systematicReceipt','#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3309, '调拨单据审核', 		143, 10,'', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryTransferProcessing:takeEffect', 	  '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3310, '调拨单据打印', 		143, 11,'', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryTransferProcessing:printOut', 		   '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3311, '调拨订单删除', 		143, 12,'', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryReceiptProcessing:delete', 			   '#', 'admin', sysdate(), '', null, '');
-- 库存盘点单制作按钮
insert into sys_menu values(3400, '下拉选项查询',     144, 1, '', null, null, 1, 0, 'F', '0', '0', 'common:commonReceipt:list',                           '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3401, '选择经手人',      144, 2, '', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryCountingProcessing:selectUser',		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3402, '盘点单据新增', 		144, 3, '', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryCountingProcessing:add', 			'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3403, '盘点单据明细', 		144, 4, '', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryCountingProcessing:detail', 		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3404, '新增货品保存', 		144, 5, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:product:add', 								'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3405, '盘点单据保存', 		144, 6, '', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryCountingProcessing:save', 			'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3406, '盘点单据修改', 		144, 7, '', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryReceiptProcessing:systematicReceipt','#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3407, '盘点单据审核', 		144, 8, '', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryCountingProcessing:takeEffect', 	'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3408, '盘点单据打印', 		144, 9, '', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryCountingProcessing:printOut', 		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3409, '盘点订单删除', 		144, 10,'', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryReceiptProcessing:delete', 			'#', 'admin', sysdate(), '', null, '');
-- 组装与拆分单制作按钮
insert into sys_menu values(3500, '下拉选项查询',     145, 1, '', null, null, 1, 0, 'F', '0', '0', 'common:commonReceipt:list',                           '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3501, '选择经手人',      145, 2, '', null, null, 1, 0, 'F', '0', '0', 'inventory:assemblyAndDisassemblyProcessing:selectUser',   '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3502, '库存单据新增',     145, 3, '', null, null, 1, 0, 'F', '0', '0', 'inventory:assemblyAndDisassemblyProcessing:add',      '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3503, '库存单据明细',     145, 4,'', null, null, 1, 0, 'F', '0', '0', 'inventory:assemblyAndDisassemblyProcessing:detail',       '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3504, '新增货品保存',     145, 5,'', null, null, 1, 0, 'F', '0', '0', 'baseDate:product:add',                '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3505, '库存单据保存',     145, 6,'', null, null, 1, 0, 'F', '0', '0', 'inventory:assemblyAndDisassemblyProcessing:save',       '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3506, '库存单据修改',     145, 7,'', null, null, 1, 0, 'F', '0', '0', 'inventory:assemblyAndDisassemblyProcessing:systematicReceipt','#','admin', sysdate(), '', null, '');
insert into sys_menu values(3507, '库存单据审核',     145, 8,'', null, null, 1, 0, 'F', '0', '0', 'inventory:assemblyAndDisassemblyProcessing:takeEffect',     '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3508, '库存单据打印',     145, 9,'', null, null, 1, 0, 'F', '0', '0', 'inventory:assemblyAndDisassemblyProcessing:printOut',     '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3509, '库存单据删除',     145, 10,'', null, null, 1, 0, 'F', '0', '0', 'inventory:assemblyAndDisassemblyProcessing:delete',       '#', 'admin', sysdate(), '', null, '');
-- 库存单据查询按钮
insert into sys_menu values(3600, '下拉选项查询',     146, 1, '', null, null, 1, 0, 'F', '0', '0', 'common:commonReceipt:list',                           '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3601, '选择经手人',      146, 2, '', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryReceiptQuery:selectUser',    		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3602, '库存单据查询', 		146, 3, '', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryReceiptQuery:headQuery', 			'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3603, '库存单据明细查询', 	146, 4, '', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryReceiptQuery:detailQuery', 			'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3604, '库存单据导出', 		146, 5, '', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryReceiptQuery:headExport', 			'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3605, '库存单据明细导出', 	146, 6, '', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryReceiptQuery:detailExport', 		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3606, '库存单据新增', 		146, 7, '', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryReceiptQuery:add', 					'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3607, '库存单据打印', 		146, 8, '', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryReceiptQuery:printOut', 			'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3608, '库存单据修改', 		146, 9, '', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryReceiptQuery:update', 				'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3609, '库存单据删除', 		146, 10,'', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryReceiptQuery:delete', 				'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3610, '库存单据详情', 		146, 11,'', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryReceiptQuery:systematicReceipt', 	'#', 'admin', sysdate(), '', null, '');
-- 库存发生汇总按钮
insert into sys_menu values(3700, '库存发生汇总查询', 	147, 1, '', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryOccurrenceSummary:list', 			'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3701, '库存发生汇总导出', 	147, 2, '', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryOccurrenceSummary:export', 			'#', 'admin', sysdate(), '', null, '');
-- 库存发生明细按钮
insert into sys_menu values(3800, '库存发生明细查询', 	148, 1, '', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryOccurrenceDetails:list', 			'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3801, '库存发生明细导出', 	148, 2, '', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryOccurrenceDetails:export', 			'#', 'admin', sysdate(), '', null, '');
-- 库存货品查询按钮
insert into sys_menu values(3900, '库存货品查询', 		149, 1, '', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryItemInquiry:list', 					'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(3901, '库存货品导出', 		149, 2, '', null, null, 1, 0, 'F', '0', '0', 'inventory:inventoryItemInquiry:export', 				'#', 'admin', sysdate(), '', null, '');
-- 历史单据迁移
insert into sys_menu values(4000, '单据头表查询', 		150, 1, '', null, null, 1, 0, 'F', '0', '0', 'inventory:historicalDocuments:head', 					'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(4001, '单据明细查询', 		150, 2, '', null, null, 1, 0, 'F', '0', '0', 'inventory:historicalDocuments:detail', 				'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(4002, '单据详情',       150, 3, '', null, null, 1, 0, 'F', '0', '0', 'inventory:historicalDocuments:SystematicReceipt', 		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(4003, '单据删除',       150, 4, '', null, null, 1, 0, 'F', '0', '0', 'inventory:historicalDocuments:delete', 				'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(4004, '单据头表导入', 		150, 5, '', null, null, 1, 0, 'F', '0', '0', 'inventory:historicalDocuments:importHeadData', 		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(4005, '单据明细导入', 		150, 6, '', null, null, 1, 0, 'F', '0', '0', 'inventory:historicalDocuments:importDetailData', 		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(4006, '单据头表导出', 		150, 7, '', null, null, 1, 0, 'F', '0', '0', 'inventory:historicalDocuments:headReceiptExport', 		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(4007, '单据明细导出', 		150, 8, '', null, null, 1, 0, 'F', '0', '0', 'inventory:historicalDocuments:detailReceiptExport',	'#', 'admin', sysdate(), '', null, '');
-- 家装工程单查询按钮
insert into sys_menu values(5000, '工程单据创建者', 	200, 1, '', null, null, 1, 0, 'F', '0', '0', 'system:user:list', 									'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(5001, '选择创建者',      200, 2, '', null, null, 1, 0, 'F', '0', '0', 'engineering:engineeringOrderQuery:selectUser',    		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(5002, '工程单据查询', 		200, 3, '', null, null, 1, 0, 'F', '0', '0', 'engineering:engineeringOrderQuery:list', 			'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(5003, '工程单据导出', 		200, 4, '', null, null, 1, 0, 'F', '0', '0', 'engineering:engineeringOrderQuery:export', 			'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(5004, '工程单据反审',     200, 5, '', null, null, 1, 0, 'F', '0', '0', 'engineering:engineeringOrderQuery:disputeBtn',      '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(5005, '工程单据审核',     200, 6, '', null, null, 1, 0, 'F', '0', '0', 'engineering:engineeringOrderQuery:auditBtn',      '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(5006, '工程单据新增', 		200, 7,'', null, null, 1, 0, 'F', '0', '0', 'engineering:engineeringOrderQuery:add', 					'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(5007, '工程单据打印', 		200, 8,'', null, null, 1, 0, 'F', '0', '0', 'engineering:engineeringOrderQuery:printOut', 			'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(5008, '工程单据修改', 		200, 9,'', null, null, 1, 0, 'F', '0', '0', 'engineering:engineeringOrderQuery:update', 				'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(5009, '工程单据删除', 		200, 10,'', null, null, 1, 0, 'F', '0', '0', 'engineering:engineeringOrderQuery:delete', 				'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(5010, '工程单据详情', 		200, 11,'', null, null, 1, 0, 'F', '0', '0', 'engineering:engineeringOrderQuery:systematicId', 	'#', 'admin', sysdate(), '', null, '');
-- 售后安装单制作按钮
insert into sys_menu values(5200, '下拉选项查询',     210, 1, '', null, null, 1, 0, 'F', '0', '0', 'common:commonReceipt:list',                           '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(5201, '选择经手人',      210, 2, '', null, null, 1, 0, 'F', '0', '0', 'afterSales:afterSalesOrderProcessing:selectUser',		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(5202, '售后单据新增', 		210, 3, '', null, null, 1, 0, 'F', '0', '0', 'afterSales:afterSalesOrderProcessing:add', 			'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(5203, '售后单据明细', 		210, 4, '', null, null, 1, 0, 'F', '0', '0', 'afterSales:afterSalesOrderProcessing:detail', 			'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(5204, '新增客户保存', 		210, 5, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:customer:add', 								'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(5205, '新增货品保存', 		210, 6, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:product:add', 								'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(5206, '售后单据保存', 		210, 7, '', null, null, 1, 0, 'F', '0', '0', 'afterSales:afterSalesOrderProcessing:save', 			'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(5207, '售后单据修改', 		210, 8, '', null, null, 1, 0, 'F', '0', '0', 'afterSales:afterSalesOrderProcessing:systematicReceipt', '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(5208, '售后单据审核', 		210, 9, '', null, null, 1, 0, 'F', '0', '0', 'afterSales:afterSalesOrderProcessing:takeEffect', 		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(5209, '售后单据打印', 		210, 10,'', null, null, 1, 0, 'F', '0', '0', 'afterSales:afterSalesOrderProcessing:printOut', 		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(5210, '售后单据删除', 		210, 11,'', null, null, 1, 0, 'F', '0', '0', 'afterSales:afterSalesOrderProcessing:delete', 			'#', 'admin', sysdate(), '', null, '');
-- 售后单据查询按钮
insert into sys_menu values(5300, '下拉选项查询',     211, 1, '', null, null, 1, 0, 'F', '0', '0', 'common:commonReceipt:list',                           '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(5301, '选择经手人',      211, 2, '', null, null, 1, 0, 'F', '0', '0', 'afterSales:afterSalesOrderQuery:selectUser',    		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(5302, '售后单据查询', 		211, 3, '', null, null, 1, 0, 'F', '0', '0', 'afterSales:afterSalesOrderQuery:headQuery', 			'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(5303, '售后单据明细查询', 	211, 4, '', null, null, 1, 0, 'F', '0', '0', 'afterSales:afterSalesOrderQuery:detailQuery', 			'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(5304, '售后单据导出', 		211, 5, '', null, null, 1, 0, 'F', '0', '0', 'afterSales:afterSalesOrderQuery:headExport', 			'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(5305, '售后单据明细导出', 	211, 6, '', null, null, 1, 0, 'F', '0', '0', 'afterSales:afterSalesOrderQuery:detailExport', 		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(5306, '售后单据新增', 		211, 7, '', null, null, 1, 0, 'F', '0', '0', 'afterSales:afterSalesOrderQuery:add', 					'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(5307, '售后单据打印', 		211, 8, '', null, null, 1, 0, 'F', '0', '0', 'afterSales:afterSalesOrderQuery:printOut', 			'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(5308, '售后单据修改', 		211, 9, '', null, null, 1, 0, 'F', '0', '0', 'afterSales:afterSalesOrderQuery:update', 				'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(5309, '售后单据删除', 		211, 10,'', null, null, 1, 0, 'F', '0', '0', 'afterSales:afterSalesOrderQuery:delete', 				'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(5310, '售后单据详情', 		211, 11,'', null, null, 1, 0, 'F', '0', '0', 'afterSales:afterSalesOrderQuery:systematicReceipt', 	'#', 'admin', sysdate(), '', null, '');




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
insert into sys_dict_type values(1,  '用户性别',          'sys_user_sex',        '0', 'admin', sysdate(), '', null, '用户性别列表');
insert into sys_dict_type values(2,  '菜单状态',          'sys_show_hide',       '0', 'admin', sysdate(), '', null, '菜单状态列表');
insert into sys_dict_type values(3,  '系统开关',          'sys_normal_disable',  '0', 'admin', sysdate(), '', null, '系统开关列表');
insert into sys_dict_type values(4,  '任务状态',          'sys_job_status',      '0', 'admin', sysdate(), '', null, '任务状态列表');
insert into sys_dict_type values(5,  '任务分组',          'sys_job_group',       '0', 'admin', sysdate(), '', null, '任务分组列表');
insert into sys_dict_type values(6,  '系统是否',          'sys_yes_no',          '0', 'admin', sysdate(), '', null, '系统是否列表');
insert into sys_dict_type values(7,  '通知类型',          'sys_notice_type',     '0', 'admin', sysdate(), '', null, '通知类型列表');
insert into sys_dict_type values(8,  '通知状态',          'sys_notice_status',   '0', 'admin', sysdate(), '', null, '通知状态列表');
insert into sys_dict_type values(9,  '操作类型',          'sys_oper_type',       '0', 'admin', sysdate(), '', null, '操作类型列表');
insert into sys_dict_type values(10, '系统状态',          'sys_common_status',   '0', 'admin', sysdate(), '', null, '登录状态列表');
insert into sys_dict_type values(11, '单据类型',          'receipt_type', 		  '0', 'admin', sysdate(), '', null, '单据类型列表');
insert into sys_dict_type values(12, '单据状态',          'receipt_status', 	  '0', 'admin', sysdate(), '', null, '单据状态列表');
insert into sys_dict_type values(13, '财务审核状态',        'financial_review',    '0', 'admin', sysdate(), '', null, '财务审核状态列表');
insert into sys_dict_type values(14, '订单类型', 'order_form_type',	  '0', 'admin', sysdate(), '', null, '订单类型列表');
insert into sys_dict_type values(15, '订单状态', 'order_form_status',	  '0', 'admin', sysdate(), '', null, '订单状态列表');
insert into sys_dict_type values(16, '家装工程类型',    'engineering_type',      '0', 'admin', sysdate(), '', null, '家装工程类型列表');
insert into sys_dict_type values(17, '售后安装',       'after_sales_installation','0', 'admin', sysdate(), '', null, '售后安装列表');
insert into sys_dict_type values(18, '售单类型',       'service_type', 		  '0', 'admin', sysdate(), '', null, '售单类型列表');
insert into sys_dict_type values(19, '审核结果',       'finding_of_audit',	  '0', 'admin', sysdate(), '', null, '审核结果列表');
insert into sys_dict_type values(20, '收付款单据类型',   'payment_type',   '0', 'admin', sysdate(), '', null, '收付款单据类型列表');
insert into sys_dict_type values(21, '收付款单据状态',   'payment_status',   '0', 'admin', sysdate(), '', null, '收付款单据状态列表');
insert into sys_dict_type values(22, '未分配金额类型',   'unappropriated_type',   '0', 'admin', sysdate(), '', null, '未分配金额类型列表');

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
  is_default       char(1)         default 'N'                comment '是否默认（Y是 N否）',
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
insert into sys_dict_data values(1,  1,  '男',       '0',       'sys_user_sex',        '',   '',        'Y', '0', 'admin', sysdate(), '', null, '性别男');
insert into sys_dict_data values(2,  2,  '女',       '1',       'sys_user_sex',        '',   '',        'N', '0', 'admin', sysdate(), '', null, '性别女');
insert into sys_dict_data values(3,  3,  '未知',     '2',       'sys_user_sex',        '',   '',        'N', '0', 'admin', sysdate(), '', null, '性别未知');
insert into sys_dict_data values(4,  1,  '显示',     '0',       'sys_show_hide',       '',   'primary', 'Y', '0', 'admin', sysdate(), '', null, '显示菜单');
insert into sys_dict_data values(5,  2,  '隐藏',     '1',       'sys_show_hide',       '',   'danger',  'N', '0', 'admin', sysdate(), '', null, '隐藏菜单');
insert into sys_dict_data values(6,  1,  '正常',     '0',       'sys_normal_disable',  '',   'primary', 'Y', '0', 'admin', sysdate(), '', null, '正常状态');
insert into sys_dict_data values(7,  2,  '停用',     '1',       'sys_normal_disable',  '',   'danger',  'N', '0', 'admin', sysdate(), '', null, '停用状态');
insert into sys_dict_data values(8,  1,  '正常',     '0',       'sys_job_status',      '',   'primary', 'Y', '0', 'admin', sysdate(), '', null, '正常状态');
insert into sys_dict_data values(9,  2,  '暂停',     '1',       'sys_job_status',      '',   'danger',  'N', '0', 'admin', sysdate(), '', null, '停用状态');
insert into sys_dict_data values(10, 1,  '默认',     'default', 'sys_job_group',       '',   '',        'Y', '0', 'admin', sysdate(), '', null, '默认分组');
insert into sys_dict_data values(11, 2,  '系统',     'system',  'sys_job_group',       '',   '',        'N', '0', 'admin', sysdate(), '', null, '系统分组');
insert into sys_dict_data values(12, 1,  '是',       'y',       'sys_yes_no',          '',   'primary', 'Y', '0', 'admin', sysdate(), '', null, '系统默认是');
insert into sys_dict_data values(13, 2,  '否',       'N',       'sys_yes_no',          '',   'danger',  'N', '0', 'admin', sysdate(), '', null, '系统默认否');
insert into sys_dict_data values(14, 1,  '通知',     '1',       'sys_notice_type',     '',   'warning', 'Y', '0', 'admin', sysdate(), '', null, '通知');
insert into sys_dict_data values(15, 2,  '公告',     '2',       'sys_notice_type',     '',   'success', 'N', '0', 'admin', sysdate(), '', null, '公告');
insert into sys_dict_data values(16, 1,  '正常',     '0',       'sys_notice_status',   '',   'primary', 'Y', '0', 'admin', sysdate(), '', null, '正常状态');
insert into sys_dict_data values(17, 2,  '关闭',     '1',       'sys_notice_status',   '',   'danger',  'N', '0', 'admin', sysdate(), '', null, '关闭状态');
insert into sys_dict_data values(18, 99, '其他',     '0',       'sys_oper_type',       '',   'info',    'N', '0', 'admin', sysdate(), '', null, '其他操作');
insert into sys_dict_data values(19, 1,  '新增',     '1',       'sys_oper_type',       '',   'info',    'N', '0', 'admin', sysdate(), '', null, '新增操作');
insert into sys_dict_data values(20, 2,  '修改',     '2',       'sys_oper_type',       '',   'info',    'N', '0', 'admin', sysdate(), '', null, '修改操作');
insert into sys_dict_data values(21, 3,  '删除',     '3',       'sys_oper_type',       '',   'danger',  'N', '0', 'admin', sysdate(), '', null, '删除操作');
insert into sys_dict_data values(22, 4,  '授权',     '4',       'sys_oper_type',       '',   'primary', 'N', '0', 'admin', sysdate(), '', null, '授权操作');
insert into sys_dict_data values(23, 5,  '导出',     '5',       'sys_oper_type',       '',   'warning', 'N', '0', 'admin', sysdate(), '', null, '导出操作');
insert into sys_dict_data values(24, 6,  '导入',     '6',       'sys_oper_type',       '',   'warning', 'N', '0', 'admin', sysdate(), '', null, '导入操作');
insert into sys_dict_data values(25, 7,  '强退',     '7',       'sys_oper_type',       '',   'danger',  'N', '0', 'admin', sysdate(), '', null, '强退操作');
insert into sys_dict_data values(26, 8,  '生成代码', 	'8',       'sys_oper_type',       '',   'warning', 'N', '0', 'admin', sysdate(), '', null, '生成操作');
insert into sys_dict_data values(27, 9,  '清空数据', 	'9',       'sys_oper_type',       '',   'danger',  'N', '0', 'admin', sysdate(), '', null, '清空操作');
insert into sys_dict_data values(28, 1,  '成功',     '0',       'sys_common_status',   '',   'primary', 'N', '0', 'admin', sysdate(), '', null, '正常状态');
insert into sys_dict_data values(29, 2,  '失败',     '1',       'sys_common_status',   '',   'danger',  'N', '0', 'admin', sysdate(), '', null, '停用状态');
-- 进销存字典数据
insert into sys_dict_data values(30, 1,  '采购订单',                '1',    'order_form_type',          '',   'danger',  'N', '0', 'admin', sysdate(), '', null, null);
insert into sys_dict_data values(31, 2,  '销售订单',                '2',    'order_form_type',          '',   'primary', 'N', '0', 'admin', sysdate(), '', null, null);
insert into sys_dict_data values(32, 1,  '待审核',                  '1',    'order_form_status',        '',   'primary', 'N', '0', 'admin', sysdate(), '', null, null);
insert into sys_dict_data values(33, 2,  '已审核',                  '2',    'order_form_status',        '',   'success', 'N', '0', 'admin', sysdate(), '', null, null);
insert into sys_dict_data values(34, 0,  '采购入库', 								'1', 		'receipt_type',             '',   'success', 'N', '0', 'admin', sysdate(), '', null, null);
insert into sys_dict_data values(35, 1,  '采购退库', 								'2', 		'receipt_type',             '',   'danger',  'N', '0', 'admin', sysdate(), '', null, null);
insert into sys_dict_data values(36, 2,  '销售出库', 								'3',  	'receipt_type',             '',   'primary', 'N', '0', 'admin', sysdate(), '', null, null);
insert into sys_dict_data values(37, 3,  '销售退库', 								'4', 		'receipt_type',             '',   'warning', 'N', '0', 'admin', sysdate(), '', null, null);
insert into sys_dict_data values(38, 4,  '其他入库', 								'5', 		'receipt_type',             '',   'info',    'N', '0', 'admin', sysdate(), '', null, null);
insert into sys_dict_data values(39, 5,  '其他出库', 								'6', 		'receipt_type',             '',   'success', 'N', '0', 'admin', sysdate(), '', null, null);
insert into sys_dict_data values(40, 6,  '库存调拨', 								'7', 		'receipt_type',             '',   'danger',  'N', '0', 'admin', sysdate(), '', null, null);
insert into sys_dict_data values(41, 7,  '库存盘点', 							  '8', 		'receipt_type',             '',   'primary', 'N', '0', 'admin', sysdate(), '', null, null);
insert into sys_dict_data values(42, 8,  '报损',                   '9',    'receipt_type',             '',   'warning', 'N', '0', 'admin', sysdate(), '', null, null);
insert into sys_dict_data values(43, 9,  '报溢',                   '10',   'receipt_type',             '',   'info',    'N', '0', 'admin', sysdate(), '', null, null);
insert into sys_dict_data values(44, 10, '商品拆装',                '11',   'receipt_type',             '',   'success',  'N', '0', 'admin', sysdate(), '', null, null);
insert into sys_dict_data values(45, 1,  '待审核',                  '1',    'receipt_status',           '',   'primary', 'N', '0', 'admin', sysdate(), '', null, null);
insert into sys_dict_data values(46, 2,  '已审核',                  '2',    'receipt_status',           '',   'success', 'N', '0', 'admin', sysdate(), '', null, null);
insert into sys_dict_data values(47, 1,  '待审核',                  '1',    'financial_review',        '',   'primary', 'N', '0', 'admin', sysdate(), '', null, null);
insert into sys_dict_data values(48, 2,  '已审核',                  '2',    'financial_review',        '',   'success', 'N', '0', 'admin', sysdate(), '', null, null);
insert into sys_dict_data values(49, 1,  '家装',                   '1',    'engineering_type',         '',   'success', 'N', '0', 'admin', sysdate(), '', null, null);
insert into sys_dict_data values(50, 2,  '工程',                   '2',    'engineering_type',         '',   'primary', 'N', '0', 'admin', sysdate(), '', null, null);
insert into sys_dict_data values(51, 1,  '售后安装',                '1',    'service_type',             '',   'success', 'N', '0', 'admin', sysdate(), '', null, null);
insert into sys_dict_data values(52, 1,  '是',	 										'0', 		'after_sales_installation', '',   'primary', 'N', '0', 'admin', sysdate(), '', null, null);
insert into sys_dict_data values(53, 2,  '否', 	 									'1', 		'after_sales_installation',	'',   'success', 'N', '0', 'admin', sysdate(), '', null, null);
insert into sys_dict_data values(54, 1,  '通过',	 									'0', 		'finding_of_audit',         '',   'success', 'N', '0', 'admin', sysdate(), '', null, null);
insert into sys_dict_data values(55, 2,  '不通过', 									'1', 		'finding_of_audit',         '',   'danger', 'N', '0', 'admin', sysdate(), '', null, null);
-- 财务字典数据
insert into sys_dict_data values(200, 1,  '付款单据',                '1',    'payment_type',      '',   'warning', 'N', '0', 'admin', sysdate(), '', null, null);
insert into sys_dict_data values(201, 2,  '收款单据',                '2',    'payment_type',      '',   'info',    'N', '0', 'admin', sysdate(), '', null, null);
insert into sys_dict_data values(202, 1,  '待审核',                  '1',    'payment_status',      '',   'primary', 'N', '0', 'admin', sysdate(), '', null, null);
insert into sys_dict_data values(203, 2,  '已审核',                  '2',    'payment_status',    '',   'success', 'N', '0', 'admin', sysdate(), '', null, null);
insert into sys_dict_data values(204, 1,  '否',                 '0',   'unappropriated_type',    '',   'primary', 'N', '0', 'admin', sysdate(), '', null, null);
insert into sys_dict_data values(205, 2,  '是',                '1',    'unappropriated_type',      '',   'danger',    'N', '0', 'admin', sysdate(), '', null, null);

-- ----------------------------
-- 13、参数配置表
-- ----------------------------
drop table if exists sys_config;
create table sys_config (
  config_id         int(5)          not null auto_increment    comment '参数主键',
  config_name       varchar(100)    default ''                 comment '参数名称',
  config_key        varchar(100)    default ''                 comment '参数键名',
  config_value      varchar(500)    default ''                 comment '参数键值',
  config_type       char(1)         default 'N'                comment '系统内置（Y是 N否）',
  create_by         varchar(64)     default ''                 comment '创建者',
  create_time       datetime                                   comment '创建时间',
  update_by         varchar(64)     default ''                 comment '更新者',
  update_time       datetime                                   comment '更新时间',
  remark            varchar(500)    default null               comment '备注',
  primary key (config_id)
) engine=innodb auto_increment=100 comment = '参数配置表';

insert into sys_config values(1, '主框架页-默认皮肤样式名称',     'sys.index.skinName',               'skin-blue',     'Y', 'admin', sysdate(), '', null, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow' );
insert into sys_config values(2, '用户管理-账号初始密码',         'sys.user.initPassword',            '123456',        'Y', 'admin', sysdate(), '', null, '初始化密码 123456' );
insert into sys_config values(3, '主框架页-侧边栏主题',           'sys.index.sideTheme',              'theme-dark',    'Y', 'admin', sysdate(), '', null, '深色主题theme-dark，浅色主题theme-light' );
insert into sys_config values(4, '账号自助-验证码开关',           'sys.account.captchaEnabled',       'true',          'Y', 'admin', sysdate(), '', null, '是否开启验证码功能（true开启，false关闭）');
insert into sys_config values(5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser',         'false',         'Y', 'admin', sysdate(), '', null, '是否开启注册用户功能（true开启，false关闭）');
insert into sys_config values(6, '用户登录-黑名单列表',           'sys.login.blackIPList',            '',              'Y', 'admin', sysdate(), '', null, '设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）');
insert into sys_config values(7, '用户管理-初始密码修改策略',     'sys.account.initPasswordModify',   '1',             'Y', 'admin', sysdate(), '', null, '0：初始密码修改策略关闭，没有任何提示，1：提醒用户，如果未修改初始密码，则在登录时就会提醒修改密码对话框');
insert into sys_config values(8, '用户管理-账号密码更新周期',     'sys.account.passwordValidateDays', '0',             'Y', 'admin', sysdate(), '', null, '密码更新周期（填写数字，数据初始化值为0不限制，若修改必须为大于0小于365的正整数），如果超过这个周期登录系统时，则在登录时就会提醒修改密码对话框');


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
insert into sys_notice values('1', '温馨提醒：2026-01-01 铠思新版本发布啦', '2', '新版本内容', '0', 'admin', sysdate(), '', null, '管理员');


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
  `systematic_id`		 		      bigint		 	      not null	 	auto_increment		comment '系统ID',
  `systematic_order_form` 		varchar(32)       default null	 		      		  comment '系统单号',
  `original_order_form` 		  varchar(64)       default null 						comment '原始单号',
  `order_form_type`           char(1)           default null 						comment '订单类型（1：采购订单，2：销售订单）',
  `order_form_status`         char(1)           default null 						comment '订单状态（1：待审核，2：已审核）',
  `order_date`                date              default null 						comment '订货日期',
  `delivery_date`             date              default null 						comment '开单日期',
  `warehousing_ids`           int               default null 						comment '入库仓库id',
  `retrieval_ids`             int               default null 						comment '出库仓库id',
  `user_ids`                  int               default null 						comment '经手人id',
  `supplier_ids`              int               default null 						comment '供应商id',
  `customer_ids`              int               default null 						comment '客户id',
  `plan_receipt`              varchar(64)       default null 						comment '计划单号',
  `order_form_notes`          varchar(128)      default null 						comment '备注',
  `deposit`                   decimal(14,2)     default null 						comment '定金',
  `order_form_amount`         decimal(14,2)     default null 						comment '总金额',
  `order_capitalize_amount` 	varchar(64)       default null 						comment '总金额(大写)',
  `after_sales_installation` 	int               default null 						comment '售后安装（0：是，1：否）',
  `finding_of_audit`          char(1) 		      default null 						comment '审核结果',
  `review_comments`           varchar(64)       default null 						comment '审核意见',
  `create_by`                 varchar(32)       default null 						comment '创建者',
  `create_time`               datetime          default null 						comment '创建时间',
  `update_by`                 varchar(32)       default null 						comment '更新者',
  `update_time` 				      datetime          default null 						comment '更新时间',
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
  `systematic_id`                 bigint		 	        not null 		auto_increment		comment '系统ID',
  `systematic_receipt`            varchar(32)         default null	 		      		  comment '系统单号',
  `original_receipt`              varchar(64)         default null 						comment '原始单号',
  `receipt_category`              char(1) 		        default null 						comment '单据类别（1：采购单据，2：销售单据，3：库存单据）',
  `receipt_type`                  char(2) 		        default null 						comment '单据类型（1：采购入库，2：采购退库，3：销售出库，4：销售退库，5：其他入库，6：其他出库，7：库存调拨，8：库存盘点，9：报损，10：报溢，11：商品拆装）',
  `financial_review`              char(1)             default null            comment '财务审核（1：待审核，2：已审核）',
  `receipt_status`                char(1) 		        default null 						comment '单据状态（1：待审核，2：已审核）',
  `invoice_date`                  date		 	          default null 						comment '开单日期',
  `warehousing_ids`               int		 		          default null 						comment '入库仓库id',
  `retrieval_ids`                 int		 		          default null 						comment '出库仓库id',
  `user_ids`                      int		 		          default null 						comment '经手人id',
  `supplier_ids`                  int		 		          default null 						comment '供应商id',
  `customer_ids`                  int		 		          default null 						comment '客户id',
  `plan_receipt`                  varchar(64)         default null 						comment '计划单号',
  `receipt_notes`                 varchar(128)        default null 						comment '备注',
  `deposit`                       decimal(14,2)       default null 						comment '定金',
  `total_amount`                  decimal(14,2)       default null 						comment '总金额',
  `capitalize_total_amount`       varchar(64)         default null 						comment '总金额(大写)',
  `after_sales_installation`      int                 default null 						comment '售后安装（0：是，1：否）',
  `finding_of_audit`              char(1)             default null 						comment '审核结果',
  `review_comments`               varchar(64)         default null 						comment '审核意见',
  `create_by`                     varchar(32)         default null 						comment '创建者',
  `create_time`                   datetime            default null 						comment '创建时间',
  `update_by`                     varchar(32)         default null 						comment '更新者',
  `update_time`                   datetime            default null 						comment '更新时间',
  primary key (systematic_id)
) engine=innodb auto_increment=1 comment='单据头表';

-- ----------------------------
-- 21、单据明细表
-- ----------------------------
drop table if exists detail_receipt;
create table `detail_receipt` (
  `systematic_id`                 bigint              not null 	auto_increment	comment '系统ID',
  `systematic_receipt`            varchar(32)         default null	      		comment '系统单号',
  `product_id`                    int                 default null            comment '货品ID',
  `product_specifications`        varchar(16)         default null            comment '商品规格',
  `measure_unit`                  varchar(16)         default null            comment '计量单位',
  `warehousing_id`                int                 default null            comment '入库仓库ID',
  `retrieval_id` 			            int                 default null            comment '出库仓库ID',
  `supplier_id`                   int                 default null            comment '供应商ID',
  `customer_id`                   int                 default null            comment '客户ID',
  `locked_goods`                  bigint              default 0               comment '锁单货品',
  `lock_inventory_qty`            bigint              default null            comment '锁单库存数量',
  `current_inventory`             bigint              default null            comment '当前库存量',
  `actual_inventory`              bigint              default null            comment '实际库存量',
  `plan_quantity`                 bigint              default null            comment '数量',
  `univalence`                    decimal(14,2)       default null            comment '单价',
  `discount`                      decimal(5,2)        default null            comment '折扣',
  `money`                         decimal(14,2)       default null            comment '金额',
  `cost`                          decimal(14,2)       default null            comment '成本',
  `remarks`                       varchar(64)         default null            comment '备注',
  `create_by`                     varchar(32)         default null            comment '创建者',
  `create_time`                   datetime            default null            comment '创建时间',
  `update_by`                     varchar(32)         default null            comment '更新者',
  `update_time`                   datetime            default null            comment '更新时间',
  primary key (systematic_id)
) engine=innodb auto_increment=1 comment='单据明细表';

-- ----------------------------
-- 20、单据头操作记录表
-- ----------------------------
drop table if exists head_receipt_log;
create table `head_receipt_log` (
  `head_log_id`                   bigint              not null    auto_increment    comment '日志ID',
  `systematic_receipt`            varchar(32)         default null                  comment '系统单号',
  `original_receipt`              varchar(64)         default null            comment '原始单号',
  `receipt_category`              char(1)             default null            comment '单据类别（1：采购单据，2：销售单据，3：库存单据）',
  `receipt_type`                  char(2)             default null            comment '单据类型（1：采购入库，2：采购退库，3：销售出库，4：销售退库，5：其他入库，6：其他出库，7：库存调拨，8：库存盘点，9：报损，10：报溢，11：商品拆装）',
  `financial_review`              char(1)             default null            comment '财务审核（1：待审核，2：已审核）',
  `receipt_status`                char(1)             default null            comment '单据状态（1：待审核，2：已审核）',
  `invoice_date`                  date                default null            comment '开单日期',
  `warehousing_ids`               int                 default null            comment '入库仓库id',
  `retrieval_ids`                 int                 default null            comment '出库仓库id',
  `user_ids`                      int                 default null            comment '经手人id',
  `supplier_ids`                  int                 default null            comment '供应商id',
  `customer_ids`                  int                 default null            comment '客户id',
  `plan_receipt`                  varchar(64)         default null            comment '计划单号',
  `receipt_notes`                 varchar(128)        default null            comment '备注',
  `deposit`                       decimal(14,2)       default null            comment '定金',
  `total_amount`                  decimal(14,2)       default null            comment '总金额',
  `capitalize_total_amount`       varchar(64)         default null            comment '总金额(大写)',
  `after_sales_installation`      int                 default null            comment '售后安装（0：是，1：否）',
  `finding_of_audit`              char(1)             default null            comment '审核结果',
  `review_comments`               varchar(64)         default null            comment '审核意见',
  `create_by`                     varchar(32)         default null            comment '创建者',
  `create_time`                   datetime            default null            comment '创建时间',
  `update_by`                     varchar(32)         default null            comment '更新者',
  `update_time`                   datetime            default null            comment '更新时间',
  primary key (head_log_id)
) engine=innodb auto_increment=1 comment='单据头操作记录表';

-- ----------------------------
-- 21、单据明细操作记录表
-- ----------------------------
drop table if exists detail_receipt_log;
create table `detail_receipt_log` (
  `detail_log_id`                 bigint              not null    auto_increment    comment '日志ID',
  `systematic_receipt`            varchar(32)         default null            comment '系统单号',
  `product_id`                    int                 default null            comment '货品ID',
  `product_specifications`        varchar(16)         default null            comment '商品规格',
  `measure_unit`                  varchar(16)         default null            comment '计量单位',
  `warehousing_id`                int                 default null            comment '入库仓库ID',
  `retrieval_id`                  int                 default null            comment '出库仓库ID',
  `supplier_id`                   int                 default null            comment '供应商ID',
  `customer_id`                   int                 default null            comment '客户ID',
  `locked_goods`                  bigint              default 0               comment '锁单货品',
  `lock_inventory_qty`            bigint              default null            comment '锁单库存数量',
  `current_inventory`             bigint              default null            comment '当前库存量',
  `actual_inventory`              bigint              default null            comment '实际库存量',
  `plan_quantity`                 bigint              default null            comment '数量',
  `univalence`                    decimal(14,2)       default null            comment '单价',
  `discount`                      decimal(5,2)        default null            comment '折扣',
  `money`                         decimal(14,2)       default null            comment '金额',
  `cost`                          decimal(14,2)       default null            comment '成本',
  `remarks`                       varchar(64)         default null            comment '备注',
  `create_by`                     varchar(32)         default null            comment '创建者',
  `create_time`                   datetime            default null            comment '创建时间',
  `update_by`                     varchar(32)         default null            comment '更新者',
  `update_time`                   datetime            default null            comment '更新时间',
  primary key (detail_log_id)
) engine=innodb auto_increment=1 comment='单据明细操作记录表';

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
-- 20、单据操作记录表
-- ----------------------------
drop table if exists document_operation_record;
create table `document_operation_record` (
  `log_id`                      bigint        not null        auto_increment      comment '操作记录ID',
  `systematic_id`               bigint        default null                        comment '系统ID',
  `systematic_receipt`          varchar(32)   default null                        comment '系统单号',
  `operate`                    varchar(32)   default null                        comment '操作步骤',
  `update_by`                   varchar(32)   default null                        comment '更新者',
  `update_time`                 datetime      default null                        comment '更新时间',
  primary key (log_id)
) engine=innodb auto_increment=1 comment='单据操作记录表';

-- ----------------------------
-- 20、配件查询表
-- ----------------------------
drop table if exists accessory;
create table `accessory` (
  `accessory_id`                bigint        not null    auto_increment      comment '配件id',
  `accessory_code`              varchar(64)                                   comment '配件编号',
  `accessory_name`              varchar(64)                                   comment '配件名称',
  `accessory_type`              varchar(64)                                   comment '配件类型',
  `accessory_specifications`    varchar(16)                                   comment '配件规格',
  `measure_unit`                varchar(16)                                   comment '计量单位',
  `producer`                    varchar(16)                                   comment '产地',
  `inventory_qty`               bigint        default 0                       comment '库存数量',
  `notes`                       varchar(64)                                   comment '备注',
  `status`                      char(1)       default 0                       comment '配件状态（0正常 1停用）',
  `create_by`                   varchar(16)   default ''                      comment '创建者',
  `create_time`                 datetime      default null                    comment '创建时间',
  `update_by`                   varchar(16)   default ''                      comment '更新者',
  `update_time`                 datetime      default null                    comment '更新时间',
  primary key (`accessory_id`)
) engine=innodb auto_increment=1 comment='配件查询表';

-- ----------------------------
-- 20、配件查询操作记录表
-- ----------------------------
drop table if exists accessory_operation_record;
create table `accessory_operation_record` (
  `log_id`                      bigint        not null        auto_increment      comment '操作记录ID',
  `accessory_id`                bigint                                            comment '配件id',
  `accessory_code`              varchar(64)                                       comment '配件编号',
  `accessory_name`              varchar(64)                                       comment '配件名称',
  `accessory_type`              varchar(64)                                       comment '配件类型',
  `accessory_specifications`    varchar(16)                                       comment '配件规格',
  `measure_unit`                varchar(16)                                       comment '计量单位',
  `producer`                    varchar(16)                                       comment '产地',
  `inventory_qty`               bigint        default 0                           comment '库存数量',
  `notes`                       varchar(64)                                       comment '备注',
  `status`                      char(1)       default 0                           comment '配件状态（0正常 1停用）',
  `update_by`                   varchar(32)   default null                        comment '更新者',
  `update_time`                 datetime      default null                        comment '更新时间',
  primary key (`log_id`)
) engine=innodb auto_increment=1 comment='配件查询操作记录表';

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
  `lock_inventory_qty`  bigint      default null          comment '锁单数量',
  `univalence` 				 decimal(14,2) 	default null 					comment '库存单价',
  `discount` 				   decimal(5,2) 	default null 					comment '库存折扣',
  `money` 					   decimal(14,2) 	default null 					comment '库存金额',
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
  `lock_inventory_qty`    bigint        default 0               comment '锁单库存数量',
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
-- 28、创建打印模板表
-- ----------------------------
drop table if exists print_template;
create table `print_template` (
  `template_id`         bigint          NOT NULL AUTO_INCREMENT   comment '主键',
  `template_name`       varchar(100)                              comment '模板名称',
  `html_content`        text                                      comment 'HTML内容',
  `css_content`         text                                      comment 'CSS内容',
  `js_content`          text                                      comment 'JS内容',
  `remark`              varchar(64)                               comment '备注',
  `create_by`           varchar(32)     default ''                comment '创建者',
  `create_time`         datetime        default null              comment '创建时间',
  `update_by`           varchar(32)     default ''                comment '更新者',
  `update_time`         datetime        default null              comment '更新时间',
  primary key (`template_id`)
) engine=innodb auto_increment=1 comment='打印模板表';



