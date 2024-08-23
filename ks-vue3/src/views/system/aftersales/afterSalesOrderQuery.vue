<template>
  <!-- 售后单据查询 -->
  <div class="app-container">
    <el-row :gutter="20">
      <el-col :span="24" :xs="24">
        <el-form
          :inline="true"
          v-show="showSearch"
          ref="queryRef"
          :model="queryParams"
          label-width="100px"
        >
          <el-form-item label="系统单号" prop="systematicReceipt">
            <el-input
              v-model="queryParams.systematicReceipt"
              placeholder="请输入"
              style="width: 200px"
              clearable
            />
          </el-form-item>
          <el-form-item label="原始单号" prop="originalReceipt">
            <el-input
              v-model="queryParams.originalReceipt"
              placeholder="请输入"
              style="width: 200px"
              clearable
            />
          </el-form-item>
          <el-form-item label="单据类型" prop="serviceType">
            <el-select
              v-model="queryParams.serviceType"
              placeholder="单据类型"
              filterable
              clearable
              style="width: 200px"
            >
              <el-option
                v-for="dict in service_type"
                :key="dict.value"
                :label="dict.label"
                :value="dict.value"
              />
            </el-select>
          </el-form-item>
          <el-form-item label="单据状态" prop="receiptStatus">
            <el-select
              v-model="queryParams.receiptStatus"
              placeholder="单据状态"
              filterable
              clearable
              style="width: 200px"
            >
              <el-option
                v-for="dict in receipt_status"
                :key="dict.value"
                :label="dict.label"
                :value="dict.value"
              />
            </el-select>
          </el-form-item>
          <el-form-item label="调入仓库" prop="warehousingIds">
            <el-select
              style="width: 200px"
              v-model="queryParams.warehousingIds"
              placeholder="请选择"
              filterable
              clearable
            >
              <el-option
                v-for="item in warehouseOptions"
                :key="item.warehouseId"
                :label="item.warehouseName"
                :value="item.warehouseId"
              ></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="调出仓库" prop="retrievalIds">
            <el-select
              style="width: 200px"
              v-model="queryParams.retrievalIds"
              placeholder="请选择"
              filterable
              clearable
            >
              <el-option
                v-for="item in warehouseOptions"
                :key="item.warehouseId"
                :label="item.warehouseName"
                :value="item.warehouseId"
              ></el-option>
            </el-select>
          </el-form-item>
          <el-form-item
            label="经手人"
            prop="userIds"
            v-hasPermi="['afterSales:afterSalesOrderQuery:selectUser']"
          >
            <el-select
              style="width: 200px"
              v-model="queryParams.userIds"
              placeholder="请选择"
              filterable
              clearable
            >
              <el-option
                v-for="item in userOptions"
                :key="item.userId"
                :label="item.userName"
                :value="item.userId"
              ></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="客户" prop="customerIds">
            <el-select
              style="width: 200px"
              v-model="queryParams.customerIds"
              placeholder="请选择"
              filterable
              clearable
              remote
              :remote-method="remoteCustomer"
              remote-show-suffix
            >
              <el-option
                v-for="item in customerOptions"
                :key="item.customerId"
                :label="item.customerName"
                :value="item.customerId"
              ></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="货品编号" prop="productCode">
            <el-input
              v-model="queryParams.productCode"
              placeholder="请输入货品编号"
              style="width: 200px"
              clearable
            />
          </el-form-item>
          <el-form-item label="货品名称" prop="productName">
            <el-input
              v-model="queryParams.productName"
              placeholder="请输入货品名称"
              style="width: 200px"
              clearable
            />
          </el-form-item>
          <el-form-item label="创建时间" style="width: 388px">
            <el-date-picker
              v-model="dateRange"
              value-format="YYYY-MM-DD"
              type="daterange"
              range-separator="-"
              start-placeholder="开始日期"
              end-placeholder="结束日期"
            ></el-date-picker>
          </el-form-item>
          <el-form-item>
            <el-button
              type="primary"
              icon="Search"
              round
              @click="handleQuery"
              v-hasPermi="['afterSales:afterSalesOrderQuery:headQuery']"
              >查询</el-button
            >
            <el-button
              type="success"
              icon="Search"
              round
              @click="handleDetailQuery"
              v-hasPermi="['afterSales:afterSalesOrderQuery:detailQuery']"
              >明细查询</el-button
            >
            <el-button type="info" icon="Refresh" round @click="resetQuery"
              >重置</el-button
            >
          </el-form-item>
        </el-form>
        <el-row :gutter="10" class="mb8">
          <el-col :span="1.5">
            <el-tooltip class="box-item" content="新建售后单据" placement="top">
              <el-button
                type="success"
                icon="plus"
                plain
                round
                @click="add"
                v-hasPermi="['afterSales:afterSalesOrderQuery:add']"
                >新建</el-button
              >
            </el-tooltip>
          </el-col>
          <el-col :span="1.5">
            <el-button
              :disabled="salesDetail"
              type="warning"
              plain
              round
              icon="Download"
              @click="handleExport"
              v-hasPermi="['afterSales:afterSalesOrderQuery:headExport']"
              >导出</el-button
            >
          </el-col>
          <el-col :span="1.5">
            <el-button
              :disabled="salesHead"
              type="danger"
              plain
              round
              icon="Download"
              @click="handleDetailExport"
              v-hasPermi="['afterSales:afterSalesOrderQuery:detailExport']"
              >明细导出</el-button
            >
          </el-col>
          <right-toolbar
            v-model:showSearch="showSearch"
            @queryTable="getList"
          ></right-toolbar>
        </el-row>

        <!-- 头表数据 -->
        <el-table
          border
          v-if="salesHead"
          v-loading="loading"
          :data="salesOrderList"
        >
          <el-table-column
            label="序号"
            align="center"
            type="index"
            width="60"
          />
          <el-table-column
            label="系统单号"
            align="center"
            prop="systematicReceipt"
            width="180"
          >
            <template #default="scope">
              <el-link type="primary">
                <a target="_blank" @click="handleUpdate(scope.row)">{{
                  scope.row.systematicReceipt
                }}</a>
              </el-link>
            </template>
          </el-table-column>
          <el-table-column
            label="原始单号"
            align="center"
            prop="originalReceipt"
            width="180"
          />
          <el-table-column
            label="单据类型"
            align="center"
            prop="serviceType"
            width="100"
          >
            <template #default="scope">
              <dict-tag
                :options="service_type"
                :value="scope.row.serviceType"
              />
            </template>
          </el-table-column>
          <el-table-column label="单据状态" align="center" prop="receiptStatus">
            <template #default="scope">
              <dict-tag
                :options="receipt_status"
                :value="scope.row.receiptStatus"
              />
            </template>
          </el-table-column>
          <el-table-column
            label="发生日期"
            align="center"
            prop="invoiceDate"
            width="100"
          />
          <el-table-column
            label="调入仓库"
            align="center"
            prop="warehousing.warehousingName"
            width="100"
          />
          <el-table-column
            label="调出仓库"
            align="center"
            prop="retrieval.retrievalName"
            width="100"
          />
          <el-table-column
            label="经手人"
            align="center"
            prop="sysUser.userName"
            width="100"
          />
          <el-table-column
            label="客户"
            align="center"
            prop="customer.customerName"
            width="100"
          />
          <el-table-column
            label="备注"
            align="center"
            prop="receiptNotes"
            :show-overflow-tooltip="true"
          />
          <el-table-column
            label="定金"
            align="center"
            prop="deposit"
            width="150"
          />
          <el-table-column
            label="总金额"
            align="center"
            prop="totalAmount"
            width="150"
          />
          <el-table-column
            label="总金额（大写）"
            align="center"
            prop="capitalizeTotalAmount"
            width="150"
            :show-overflow-tooltip="true"
          />
          <el-table-column
            label="安装人员"
            align="center"
            prop="installer"
            width="120"
          >
          </el-table-column>
          <el-table-column
            label="创建者"
            align="center"
            prop="createBy"
            width="100"
          />
          <el-table-column
            label="创建时间"
            align="center"
            prop="createTime"
            width="180"
          >
            <template #default="scope">
              <span>{{ parseTime(scope.row.createTime) }}</span>
            </template>
          </el-table-column>
          <el-table-column
            label="更新者"
            align="center"
            prop="updateBy"
            width="100"
          />
          <el-table-column
            label="更新时间"
            align="center"
            prop="updateTime"
            width="180"
          >
            <template #default="scope">
              <span>{{ parseTime(scope.row.updateTime) }}</span>
            </template>
          </el-table-column>
          <el-table-column
            fixed="right"
            label="操作"
            align="center"
            width="120"
            class-name="small-padding fixed-width"
          >
            <template #default="scope">
              <el-tooltip content="修改" placement="top">
                <el-button
                  link
                  type="primary"
                  icon="Edit"
                  @click="handleUpdate(scope.row)"
                  v-hasPermi="['afterSales:afterSalesOrderQuery:update']"
                ></el-button>
              </el-tooltip>
              <el-tooltip content="打印" placement="top">
                <el-button
                  link
                  type="primary"
                  icon="Printer"
                  @click="printOut(scope.row)"
                  v-hasPermi="['afterSales:afterSalesOrderQuery:printOut']"
                ></el-button>
              </el-tooltip>
              <el-tooltip content="删除" placement="top">
                <el-button
                  link
                  type="primary"
                  icon="Delete"
                  @click="handleDelete(scope.row)"
                  v-hasPermi="['afterSales:afterSalesOrderQuery:delete']"
                ></el-button>
              </el-tooltip>
            </template>
          </el-table-column>
        </el-table>
        <!-- 分页组件 -->
        <pagination
          v-if="salesHead"
          v-show="total > 0"
          :total="total"
          v-model:page="queryParams.pageNum"
          v-model:limit="queryParams.pageSize"
          @pagination="getList"
        />
        <!-- 明细表数据 -->
        <el-table
          border
          v-if="salesDetail"
          v-loading="loading"
          :data="salesDetailOrderList"
        >
          <el-table-column
            label="序号"
            align="center"
            type="index"
            width="60"
          />
          <el-table-column
            label="系统单号"
            align="center"
            prop="systematicReceipt"
            width="180"
          />
          <el-table-column
            label="货品编号"
            align="center"
            prop="product.productCode"
          />
          <el-table-column
            label="货品名称"
            align="center"
            prop="product.productName"
          />
          <el-table-column
            label="货品类型"
            align="center"
            prop="type.productTypeName"
          />
          <el-table-column
            label="规格"
            align="center"
            prop="product.productSpecifications"
          />
          <el-table-column
            label="单位"
            align="center"
            prop="product.measureUnit"
          />
          <el-table-column
            label="产地"
            align="center"
            prop="product.producer"
          />
          <el-table-column label="数量" align="center" prop="planQuantity" />
          <el-table-column label="单价" align="center" prop="univalence" />
          <el-table-column label="折扣" align="center" prop="discount" />
          <el-table-column label="金额" align="center" prop="money" />
          <el-table-column label="成本" align="center" prop="cost" />
          <el-table-column
            label="备注"
            align="center"
            prop="remarks"
            :show-overflow-tooltip="true"
          />
        </el-table>
        <!-- 分页组件 -->
        <pagination
          v-if="salesDetail"
          v-show="total > 0"
          :total="total"
          v-model:page="queryParams.pageNum"
          v-model:limit="queryParams.pageSize"
          @pagination="getDetailList"
        />
      </el-col>
    </el-row>
  </div>
