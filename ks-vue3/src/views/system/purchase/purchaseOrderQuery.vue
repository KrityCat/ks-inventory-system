<template>
  <!-- 采购订单查询 -->
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
          <el-form-item label="系统单号" prop="systematicOrderForm">
            <el-input
              v-model="queryParams.systematicOrderForm"
              placeholder="请输入"
              class="form-item"
              clearable
            />
          </el-form-item>
          <el-form-item label="原始单号" prop="originalOrderForm">
            <el-input
              v-model="queryParams.originalOrderForm"
              placeholder="请输入"
              class="form-item"
              clearable
            />
          </el-form-item>
          <el-form-item label="订单状态" prop="orderFormStatus">
            <el-select
              v-model="queryParams.orderFormStatus"
              placeholder="订单状态"
              filterable
              clearable
              class="form-item"
            >
              <el-option
                v-for="dict in order_form_status"
                :key="dict.value"
                :label="dict.label"
                :value="dict.value"
              />
            </el-select>
          </el-form-item>
          <el-form-item label="调入仓库" prop="warehousingIds">
            <el-select
              class="form-item"
              v-model="queryParams.warehousingIds"
              placeholder="请选择"
              filterable
              clearable
              remote
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
              class="form-item"
              v-model="queryParams.retrievalIds"
              placeholder="请选择"
              filterable
              clearable
              remote
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
            v-hasPermi="['purchase:purchaseOrderQuery:selectUser']"
          >
            <el-select
              class="form-item"
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
          <el-form-item label="供应商" prop="supplierIds">
            <el-select
              class="form-item"
              v-model="queryParams.supplierIds"
              placeholder="请输入供应商"
              filterable
              clearable
              remote
              :remote-method="remoteSupplier"
              remote-show-suffix
            >
              <el-option
                v-for="item in supplierOptions"
                :key="item.supplierId"
                :label="item.supplierName"
                :value="item.supplierId"
              ></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="货品编号" prop="productCode">
            <el-input
              v-model="queryParams.productCode"
              placeholder="请输入货品编号"
              class="form-item"
              filterable
            >
            </el-input>
          </el-form-item>
          <el-form-item label="货品名称" prop="productName">
            <el-input
              v-model="queryParams.productName"
              placeholder="请输入货品名称"
              class="form-item"
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
              v-hasPermi="['purchase:purchaseOrderQuery:headQuery']"
              >查询</el-button
            >
            <el-button
              type="success"
              icon="Search"
              round
              @click="handleDetailQuery"
              v-hasPermi="['purchase:purchaseOrderQuery:detailQuery']"
              >明细查询</el-button
            >
            <el-button type="info" icon="Refresh" round @click="resetQuery"
              >重置</el-button
            >
          </el-form-item>
        </el-form>
        <el-row :gutter="10" class="mb8">
          <el-col :span="1.5">
            <el-tooltip class="box-item" content="新建采购订单" placement="top">
              <el-button
                type="success"
                icon="plus"
                plain
                round
                @click="add"
                v-hasPermi="['purchase:purchaseOrderQuery:add']"
                >新建</el-button
              >
            </el-tooltip>
          </el-col>
          <el-col :span="1.5">
            <el-button
              :disabled="purchaseDetail"
              type="warning"
              plain
              round
              icon="Download"
              @click="handleExport"
              v-hasPermi="['purchase:purchaseOrderQuery:headExport']"
              >导出</el-button
            >
          </el-col>
          <el-col :span="1.5">
            <el-button
              :disabled="purchaseHead"
              type="danger"
              plain
              round
              icon="Download"
              @click="handleDetailExport"
              v-hasPermi="['purchase:purchaseOrderQuery:detailExport']"
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
          v-if="purchaseHead"
          v-loading="loading"
          :data="purchaseOrderList"
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
            prop="systematicOrderForm"
            width="180"
          >
            <template #default="scope">
              <el-link type="primary">
                <a target="_blank" @click="handleUpdate(scope.row)">{{
                  scope.row.systematicOrderForm
                }}</a>
              </el-link>
            </template>
          </el-table-column>
          <el-table-column
            label="原始单号"
            align="center"
            prop="originalOrderForm"
            width="180"
          />
          <el-table-column
            label="订单类型"
            align="center"
            prop="orderFormType"
            width="100"
          >
            <template #default="scope">
              <dict-tag
                :options="order_form_type"
                :value="scope.row.orderFormType"
              />
            </template>
          </el-table-column>
          <el-table-column
            label="订单状态"
            align="center"
            prop="orderFormStatus"
          >
            <template #default="scope">
              <dict-tag
                :options="order_form_status"
                :value="scope.row.orderFormStatus"
              />
            </template>
          </el-table-column>
          <el-table-column
            label="订货日期"
            align="center"
            prop="orderDate"
            width="100"
          />
          <el-table-column
            label="发生日期"
            align="center"
            prop="deliveryDate"
            width="100"
          />
          <el-table-column
            label="仓库"
            align="center"
            prop="warehousing.warehousingName"
            width="100"
          />
          <el-table-column
            label="经手人"
            align="center"
            prop="sysUser.userName"
            width="100"
          />
          <el-table-column
            label="供应商"
            align="center"
            prop="supplier.supplierName"
            width="100"
          />
          <el-table-column
            label="备注"
            align="center"
            prop="orderFormNotes"
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
            prop="orderFormAmount"
            width="150"
          />
          <el-table-column
            label="总金额（大写）"
            align="center"
            prop="orderCapitalizeAmount"
            width="150"
            :show-overflow-tooltip="true"
          />
          <el-table-column
            label="审核结果"
            align="center"
            prop="findingOfAudit"
            width="100"
            ><template #default="scope">
              <dict-tag
                :options="finding_of_audit"
                :value="scope.row.findingOfAudit"
              />
            </template>
          </el-table-column>
          <el-table-column
            label="审核意见"
            align="center"
            prop="reviewComments"
            width="100"
          />
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
                  v-hasPermi="['purchase:purchaseOrderQuery:update']"
                ></el-button>
              </el-tooltip>
              <el-tooltip content="打印" placement="top">
                <el-button
                  link
                  type="primary"
                  icon="Printer"
                  @click="printOut(scope.row)"
                  v-hasPermi="['purchase:purchaseOrderQuery:printOut']"
                ></el-button>
              </el-tooltip>
              <el-tooltip content="删除" placement="top">
                <el-button
                  link
                  type="primary"
                  icon="Delete"
                  @click="handleDelete(scope.row)"
                  v-hasPermi="['purchase:purchaseOrderQuery:delete']"
                ></el-button>
              </el-tooltip>
            </template>
          </el-table-column>
        </el-table>
        <!-- 分页组件 -->
        <pagination
          v-if="purchaseHead"
          v-show="total > 0"
          :total="total"
          v-model:page="queryParams.pageNum"
          v-model:limit="queryParams.pageSize"
          @pagination="getList"
        />
        <!-- 明细表数据 -->
        <el-table
          border
          v-if="purchaseDetail"
          v-loading="loading"
          :data="purchaseDetailOrderList"
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
            prop="systematicOrderForm"
            width="180"
          />
          <el-table-column
            label="商品编号"
            align="center"
            prop="product.productCode"
          />
          <el-table-column
            label="商品名称"
            align="center"
            prop="product.productName"
          />
          <el-table-column
            label="商品类型"
            align="center"
            prop="type.productTypeName"
          />
          <el-table-column
            label="规格"
            align="center"
            prop="productSpecifications"
          />
          <el-table-column label="单位" align="center" prop="measureUnit" />
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
          v-if="purchaseDetail"
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

