<template>
  <!-- 售后安装单制作 -->
  <div class="app-container">
    <el-row :gutter="10">
      <el-col :span="24" :xs="24">
        <el-form
            ref="orderRef"
            :inline="true"
            :model="form"
            :rules="rules"
            label-width="100px"
        >
          <el-form-item label="系统单号" prop="systematicReceipt">
            <el-input
                v-model="form.systematicReceipt"
                class="form-item"
                disabled="disabled"
                placeholder="系统单号"
            ></el-input>
          </el-form-item>
          <el-form-item label="单据类型" prop="serviceType">
            <el-radio-group v-model="form.serviceType" class="form-item">
              <el-radio-button label="1">售后安装</el-radio-button>
            </el-radio-group>
          </el-form-item>
          <el-form-item label="单据状态" prop="receiptStatus">
            <el-radio-group v-model="form.receiptStatus" class="form-item">
              <el-radio-button :value="1" label="1">待审核</el-radio-button>
              <el-radio-button v-if="audited" :value="2" label="2"
              >已审核
              </el-radio-button
              >
            </el-radio-group>
          </el-form-item>
          <el-form-item label="出货日期" prop="invoiceDate">
            <el-date-picker
                v-model="form.invoiceDate"
                format="YYYY/MM/DD"
                placeholder="请选择出货日期"
                type="date"
                value-format="YYYY-MM-DD"
            ></el-date-picker>
          </el-form-item>
          <el-form-item label="仓库" prop="retrievalIds">
            <el-select
                v-model="form.retrievalIds"
                :loading="loading"
                :remote-method="remoteWarehouse"
                class="form-item"
                clearable
                filterable
                placeholder="请输入仓库"
                remote
                remote-show-suffix
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
              v-hasPermi="['afterSales:afterSalesOrderProcessing:selectUser']"
              label="经手人"
              prop="userIds"
          >
            <el-select
                v-model="form.userIds"
                class="form-item"
                clearable
                filterable
                placeholder="请选择"
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
                v-model="form.customerIds"
                :loading="loading"
                :remote-method="remoteCustomer"
                class="form-item"
                clearable
                filterable
                placeholder="请输入客户"
                remote
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
          <el-form-item label="原始单号" prop="originalReceipt">
            <el-input
                v-model="form.originalReceipt"
                class="form-item"
                clearable
            />
          </el-form-item>
          <el-form-item label="备注" prop="receiptNotes">
            <el-input
                v-model="form.receiptNotes"
                class="form-item"
                type="textarea"
            />
          </el-form-item>
          <el-form-item label="定金" prop="deposit">
            <el-input
                v-model="form.deposit"
                class="form-item"
                clearable
                oninput="this.value=this.value.replace(/[^\d.]/g, '').replace(/(\..*)\./g, '$1').replace(/^\./, '0.').replace(/^(-|0+)/g, '').replace(/(\d{16})\d+/, '$1').replace(/(\d+\.\d{2})\d+/, '$1').padEnd(1, '0')"
            />
          </el-form-item>
          <el-form-item label="总金额" prop="totalAmount">
            <el-input
                v-model="form.totalAmount"
                :formatter="
                (value) => `￥ ${value}`.replace(/\B(?=(\d{3})+(?!\d))/g, ',')
              "
                :parser="(value) => value.replace(/\￥\s?|(,*)/g, '')"
                class="form-item"
                disabled="disabled"
            />
          </el-form-item>
          <el-form-item label="总金额(大写)" prop="capitalizeTotalAmount">
            <el-input
                v-model="form.capitalizeTotalAmount"
                class="form-item"
                disabled="disabled"
            />
          </el-form-item>
          <el-form-item label="安装人员" prop="installer">
            <el-select
                v-model="form.installer"
                class="form-item"
                clearable
                filterable
                placeholder="请选择"
            >
              <el-option
                  v-for="item in userOptions"
                  :key="item.userId"
                  :label="item.userName"
                  :value="item.userId"
              ></el-option>
            </el-select>
          </el-form-item>
        </el-form>
        <div>
          <div>
            <el-row :gutter="10">
              <el-col :span="1.5">
                <div>货品明细</div>
              </el-col>
            </el-row>
          </div>
          <div>
            <el-table
                :data="form.details"
                :summary-method="getSummaries"
                border
                show-summary
            >
              <el-table-column
                  align="center"
                  label="序号"
                  type="index"
                  width="60"
              />
              <el-table-column
                  align="center"
                  label="货品编号"
                  prop="productCode"
                  width="180"
              >
                <template #default="scope">
                  <el-select
                      v-model="scope.row.productCode"
                      :loading="loading"
                      :remote-method="remoteProductCode"
                      filterable
                      placeholder="请输入货品编号"
                      remote
                      remote-show-suffix
                      @change="changeProduct(scope.$index, scope.row)"
                  >
                    <el-option
                        v-for="item in productOptions"
                        :key="item.productId"
                        :label="item.productCode"
                        :value="item.productId"
                    ></el-option>
                  </el-select>
                </template>
              </el-table-column>
              <el-table-column
                  align="center"
                  label="货品名称"
                  prop="productName"
                  width="300"
              >
                <template #default="scope">
                  <el-select
                      v-model="scope.row.productName"
                      :loading="loading"
                      :remote-method="remoteProductName"
                      filterable
                      placeholder="请输入货品名称"
                      remote
                      remote-show-suffix
                      @change="changeProduct(scope.$index, scope.row)"
                  >
                    <el-option
                        v-for="item in productOptions"
                        :key="item.productId"
                        :label="item.productName"
                        :value="item.productId"
                    ></el-option>
                  </el-select>
                </template>
              </el-table-column>
              <el-table-column
                  align="center"
                  label="类型"
                  prop="productTypeName"
              />
              <el-table-column
                  align="center"
                  label="规格"
                  prop="productSpecifications"
              />
              <el-table-column align="center" label="单位" prop="measureUnit"/>
              <el-table-column align="center" label="产地" prop="producer"/>
              <el-table-column
                  align="center"
                  label="数量"
                  prop="planQuantity"
                  width="100"
              >
                <template #default="scope">
                  <el-input
                      v-model="scope.row.planQuantity"
                      oninput="this.value=this.value.replace(/[^\d]/g, '').replace(/^0+(\d)/, '$1').slice(0, 16).padEnd(1, '0')"
                      @change="calculateDetails(scope.row)"
                  ></el-input>
                </template>
              </el-table-column>
              <el-table-column
                  align="center"
                  label="单价"
                  prop="univalence"
                  width="150"
              >
                <template #default="scope">
                  <el-input
                      v-model="scope.row.univalence"
                      oninput="this.value=this.value.replace(/[^\d.]/g, '').replace(/(\..*)\./g, '$1').replace(/^\./, '0.').replace(/^(-|0+)/g, '').replace(/(\d{16})\d+/, '$1').replace(/(\d+\.\d{2})\d+/, '$1').padEnd(1, '0')"
                      @change="calculateDetails(scope.row)"
                  ></el-input>
                </template>
              </el-table-column>
              <el-table-column align="center" label="折扣" width="80">
                <template #default="scope">
                  <el-input
                      v-model="scope.row.discount"
                      oninput="this.value=this.value.replace(/[^\d.]/g, '').replace(/(\..*)\./g, '$1').replace(/^\./, '0.').replace(/^(-|0+)/g, '').replace(/(\d{16})\d+/, '$1').replace(/(\d+\.\d{2})\d+/, '$1').padEnd(1, '0')"
                      @change="calculateDetails(scope.row)"
                  ></el-input>
                </template>
              </el-table-column>
              <el-table-column
                  align="center"
                  label="金额"
                  prop="money"
                  width="150"
              >
                <template #default="scope">
                  <el-input
                      v-model="scope.row.money"
                      oninput="this.value=this.value.replace(/[^\d.]/g, '').replace(/(\..*)\./g, '$1').replace(/^\./, '0.').replace(/^(-|0+)/g, '').replace(/(\d{16})\d+/, '$1').replace(/(\d+\.\d{2})\d+/, '$1').padEnd(1, '0')"
                  ></el-input>
                </template>
              </el-table-column>
              <el-table-column
                  align="center"
                  label="成本"
                  prop="cost"
                  width="150"
              >
                <template #default="scope">
                  <el-input
                      v-model="scope.row.cost"
                      oninput="this.value=this.value.replace(/[^\d.]/g, '').replace(/(\..*)\./g, '$1').replace(/^\./, '0.').replace(/^(-|0+)/g, '').replace(/(\d{16})\d+/, '$1').replace(/(\d+\.\d{2})\d+/, '$1').padEnd(1, '0')"
                  ></el-input>
                </template>
              </el-table-column>
              <el-table-column align="center" label="备注" width="180">
                <template #default="scope">
                  <el-input v-model="scope.row.remarks"></el-input>
                </template>
              </el-table-column>
              <el-table-column align="center" fixed="right" label="操作" width="90">
                <template #default="scope">
                  <el-button
                      plain
                      round
                      type="danger"
                      @click="form.details.splice(scope.$index, 1)"
                  >删除
                  </el-button
                  >
                </template>
              </el-table-column>
            </el-table>
          </div>
          <el-affix :offset="20" class="tc mt16 footer" position="bottom">
            <el-button
                v-hasPermi="['afterSales:afterSalesOrderProcessing:add']"
                color="#BB5500"
                icon="Plus"
                round
                @click="addOrder"
            >新增单据
            </el-button
            >
            <el-button
                v-hasPermi="['afterSales:afterSalesOrderProcessing:detail']"
                icon="Plus"
                round
                type="primary"
                @click="addItem"
            >添加明细
            </el-button
            >
            <el-button
                v-hasPermi="['baseDate:customer:add']"
                color="#626aef"
                icon="Upload"
                round
                @click="customerAdd"
            >新增客户
            </el-button
            >
            <el-button
                v-hasPermi="['baseDate:product:add']"
                icon="Upload"
                round
                type="warning"
                @click="handleAdd"
            >新增货品
            </el-button
            >
            <el-button
                v-hasPermi="['afterSales:afterSalesOrderProcessing:save']"
                icon="position"
                round
                type="primary"
                @click="submitForm"
            >保存单据
            </el-button
            >
            <el-button
                v-hasPermi="['afterSales:afterSalesOrderProcessing:takeEffect']"
                :disabled="takeEffectBtn"
                icon="Check"
                round
                type="success"
                @click="auditingForm"
            >审核单据
            </el-button
            >
            <el-button
                v-hasPermi="['afterSales:afterSalesOrderProcessing:printOut']"
                :disabled="printBtn"
                color="#626aef"
                icon="Printer"
                round
                @click="printCommon"
            >打印单据
            </el-button
            >
            <el-tooltip
                class="box-item"
                content="删除单据，重新制作"
                placement="top"
            >
              <el-button
                  ref="ref22"
                  v-hasPermi="['afterSales:afterSalesOrderProcessing:delete']"
                  :disabled="printBtn"
                  icon="delete"
                  round
                  type="danger"
                  @click="deleteReceipt"
              >删除单据
              </el-button
              >
            </el-tooltip>
            <el-tooltip
                class="box-item"
                content="取消制作，返回查询"
                placement="top"
            >
              <el-button icon="close" round type="info" @click="cancel"
              >取消制作
              </el-button
              >
            </el-tooltip>
          </el-affix>
        </div>
      </el-col>
    </el-row>
  </div>

  <!-- 添加客户配置对话框 -->
  <customer-dialog
      v-model:visible="openCustomer"
  />

  <!-- 添加货品配置对话框 -->
  <product-dialog
      v-model:visible="openProduct"
  />

  <!-- 查看打印模板对话框 -->
  <print-template-dialog
      v-model:visible="openPrintTemplate"
      :systematic-receipt="systematicReceipt"
  />
