<template>
  <!-- 采购单据查询 -->
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
          <el-form-item label="单据类型" prop="receiptType">
            <el-select
              style="width: 200px"
              v-model="queryParams.receiptType"
              placeholder="单据类型"
              filterable
              clearable
            >
              <el-option
                v-for="dict in receipt_type"
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
          <el-form-item label="经手人" prop="userIds">
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
          <el-form-item label="供应商" prop="supplierIds">
            <el-select
              style="width: 200px"
              v-model="queryParams.supplierIds"
              placeholder="请选择"
              filterable
              clearable
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
              @click="handleQuery"
              v-hasPermi="['system:purchase:PurchaseOrderQuery']"
              >查询</el-button
            >
            <el-button
              type="success"
              icon="Search"
              @click="handleDetailQuery"
              v-hasPermi="['system:purchase:PurchaseDetailOrderQuery']"
              >明细查询</el-button
            >
            <el-button icon="Refresh" @click="resetQuery">重置</el-button>
          </el-form-item>
        </el-form>
        <el-row :gutter="10" class="mb8">
          <el-col :span="1.5">
            <el-button
              :disabled="purchaseDetail"
              type="warning"
              plain
              icon="Download"
              @click="handleExport"
              v-hasPermi="['system:purchase:purchaseOrderExport']"
              >导出</el-button
            >
          </el-col>
          <el-col :span="1.5">
            <el-button
              :disabled="purchaseHead"
              type="danger"
              plain
              icon="Download"
              @click="handleDetailExport"
              v-hasPermi="['system:purchase:purchaseDetailOrderExport']"
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
            prop="systematicReceipt"
            width="180"
          />
          <el-table-column
            label="原始单号"
            align="center"
            prop="originalReceipt"
            width="180"
          />
          <el-table-column
            label="单据类型"
            align="center"
            prop="receiptType"
            width="100"
          >
            <template #default="scope">
              <dict-tag
                :options="receipt_type"
                :value="scope.row.receiptType"
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
            label="供应商"
            align="center"
            prop="supplier.supplierName"
            width="100"
          />
          <el-table-column
            label="订单号"
            align="center"
            prop="planReceipt"
            width="150"
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
              <el-tooltip content="打印" placement="top">
                <el-button
                  link
                  type="primary"
                  icon="Printer"
                  @click="printOut(scope.row)"
                  v-hasPermi="['system:purchase:printOut']"
                ></el-button>
              </el-tooltip>
              <el-tooltip content="修改" placement="top">
                <el-button
                  link
                  type="primary"
                  icon="Edit"
                  @click="handleUpdate(scope.row)"
                  v-hasPermi="['system:purchase:update']"
                ></el-button>
              </el-tooltip>
              <el-tooltip content="删除" placement="top">
                <el-button
                  link
                  type="primary"
                  icon="Delete"
                  @click="handleDelete(scope.row)"
                  v-hasPermi="['system:purchase:delete']"
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
          id="printTest"
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
          <el-table-column label="成本" align="center" prop="money" />
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

  <!-- 打印对话框 -->
  <el-dialog :title="title" v-model="open" width="900px" append-to-body>
    <el-form :model="form" :rules="rules" ref="printRef" label-width="80px">
      <el-row>
        <el-col :span="8">
          <el-form-item label="打印文件" prop="printId">
            <el-select
              style="width: 200px"
              v-model="form.printId"
              placeholder="请选择"
              filterable
              clearable
            >
              <el-option
                v-for="item in printOptions"
                :key="item.id"
                :label="item.name"
                :value="item.id"
              ></el-option>
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :span="8">
          <el-form-item label="系统编号" prop="systematicReceipt">
            <el-input
              style="width: 200px"
              v-model="form.systematicReceipt"
              maxlength="30"
              disabled="isDisabled"
            />
          </el-form-item>
        </el-col>
        <el-col :span="8">
          <el-form-item label="原始单号" prop="originalReceipt">
            <el-input
              v-model="form.originalReceipt"
              clearable
              disabled="isDisabled"
            />
          </el-form-item>
        </el-col>
      </el-row>
    </el-form>
    <template #footer>
      <div class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </template>
  </el-dialog>
</template>

<script setup name="PurchaseDocumentQuery">
import { useRouter } from "vue-router";
import { listWarehouse } from "@/api/basedate/warehouse";
import { listUser } from "@/api/system/user";
import { listSupplier } from "@/api/basedate/supplier";
import { listJiMuReport } from "@/api/system/jiMuReport";
import { listMenu } from "@/api/system/menu";
import {
  listPurchaseOrder,
  listPurchaseDetailOrder,
  getPurchaseOrder,
  delWarehouseReceipt,
} from "@/api/purchase/PurchaseDocumentQuery";