<script setup name="PurchaseOrderQuery">
import { getToken } from "@/utils/auth";
import { useRouter } from "vue-router";
import { listWarehouse } from "@/api/basedate/warehouse";
import { listUser, getUserProfile } from "@/api/system/user";
import { listSupplier } from "@/api/basedate/supplier";
import {
  purchaseOrderHeadQuery,
  detailQuery,
  getPurchaseOrder,
  delPurchaseOrder,
} from "@/api/purchase/purchaseOrderQuery";
import { viewUrl } from "@/api/jimu/jiMuReport";
import { ref } from "vue";

const { proxy } = getCurrentInstance();
const { order_form_type } = proxy.useDict("order_form_type");
const { order_form_status } = proxy.useDict("order_form_status");
const { finding_of_audit } = proxy.useDict("finding_of_audit");
const { print_selected_files } = proxy.useDict("print_selected_files");
const { print_selected_sizes } = proxy.useDict("print_selected_sizes");

// 查询结果表
const purchaseOrderList = ref([]);
const purchaseDetailOrderList = ref([]);
const openUrl = ref("");
// 查询表展示
const purchaseHead = ref(true);
// 查询明细表展示
const purchaseDetail = ref(false);
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
  userOptions: undefined,
  supplierOptions: undefined,
  warehouseOptions: undefined,
  productOptions: undefined,
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
    systematicOrderForm: undefined,
    originalOrderForm: undefined,
  },
  queryParams: {
    pageNum: 1,
    pageSize: 50,
    systematicOrderForm: undefined,
    originalOrderForm: undefined,
    orderFormType: "1",
    orderFormStatus: undefined,
    warehousingIds: undefined,
    retrievalIds: undefined,
    userIds: undefined,
    customerIds: undefined,
    productCode: undefined,
    productName: undefined,
  },
  rules: {},
});