</template>

<script name="AfterSalesOrderProcessing" setup>
import {useRouter} from "vue-router";
import {getUserProfile} from "@/api/system/user";
import {delAfterSales, getAfterSales, saveAfterSales,} from "@/api/aftersales/afterSalesOrderProcessing";
import {randomId} from "@/utils/RandomUtils";
import {
  addProcessingBatch,
  deleteReceiptBatch,
  getColumns,
  getNowTime,
  getRemoteCustomer,
  getRemoteProduct,
  getRemoteWarehouse,
  SubmitVerification,
} from "@/utils/processingUtils";
import {customerList, userList, warehouseList,} from "@/api/common/CommonReceipt";
import productDialog from '@/components/CommonDialog/productDialog.vue';
import customerDialog from '@/components/CommonDialog/customerDialog.vue';
import {ref} from "vue";
import printTemplateDialog from '@/components/CommonDialog/printTemplateDialog.vue';

const {proxy} = getCurrentInstance();

// 订单状态下拉框
const audited = ref(false);
const takeEffectBtn = ref(false);
const router = useRouter();
const printBtn = ref(false);
const loading = ref(false);
const openUrl = ref("");
// 窗口标题
const openCustomer = ref(false);
const openProduct = ref(false);
const openPrintTemplate = ref(false);
const systematicReceipt = ref(null);