</template>

<script setup name="afterSalesOrderQuery">
import { getToken } from "@/utils/auth";
import { useRouter } from "vue-router";
import { listWarehouse } from "@/api/basedate/warehouse";
import { listUser, getUserProfile } from "@/api/system/user";
import { listCustomer } from "@/api/basedate/customer";
import {
  headQuery,
  detailQuery,
  getAfterSales,
  delAfterSales,
} from "@/api/aftersales/afterSalesOrderQuery";
import { viewUrl } from "@/api/jimu/jiMuReport";

const { proxy } = getCurrentInstance();
const { service_type } = proxy.useDict("service_type");
const { receipt_status } = proxy.useDict("receipt_status");
const { print_selected_files } = proxy.useDict("print_selected_files");
const { print_selected_sizes } = proxy.useDict("print_selected_sizes");

// 查询结果表
const salesOrderList = ref([]);
const salesDetailOrderList = ref([]);
const userOptions = ref(undefined);
const customerOptions = ref(undefined);
const warehouseOptions = ref(undefined);
const printOptions = ref(undefined);
const openUrl = ref("");
// 查询表展示
const salesHead = ref(true);
// 查询明细表展示
const salesDetail = ref(false);
// 隐藏查询
const showSearch = ref(true);
// 加载
const loading = ref(false);
// 总条数
const total = ref(0);
// 窗口标题
const title = ref("");
const open = ref(false);
// 数据范围
const dateRange = ref([]);
const router = useRouter();