const { proxy } = getCurrentInstance();
const { receipt_type } = proxy.useDict("receipt_type");
const { receipt_status } = proxy.useDict("receipt_status");

// 查询结果表
const purchaseOrderList = ref([]);
const purchaseDetailOrderList = ref([]);
const userOptions = ref(undefined);
const supplierOptions = ref(undefined);
const warehouseOptions = ref(undefined);
const printOptions = ref(undefined);
// 查询表展示
const purchaseHead = ref(true);
// 查询明细表展示
const purchaseDetail = ref(false);
// 隐藏查询
const showSearch = ref(true);
// 加载
const loading = ref(true);
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
    pageSize: 1000,
  },
  menuOption: {
    menuName: "打印调用IP",
  },
  form: {
    printId: undefined,
    path: undefined,
    systematicReceipt: undefined,
    originalReceipt: undefined,
  },
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    systematicReceipt: undefined,
    originalReceipt: undefined,
    receiptType: undefined,
    receiptStatus: undefined,
    warehousingIds: undefined,
    retrievalIds: undefined,
    userIds: undefined,
    supplierIds: undefined,
    productCode: undefined,
    productName: undefined,
  },
  rules: {
    printId: [{ required: true, message: "打印文件不能为空", trigger: "blur" }],
  },
});

const { queryParams, form, option, menuOption, rules } = toRefs(data);

function Options() {
  listWarehouse(option.value).then((response) => {
    warehouseOptions.value = response.rows;
  });
  listSupplier(option.value).then((response) => {
    supplierOptions.value = response.rows;
  });
  listUser(option.value).then((response) => {
    userOptions.value = response.rows;
  });
}
/** 查询采购头单列表 */
function getList() {
  loading.value = true;
  listPurchaseOrder(
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
  listPurchaseDetailOrder(
    proxy.addDateRange(queryParams.value, dateRange.value)
  ).then((response) => {
    purchaseDetailOrderList.value = response.rows;
    total.value = response.total;
    loading.value = false;
  });
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
  handleQuery();
}
/** 重置操作表单 */
function reset() {
  form.value = {
    printId: undefined,
    path: undefined,
    systematicReceipt: undefined,
    originalReceipt: undefined,
  };
  proxy.resetForm("printRef");
}
/** 打印按钮 */
function printOut(row) {
  reset();
  listJiMuReport(option.value).then((response) => {
    printOptions.value = response.rows;
  });
  listMenu(menuOption.value).then((response) => {
    console.log(response.data[0].path);
    form.value.path = response.data[0].path;
  });
  form.value.systematicReceipt = row.systematicReceipt;
  form.value.originalReceipt = row.originalReceipt;
  open.value = true;
  title.value = "打印文件选择";
}
/** 确认按钮 */
function submitForm() {
  proxy.$refs["printRef"].validate((valid) => {
    if (valid) {
      const printUrl =
        form.value.path +
        "/jmreport/view/" +
        form.value.printId +
        "?systematicReceipt=" +
        form.value.systematicReceipt;
      window.open(printUrl, "_blank");
      open.value = false;
    }
  });
}
/** 取消按钮 */
function cancel() {
  open.value = false;
  reset();
}
/** 修改按钮操作 */
function handleUpdate(row) {
  const systematicReceipt = row.systematicReceipt;
  const receiptType = row.receiptType;
  if (receiptType == 1) {
    router.push({
      path: "/purchase/warehouseReceipt",
      query: { systematicReceipt },
    });
  } else if (receiptType == 2) {
    router.push({
      path: "/purchase/retreatWarehouse",
      query: { systematicReceipt },
    });
  }
}
/** 删除按钮操作 */
function handleDelete(row) {
  const systematicReceipt = row.systematicReceipt;
  getPurchaseOrder(systematicReceipt).then((response) => {
    const details = response.data.detail;
    proxy.$modal
      .confirm("确认要删除系统编号为" + systematicReceipt + "的采购单据?")
      .then(function () {
        return delWarehouseReceipt(details);
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
    "system/purchase/purchaseOrderExport",
    {
      ...queryParams.value,
    },
    `采购单据表_${new Date().getTime()}.xlsx`
  );
}
/** 明细导出按钮操作 */
function handleDetailExport() {
  proxy.download(
    "system/purchase/purchaseDetailOrderExport",
    {
      ...queryParams.value,
    },
    `采购单据明细表_${new Date().getTime()}.xlsx`
  );
}
getList();
Options();
</script>