const data = reactive({
  userOptions: undefined,
  customerOptions: undefined,
  warehouseOptions: undefined,
  productOptions: undefined,
  typeOptions: undefined,
  option: {
    warehousingId: undefined,
    retrievalId: undefined,
    warehouseId: undefined,
    warehouseName: undefined,
    supplierId: undefined,
    supplierName: undefined,
    customerId: undefined,
    customerName: undefined,
    productCode: undefined,
    productName: undefined,
    pageSize: 50,
  },
  // 表单参数
  form: {
    details: [],
    systematicReceipt: null,
    originalReceipt: null,
    serviceType: 1,
    receiptStatus: null,
    retrievalIds: null,
    customerIds: null,
    userIds: null,
    invoiceDate: null,
    planReceipt: null,
    receiptNotes: null,
    deposit: null,
    totalAmount: null,
    capitalizeTotalAmount: null,
    installer: null,
    // 打印ID
    printId: null,
    printSize: undefined,
  },
  // 表单校验
  rules: {
    receiptType: [
      {required: true, message: "单据类型不能不选", trigger: "blur"},
    ],
    retrievalIds: [
      {required: true, message: "仓库不能为空", trigger: "blur"},
    ],
    userIds: [{required: true, message: "经手人不能为空", trigger: "blur"}],
    customerIds: [{required: true, message: "客户不能为空", trigger: "blur"}],
    deliveryDate: [
      {required: true, message: "交货日期不能为空", trigger: "blur"},
    ],
  },
});

