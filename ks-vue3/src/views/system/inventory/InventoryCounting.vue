<template>
  <!-- 库存盘点单制作 -->
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
            ></el-input>
          </el-form-item>
          <el-form-item label="单据类型" prop="receiptType">
            <el-radio-group v-model="form.receiptType" class="form-item">
              <el-radio-button :value="8" label="8">库存盘点</el-radio-button>
            </el-radio-group>
          </el-form-item>
          <el-form-item label="单据状态" prop="receiptStatus">
            <el-radio-group v-model="form.receiptStatus" class="form-item">
              <el-radio-button v-if="pending" :value="1" label="1">待审核</el-radio-button>
              <el-radio-button v-if="audited" :value="2" label="2"
              >已审核
              </el-radio-button
              >
            </el-radio-group>
          </el-form-item>
          <el-form-item label="发生日期" prop="invoiceDate">
            <el-date-picker
                v-model="form.invoiceDate"
                format="YYYY/MM/DD"
                placeholder="请选择"
                type="date"
                value-format="YYYY-MM-DD"
            ></el-date-picker>
          </el-form-item>
          <el-form-item label="盘点仓库" prop="warehousingIds">
            <el-select
                v-model="form.warehousingIds"
                :loading="loading"
                :remote-method="remoteWarehouse"
                class="form-item"
                clearable
                filterable
                placeholder="请选择"
                remote
                remote-show-suffix
                @change="handleWarehouseChange"
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
              v-hasPermi="['inventory:inventoryCountingProcessing:selectUser']"
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
          <el-form-item label="原始单号" prop="originalReceipt">
            <el-input
                v-model="form.originalReceipt"
                class="form-item"
                clearable
                placeholder="请输入"
            />
          </el-form-item>
          <el-form-item label="计划订单" prop="planReceipt">
            <el-input v-model="form.planReceipt" class="form-item" clearable/>
          </el-form-item>
          <el-form-item label="备注" prop="receiptNotes">
            <el-input
                v-model="form.receiptNotes"
                class="form-item"
                type="textarea"
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
          <div v-if="finding">
            <el-divider/>
            <el-form-item
                :disabled="['inventory:inventoryCountingProcessing:takeEffect']"
                label="审核结果"
                prop="findingOfAudit"
            >
              <el-select
                  v-model="form.findingOfAudit"
                  class="form-item"
                  clearable
                  filterable
              >
                <el-option
                    v-for="dict in finding_of_audit"
                    :key="dict.value"
                    :label="dict.label"
                    :value="dict.value"
                />
              </el-select>
            </el-form-item>
            <el-form-item
                :disabled="['inventory:inventoryCountingProcessing:takeEffect']"
                label="审核意见"
                prop="reviewComments"
            >
              <el-input
                  v-model="form.reviewComments"
                  clearable
                  style="width: 530px"
              />
            </el-form-item>
          </div>
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
                  width="100"
              >
                <template #default="scope">
                  <el-input
                      v-model="scope.row.productSpecifications"
                  ></el-input>
                </template>
              </el-table-column>
              <el-table-column align="center" label="单位" prop="measureUnit">
                <template #default="scope">
                  <el-input v-model="scope.row.measureUnit"></el-input>
                </template>
              </el-table-column>
              <el-table-column align="center" label="产地" prop="producer"/>
              <el-table-column
                  align="center"
                  label="库存数量"
                  prop="inventoryQty"
              >
                <template #default="scope">
                  <el-button
                      plain
                      round
                      type="primary"
                      @click="selectAllInventoryQty(scope.row.productId)"
                  >{{ scope.row.inventoryQty }}
                  </el-button
                  >
                </template>
              </el-table-column>
              <el-table-column
                  align="center"
                  label="单据锁单数量"
                  prop="lockQty"
                  width="110"
              >
                <template #default="scope">
                  <el-button
                      plain
                      round
                      type="warning"
                      @click="selectLockQty(scope.row.productId)"
                  >{{ scope.row.lockQty }}
                  </el-button
                  >
                </template>
              </el-table-column>
              <el-table-column
                  align="center"
                  label="当前库存量"
                  prop="currentInventory"
                  width="100"
              >
                <template #default="scope">
                  <el-input
                      v-model="scope.row.currentInventory"
                      @change="calculateDetails(scope.row)"
                  ></el-input>
                </template>
              </el-table-column>
              <el-table-column
                  align="center"
                  label="实际库存量"
                  prop="actualInventory"
                  width="100"
              >
                <template #default="scope">
                  <el-input
                      v-model="scope.row.actualInventory"
                      @change="calculateDetails(scope.row)"
                  ></el-input>
                </template>
              </el-table-column>
              <el-table-column
                  align="center"
                  label="数量"
                  prop="planQuantity"
                  width="100"
              >
                <template #default="scope">
                  <el-input
                      v-model="scope.row.planQuantity"
                      disabled="disabled"
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
                v-hasPermi="['inventory:inventoryCountingProcessing:add']"
                color="#BB5500"
                icon="Plus"
                round
                @click="addOrder"
            >新增单据
            </el-button
            >
            <el-button
                v-hasPermi="['inventory:inventoryCountingProcessing:detail']"
                color="#00AAAA"
                icon="Plus"
                round
                @click="addItem"
            >添加明细
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
                v-hasPermi="['inventory:inventoryCountingProcessing:save']"
                icon="position"
                round
                type="primary"
                @click="submitForm"
            >保存单据
            </el-button
            >
            <el-button
                v-hasPermi="[
                  'inventory:inventoryCountingProcessing:takeEffect',
                ]"
                :disabled="takeEffectBtn"
                icon="Check"
                round
                type="success"
                @click="auditingForm"
            >审核单据
            </el-button
            >
            <el-button
                v-hasPermi="['inventory:inventoryCountingProcessing:takeEffect']"
                :disabled="antiReviewBtn"
                icon="unlock"
                round
                type="danger"
                @click="antiReviewForm"
            >反审单据
            </el-button
            >
            <el-button
                v-hasPermi="['inventory:inventoryCountingProcessing:printOut']"
                :disabled="printBtn"
                color="#626aef"
                icon="Printer"
                round
                @click="printCommon"
            >打印单据
            </el-button
            >
            <el-button
                ref="ref22"
                v-hasPermi="['inventory:inventoryReceiptProcessing:delete']"
                :disabled="printBtn"
                icon="delete"
                round
                type="danger"
                @click="deleteReceipt"
            >删除单据
            </el-button
            >
            <el-button icon="close" round type="info" @click="cancel"
            >取消制作
            </el-button
            >
          </el-affix>
        </div>
      </el-col>
    </el-row>
  </div>

  <!-- 添加货品配置对话框 -->
  <product-dialog
      v-model:visible="openProduct"
  />

  <!-- 查看货品库存对话框 -->
  <product-inventory-dialog
      v-model:visible="openProductInventory"
      :product-id="currentProductId"
  />

  <!-- 查看单据锁单数量对话框 -->
  <lock-quantity-dialog
      v-model:visible="openLockQuantity"
      :product-id="currentProductId"
      :retrieval-id="retrievalId"
      :warehousing-id="warehousingId"
  />

  <!-- 查看打印模板对话框 -->
  <print-template-dialog
      v-model:visible="openPrintTemplate"
      :systematic-receipt="systematicReceipt"
  />