const data = reactive({
  option: {
    warehouseName: undefined,
    supplierName: undefined,
    customerName: undefined,
    productCode: undefined,
    productName: undefined,
    pageSize: 50,
  },
  form: {
    printId: undefined,
    printSize: undefined,
    systematicReceipt: undefined,
    originalReceipt: undefined,
  },
  queryParams: {
    pageNum: 1,
    pageSize: 50,
    systematicReceipt: undefined,
    originalReceipt: undefined,
    serviceType: undefined,
    receiptStatus: undefined,
    warehousingIds: undefined,
    retrievalIds: undefined,
    userIds: undefined,
    customerIds: undefined,
    productCode: undefined,
    productName: undefined,
  },
  rules: {},
});

const { queryParams, form, option, rules } = toRefs(data);

async function Options() {
  loading.value = true;
  listWarehouse(option.value).then((response) => {
    warehouseOptions.value = response.rows;
  });
  listCustomer(option.value).then((response) => {
    customerOptions.value = response.rows;
  });
  await listUser(option.value).then((response) => {
    userOptions.value = response.rows;
  });
  await getUserProfile().then((response) => {
    queryParams.value.userIds = response.data.userId;
  });
  getList();
  loading.value = false;
}
/** 查询售后头单列表 */
function getList() {
  loading.value = true;
  headQuery(proxy.addDateRange(queryParams.value, dateRange.value)).then(
    (response) => {
      salesOrderList.value = response.rows;
      total.value = response.total;
      loading.value = false;
    }
  );
}
/** 查询售后明细单列表 */
function getDetailList() {
  loading.value = true;
  detailQuery(proxy.addDateRange(queryParams.value, dateRange.value)).then(
    (response) => {
      salesDetailOrderList.value = response.rows;
      total.value = response.total;
      loading.value = false;
    }
  );
}
/** 查询按钮操作 */
function handleQuery() {
  salesHead.value = true;
  salesDetail.value = false;
  queryParams.value.pageNum = 1;
  getList();
}
/** 明细查询按钮操作 */
function handleDetailQuery() {
  salesHead.value = false;
  salesDetail.value = true;
  queryParams.value.pageNum = 1;
  getDetailList();
}
/** 重置按钮操作 */
function resetQuery() {
  dateRange.value = [];
  proxy.resetForm("queryRef");
  Options();
}
/** 新增按钮 */
function add() {
  router.push({ path: "/afterSales/afterSalesOrderProcessing" });
}
/** 重置操作表单 */
function reset() {
  form.value = {
    printId: undefined,
    systematicReceipt: undefined,
    originalReceipt: undefined,
  };
  proxy.resetForm("printRef");
}
/** 打印按钮 */
async function printOut(row) {
  form.value.printId = print_selected_files.value[8].label;
  form.value.printSize = print_selected_sizes.value[8].label;
  await viewUrl().then((res) => {
    openUrl.value = res;
  });
  const printUrl =
    openUrl.value +
    "/" +
    form.value.printId +
    "?token=Bearer " +
    getToken() +
    "&systematicReceipt=" +
    row.systematicReceipt +
    "&pageSize=" +
    form.value.printSize;
  window.open(printUrl, "_blank");
}
/** 修改按钮操作 */
function handleUpdate(row) {
  const systematicReceipt = row.systematicReceipt;
  const serviceType = row.serviceType;
  if (serviceType == 1) {
    router.push({
      path: "/afterSales/afterSalesOrderProcessing",
      query: { systematicReceipt },
    });
  }
}
/** 删除按钮操作 */
function handleDelete(row) {
  const systematicReceipt = row.systematicReceipt;
  getAfterSales(systematicReceipt).then((response) => {
    const details = response.data.details;
    proxy.$modal
      .confirm("确认要删除系统编号为" + systematicReceipt + "的售后单据?")
      .then(function () {
        return delAfterSales(details);
      })
      .then(() => {
        getList();
        proxy.$modal.msgSuccess("删除成功");
      })
      .catch(() => {});
  });
}
/** 导出按钮操作 */
function handleExport() {
  proxy.download(
    "afterSales/afterSalesQuery/headExport",
    {
      ...queryParams.value,
    },
    `售后单据表_${new Date().getTime()}.xlsx`
  );
  proxy.$modal.msgSuccess("浏览器正在下载，请稍等！");
}
/** 明细导出按钮操作 */
function handleDetailExport() {
  proxy.download(
    "afterSales/afterSalesQuery/detailExport",
    {
      ...queryParams.value,
    },
    `售后单据明细表_${new Date().getTime()}.xlsx`
  );
  proxy.$modal.msgSuccess("浏览器正在下载，请稍等！");
}
/** 重置下拉框表单 */
function optionReset() {
  option.value = {
    warehouseName: undefined,
    supplierName: undefined,
    customerName: undefined,
    productCode: undefined,
    productName: undefined,
    pageSize: 50,
  };
}
// 查询客户名称
function remoteCustomer(query) {
  optionReset();
  if (query) {
    setTimeout(() => {
      option.value.customerName = query;
      listCustomer(option.value).then((response) => {
        customerOptions.value = response.rows;
      });
      customerOptions.value = list.value.filter((item) => {
        return item.label.toLowerCase().includes(query.toLowerCase());
      });
    }, 200);
  } else {
    listCustomer(option.value).then((response) => {
      customerOptions.value = response.rows;
    });
  }
}

Options();
</script>