const {
  userOptions,
  customerOptions,
  warehouseOptions,
  productOptions,
  option,
  form,
  rules,
} = toRefs(data);

function initialization() {
  const {systematicReceipt} = proxy.$route.query;
  if (systematicReceipt) {
    loadDetail(systematicReceipt);
  } else {
    reset();
    takeEffectBtn.value = true;
    printBtn.value = true;
  }
}

async function getList() {
  option.value.pageSize = 500;
  userList(option.value).then((response) => {
    userOptions.value = response.rows;
  });
  getUserProfile(option.value).then((response) => {
    form.value.userIds = response.data.userId;
  });
  optionReset();
}

/** 新增按钮操作 */
function addOrder() {
  addProcessingBatch(router, proxy, 'AfterSalesOrderProcessing')
}

/** 统计金额和成本 */
function calculateDetails(row) {
  row.money = row.cost = Number(
      Math.abs(row.planQuantity) * row.univalence * row.discount
  ).toFixed(2);
}

/** 取消按钮 */
function cancel() {
  router.push({path: "/afterSales/afterSalesOrderQuery"});
}

/** 提交公共方法 */
function submitAuditingForm(isSubmit) {
  proxy.$refs["orderRef"].validate(async (valid) => {
    if (!valid) return;
    if (!await SubmitVerification(proxy, form)) return;
    const details = form.value.details.map((it) => {
      return {
        systematicReceipt: form.value.systematicReceipt,
        productId: it.productId,
        retrievalId: form.value.retrievalIds,
        customerId: form.value.customerIds,
        planQuantity: it.planQuantity,
        univalence: it.univalence,
        discount: it.discount,
        money: it.money,
        cost: it.cost,
        remarks: it.remarks,
      };
    });
    if (isSubmit === 1) {
      proxy.$modal.msgSuccess("售后安装单保存成功");
    } else if (isSubmit === 2) {
      form.value.receiptStatus = 2;
      proxy.$modal.msgSuccess("售后安装单审核成功");
    }
    const reqs = {...form.value, details};
    await saveAfterSales(reqs);
    cancel();
  });
}

/** 提交按钮 */
function submitForm() {
  submitAuditingForm(1);
}

/** 审核按钮 */
function auditingForm() {
  submitAuditingForm(2);
}