</template>

<script name="InventoryCounting" setup>
import {useRouter} from "vue-router";
import {getUserProfile} from "@/api/system/user";
import {delReceipt, getReceipt, saveInventoryCounting,} from "@/api/inventory/inventoryDocumentProcessing";
import {randomId} from "@/utils/RandomUtils";
import {ref} from "vue";
import {
  addProcessingBatch,
  deleteReceiptBatch,
  getColumns,
  getNowTime,
  getRemoteProduct,
  getRemoteWarehouse,
  SubmitVerification
} from "@/utils/processingUtils";
import {userList, warehouseList,} from "@/api/common/CommonReceipt";
import productDialog from '@/components/CommonDialog/productDialog.vue';
import productInventoryDialog from '@/components/CommonDialog/productInventoryDialog.vue';
import lockQuantityDialog from '@/components/CommonDialog/lockQuantityDialog.vue';
import printTemplateDialog from '@/components/CommonDialog/printTemplateDialog.vue';

const {proxy} = getCurrentInstance();
const {finding_of_audit} = proxy.useDict("finding_of_audit");

// 订单状态下拉框
const pending = ref(true);
const audited = ref(false);
const submitBtn = ref(false);
const takeEffectBtn = ref(false);
const antiReviewBtn = ref(true);
const finding = ref(false);
const loading = ref(false);
const printBtn = ref(false);
const router = useRouter();
const openUrl = ref("");
// 窗口标题
const openProduct = ref(false);
const openProductInventory = ref(false);
const openLockQuantity = ref(false);
const currentProductId = ref(null);
const warehousingId = ref(null);
const retrievalId = ref(null);
const openPrintTemplate = ref(false);
const systematicReceipt = ref(null);

