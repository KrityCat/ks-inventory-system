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
insert into sys_dept values(100,  0,   '0',          '铠思科技',   0, 'kc', '15888888888', 'ks@qq.com', '0', '0', 'admin', sysdate(), '', null);

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
insert into sys_user values(2,  105, 'kc',    'kc', '00', 'kc@qq.com',  '15666666666', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', sysdate(), 'admin', sysdate(), '', null, '测试员');


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
insert into sys_role values('2', '普通角色',		'common', 2, 2, 1, 1, '0', '0', 'admin', sysdate(), '', null, '普通角色');

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
insert into sys_menu values(1, '采购管理', 0, 1, 'purchase', 		 null, '', 1, 0, 'M', '0', '0', '', 'shopping', 		'admin', sysdate(), '', null, '采购管理目录');
insert into sys_menu values(2, '销售管理', 0, 2, 'sales', 			 null, '', 1, 0, 'M', '0', '0', '', 'form', 			'admin', sysdate(), '', null, '销售管理目录');
insert into sys_menu values(3, '库存管理', 0, 3, 'inventory', 		 null, '', 1, 0, 'M', '0', '0', '', 'tab', 				'admin', sysdate(), '', null, '库存管理目录');
insert into sys_menu values(4, '基础数据', 0, 4, 'basedate', 		 null, '', 1, 0, 'M', '0', '0', '', 'documentation', 	'admin', sysdate(), '', null, '基础数据目录');
insert into sys_menu values(5, '系统管理', 0, 5, 'system',         null, '', 1, 0, 'M', '0', '0', '', 'system',   			'admin', sysdate(), '', null, '系统管理目录');
insert into sys_menu values(6, '系统监控', 0, 6, 'monitor',        null, '', 1, 0, 'M', '0', '0', '', 'monitor',  			'admin', sysdate(), '', null, '系统监控目录');
insert into sys_menu values(7, '系统工具', 0, 7, 'tool',           null, '', 1, 0, 'M', '0', '0', '', 'tool',     			'admin', sysdate(), '', null, '系统工具目录');
-- 二级菜单
-- 采购管理
insert into sys_menu values(20, '采购入库单制作', 	1, 1, 'warehouseReceipt', 						'system/purchase/WarehouseReceipt', 			null, 1, 1, 'C', '0', '0', '', 										'edit', 		'admin', sysdate(), '', null, '');
insert into sys_menu values(21, '采购退货单制作', 	1, 2, 'retreatWarehouse', 						'system/purchase/RetreatWarehouse', 			null, 1, 1, 'C', '0', '0', '', 										'log', 			'admin', sysdate(), '', null, '');
insert into sys_menu values(22, '采购单据查询', 	1, 3, 'purchaseDocumentQuery', 					'system/purchase/purchaseDocumentQuery', 		null, 1, 0, 'C', '0', '0', '', 										'clipboard', 	'admin', sysdate(), '', null, '');
-- 销售管理
insert into sys_menu values(30, '销售订单制作', 	2, 1, 'salesOrderProduction', 							'system/sales/salesOrderProduction', 					null, 1, 1, 'C', '0', '0', '', 										'shopping', 	'admin', sysdate(), '', null, '');
insert into sys_menu values(31, '销售出库单制作', 	2, 2, 'salesoutbound', 							'system/sales/salesOutbound', 					null, 1, 1, 'C', '0', '0', '', 										'shopping', 	'admin', sysdate(), '', null, '');
insert into sys_menu values(32, '销售退库单制作', 	2, 3, 'salesretreat', 							'system/sales/salesRetreat', 					null, 1, 1, 'C', '0', '0', '', 										'date-range', 	'admin', sysdate(), '', null, '');
insert into sys_menu values(33, '销售订单查询', 	2, 4, 'salesOrderQuery', 					'system/sales/salesOrderQuery', 				null, 1, 0, 'C', '0', '0', '', 										'search', 		'admin', sysdate(), '', null, '');
insert into sys_menu values(34, '销售单据查询', 	2, 5, 'salesdocumentquery', 					'system/sales/salesDocumentQuery', 				null, 1, 0, 'C', '0', '0', '', 										'search', 		'admin', sysdate(), '', null, '');
-- 库存管理
insert into sys_menu values(40, '其他入库单制作', 	3, 1, 'storageOther', 							'system/inventory/storageOther', 				null, 1, 1, 'C', '0', '0', '', 										'edit', 		'admin', sysdate(), '', null, '');
insert into sys_menu values(41, '其他出库单制作', 	3, 2, 'outboundOther', 							'system/inventory/outboundOther', 				null, 1, 1, 'C', '0', '0', '', 										'nested', 		'admin', sysdate(), '', null, '');
insert into sys_menu values(42, '库存调拨单制作', 	3, 3, 'inventoryTransfer', 						'system/inventory/InventoryTransfer', 			null, 1, 1, 'C', '0', '0', '', 										'redis-list', 	'admin', sysdate(), '', null, '');
insert into sys_menu values(43, '库存盘点单制作', 	3, 4, 'inventoryCounting', 						'system/inventory/InventoryCounting', 			null, 1, 1, 'C', '0', '0', '', 										'table', 		'admin', sysdate(), '', null, '');
insert into sys_menu values(44, '库存单据查询', 	3, 5, 'inventoryDocumentQuery', 				'system/inventory/InventoryDocumentQuery', 		null, 1, 0, 'C', '0', '0', '', 										'swagger', 		'admin', sysdate(), '', null, '');
insert into sys_menu values(45, '库存发生汇总', 	3, 6, 'inventoryOccurrenceSummary', 			'system/inventory/InventoryOccurrenceSummary', 	null, 1, 0, 'C', '0', '0', 'system:inventoryOccurrenceSummary:list','tree-table', 	'admin', sysdate(), '', null, '');
insert into sys_menu values(46, '库存发生明细', 	3, 7, 'inventoryOccurrenceDetails', 			'system/inventory/InventoryOccurrenceDetails', 	null, 1, 0, 'C', '0', '0', 'system:inventoryOccurrenceDetails:list','tree', 		'admin', sysdate(), '', null, '');
insert into sys_menu values(47, '库存货品查询', 	3, 8, 'inventoryItemInquiry', 					'system/inventory/InventoryItemInquiry', 		null, 1, 1, 'C', '0', '0', 'system:inventoryItemInquiry:list', 		'zip', 			'admin', sysdate(), '', null, '');
insert into sys_menu values(48, '历史单据迁移', 	3, 9, 'HistoricalDocuments', 					'system/inventory/HistoricalDocuments', 		null, 1, 0, 'C', '0', '0', 'system:historicalDocuments:head', 		'guide', 		'admin', sysdate(), '', null, '');
-- 基础数据
insert into sys_menu values(50, '供应商资料', 		4, 1, 'supplier', 								'system/basedate/supplier', 					null, 1, 0, 'C', '0', '0', 'baseDate:supplier:list', 				'clipboard', 	'admin', sysdate(), '', null, '');
insert into sys_menu values(51, '客户资料', 		4, 2, 'customer', 								'system/basedate/customer', 					null, 1, 0, 'C', '0', '0', 'baseDate:customer:list', 				'peoples', 		'admin', sysdate(), '', null, '');
insert into sys_menu values(52, '仓库资料', 		4, 3, 'warehouse', 								'system/basedate/warehouse', 					null, 1, 0, 'C', '0', '0', 'baseDate:warehouse:list', 				'table', 		'admin', sysdate(), '', null, '');
insert into sys_menu values(53, '商品资料', 		4, 4, 'commodity', 								'system/basedate/commodity', 					null, 1, 0, 'C', '0', '0', 'baseDate:commodity:list', 				'tab', 			'admin', sysdate(), '', null, '');
insert into sys_menu values(54, '商品类型', 		4, 5, 'commodityType', 							'system/basedate/commodityType', 				null, 1, 0, 'C', '0', '0', 'baseDate:commodityType:list', 			'tree-table', 	'admin', sysdate(), '', null, '');
insert into sys_menu values(55, '货品资料', 		4, 6, 'product', 								'system/basedate/product', 						null, 1, 0, 'C', '0', '0', 'baseDate:product:list', 				'tab', 			'admin', sysdate(), '', null, '');
insert into sys_menu values(56, '货品类型', 		4, 7, 'producttype', 							'system/basedate/productType', 					null, 1, 0, 'C', '0', '0', 'baseDate:productType:list', 			'tree-table', 	'admin', sysdate(), '', null, '');
insert into sys_menu values(57, '文件共享', 		4, 8, 'filesharing', 							'system/basedate/fileSharing', 					null, 1, 0, 'C', '0', '0', '', 										'excel', 		'admin', sysdate(), '', null, '');
insert into sys_menu values(58, '打印设计器', 		4, 9, 'http://localhost:8035/jmreport/list', 	'/jmreport/list', 								null, 1, 0, 'C', '0', '0', '', 										'component', 	'admin', sysdate(), '', null, '');
insert into sys_menu values(59, '打印调用IP', 		4, 10, 'http://localhost:8035', 					'/springboot', 									null, 1, 0, 'C', '1', '0', '', 										'component', 	'admin', sysdate(), '', null, '');
-- 系统管理
insert into sys_menu values('100',  '用户管理', 5,   '1', 'user',       'system/user/index',        '', 1, 0, 'C', '0', '0', 'system:user:list',        'user',          'admin', sysdate(), '', null, '用户管理菜单');
insert into sys_menu values('101',  '角色管理', 5,   '2', 'role',       'system/role/index',        '', 1, 0, 'C', '0', '0', 'system:role:list',        'peoples',       'admin', sysdate(), '', null, '角色管理菜单');
insert into sys_menu values('102',  '菜单管理', 5,   '3', 'menu',       'system/menu/index',        '', 1, 0, 'C', '0', '0', 'system:menu:list',        'tree-table',    'admin', sysdate(), '', null, '菜单管理菜单');
insert into sys_menu values('103',  '部门管理', 5,   '4', 'dept',       'system/dept/index',        '', 1, 0, 'C', '0', '0', 'system:dept:list',        'tree',          'admin', sysdate(), '', null, '部门管理菜单');
insert into sys_menu values('104',  '岗位管理', 5,   '5', 'post',       'system/post/index',        '', 1, 0, 'C', '0', '0', 'system:post:list',        'post',          'admin', sysdate(), '', null, '岗位管理菜单');
insert into sys_menu values('105',  '字典管理', 5,   '6', 'dict',       'system/dict/index',        '', 1, 0, 'C', '0', '0', 'system:dict:list',        'dict',          'admin', sysdate(), '', null, '字典管理菜单');
insert into sys_menu values('106',  '参数设置', 5,   '7', 'config',     'system/config/index',      '', 1, 0, 'C', '0', '0', 'system:config:list',      'edit',          'admin', sysdate(), '', null, '参数设置菜单');
insert into sys_menu values('107',  '通知公告', 5,   '8', 'notice',     'system/notice/index',      '', 1, 0, 'C', '0', '0', 'system:notice:list',      'message',       'admin', sysdate(), '', null, '通知公告菜单');
insert into sys_menu values('108',  '日志管理', 5,   '9', 'log',        '',                         '', 1, 0, 'M', '0', '0', '',                        'log',           'admin', sysdate(), '', null, '日志管理菜单');
insert into sys_menu values('109',  '在线用户', 6,   '1', 'online',     'monitor/online/index',     '', 1, 0, 'C', '0', '0', 'monitor:online:list',     'online',        'admin', sysdate(), '', null, '在线用户菜单');
insert into sys_menu values('110',  '定时任务', 6,   '2', 'job',        'monitor/job/index',        '', 1, 0, 'C', '0', '0', 'monitor:job:list',        'job',           'admin', sysdate(), '', null, '定时任务菜单');
insert into sys_menu values('111',  '数据监控', 6,   '3', 'druid',      'monitor/druid/index',      '', 1, 0, 'C', '0', '0', 'monitor:druid:list',      'druid',         'admin', sysdate(), '', null, '数据监控菜单');
insert into sys_menu values('112',  '服务监控', 6,   '4', 'server',     'monitor/server/index',     '', 1, 0, 'C', '0', '0', 'monitor:server:list',     'server',        'admin', sysdate(), '', null, '服务监控菜单');
insert into sys_menu values('113',  '缓存监控', 6,   '5', 'cache',      'monitor/cache/index',      '', 1, 0, 'C', '0', '0', 'monitor:cache:list',      'redis',         'admin', sysdate(), '', null, '缓存监控菜单');
insert into sys_menu values('114',  '缓存列表', 6,   '6', 'cachelist',  'monitor/cache/list',       '', 1, 0, 'C', '0', '0', 'monitor:cache:list',      'redis-list',    'admin', sysdate(), '', null, '缓存列表菜单');
insert into sys_menu values('115',  '表单构建', 7,   '1', 'build',      'tool/build/index',         '', 1, 0, 'C', '0', '0', 'tool:build:list',         'build',         'admin', sysdate(), '', null, '表单构建菜单');
insert into sys_menu values('116',  '代码生成', 7,   '2', 'gen',        'tool/gen/index',           '', 1, 0, 'C', '0', '0', 'tool:gen:list',           'code',          'admin', sysdate(), '', null, '代码生成菜单');
insert into sys_menu values('117',  '系统接口', 7,   '3', 'swagger',    'tool/swagger/index',       '', 1, 0, 'C', '0', '0', 'tool:swagger:list',       'swagger',       'admin', sysdate(), '', null, '系统接口菜单');
-- 三级菜单
-- 日志管理
insert into sys_menu values('500',  '操作日志', '108', '1', 'operlog',    'monitor/operlog/index',    '', 1, 0, 'C', '0', '0', 'monitor:operlog:list',    'form',          'admin', sysdate(), '', null, '操作日志菜单');
insert into sys_menu values('501',  '登录日志', '108', '2', 'logininfor', 'monitor/logininfor/index', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor',    'admin', sysdate(), '', null, '登录日志菜单');
-- 采购入库单制作按钮
insert into sys_menu values(700, '仓库选择', 			20, 1, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:warehouse:list', 						'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(701, '经手人选择', 		20, 2, '', null, null, 1, 0, 'F', '0', '0', 'system:user:list', 							'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(702, '供应商选择', 		20, 3, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:supplier:list', 						'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(703, '货品选择', 			20, 4, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:product:list', 						'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(704, '采购入库保存', 		20, 5, '', null, null, 1, 0, 'F', '0', '0', 'system:purchase:saveWarehouseReceipt', 		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(705, '采购入库修改', 		20, 6, '', null, null, 1, 0, 'F', '0', '0', 'system:purchase:systematicReceipt', 			'#', 'admin', sysdate(), '', null, '');
-- 采购退货单制作按钮
insert into sys_menu values(710, '仓库选择', 			21, 1, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:warehouse:list', 						'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(711, '经手人选择', 		21, 2, '', null, null, 1, 0, 'F', '0', '0', 'system:user:list', 							'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(712, '供应商选择', 		21, 3, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:supplier:list', 						'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(713, '货品选择', 			21, 4, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:product:list', 						'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(714, '采购退库保存', 		21, 5, '', null, null, 1, 0, 'F', '0', '0', 'system:purchase:saveRetreatWarehouse', 		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(715, '采购退库修改', 		21, 6, '', null, null, 1, 0, 'F', '0', '0', 'system:purchase:systematicReceipt', 			'#', 'admin', sysdate(), '', null, '');
-- 采购单据查询按钮
insert into sys_menu values(720, '采购单据查询', 		22, 1, '', null, null, 1, 0, 'F', '0', '0', 'system:purchase:PurchaseOrderQuery', 			'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(721, '采购单据明细查询', 	22, 2, '', null, null, 1, 0, 'F', '0', '0', 'system:purchase:PurchaseDetailOrderQuery', 	'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(722, '采购单据导出', 		22, 3, '', null, null, 1, 0, 'F', '0', '0', 'system:purchase:purchaseOrderExport', 			'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(723, '采购单据明细导出', 	22, 4, '', null, null, 1, 0, 'F', '0', '0', 'system:purchase:purchaseDetailOrderExport', 	'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(724, '采购单据打印', 		22, 5, '', null, null, 1, 0, 'F', '0', '0', 'system:purchase:printOut', 					'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(725, '单据打印域名', 		22, 6, '', null, null, 1, 0, 'F', '0', '0', 'system:menu:list', 							'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(726, '采购单据修改', 		22, 7, '', null, null, 1, 0, 'F', '0', '0', 'system:purchase:update', 						'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(727, '采购单据删除', 		22, 8, '', null, null, 1, 0, 'F', '0', '0', 'system:purchase:delete', 						'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(728, '采购单据详情', 		22, 9, '', null, null, 1, 0, 'F', '0', '0', 'system:purchase:systematicReceipt', 			'#', 'admin', sysdate(), '', null, '');
-- 销售订单制作按钮
insert into sys_menu values(730, '仓库选择', 			30, 1, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:warehouse:list', 						'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(731, '经手人选择', 		30, 2, '', null, null, 1, 0, 'F', '0', '0', 'system:user:list', 							'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(732, '客户选择', 			30, 3, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:customer:list', 						'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(733, '货品选择', 			30, 4, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:product:list', 						'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(734, '销售订单生效', 		30, 5, '', null, null, 1, 0, 'F', '0', '0', 'system:sales:takeEffectSalesOutbound', 		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(735, '销售订单保存', 		30, 6, '', null, null, 1, 0, 'F', '0', '0', 'system:sales:saveSalesOutbound', 				'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(736, '销售订单修改', 		30, 7, '', null, null, 1, 0, 'F', '0', '0', 'system:sales:systematicReceipt', 				'#', 'admin', sysdate(), '', null, '');
-- 销售出库单制作按钮
insert into sys_menu values(740, '仓库选择', 			31, 1, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:warehouse:list', 						'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(741, '经手人选择', 		31, 2, '', null, null, 1, 0, 'F', '0', '0', 'system:user:list', 							'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(742, '客户选择', 			31, 3, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:customer:list', 						'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(743, '货品选择', 			31, 4, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:product:list', 						'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(744, '销售出库生效', 		31, 5, '', null, null, 1, 0, 'F', '0', '0', 'system:sales:takeEffectSalesOutbound', 		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(745, '销售出库保存', 		31, 6, '', null, null, 1, 0, 'F', '0', '0', 'system:sales:saveSalesOutbound', 				'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(746, '销售出库修改', 		31, 7, '', null, null, 1, 0, 'F', '0', '0', 'system:sales:systematicReceipt', 				'#', 'admin', sysdate(), '', null, '');
-- 销售退库单制作按钮
insert into sys_menu values(750, '仓库选择', 			32, 1, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:warehouse:list', 						'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(751, '经手人选择', 		32, 2, '', null, null, 1, 0, 'F', '0', '0', 'system:user:list', 							'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(752, '客户选择', 			32, 3, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:customer:list', 						'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(753, '货品选择', 			32, 4, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:product:list', 						'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(754, '销售退库生效', 		32, 5, '', null, null, 1, 0, 'F', '0', '0', 'system:sales:takeEffectSalesRetreat', 			'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(755, '销售退库保存', 		32, 6, '', null, null, 1, 0, 'F', '0', '0', 'system:sales:saveSalesRetreat', 				'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(756, '销售退库修改', 		32, 7, '', null, null, 1, 0, 'F', '0', '0', 'system:sales:systematicReceipt', 				'#', 'admin', sysdate(), '', null, '');
-- 销售订单查询按钮
insert into sys_menu values(760, '销售单据查询', 		33, 1, '', null, null, 1, 0, 'F', '0', '0', 'system:sales:salesHeadQuery', 					'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(761, '销售单据明细查询', 	33, 2, '', null, null, 1, 0, 'F', '0', '0', 'system:sales:salesDetailQuery', 				'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(762, '销售单据导出', 		33, 3, '', null, null, 1, 0, 'F', '0', '0', 'system:sales:salesHeadExport', 				'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(763, '销售单据明细导出', 	33, 4, '', null, null, 1, 0, 'F', '0', '0', 'system:sales:salesDetailExport', 				'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(764, '销售单据打印', 		33, 5, '', null, null, 1, 0, 'F', '0', '0', 'system:sales:printOut', 						'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(765, '单据打印域名', 		33, 6, '', null, null, 1, 0, 'F', '0', '0', 'system:menu:list', 							'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(766, '销售单据修改', 		33, 7, '', null, null, 1, 0, 'F', '0', '0', 'system:sales:update', 							'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(767, '销售单据删除', 		33, 8, '', null, null, 1, 0, 'F', '0', '0', 'system:sales:delete', 							'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(768, '销售单据详情', 		33, 9, '', null, null, 1, 0, 'F', '0', '0', 'system:sales:systematicReceipt', 				'#', 'admin', sysdate(), '', null, '');
-- 销售单据查询按钮
insert into sys_menu values(770, '销售单据查询', 		34, 1, '', null, null, 1, 0, 'F', '0', '0', 'system:sales:salesHeadQuery', 					'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(771, '销售单据明细查询', 	34, 2, '', null, null, 1, 0, 'F', '0', '0', 'system:sales:salesDetailQuery', 				'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(772, '销售单据导出', 		34, 3, '', null, null, 1, 0, 'F', '0', '0', 'system:sales:salesHeadExport', 				'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(773, '销售单据明细导出', 	34, 4, '', null, null, 1, 0, 'F', '0', '0', 'system:sales:salesDetailExport', 				'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(774, '销售单据打印', 		34, 5, '', null, null, 1, 0, 'F', '0', '0', 'system:sales:printOut', 						'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(775, '单据打印域名', 		34, 6, '', null, null, 1, 0, 'F', '0', '0', 'system:menu:list', 							'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(776, '销售单据修改', 		34, 7, '', null, null, 1, 0, 'F', '0', '0', 'system:sales:update', 							'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(777, '销售单据删除', 		34, 8, '', null, null, 1, 0, 'F', '0', '0', 'system:sales:delete', 							'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(778, '销售单据详情', 		34, 9, '', null, null, 1, 0, 'F', '0', '0', 'system:sales:systematicReceipt', 				'#', 'admin', sysdate(), '', null, '');
-- 其他入库单制作按钮
insert into sys_menu values(780, '仓库选择', 			40, 1, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:warehouse:list', 						'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(781, '经手人选择', 		40, 2, '', null, null, 1, 0, 'F', '0', '0', 'system:user:list', 							'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(782, '供应商选择', 		40, 3, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:supplier:list', 						'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(783, '客户选择', 			40, 4, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:customer:list', 						'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(784, '货品选择', 			40, 5, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:product:list', 						'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(785, '其他入库保存', 		40, 6, '', null, null, 1, 0, 'F', '0', '0', 'system:inventory:saveStorageOther', 			'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(786, '其他入库修改', 		40, 7, '', null, null, 1, 0, 'F', '0', '0', 'system:inventory:systematicReceipt', 			'#', 'admin', sysdate(), '', null, '');
-- 其他出库单制作按钮
insert into sys_menu values(790, '仓库选择', 			41, 1, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:warehouse:list', 						'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(791, '经手人选择', 		41, 2, '', null, null, 1, 0, 'F', '0', '0', 'system:user:list', 							'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(792, '供应商选择', 		41, 3, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:supplier:list', 						'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(793, '客户选择', 			41, 4, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:customer:list', 						'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(794, '货品选择', 			41, 5, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:product:list', 						'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(795, '其他出库保存', 		41, 6, '', null, null, 1, 0, 'F', '0', '0', 'system:inventory:saveOutboundOther', 			'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(796, '其他出库修改', 		41, 7, '', null, null, 1, 0, 'F', '0', '0', 'system:inventory:systematicReceipt', 			'#', 'admin', sysdate(), '', null, '');
-- 库存调拨单制作按钮
insert into sys_menu values(800, '仓库选择', 			42, 1, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:warehouse:list', 						'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(801, '经手人选择', 		42, 2, '', null, null, 1, 0, 'F', '0', '0', 'system:user:list', 							'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(802, '供应商选择', 		42, 3, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:supplier:list', 						'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(803, '客户选择', 			42, 4, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:customer:list', 						'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(804, '货品选择', 			42, 5, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:product:list', 						'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(805, '库存调拨保存', 		42, 6, '', null, null, 1, 0, 'F', '0', '0', 'system:inventory:saveInventoryTransfer', 		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(806, '库存调拨修改', 		42, 7, '', null, null, 1, 0, 'F', '0', '0', 'system:inventory:systematicReceipt', 			'#', 'admin', sysdate(), '', null, '');
-- 库存盘点单制作按钮
insert into sys_menu values(810, '仓库选择', 			43, 1, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:warehouse:list', 						'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(811, '经手人选择', 		43, 2, '', null, null, 1, 0, 'F', '0', '0', 'system:user:list', 							'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(812, '货品选择', 			43, 3, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:product:list', 						'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(813, '库存盘点保存', 		43, 4, '', null, null, 1, 0, 'F', '0', '0', 'system:inventory:saveInventoryCounting', 		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(814, '库存盘点修改', 		43, 5, '', null, null, 1, 0, 'F', '0', '0', 'system:inventory:systematicReceipt', 			'#', 'admin', sysdate(), '', null, '');
-- 库存单据查询按钮
insert into sys_menu values(820, '库存单据查询', 		44, 1, '', null, null, 1, 0, 'F', '0', '0', 'system:inventory:headReceiptQuery', 			'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(821, '库存单据明细查询', 	44, 2, '', null, null, 1, 0, 'F', '0', '0', 'system:inventory:detailReceiptQuery', 			'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(822, '库存单据导出', 		44, 3, '', null, null, 1, 0, 'F', '0', '0', 'system:inventory:headReceiptExport', 			'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(823, '库存单据明细导出', 	44, 4, '', null, null, 1, 0, 'F', '0', '0', 'system:inventory:detailReceiptExport', 		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(824, '库存单据打印', 		44, 5, '', null, null, 1, 0, 'F', '0', '0', 'system:inventory:printOut', 					'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(825, '单据打印域名', 		44, 6, '', null, null, 1, 0, 'F', '0', '0', 'system:menu:list', 							'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(826, '库存单据修改', 		44, 7, '', null, null, 1, 0, 'F', '0', '0', 'system:inventory:update', 						'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(827, '库存单据删除', 		44, 8, '', null, null, 1, 0, 'F', '0', '0', 'system:inventory:delete', 						'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(828, '库存单据详情', 		44, 9, '', null, null, 1, 0, 'F', '0', '0', 'system:inventory:systematicReceipt', 			'#', 'admin', sysdate(), '', null, '');
-- 库存发生汇总按钮
insert into sys_menu values(830, '库存发生汇总查询', 	45, 1, '', null, null, 1, 0, 'F', '0', '0', 'system:inventoryOccurrenceSummary:list', 		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(831, '库存发生汇总导出', 	45, 2, '', null, null, 1, 0, 'F', '0', '0', 'system:inventoryOccurrenceSummary:export', 	'#', 'admin', sysdate(), '', null, '');
-- 库存发生明细按钮
insert into sys_menu values(840, '库存发生明细查询', 	46, 1, '', null, null, 1, 0, 'F', '0', '0', 'system:inventoryOccurrenceDetails:list', 		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(841, '库存发生明细导出', 	46, 2, '', null, null, 1, 0, 'F', '0', '0', 'system:inventoryOccurrenceDetails:export', 	'#', 'admin', sysdate(), '', null, '');
-- 库存货品查询按钮
insert into sys_menu values(850, '库存货品查询', 		47, 1, '', null, null, 1, 0, 'F', '0', '0', 'system:inventoryItemInquiry:list', 			'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(851, '库存货品导出', 		47, 2, '', null, null, 1, 0, 'F', '0', '0', 'system:inventoryItemInquiry:export', 			'#', 'admin', sysdate(), '', null, '');
-- 历史单据迁移
insert into sys_menu values(860, '单据头表查询', 		48, 1, '', null, null, 1, 0, 'F', '0', '0', 'system:historicalDocuments:head', 					'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(861, '单据明细查询', 		48, 2, '', null, null, 1, 0, 'F', '0', '0', 'system:historicalDocuments:detail', 				'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(862, '单据详情', 			48, 3, '', null, null, 1, 0, 'F', '0', '0', 'system:historicalDocuments:SystematicReceipt', 	'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(863, '单据删除', 			48, 4, '', null, null, 1, 0, 'F', '0', '0', 'system:historicalDocuments:delete', 				'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(864, '单据头表导入', 		48, 5, '', null, null, 1, 0, 'F', '0', '0', 'system:historicalDocuments:importHeadData', 		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(865, '单据明细导入', 		48, 6, '', null, null, 1, 0, 'F', '0', '0', 'system:historicalDocuments:importDetailData', 		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(866, '单据头表导出', 		48, 7, '', null, null, 1, 0, 'F', '0', '0', 'system:historicalDocuments:headReceiptExport', 	'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(867, '单据明细导出', 		48, 8, '', null, null, 1, 0, 'F', '0', '0', 'system:historicalDocuments:detailReceiptExport',	'#', 'admin', sysdate(), '', null, '');
-- 供应商资料按钮
insert into sys_menu values(870, '供应商查询', 		50, 1, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:supplier:list', 						'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(871, '供应商详情', 		50, 2, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:supplier:query', 						'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(872, '供应商新增', 		50, 3, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:supplier:add', 						'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(873, '供应商修改', 		50, 4, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:supplier:update', 					'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(874, '供应商删除', 		50, 5, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:supplier:remove', 					'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(875, '供应商导入', 		50, 6, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:supplier:import', 					'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(876, '供应商导出', 		50, 7, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:supplier:export', 					'#', 'admin', sysdate(), '', null, '');
-- 客户资料按钮
insert into sys_menu values(880, '客户查询', 			51, 1, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:customer:list', 						'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(881, '客户详情', 			51, 2, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:customer:query', 						'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(882, '客户新增', 			51, 3, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:customer:add', 						'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(883, '客户修改', 			51, 4, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:customer:update', 					'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(884, '客户删除', 			51, 5, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:customer:remove', 					'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(885, '客户导入', 			51, 6, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:customer:import', 					'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(886, '客户导出', 			51, 7, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:customer:export', 					'#', 'admin', sysdate(), '', null, '');
-- 仓库资料按钮
insert into sys_menu values(890, '仓库查询', 			52, 1, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:warehouse:list', 						'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(891, '仓库详情', 			52, 2, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:warehouse:query', 					'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(892, '仓库新增', 			52, 3, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:warehouse:add', 						'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(893, '仓库修改', 			52, 4, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:warehouse:update', 					'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(894, '仓库删除', 			52, 5, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:warehouse:remove', 					'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(895, '仓库导入', 			52, 6, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:warehouse:import', 					'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(896, '仓库导出', 			52, 7, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:warehouse:export', 					'#', 'admin', sysdate(), '', null, '');
-- 商品资料按钮
insert into sys_menu values(900, '商品类型', 			53, 1, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:commodity:commodityTypeTree', 		'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(901, '商品查询', 			53, 2, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:commodity:list', 						'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(902, '商品详情', 			53, 3, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:commodity:query', 					'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(903, '商品新增', 			53, 4, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:commodity:add', 						'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(904, '商品修改', 			53, 5, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:commodity:update', 					'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(905, '商品删除', 			53, 6, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:commodity:remove', 					'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(906, '商品导入', 			53, 7, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:commodity:import', 					'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(907, '商品导出', 			53, 8, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:commodity:export', 					'#', 'admin', sysdate(), '', null, '');
-- 商品类型按钮
insert into sys_menu values(910, '商品类型查询',		54, 1, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:commodityType:list',					'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(911, '商品类型详情',		54, 2, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:commodityType:query',					'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(912, '商品类型新增',		54, 3, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:commodityType:add',					'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(913, '商品类型修改',		54, 4, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:commodityType:edit',					'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(914, '商品类型删除',		54, 5, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:commodityType:remove',				'#', 'admin', sysdate(), '', null, '');
-- 货品资料按钮
insert into sys_menu values(920, '货品类型', 			55, 1, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:product:productTypeTree', 			'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(921, '货品查询', 			55, 2, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:product:list', 						'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(922, '货品详情', 			55, 3, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:product:query', 						'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(923, '货品新增', 			55, 4, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:product:add', 						'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(924, '货品修改', 			55, 5, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:product:update', 						'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(925, '货品删除', 			55, 6, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:product:remove', 						'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(926, '货品导入', 			55, 7, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:product:import', 						'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(927, '货品导出', 			55, 8, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:product:export', 						'#', 'admin', sysdate(), '', null, '');
-- 货品类型按钮
insert into sys_menu values(930, '货品类型查询', 		56, 1, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:productType:list', 					'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(931, '货品类型详情', 		56, 2, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:productType:query', 					'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(932, '货品类型新增', 		56, 3, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:productType:add', 					'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(933, '货品类型修改', 		56, 4, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:productType:edit', 					'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(934, '货品类型删除', 		56, 5, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:productType:remove', 					'#', 'admin', sysdate(), '', null, '');
-- 文件共享按钮
insert into sys_menu values(940, '文件共享查询', 		57, 1, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:fileSharing:list', 					'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(941, '文件共享详情', 		57, 2, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:fileSharing:query', 					'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(942, '文件共享上传', 		57, 3, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:fileSharing:upload', 					'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(943, '文件共享修改', 		57, 4, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:fileSharing:update', 					'#', 'admin', sysdate(), '', null, '');
insert into sys_menu values(944, '文件共享删除', 		57, 5, '', null, null, 1, 0, 'F', '0', '0', 'baseDate:fileSharing:remove', 					'#', 'admin', sysdate(), '', null, '');
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
insert into sys_user_role values ('2', '2');


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
insert into sys_role_dept values ('2', '100');
insert into sys_role_dept values ('2', '101');
insert into sys_role_dept values ('2', '105');


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
insert into sys_user_post values ('2', '2');


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
insert into sys_dict_data values(26, 8,  '生成代码', '8',       'sys_oper_type',       '',   'warning', 'n', '0', 'admin', sysdate(), '', null, '生成操作');
insert into sys_dict_data values(27, 9,  '清空数据', '9',       'sys_oper_type',       '',   'danger',  'n', '0', 'admin', sysdate(), '', null, '清空操作');
insert into sys_dict_data values(28, 1,  '成功',     '0',       'sys_common_status',   '',   'primary', 'n', '0', 'admin', sysdate(), '', null, '正常状态');
insert into sys_dict_data values(29, 2,  '失败',     '1',       'sys_common_status',   '',   'danger',  'n', '0', 'admin', sysdate(), '', null, '停用状态');
insert into sys_dict_data values(30, 0,  '采购入库', '1', 		'receipt_type', 	   '',   'success', 'n', '0', 'admin', sysdate(), '', null, null);
insert into sys_dict_data values(31, 1,  '采购退库', '2', 		'receipt_type', 	   '',   'danger',  'n', '0', 'admin', sysdate(), '', null, null);
insert into sys_dict_data values(32, 2,  '销售出库', '3',  	    'receipt_type', 	   '',   'primary', 'n', '0', 'admin', sysdate(), '', null, null);
insert into sys_dict_data values(33, 3,  '销售退库', '4', 		'receipt_type', 	   '',   'warning', 'n', '0', 'admin', sysdate(), '', null, null);
insert into sys_dict_data values(34, 1,  '拟制',	 '1', 		'receipt_status', 	   '',   'primary', 'n', '0', 'admin', sysdate(), '', null, null);
insert into sys_dict_data values(35, 2,  '生效', 	 '2', 		'receipt_status',	   '',   'success', 'n', '0', 'admin', sysdate(), '', null, null);
insert into sys_dict_data values(36, 4,  '其他入库', '5', 		'receipt_type',		   '',   'info',    'n', '0', 'admin', sysdate(), '', null, null);
insert into sys_dict_data values(37, 5,  '其他出库', '6', 		'receipt_type',        '',   'success', 'n', '0', 'admin', sysdate(), '', null, null);
insert into sys_dict_data values(38, 6,  '库存调拨', '7', 		'receipt_type',        '',   'danger',  'n', '0', 'admin', sysdate(), '', null, null);
insert into sys_dict_data values(39, 7,  '库存盘点', '8', 		'receipt_type',        '',   'primary', 'n', '0', 'admin', sysdate(), '', null, null);

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
insert into sys_config values(4, '账号自助-验证码开关',           'sys.account.captchaenabled',    'true',          'y', 'admin', sysdate(), '', null, '是否开启验证码功能（true开启，false关闭）');
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
insert into sys_notice values('1', '温馨提醒：2024-03-20 KS新版本发布啦', '2', '新版本内容', '0', 'admin', sysdate(), '', null, '管理员');
insert into sys_notice values('2', '维护通知：2024-03-20 KS系统凌晨维护', '1', '维护内容',   '0', 'admin', sysdate(), '', null, '管理员');


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
  java_type         varchar(500)                               comment 'java类型',
  java_field        varchar(200)                               comment 'java字段名',
  is_pk             char(1)                                    comment '是否主键（1是）',
  is_increment      char(1)                                    comment '是否自增（1是）',
  is_required       char(1)                                    comment '是否必填（1是）',
  is_insert         char(1)                                    comment '是否为插入字段（1是）',
  is_edit           char(1)                                    comment '是否编辑字段（1是）',
  is_list           char(1)                                    comment '是否列表字段（1是）',
  is_query          char(1)                                    comment '是否查询字段（1是）',
  query_type        varchar(200)    default 'eq'               comment '查询方式（等于、不等于、大于、小于、范围）',
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
  `systematic_order_form` 		varchar(32) 	default null 		      			comment '系统单号',
  `original_order_form` 		varchar(64) 	default null 						comment '原始单号',
  `order_form_type` 			bigint 			default null 						comment '订单类型（1：采购订单，2：销售订单，3：库存订单）',
  `order_form_status` 			bigint 			default null 						comment '订单状态（1：拟制，2：生效）',
  `invoice_date` 			varchar(16) 	default null 						comment '开单日期',
  `warehousing_ids` 		varchar(8) 		default null 						comment '入库仓库id',
  `retrieval_ids` 			varchar(8) 		default null 						comment '出库仓库id',
  `user_ids` 				varchar(8) 		default null 						comment '经手人id',
  `supplier_ids` 			varchar(8) 		default null 						comment '供应商id',
  `customer_ids` 			varchar(8) 		default null 						comment '客户id',
  `plan_receipt` 			varchar(64) 	default null 						comment '计划单号',
  `order_form_notes` 			varchar(128) 	default null 						comment '备注',
  `deposit` 				varchar(64) 	default null 						comment '定金',
  `total_amount` 			varchar(64) 	default null 						comment '总金额',
  `capitalize_total_amount` varchar(64) 	default null 						comment '总金额(大写)',
  `create_by` 				varchar(32) 	default null 						comment '创建者',
  `create_time` 			datetime 		default null 						comment '创建时间',
  `update_by` 				varchar(32) 	default null 						comment '更新者',
  `update_time` 			datetime 		default null 						comment '更新时间'
) engine=innodb comment='订单头表';

-- ----------------------------
-- 21、订单明细表
-- ----------------------------
drop table if exists detail_order_form;
create table `detail_order_form` (
  `systematic_order_form` 		varchar(32) 	default null      			comment '系统单号',
  `product_id` 				varchar(32) 	default null 				comment '货品编号',
  `warehousing_id`			varchar(8) 		default null 				comment ' 入库仓库id',
  `retrieval_id` 			varchar(8) 		default null 				comment ' 出库仓库id',
  `supplier_id` 			varchar(8) 		default null 				comment '供应商id',
  `customer_id` 			varchar(8) 		default null 				comment '客户id',
  `current_inventory` 		varchar(32) 	default null 				comment '当前库存量',
  `actual_inventory` 		varchar(32) 	default null 				comment '实际库存量',
  `plan_quantity` 			int 			default null 				comment '数量',
  `univalence` 				double 			default null 				comment '单价',
  `discount` 				double 			default null 				comment '折扣',
  `money` 					double 			default null 				comment '金额',
  `cost` 					double 			default null 				comment '成本',
  `remarks` 				varchar(64) 	default null 				comment '备注'
) engine=innodb comment='订单明细表';

-- ----------------------------
-- 20、单据头表
-- ----------------------------
drop table if exists head_receipt;
create table `head_receipt` (
  `systematic_receipt` 		varchar(32) 	default null 		      			comment '系统单号',
  `original_receipt` 		varchar(64) 	default null 						comment '原始单号',
  `receipt_category` 		bigint 			default null 						comment '单据类别（1：采购单据，2：销售单据，3：库存单据）',
  `receipt_type` 			bigint 			default null 						comment '单据类型（1：采购入库，2：采购退库，3：销售出库，4：销售退库，5：其他入库，6：其他出库，7：库存调拨，8：库存盘点）',
  `receipt_status` 			bigint 			default null 						comment '单据状态（1：拟制，2：生效）',
  `invoice_date` 			varchar(16) 	default null 						comment '开单日期',
  `warehousing_ids` 		varchar(8) 		default null 						comment '入库仓库id',
  `retrieval_ids` 			varchar(8) 		default null 						comment '出库仓库id',
  `user_ids` 				varchar(8) 		default null 						comment '经手人id',
  `supplier_ids` 			varchar(8) 		default null 						comment '供应商id',
  `customer_ids` 			varchar(8) 		default null 						comment '客户id',
  `plan_receipt` 			varchar(64) 	default null 						comment '计划单号',
  `receipt_notes` 			varchar(128) 	default null 						comment '备注',
  `deposit` 				varchar(64) 	default null 						comment '定金',
  `total_amount` 			varchar(64) 	default null 						comment '总金额',
  `capitalize_total_amount` varchar(64) 	default null 						comment '总金额(大写)',
  `create_by` 				varchar(32) 	default null 						comment '创建者',
  `create_time` 			datetime 		default null 						comment '创建时间',
  `update_by` 				varchar(32) 	default null 						comment '更新者',
  `update_time` 			datetime 		default null 						comment '更新时间'
) engine=innodb comment='单据头表';

-- ----------------------------
-- 21、单据明细表
-- ----------------------------
drop table if exists detail_receipt;
create table `detail_receipt` (
  `systematic_receipt` 		varchar(32) 	default null      			comment '系统单号',
  `product_id` 				varchar(32) 	default null 				comment '货品编号',
  `warehousing_id`			varchar(8) 		default null 				comment ' 入库仓库id',
  `retrieval_id` 			varchar(8) 		default null 				comment ' 出库仓库id',
  `supplier_id` 			varchar(8) 		default null 				comment '供应商id',
  `customer_id` 			varchar(8) 		default null 				comment '客户id',
  `current_inventory` 		varchar(32) 	default null 				comment '当前库存量',
  `actual_inventory` 		varchar(32) 	default null 				comment '实际库存量',
  `plan_quantity` 			int 			default null 				comment '数量',
  `univalence` 				double 			default null 				comment '单价',
  `discount` 				double 			default null 				comment '折扣',
  `money` 					double 			default null 				comment '金额',
  `cost` 					double 			default null 				comment '成本',
  `remarks` 				varchar(64) 	default null 				comment '备注'
) engine=innodb comment='单据明细表';

-- ----------------------------
-- 22、库存货品查询表
-- ----------------------------
drop table if exists inventory_product;
create table `inventory_product` (
  `inventory_id` 			bigint 			not null 		auto_increment 	comment '库存货品id',
  `product_id` 				varchar(32) 	default null 					comment '货品编号',
  `warehouse_id` 			varchar(8) 		default null 					comment '仓库id',
  `supplier_id` 			varchar(8) 		default null 					comment '供应商id',
  `plan_quantity` 			varchar(32) 	default null 					comment '库存数量',
  `univalence` 				varchar(32) 	default null 					comment '库存单价',
  `discount` 				varchar(32) 	default null 					comment '库存折扣',
  `money` 					varchar(32) 	default null 					comment '库存金额',
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
  `remarks` 						varchar(200) 											comment '备注',
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
  `commodity_id` 					bigint 				not null 		auto_increment 			comment '商品id',
  `commodity_code` 				varchar(64) 					 							comment '商品编号',
  `commodity_name` 				varchar(64) 												comment '商品名称',
  `commodity_type` 				varchar(64) 												comment '商品类型',
  `commodity_specifications` 	varchar(16) 												comment '商品规格',
  `measure_unit` 				varchar(16) 												comment '计量单位',
  `producer` 					varchar(16) 												comment '产地',
  `cost_price` 					char(20) 													comment '成本价',
  `price` 						char(20) 													comment '参考售价',
  `product_barcode` 			varchar(64) 												comment '商品条码',
  `upper_limit` 				char(10) 													comment '库存上限',
  `lower_limit` 				char(10) 													comment '库存下限',
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
  `product_type` 				varchar(64) 												comment '货品类型',
  `product_specifications` 		varchar(16) 												comment '商品规格',
  `measure_unit` 				varchar(16) 												comment '计量单位',
  `producer` 					varchar(16) 												comment '产地',
  `cost_price` 					char(20) 													comment '成本价',
  `price` 						char(20) 													comment '参考售价',
  `product_barcode` 			varchar(64) 												comment '货品条码',
  `upper_limit` 				char(10) 													comment '库存上限',
  `lower_limit` 				char(10) 													comment '库存下限',
  `default_warehouse` 			varchar(16) 												comment '默认仓库',
  `notes` 						varchar(64) 												comment '备注',
  `status` 						char(1) 			default '0' 							comment '货品状态（0正常 1停用）',
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
  `file_name` 				varchar(128) 														comment '文件名称',
  `file_url` 				varchar(128) 														comment '文件',
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
INSERT INTO jimu_report VALUES('957623614502789120', '20240603232403', '送货结算单', NULL, NULL, 'printinfo', '{"loopBlockList":[],"area":{"sri":18,"sci":2,"eri":18,"eci":6,"width":378,"height":25},"excel_config_id":"957623614502789120","printConfig":{"paper":"A4","width":210,"height":297,"definition":10,"isBackend":false,"marginX":10,"marginY":10,"layout":"portrait","printCallBackUrl":"","paginationShow":false,"paginationLocation":"middle"},"hiddenCells":[],"zonedEditionList":[],"rows":{"0":{"cells":{"7":{"text":"No"}}},"1":{"cells":{"1":{"merge":[2,4],"style":61,"height":75,"text":"东莞市铠思科技\n送货(结算)单"},"2":{"style":62},"3":{"style":62},"4":{"style":62},"5":{"style":62},"7":{"text":"系统编号："},"8":{"text":"#{headReceipt.systematic_receipt}"}}},"2":{"cells":{"1":{"style":62},"2":{"style":62},"3":{"style":62},"4":{"style":62},"5":{"style":62},"7":{"text":"开单日期："},"8":{"text":"#{headReceipt.create_time}"}}},"3":{"cells":{"1":{"style":62},"2":{"style":62},"3":{"style":62},"4":{"style":62},"5":{"style":62},"7":{"text":"送货日期："},"8":{"text":"#{headReceipt.invoice_date}"}}},"4":{"cells":{"1":{"text":"客户名称："},"2":{"text":"#{headReceipt.customer_name}"}}},"5":{"cells":{"1":{"style":23,"text":"商品编号"},"2":{"style":23,"text":"名称/型号/规格"},"3":{"style":23,"text":"颜色"},"4":{"style":23,"text":"单位"},"5":{"style":23,"text":"数量"},"6":{"style":23,"text":"单价"},"7":{"style":23,"text":"金额"},"8":{"style":23,"text":"备注"}}},"6":{"cells":{"1":{"style":13,"text":"#{detailReceipt.product_code}"},"2":{"style":13,"text":"#{detailReceipt.product_name}"},"3":{"style":13,"text":" "},"4":{"style":13,"text":"#{detailReceipt.measure_unit}"},"5":{"style":13,"text":"#{detailReceipt.plan_quantity}"},"6":{"style":13,"text":"#{detailReceipt.discount}"},"7":{"style":13,"text":"#{detailReceipt.money}"},"8":{"style":13,"text":"#{detailReceipt.remarks}","rendered":"","config":"","funcname":"-1","subtotal":"-1"}}},"7":{"cells":{"1":{"style":13,"text":" "},"2":{"style":13,"text":" "},"3":{"style":13,"text":" "},"4":{"style":13,"text":" "},"5":{"style":13,"text":" "},"6":{"style":13,"text":" "},"7":{"style":13,"text":" "},"8":{"style":13,"text":" "}}},"8":{"cells":{"1":{"style":13,"text":" "},"2":{"style":13,"text":" "},"3":{"style":13,"text":" "},"4":{"style":13,"text":" "},"5":{"style":13,"text":" "},"6":{"style":13,"text":" "},"7":{"style":13,"text":" "},"8":{"style":13,"text":" "}}},"9":{"cells":{"1":{"style":13,"text":" "},"2":{"style":13,"text":" "},"3":{"style":13,"text":" "},"4":{"style":13,"text":" "},"5":{"style":13,"text":" "},"6":{"style":13,"text":" "},"7":{"style":13,"text":" "},"8":{"style":13,"text":" "}}},"10":{"cells":{"1":{"style":13,"text":" "},"2":{"style":13,"text":" "},"3":{"style":13,"text":" "},"4":{"style":13,"text":" "},"5":{"style":13,"text":" "},"6":{"style":13,"text":" "},"7":{"style":13,"text":" "},"8":{"style":13,"text":" "}}},"11":{"cells":{"1":{"style":13,"text":" "},"2":{"style":13,"text":" "},"3":{"style":13,"text":" "},"4":{"style":13,"text":" "},"5":{"style":13,"text":" "},"6":{"style":13,"text":" "},"7":{"style":13,"text":" "},"8":{"style":13,"text":" "}}},"12":{"cells":{"1":{"style":13,"text":" "},"2":{"style":13,"text":" "},"3":{"style":13,"text":" "},"4":{"style":13,"text":" "},"5":{"style":13,"text":" "},"6":{"style":13,"text":" "},"7":{"style":13,"text":" "},"8":{"style":13,"text":" "}}},"13":{"cells":{"1":{"style":13,"text":" "},"2":{"style":13,"text":" "},"3":{"style":13,"text":" "},"4":{"style":13,"text":" "},"5":{"style":13,"text":" "},"6":{"style":13,"text":" "},"7":{"style":13,"text":" "},"8":{"style":13,"text":" "}}},"14":{"cells":{"1":{"style":13,"text":"合计（大写）：","merge":[0,4],"height":25},"6":{"style":13,"merge":[0,2],"height":25,"rendered":"","config":"","display":"number","text":"（小写）：￥"}}},"15":{"cells":{"1":{"style":22,"merge":[1,4],"height":50,"text":"备注：#{headReceipt.receipt_notes}"},"2":{},"3":{},"4":{},"5":{},"6":{"style":13,"merge":[0,2],"height":25,"text":"已收定金：￥"}}},"16":{"cells":{"1":{},"2":{},"3":{},"4":{},"5":{},"6":{"style":13,"merge":[0,2],"height":25,"text":"应收余款：￥"}}},"17":{"cells":{"1":{"style":34,"text":"顾客须知","merge":[2,0],"height":75},"2":{"merge":[0,4],"style":13,"text":"1、禁止恶意损坏物品","height":25},"7":{"merge":[2,1],"style":41,"text":"顾客签名：","height":75},"8":{}}},"18":{"cells":{"1":{"style":33},"2":{"merge":[0,4],"style":42,"height":25,"text":"2、商品验收后无质量问题不予退货"},"7":{},"8":{}}},"19":{"cells":{"1":{"style":33},"2":{"merge":[0,4],"style":39,"height":25,"text":"3、客户验收核对所购买产品无误"},"7":{},"8":{}}},"21":{"cells":{"2":{}}},"len":95},"dbexps":[],"dicts":[],"rpbar":{"show":true,"pageSize":"","btnList":[]},"fixedPrintHeadRows":[],"fixedPrintTailRows":[],"freeze":"A1","dataRectWidth":660,"displayConfig":{},"background":false,"name":"sheet1","autofilter":{},"styles":[{"align":"center"},{"align":"center","font":{"size":26}},{"font":{"size":26}},{"align":"center","font":{"size":42}},{"font":{"size":42}},{"border":{"top":["thin","#000"],"left":["thin","#000"]}},{"border":{"top":["thin","#000"]}},{"border":{"top":["thin","#000"],"right":["thin","#000"]}},{"border":{"left":["thin","#000"]}},{"border":{"right":["thin","#000"]}},{"border":{"left":["thin","#000"],"bottom":["thin","#000"]}},{"border":{"bottom":["thin","#000"]}},{"border":{"bottom":["thin","#000"],"right":["thin","#000"]}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"font":{"size":15}},{"font":{"size":15}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"font":{"size":18}},{"font":{"size":18}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"font":{"size":26}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"font":{"size":16}},{"font":{"size":16}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"align":"left"},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"valign":"top","align":"left"},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"align":"center"},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"font":{"size":16},"valign":"middle"},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"font":{"size":16},"valign":"top"},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"font":{"size":16},"valign":"top","textwrap":true},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"font":{"size":16},"valign":"top","textwrap":false},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"font":{"size":18},"valign":"top","textwrap":true},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"font":{"size":26},"valign":"top","textwrap":true},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"font":{"size":24},"valign":"top","textwrap":true},{"font":{"size":24}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"font":{"size":22},"valign":"top","textwrap":true},{"font":{"size":22}},{"border":{"top":["thin","#000"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]},"font":{"size":22},"valign":"top","textwrap":true,"align":"center"},{},{"border":{"right":["thin","#ffffff"]}},{"border":{"right":["thin","#ffffff"],"top":["thin","#ffffff"]}},{"border":{"right":["thin","#ffffff"],"top":["thin","#ffffff"],"bottom":["thin","#ffffff"]}},{"border":{"top":["thin","#ffffff"],"left":["thin","#000"],"bottom":["thin","#000"],"right":["thin","#000"]}},{"border":{"top":["thin","#ffffff"],"left":["thin","#ffffff"],"bottom":["thin","#ffffff"],"right":["thin","#ffffff"]},"valign":"top","align":"left"},{"border":{"top":["thin","#000100"],"left":["thin","#000100"],"bottom":["thin","#000100"],"right":["thin","#000100"]},"valign":"top","align":"left"},{"border":{"right":["thin","#000100"],"top":["thin","#000100"],"bottom":["thin","#000100"],"left":["thin","#000100"]}},{"align":"center","font":{"size":42},"textwrap":true},{"align":"center","font":{"size":42},"textwrap":false},{"align":"center","font":{"size":14},"textwrap":false},{"font":{"size":14}},{"align":"center","font":{"size":18},"textwrap":false},{"align":"center","font":{"size":22},"textwrap":false},{"align":"center","font":{"size":22,"bold":true},"textwrap":false},{"font":{"size":22,"bold":true}},{"align":"center","font":{"size":22,"bold":false},"textwrap":false},{"font":{"size":22,"bold":false}},{"align":"center","font":{"size":22,"bold":true,"name":"Microsoft YaHei"},"textwrap":false},{"font":{"size":22,"bold":true,"name":"Microsoft YaHei"}},{"align":"center","font":{"size":22,"bold":true,"name":"宋体"},"textwrap":false},{"font":{"size":22,"bold":true,"name":"宋体"}},{"align":"center","font":{"size":22,"bold":true,"name":"Source Sans Pro"},"textwrap":false},{"font":{"size":22,"bold":true,"name":"Source Sans Pro"}},{"align":"center","font":{"size":22,"bold":true,"name":"Lato"},"textwrap":false},{"font":{"size":22,"bold":true,"name":"Lato"}},{"align":"center","font":{"size":24,"bold":true,"name":"Microsoft YaHei"},"textwrap":false},{"font":{"size":24,"bold":true,"name":"Microsoft YaHei"}}],"validations":[],"cols":{"0":{"width":25},"1":{"width":86},"2":{"width":193},"3":{"width":40},"4":{"width":40},"5":{"width":42},"6":{"width":63},"7":{"width":71},"len":50},"merges":["B2:F4","C18:G18","H18:I20","C19:G19","C20:G20","B15:F15","G15:I15","G16:I16","G17:I17","B16:F17","B18:B20"]}', NULL, NULL, 'admin', sysdate(), NULL, NULL, 0, NULL, NULL, 0, 11, NULL, NULL, NULL, NULL);

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
INSERT INTO jimu_report_db_param VALUES('957638707881893888', '957638707491823616', 'systematicReceipt', 'systematicReceipt', '', 1, 'admin', sysdate(), NULL, NULL, 0, NULL, NULL, NULL, NULL, '');
INSERT INTO jimu_report_db_param VALUES('957987696342917120', '957987695822823424', 'systematicReceipt', 'systematicReceipt', '', 1, 'admin', sysdate(), NULL, NULL, 0, NULL, NULL, NULL, NULL, '');

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
INSERT INTO jimu_report_db (id, jimu_report_id, create_by, update_by, create_time, update_time, db_code, db_ch_name, db_type, db_table_name, db_dyn_sql, db_key, tb_db_key, tb_db_table_name, java_type, java_value, api_url, api_method, is_list, is_page, db_source, db_source_type, json_data, api_convert) VALUES('957638707491823616', '957623614502789120', 'admin', NULL, sysdate(), NULL, 'headReceipt', '单据头信息', '0', NULL, 'SELECT
        hr.systematic_receipt, hr.original_receipt, hr.receipt_category, hr.receipt_type, hr.receipt_status,
        hr.invoice_date, hr.warehousing_ids, hr.retrieval_ids, hr.user_ids, hr.supplier_ids, hr.customer_ids,
        hr.plan_receipt, hr.receipt_notes, hr.deposit, hr.total_amount, hr.capitalize_total_amount,
        hr.create_by, hr.create_time, hr.update_by, hr.update_time,
        w.warehouse_name, c.customer_name, su.user_name
        FROM head_receipt hr
        JOIN warehouse w ON w.warehouse_id = hr.retrieval_ids
        JOIN customer c ON c.customer_id = hr.customer_ids
        JOIN sys_user su ON su.user_id = hr.user_ids
        WHERE hr.systematic_receipt = ''${systematicReceipt}''', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', '0', '', 'mysql', '', '');
INSERT INTO jimu_report_db (id, jimu_report_id, create_by, update_by, create_time, update_time, db_code, db_ch_name, db_type, db_table_name, db_dyn_sql, db_key, tb_db_key, tb_db_table_name, java_type, java_value, api_url, api_method, is_list, is_page, db_source, db_source_type, json_data, api_convert) VALUES('957987695822823424', '957623614502789120', 'admin', NULL, sysdate(), NULL, 'detailReceipt', '单据明细信息', '0', NULL, 'select 
        dr.systematic_receipt, dr.product_id, dr.warehousing_id, dr.retrieval_id, dr.supplier_id, dr.customer_id,
        dr.current_inventory, dr.actual_inventory, dr.plan_quantity, dr.univalence, dr.discount, dr.money, dr.cost,
        dr.remarks, p.product_code, p.product_name, p.product_type, p.product_specifications, p.measure_unit,
        p.producer, w.warehouse_id, w.warehouse_name, su.user_id, su.user_name
        FROM (head_receipt hr, detail_receipt dr, product p)
        JOIN warehouse w ON w.warehouse_id = hr.warehousing_ids OR w.warehouse_id = hr.retrieval_ids
        JOIN sys_user su ON su.user_id = hr.user_ids
        WHERE dr.systematic_receipt = hr.systematic_receipt
        AND p.product_id = dr.product_id
        AND hr.systematic_receipt = ''${systematicReceipt}''', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', '0', '', 'mysql', '', '');

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
INSERT INTO jimu_report_db_field VALUES('957638707546349568', 'admin', sysdate(), NULL, NULL, '957638707491823616', 'systematic_receipt', '系统单号', 'String', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957638707584098304', 'admin', sysdate(), NULL, NULL, '957638707491823616', 'original_receipt', '原始单号', 'String', NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957638707613458432', 'admin', sysdate(), NULL, NULL, '957638707491823616', 'receipt_category', '单据类别', 'String', NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957638707655401472', 'admin', sysdate(), NULL, NULL, '957638707491823616', 'receipt_type', '单据类型', 'String', NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957638707667984384', 'admin', sysdate(), NULL, NULL, '957638707491823616', 'receipt_status', '单据状态', 'String', NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957638707684761600', 'admin', sysdate(), NULL, NULL, '957638707491823616', 'invoice_date', '开单日期', 'String', NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957638707697344512', 'admin', sysdate(), NULL, NULL, '957638707491823616', 'warehousing_ids', '入库仓库id', 'String', NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957638707718316032', 'admin', sysdate(), NULL, NULL, '957638707491823616', 'retrieval_ids', '出库仓库id', 'String', NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957638707730898944', 'admin', sysdate(), NULL, NULL, '957638707491823616', 'user_ids', '经手人id', 'String', NULL, 8, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957638707743481856', 'admin', sysdate(), NULL, NULL, '957638707491823616', 'supplier_ids', '供应商id', 'String', NULL, 9, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957638707751870464', 'admin', sysdate(), NULL, NULL, '957638707491823616', 'customer_ids', '客户id', 'String', NULL, 10, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957638707764453376', 'admin', sysdate(), NULL, NULL, '957638707491823616', 'plan_receipt', '计划单号', 'String', NULL, 11, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957638707772841984', 'admin', sysdate(), NULL, NULL, '957638707491823616', 'receipt_notes', '备注', 'String', NULL, 12, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957638707789619200', 'admin', sysdate(), NULL, NULL, '957638707491823616', 'create_by', '创建者', 'String', NULL, 13, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957638707802202112', 'admin', sysdate(), NULL, NULL, '957638707491823616', 'create_time', '创建时间', 'String', NULL, 14, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957638707814785024', 'admin', sysdate(), NULL, NULL, '957638707491823616', 'update_by', '更新者', 'String', NULL, 15, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957638707835756544', 'admin', sysdate(), NULL, NULL, '957638707491823616', 'update_time', '更新时间', 'String', NULL, 16, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957987275637448704', 'admin', sysdate(), NULL, NULL, '957638707491823616', 'warehouse_name', '仓库名称', 'String', NULL, 17, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957987275691974656', 'admin', sysdate(), NULL, NULL, '957638707491823616', 'user_name', '经手人', 'String', NULL, 18, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957987275842969600', 'admin', sysdate(), NULL, NULL, '957638707491823616', 'customer_name', '客户名称', 'String', NULL, 19, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('959088554749124608', 'admin', sysdate(), NULL, NULL, '957638707491823616', 'deposit', '定金', 'String', NULL, 20, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('959088554761707520', 'admin', sysdate(), NULL, NULL, '957638707491823616', 'total_amount', '总金额', 'String', NULL, 21, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('959088554782679040', 'admin', sysdate(), NULL, NULL, '957638707491823616', 'capitalize_total_amount', '总金额（大写）', 'String', NULL, 22, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957987695860572160', 'admin', sysdate(), NULL, NULL, '957987695822823424', 'systematic_receipt', '系统单号', 'String', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957987695906709504', 'admin', sysdate(), NULL, NULL, '957987695822823424', 'product_id', '货品id', 'String', NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957987695919292416', 'admin', sysdate(), NULL, NULL, '957987695822823424', 'warehousing_id', '入库仓库id', 'String', NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957987695936069632', 'admin', sysdate(), NULL, NULL, '957987695822823424', 'retrieval_id', '出库仓库id', 'String', NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957987695948652544', 'admin', sysdate(), NULL, NULL, '957987695822823424', 'supplier_id', '供应商id', 'String', NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957987695965429760', 'admin', sysdate(), NULL, NULL, '957987695822823424', 'customer_id', '客户id', 'String', NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957987695982206976', 'admin', sysdate(), NULL, NULL, '957987695822823424', 'current_inventory', '当前库存量', 'String', NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957987695994789888', 'admin', sysdate(), NULL, NULL, '957987695822823424', 'actual_inventory', '实际库存量', 'String', NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957987696028344320', 'admin', sysdate(), NULL, NULL, '957987695822823424', 'plan_quantity', '数量', 'String', NULL, 8, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957987696040927232', 'admin', sysdate(), NULL, NULL, '957987695822823424', 'univalence', '单价', 'String', NULL, 9, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957987696053510144', 'admin', sysdate(), NULL, NULL, '957987695822823424', 'discount', '折扣', 'String', NULL, 10, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957987696066093056', 'admin', sysdate(), NULL, NULL, '957987695822823424', 'money', '金额', 'String', NULL, 11, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957987696103841792', 'admin', sysdate(), NULL, NULL, '957987695822823424', 'cost', '成本', 'String', NULL, 12, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957987696124813312', 'admin', sysdate(), NULL, NULL, '957987695822823424', 'remarks', '备注', 'String', NULL, 13, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957987696141590528', 'admin', sysdate(), NULL, NULL, '957987695822823424', 'product_code', '货品编码', 'String', NULL, 14, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957987696212893696', 'admin', sysdate(), NULL, NULL, '957987695822823424', 'product_name', '货品名称', 'String', NULL, 15, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957987696225476608', 'admin', sysdate(), NULL, NULL, '957987695822823424', 'product_type', '货品类型', 'String', NULL, 16, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957987696242253824', 'admin', sysdate(), NULL, NULL, '957987695822823424', 'product_specifications', '商品规格', 'String', NULL, 17, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957987696254836736', 'admin', sysdate(), NULL, NULL, '957987695822823424', 'measure_unit', '单位', 'String', NULL, 18, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957987696267419648', 'admin', sysdate(), NULL, NULL, '957987695822823424', 'producer', '产地', 'String', NULL, 19, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957987696280002560', 'admin', sysdate(), NULL, NULL, '957987695822823424', 'warehouse_id', '仓库id', 'String', NULL, 20, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957987696288391168', 'admin', sysdate(), NULL, NULL, '957987695822823424', 'warehouse_name', '仓库名称', 'String', NULL, 21, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957987696300974080', 'admin', sysdate(), NULL, NULL, '957987695822823424', 'user_id', '经手人id', 'String', NULL, 22, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO jimu_report_db_field VALUES('957987696317751296', 'admin', sysdate(), NULL, NULL, '957987695822823424', 'user_name', '经手人名称', 'String', NULL, 23, NULL, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- 33、报表参数
-- ----------------------------
DROP TABLE IF EXISTS `jimu_report_db_param`;
CREATE TABLE `jimu_report_db_param`  (
  `id` 					varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `jimu_report_head_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '动态报表ID',
  `param_name` 			varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '参数字段',
  `param_txt` 			varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '参数文本',
  `param_value` 		varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '参数默认值',
  `order_num` 			int(11) NULL DEFAULT NULL COMMENT '排序',
  `create_by` 			varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人登录名称',
  `create_time` 		datetime NULL DEFAULT NULL COMMENT '创建日期',
  `update_by` 			varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人登录名称',
  `update_time` 		datetime NULL DEFAULT NULL COMMENT '更新日期',
  `search_flag` 		int(1) NULL DEFAULT NULL COMMENT '查询标识0否1是 默认0',
  `widget_type` 		varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '查询控件类型',
  `search_mode` 		int(1) NULL DEFAULT NULL COMMENT '查询模式1简单2范围',
  `dict_code` 			varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典',
  `search_format` 		varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '查询时间格式化表达式',
  `ext_json` 			text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '参数配置',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_jmrheadid`(`jimu_report_head_id`) USING BTREE,
  INDEX `idx_jrdp_jimu_report_head_id`(`jimu_report_head_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '报表参数' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- 初始化-报表参数表数据
-- ----------------------------
INSERT INTO jimu_report_db_param VALUES('957638707881893888', '957638707491823616', 'systematicReceipt', 'systematicReceipt', '', 1, 'admin', sysdate(), NULL, NULL, 0, NULL, NULL, NULL, NULL, '');
INSERT INTO jimu_report_db_param VALUES('957987696342917120', '957987695822823424', 'systematicReceipt', 'systematicReceipt', '', 1, 'admin', sysdate(), NULL, NULL, 0, NULL, NULL, NULL, NULL, '');

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