function loadDetail(systematicReceipt) {
  getAfterSales(systematicReceipt).then((response) => {
    option.value.warehouseId = response.data.warehousingIds;
    warehouseList(option.value).then((response) => {
      warehouseOptions.value = response.rows;
    });
    option.value.customerId = response.data.customerIds;
    customerList(option.value).then((response) => {
      customerOptions.value = response.rows;
    });
    optionReset();
    if (response.data.receiptStatus === 2) {
      audited.value = true;
      takeEffectBtn.value = true;
    }
    const details = response.data.details;
    const product = response.data.product;
    const map = {};
    (product || []).forEach((it) => {
      map[it.productId] = it;
    });
    form.value = {
      ...response.data,
      details,
    };
    form.value.retrievalIds = Number(response.data.retrievalIds);
    form.value.userIds = Number(response.data.userIds);
    form.value.customerIds = Number(response.data.customerIds);
  });
}

//自定义合计行
function getSummaries(param) {
  const {columns, data} = param;
  const sums = new Array(columns.length).fill("");
  getColumns(columns, data, form, sums, [1, 2, 3, 4, 5, 6, 9], [10, 11]);
  return sums;
}

// 表单重置
function reset() {
  form.value = {
    systematicReceipt: "XC-" + randomId(),
    originalReceipt: null,
    serviceType: 1,
    receiptStatus: 1,
    invoiceDate: getNowTime(),
    retrievalIds: null,
    customerIds: null,
    userIds: null,
    planReceipt: null,
    receiptNotes: null,
    deposit: null,
    totalAmount: null,
    capitalizeTotalAmount: null,
    installer: null,
    printId: null,
    details: [],
  };
  proxy.resetForm("orderRef");
}

// 添加货品
function addItem() {
  form.value.details.push({});
}

// 选择货品
function changeProduct(index, row) {
  form.value.details[index] = {
    productId: null,
    productCode: null,
    productName: null,
    productTypeName: null,
    productSpecifications: null,
    measureUnit: null,
    producer: null,
  };
  let lists = [];
  productOptions.value.forEach((item) => {
    const targetId = item.productId;
    if (row.productCode === targetId || row.productName === targetId) {
      lists = item;
    }
  });
  form.value.details[index] = {
    systematicReceipt: form.value.systematicReceipt,
    productId: lists.productId,
    productCode: lists.productCode,
    productName: lists.productName,
    productTypeName: lists.productTypeName,
    productSpecifications: lists.productSpecifications,
    measureUnit: lists.measureUnit,
    producer: lists.producer,
    retrievalId: form.value.retrievalIds,
    customerId: form.value.customerIds,
    planQuantity: 0,
    univalence: lists.univalence,
    discount: lists.discount,
    money: 0,
    cost: 0,
    remarks: null,
  };
  form.value.details = [...form.value.details];
}

// 打印按钮
function printCommon() {
  systematicReceipt.value = form.value.systematicReceipt;
  openPrintTemplate.value = true;
}

/** 删除按钮操作 */
function deleteReceipt() {
  deleteReceiptBatch(router, proxy, form, getAfterSales, delAfterSales, 'AfterSalesOrderProcessing');
}

/** 新增客户按钮操作 */
function customerAdd() {
  openCustomer.value = true;
}

/** 新增货品按钮操作 */
function handleAdd() {
  openProduct.value = true;
}

/** 重置下拉框表单 */
function optionReset() {
  option.value = {
    warehousingId: undefined,
    retrievalId: undefined,
    warehouseId: undefined,
    warehouseName: undefined,
    supplierId: undefined,
    supplierName: undefined,
    customerId: undefined,
    customerName: undefined,
    productCode: undefined,
    productName: undefined,
    pageSize: 50,
  };
}

// 查询仓库名称
function remoteWarehouse(query) {
  optionReset();
  getRemoteWarehouse(query, loading, option, warehouseOptions);
}

// 查询客户名称
function remoteCustomer(query) {
  optionReset();
  getRemoteCustomer(query, loading, option, customerOptions);
}

// 查询货品编号
function remoteProductCode(query) {
  optionReset();
  option.value.warehousingId = form.value.warehousingIds;
  option.value.retrievalId = form.value.retrievalIds;
  getRemoteProduct(query, "productCode", loading, option, productOptions);
}

// 查询货品名称
function remoteProductName(query) {
  optionReset();
  option.value.warehousingId = form.value.warehousingIds;
  option.value.retrievalId = form.value.retrievalIds;
  getRemoteProduct(query, "productName", loading, option, productOptions);
}

initialization();
getList();
</script>

<style scoped>
.form-item {
  width: 220px;
}

.footer {
  text-align: center;
}
</style>