const data = reactive({
  userOptions: undefined,
  warehouseOptions: undefined,
  productOptions: undefined,
  typeOptions: undefined,
  option: {
    warehouseName: undefined,
    supplierName: undefined,
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
    receiptType: null,
    receiptCategory: 3,
    receiptStatus: null,
    retrievalIds: null,
    warehousingIds: null,
    userIds: null,
    invoiceDate: null,
    planReceipt: null,
    receiptNotes: null,
    deposit: null,
    totalAmount: null,
    capitalizeTotalAmount: null,
    findingOfAudit: null,
    reviewComments: null,
    // 打印ID
    printId: null,
    printSize: undefined,
  },
  // 表单校验
  rules: {
    receiptType: [
      {required: true, message: "单据类型不能不选", trigger: "blur"},
    ],
    userIds: [{required: true, message: "经手人不能为空", trigger: "blur"}],
    warehousingIds: [
      {required: true, message: "盘点仓库不能为空", trigger: "blur"},
    ],
    invoiceDate: [
      {required: true, message: "发生日期不能为空", trigger: "blur"},
    ],
  },
});

const {
  userOptions,
  warehouseOptions,
  productOptions,
  typeOptions,
  option,
  productForm,
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
    antiReviewBtn.value = true;
    printBtn.value = true;
  }
}

async function getList() {
  option.value.pageSize = 500;
  userList(option.value).then((response) => {
    userOptions.value = response.rows;
  });
  getUserProfile().then((response) => {
    form.value.userIds = response.data.userId;
  });
}

/** 新增按钮操作 */
function addOrder() {
  addProcessingBatch(router, proxy, 'InventoryCounting')
}

/** 统计金额和成本 */
function calculateDetails(row) {
  if (
      row.actualInventory == 0 &&
      row.currentInventory == 0 &&
      row.planQuantity != 0
  ) {
    row.money = row.cost = Number(
        Math.abs(row.planQuantity) * row.univalence * row.discount
    ).toFixed(2);
  } else {
    row.planQuantity = row.actualInventory - row.currentInventory;
    row.money = row.cost = Number(
        Math.abs(row.planQuantity) * row.univalence * row.discount
    ).toFixed(2);
  }
}

/** 取消按钮 */
function cancel() {
  router.push({path: "/inventory/inventoryDocumentQuery"});
}