const {
  userOptions,
  supplierOptions,
  warehouseOptions,
  productOptions,
  queryParams,
  form,
  option,
  rules,
} = toRefs(data);

async function Options() {
  loading.value = true;
  listWarehouse(option.value).then((response) => {
    warehouseOptions.value = response.rows;
  });
  listSupplier(option.value).then((response) => {
    supplierOptions.value = response.rows;
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
/** 查询采购头单列表 */
function getList() {
  loading.value = true;
  purchaseOrderHeadQuery(
    proxy.addDateRange(queryParams.value, dateRange.value)
  ).then((response) => {
    purchaseOrderList.value = response.rows;
    total.value = response.total;
    loading.value = false;
  });
}
/** 查询采购明细单列表 */
function getDetailList() {
  loading.value = true;
  detailQuery(proxy.addDateRange(queryParams.value, dateRange.value)).then(
    (response) => {
      purchaseDetailOrderList.value = response.rows;
      total.value = response.total;
      loading.value = false;
    }
  );
}
/** 查询按钮操作 */
function handleQuery() {
  purchaseHead.value = true;
  purchaseDetail.value = false;
  queryParams.value.pageNum = 1;
  getList();
}
/** 明细查询按钮操作 */
function handleDetailQuery() {
  purchaseHead.value = false;
  purchaseDetail.value = true;
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
  router.push({ path: "/purchase/purchaseOrderProcessing" });
}
/** 重置操作表单 */
function reset() {
  form.value = {
    printId: undefined,
    systematicOrderForm: undefined,
    originalOrderForm: undefined,
  };
  proxy.resetForm("printRef");
}
/** 打印按钮 */
async function printOut(row) {
  form.value.printId = print_selected_files.value[0].label;
  form.value.printSize = print_selected_sizes.value[0].label;
  await viewUrl().then((res) => {
    openUrl.value = res;
  });
  const printUrl =
    openUrl.value +
    "/" +
    form.value.printId +
    "?token=Bearer " +
    getToken() +
    "&systematicOrderForm=" +
    row.systematicOrderForm +
    "&pageSize=" +
    form.value.printSize;
  window.open(printUrl, "_blank");
}
/** 修改按钮操作 */
function handleUpdate(row) {
  const systematicOrderForm = row.systematicOrderForm;
  router.push({
    path: "/purchase/purchaseOrderProcessing",
    query: { systematicOrderForm },
  });
}
/** 删除按钮操作 */
function handleDelete(row) {
  const systematicOrderForm = row.systematicOrderForm;
  getPurchaseOrder(systematicOrderForm).then((response) => {
    const details = response.data.details;
    proxy.$modal
      .confirm("确认要删除系统编号为" + systematicOrderForm + "的采购订单?")
      .then(function () {
        return delPurchaseOrder(details);
      })
      .then(() => {
        getList();
        proxy.$modal.msgSuccess(
          "已删除系统编号为" + systematicOrderForm + "的采购订单。"
        );
      })
      .catch(() => {});
  });
}
/** 导出按钮操作 */
function handleExport() {
  proxy.download(
    "purchase/purchaseOrderQuery/headExport",
    {
      ...queryParams.value,
    },
    `采购订单表_${new Date().getTime()}.xlsx`
  );
  proxy.$modal.msgSuccess("浏览器正在下载，请稍等！");
}
/** 明细导出按钮操作 */
function handleDetailExport() {
  proxy.download(
    "purchase/purchaseOrderQuery/detailExport",
    {
      ...queryParams.value,
    },
    `采购订单明细表_${new Date().getTime()}.xlsx`
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
// 查询供应商名称
function remoteSupplier(query) {
  optionReset();
  if (query) {
    setTimeout(() => {
      option.value.supplierName = query;
      listSupplier(option.value).then((response) => {
        supplierOptions.value = response.rows;
      });
      supplierOptions.value = list.value.filter((item) => {
        return item.label.toLowerCase().includes(query.toLowerCase());
      });
    }, 200);
  } else {
    listSupplier(option.value).then((response) => {
      supplierOptions.value = response.rows;
    });
  }
}

Options();
</script>

<style scoped>
.form-item {
  width: 200px;
}
</style>