/** 提交公共方法 */
function submitAuditingForm(isSubmit) {
  proxy.$refs["orderRef"].validate(async (valid) => {
    if (!valid) return;
    if (!await SubmitVerification(proxy, form)) return;

    const details = form.value.details.map((it) => {
      const isPositive = Number(it.planQuantity) > 0;

      return {
        systematicReceipt: form.value.systematicReceipt,
        productId: it.productId,
        retrievalId: isPositive ? null : form.value.warehousingIds,
        warehousingId: isPositive ? form.value.warehousingIds : null,
        productSpecifications: it.productSpecifications,
        measureUnit: it.measureUnit,
        currentInventory: it.currentInventory,
        actualInventory: it.actualInventory,
        planQuantity: it.planQuantity,
        univalence: it.univalence,
        discount: it.discount,
        money: it.money,
        cost: it.cost,
        remarks: it.remarks,
      };
    });
    if (isSubmit === 1) {
      proxy.$modal.msgSuccess("库存盘点单保存成功");
    } else if (isSubmit === 2) {
      form.value.receiptStatus = 2;
      proxy.$modal.msgSuccess("库存盘点单审核成功");
    }
    const reqs = {...form.value, details};
    await saveInventoryCounting(reqs);
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

/** 反审按钮 */
function antiReviewForm() {
  getReceipt(form.value.systematicReceipt).then(async (response) => {
    const details = response.data.details;
    form.value = {
      ...response.data,
      details,
    }
    form.value.receiptStatus = 1;
    const reqs = {...form.value, details};
    await saveInventoryCounting(reqs);
    proxy.$modal.msgSuccess("单据反审成功");
    cancel();
  });
}

function loadDetail(systematicReceipt) {
  getReceipt(systematicReceipt).then((response) => {
    option.value.warehouseId = response.data.warehousingIds;
    warehouseList(option.value).then((response) => {
      warehouseOptions.value = response.rows;
    });
    if (response.data.receiptStatus === 2) {
      pending.value = false;
      audited.value = true;
      submitBtn.value = true;
      takeEffectBtn.value = true;
      antiReviewBtn.value = false;
    }
    printBtn.value = false;
    finding.value = true;
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
    form.value.warehousingIds = Number(response.data.warehousingIds);
    form.value.retrievalIds = Number(response.data.retrievalIds);
    form.value.userIds = Number(response.data.userIds);
  });
}

//自定义合计行
function getSummaries(param) {
  const {columns, data} = param;
  const sums = new Array(columns.length).fill("");
  getColumns(columns, data, form, sums, [1, 2, 3, 4, 5, 6, 14], [15, 16]);
  return sums;
}

// 表单重置
function reset() {
  form.value = {
    systematicReceipt: "PD-" + randomId(),
    originalReceipt: null,
    receiptType: 8,
    receiptCategory: 3,
    receiptStatus: 1,
    invoiceDate: getNowTime(),
    retrievalIds: null,
    warehousingIds: null,
    userIds: null,
    planReceipt: null,
    receiptNotes: null,
    deposit: null,
    totalAmount: null,
    capitalizeTotalAmount: null,
    findingOfAudit: null,
    reviewComments: null,
    printId: null,
    details: [],
  };
  proxy.resetForm("orderRef");
}

// 添加货品
function addItem() {
  proxy.$refs["orderRef"].validate((valid) => {
    if (!valid) {
      proxy.$modal.msgError("请先选择单据头信息");
      return;
    }
    form.value.details.push({});
  });
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
    inventoryQty: null,
    lockQty: null,
    retrievalId: null,
    warehousingId: null,
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
    inventoryQty: lists.inventoryQty,
    lockQty: lists.lockQty,
    retrievalId: form.value.retrievalIds,
    warehousingId: form.value.warehousingIds,
    currentInventory: 0,
    actualInventory: 0,
    planQuantity: 0,
    univalence: lists.univalence,
    discount: lists.discount,
    money: 0,
    cost: 0,
    remarks: null,
  };
  form.value.details = [...form.value.details];
}

/** 打印按钮 */
function printCommon() {
  systematicReceipt.value = form.value.systematicReceipt;
  openPrintTemplate.value = true;
}

/** 删除按钮操作 */
function deleteReceipt() {
  deleteReceiptBatch(router, proxy, form, getReceipt, delReceipt, 'InventoryCounting');
}

/** 新增按钮操作 */
function handleAdd() {
  openProduct.value = true;
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

// 查询仓库名称
function remoteWarehouse(query) {
  optionReset();
  getRemoteWarehouse(query, loading, option, warehouseOptions);
}

// 查询货品编号
function remoteProductCode(query) {
  optionReset();
  option.value.warehousingId = form.value.warehousingIds;
  option.value.retrievalId = form.value.retrievalIds;
  getRemoteProduct(query, 'productCode', loading, option, productOptions);
}

// 查询货品名称
function remoteProductName(query) {
  optionReset();
  option.value.warehousingId = form.value.warehousingIds;
  option.value.retrievalId = form.value.retrievalIds;
  getRemoteProduct(query, 'productName', loading, option, productOptions);
}

function handleWarehouseChange() {
  form.value.details = [];
}

function selectAllInventoryQty(productId) {
  if (!productId || typeof productId !== 'string') {
    proxy.$modal.msgError('请选择货品');
    return;
  }

  currentProductId.value = productId;
  openProductInventory.value = true;
}

function selectLockQty(productId) {
  if (!productId || typeof productId !== 'string') {
    proxy.$modal.msgError('请选择货品');
    return;
  }

  currentProductId.value = productId;
  warehousingId.value = form.value.warehousingIds;
  retrievalId.value = form.value.retrievalIds;
  openLockQuantity.value = true;
}

initialization();
getList();
</script>

<style scoped>
.form-item {
  width: 200px;
}

.footer {
  text-align: center;
}
</style>
