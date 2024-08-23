<template>
  <!-- 历史单据迁移 -->
  <div class="app-container">
    <el-row :gutter="20">
      <el-col :span="24" :xs="24">
        <el-form
          :inline="true"
          ref="queryRef"
          :model="queryParams"
          label-width="70px"
        >
          <el-form-item label="系统单号" prop="systematicReceipt">
            <el-input
              v-model="queryParams.systematicReceipt"
              placeholder="请输入"
              class="form-item"
              clearable
            />
          </el-form-item>
          <el-form-item label="原始单号" prop="originalReceipt">
            <el-input
              v-model="queryParams.originalReceipt"
              placeholder="请输入"
              class="form-item"
              clearable
            />
          </el-form-item>
          <el-form-item label="单据类型" prop="receiptType">
            <el-select
              v-model="queryParams.receiptType"
              placeholder="单据类型"
              filterable
              clearable
              class="form-item"
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
              class="form-item"
            >
              <el-option
                v-for="dict in receipt_status"
                :key="dict.value"
                :label="dict.label"
                :value="dict.value"
              />
            </el-select>
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
              v-hasPermi="['system:historicalDocuments:head']"
              >查询</el-button
            >
            <el-button
              type="success"
              icon="Search"
              @click="handleDetailQuery"
              v-hasPermi="['system:historicalDocuments:detail']"
              >明细查询</el-button
            >
            <el-button icon="Refresh" @click="resetQuery">重置</el-button>
          </el-form-item>
        </el-form>
        <el-row :gutter="10" class="mb8">
          <el-col :span="1.5">
            <el-button
              :disabled="historicalDocumentsDetail"
              type="info"
              plain
              icon="Upload"
              @click="handleHeadImport"
              v-hasPermi="['system:historicalDocuments:importHeadData']"
              >导入</el-button
            >
          </el-col>
          <el-col :span="1.5">
            <el-button
              :disabled="historicalDocumentsDetail"
              type="warning"
              plain
              icon="Download"
              @click="handleExport"
              v-hasPermi="['system:historicalDocuments:headReceiptExport']"
              >导出</el-button
            >
          </el-col>
          <el-col :span="1.5">
            <el-button
              :disabled="historicalDocuments"
              type="info"
              plain
              icon="Upload"
              @click="handleDetailImport"
              v-hasPermi="['system:historicalDocuments:importDetailData']"
              >明细导入</el-button
            >
          </el-col>
          <el-col :span="1.5">
            <el-button
              :disabled="historicalDocuments"
              type="danger"
              plain
              icon="Download"
              @click="handleDetailExport"
              v-hasPermi="['system:historicalDocuments:detailReceiptExport']"
              >明细导出</el-button
            >
          </el-col>
        </el-row>

        <!-- 头表数据 -->
        <el-table
          border
          v-if="historicalDocuments"
          v-loading="loading"
          :data="headReceiptList"
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
            label="单据类别ID"
            align="center"
            prop="receiptCategory"
          />
          <el-table-column
            label="单据类型ID"
            align="center"
            prop="receiptType"
          />
          <el-table-column label="单据类型" align="center" prop="receiptType">
            <template #default="scope">
              <dict-tag
                :options="receipt_type"
                :value="scope.row.receiptType"
              />
            </template>
          </el-table-column>
          <el-table-column
            label="单据状态ID"
            align="center"
            prop="receiptStatus"
          />
          <el-table-column label="单据状态" align="center" prop="receiptStatus">
            <template #default="scope">
              <dict-tag
                :options="receipt_status"
                :value="scope.row.receiptStatus"
              />
            </template>
          </el-table-column>
          <el-table-column label="发生日期" align="center" prop="invoiceDate" />
          <el-table-column
            label="调入仓库ID"
            align="center"
            prop="warehousingIds"
          />
          <el-table-column
            label="调入仓库"
            align="center"
            prop="warehousing.warehousingName"
          />
          <el-table-column
            label="调出仓库ID"
            align="center"
            prop="retrievalIds"
          />
          <el-table-column
            label="调出仓库"
            align="center"
            prop="retrieval.retrievalName"
          />
          <el-table-column label="经手人ID" align="center" prop="userIds" />
          <el-table-column
            label="经手人"
            align="center"
            prop="sysUser.userName"
          />
          <el-table-column label="供应商ID" align="center" prop="supplierIds" />
          <el-table-column
            label="供应商"
            align="center"
            prop="supplier.supplierName"
          />
          <el-table-column label="客户ID" align="center" prop="customerIds" />
          <el-table-column
            label="客户"
            align="center"
            prop="customer.customerName"
          />
          <el-table-column label="订单号" align="center" prop="planReceipt" />
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
          <el-table-column label="创建者" align="center" prop="createBy" />
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
          <el-table-column label="更新者" align="center" prop="updateBy" />
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
            width="80"
            class-name="small-padding fixed-width"
          >
            <template #default="scope">
              <el-tooltip content="删除" placement="top">
                <el-button
                  link
                  type="primary"
                  icon="Delete"
                  @click="handleDelete(scope.row)"
                  v-hasPermi="['system:historicalDocuments:delete']"
                ></el-button>
              </el-tooltip>
            </template>
          </el-table-column>
        </el-table>
        <!-- 分页组件 -->
        <pagination
          v-if="historicalDocuments"
          v-show="total > 0"
          :total="total"
          v-model:page="queryParams.pageNum"
          v-model:limit="queryParams.pageSize"
          @pagination="getList"
        />
        <!-- 明细表数据 -->
        <el-table
          border
          v-if="historicalDocumentsDetail"
          v-loading="loading"
          :data="detailReceiptList"
        >
          <el-table-column
            label="序号"
            align="center"
            type="index"
            width="60"
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
          v-if="historicalDocumentsDetail"
          v-show="total > 0"
          :total="total"
          v-model:page="queryParams.pageNum"
          v-model:limit="queryParams.pageSize"
          @pagination="getDetailList"
        />
      </el-col>
    </el-row>

    <!-- 单据头表导入对话框 -->
    <el-dialog
      :title="uploadHead.title"
      v-model="uploadHead.open"
      width="400px"
      append-to-body
    >
      <el-upload
        ref="uploadHeadRef"
        :limit="1"
        accept=".xlsx, .xls"
        :headers="uploadHead.headers"
        :action="uploadHead.url + '?updateSupport=' + uploadHead.updateSupport"
        :disabled="uploadHead.isUploading"
        :on-progress="handleHeadFileUploadProgress"
        :on-success="handleHeadFileSuccess"
        :auto-upload="false"
        drag
      >
        <el-icon class="el-icon--upload"><upload-filled /></el-icon>
        <div class="el-upload__text">将文件拖到此处，或<em>点击上传</em></div>
        <template #tip>
          <div class="el-upload__tip text-center">
            <div class="el-upload__tip">
              <el-checkbox
                v-model="uploadHead.updateSupport"
              />是否更新已经存在的单据头表数据
            </div>
            <span>仅允许导入xls、xlsx格式文件。</span>
            <el-link
              type="primary"
              :underline="false"
              style="font-size: 12px; vertical-align: baseline"
              @click="importHeadTemplate"
              >下载模板</el-link
            >
          </div>
        </template>
      </el-upload>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitHeadFileForm"
            >确 定</el-button
          >
          <el-button @click="uploadHead.open = false">取 消</el-button>
        </div>
      </template>
    </el-dialog>

    <!-- 单据明细表导入对话框 -->
    <el-dialog
      :title="uploadDetail.title"
      v-model="uploadDetail.open"
      width="400px"
      append-to-body
    >
      <el-upload
        ref="uploadDetailRef"
        :limit="1"
        accept=".xlsx, .xls"
        :headers="uploadDetail.headers"
        :action="
          uploadDetail.url + '?updateSupport=' + uploadDetail.updateSupport
        "
        :disabled="uploadDetail.isUploading"
        :on-progress="handleDetailFileUploadProgress"
        :on-success="handleDetailFileSuccess"
        :auto-upload="false"
        drag
      >
        <el-icon class="el-icon--upload"><upload-filled /></el-icon>
        <div class="el-upload__text">将文件拖到此处，或<em>点击上传</em></div>
        <template #tip>
          <div class="el-upload__tip text-center">
            <div class="el-upload__tip">
              <el-checkbox
                v-model="uploadDetail.updateSupport"
              />是否更新已经存在的单据明细表数据
            </div>
            <span>仅允许导入xls、xlsx格式文件。</span>
            <el-link
              type="primary"
              :underline="false"
              style="font-size: 12px; vertical-align: baseline"
              @click="importDetailTemplate"
              >下载模板</el-link
            >
          </div>
        </template>
      </el-upload>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitDetailFileForm"
            >确 定</el-button
          >
          <el-button @click="uploadDetail.open = false">取 消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="historicalDocuments">
import { getToken } from "@/utils/auth";
import {
  headReceiptQuery,
  detailReceiptQuery,
  getHeadReceipt,
  delInventoryReceipt,
} from "@/api/inventory/historicalDocuments";

const { proxy } = getCurrentInstance();
const { receipt_type } = proxy.useDict("receipt_type");
const { receipt_status } = proxy.useDict("receipt_status");

// 查询结果表
const headReceiptList = ref([]);
const detailReceiptList = ref([]);
// 查询表展示
const historicalDocuments = ref(true);
// 查询明细表展示
const historicalDocumentsDetail = ref(false);
// 加载
const loading = ref(true);
// 总条数
const total = ref(0);
// 数据范围
const dateRange = ref([]);
/*** 单据头表导入参数 */
const uploadHead = reactive({
  // 是否显示弹出层（单据头表导入）
  open: false,
  // 弹出层标题（单据头表导入）
  title: "",
  // 是否禁用上传
  isUploading: false,
  // 是否更新已经存在的头数据
  updateSupport: 0,
  // 设置上传的请求头部
  headers: { Authorization: "Bearer " + getToken() },
  // 上传的地址
  url:
    import.meta.env.VITE_APP_BASE_API +
    "/system/historicalDocuments/importHeadData",
});
/*** 单据明细表导入参数 */
const uploadDetail = reactive({
  // 是否显示弹出层（单据明细表导入）
  open: false,
  // 弹出层标题（单据明细表导入）
  title: "",
  // 是否禁用上传
  isUploading: false,
  // 是否更新已经存在的明细数据
  updateSupport: 0,
  // 设置上传的请求头部
  headers: { Authorization: "Bearer " + getToken() },
  // 上传的地址
  url:
    import.meta.env.VITE_APP_BASE_API +
    "/system/historicalDocuments/importDetailData",
});

const data = reactive({
  form: {},
  fileForm: {},
  queryParams: {
    pageNum: 1,
    pageSize: 50,
    systematicReceipt: undefined,
    originalReceipt: undefined,
    receiptType: undefined,
    receiptStatus: undefined,
    warehousingIds: undefined,
    retrievalIds: undefined,
    userIds: undefined,
    supplierIds: undefined,
    customerIds: undefined,
    productCode: undefined,
    productName: undefined,
  },
  rules: {},
});

const { queryParams, fileForm, form, rules } = toRefs(data);

/** 查询库存头单列表 */
function getList() {
  loading.value = true;
  headReceiptQuery(proxy.addDateRange(queryParams.value, dateRange.value)).then(
    (response) => {
      headReceiptList.value = response.rows;
      total.value = response.total;
      loading.value = false;
    }
  );
}
/** 查询库存明细列表 */
function getDetailList() {
  loading.value = true;
  detailReceiptQuery(
    proxy.addDateRange(queryParams.value, dateRange.value)
  ).then((response) => {
    detailReceiptList.value = response.rows;
    total.value = response.total;
    loading.value = false;
  });
}
/** 查询按钮操作 */
function handleQuery() {
  historicalDocuments.value = true;
  historicalDocumentsDetail.value = false;
  queryParams.value.pageNum = 1;
  getList();
}
/** 明细查询按钮操作 */
function handleDetailQuery() {
  historicalDocuments.value = false;
  historicalDocumentsDetail.value = true;
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
    originalReceipt: undefined,
    receiptType: undefined,
    warehousingIds: undefined,
    retrievalIds: undefined,
    customerIds: undefined,
    productCode: undefined,
    productName: undefined,
    fileId: undefined,
  };
  proxy.resetForm("queryRef");
  historicalDocumentsHead.value = true;
  historicalDocumentsDetail.value = false;
}
/** 删除按钮操作 */
function handleDelete(row) {
  const systematicReceipt = row.systematicReceipt;
  getHeadReceipt(systematicReceipt).then((response) => {
    const details = response.data.details;
    proxy.$modal
      .confirm("确认要删除编号为" + systematicReceipt + "的单据?")
      .then(function () {
        return delInventoryReceipt(details);
      })
      .then(() => {
        getList();
        proxy.$modal.msgSuccess("删除成功");
      })
      .catch(() => {});
  });
}
/** 单据头导入按钮操作 */
function handleHeadImport() {
  uploadHead.title = "单据头表";
  uploadHead.open = true;
}
/** 单据头下载模板操作 */
function importHeadTemplate() {
  proxy.download(
    "/system/historicalDocuments/importHeadTemplate",
    {},
    `单据头导入模板_${new Date().getTime()}.xlsx`
  );
}
/**文件上传中处理 */
const handleHeadFileUploadProgress = (event, file, fileList) => {
  uploadHead.isUploading = true;
};
/** 文件上传成功处理 */
const handleHeadFileSuccess = (response, file, fileList) => {
  uploadHead.open = false;
  uploadHead.isUploading = false;
  proxy.$refs["uploadHeadRef"].handleRemove(file);
  proxy.$alert(
    "<div style='overflow: auto;overflow-x: hidden;max-height: 70vh;padding: 10px 20px 0;'>" +
      response.msg +
      "</div>",
    "导入结果",
    { dangerouslyUseHTMLString: true }
  );
  getList();
};
/** 提交上传文件 */
function submitHeadFileForm() {
  proxy.$refs["uploadHeadRef"].submit();
}
/** 单据明细导入按钮操作 */
function handleDetailImport() {
  uploadDetail.title = "单据明细表";
  uploadDetail.open = true;
}
/** 单据明细下载模板操作 */
function importDetailTemplate() {
  proxy.download(
    "/system/historicalDocuments/importDetailTemplate",
    {},
    `单据明细导入模板_${new Date().getTime()}.xlsx`
  );
}
/**文件上传中处理 */
const handleDetailFileUploadProgress = (event, file, fileList) => {
  uploadDetail.isUploading = true;
};
/** 文件上传成功处理 */
const handleDetailFileSuccess = (response, file, fileList) => {
  uploadDetail.open = false;
  uploadDetail.isUploading = false;
  proxy.$refs["uploadDetailRef"].handleRemove(file);
  proxy.$alert(
    "<div style='overflow: auto;overflow-x: hidden;max-height: 70vh;padding: 10px 20px 0;'>" +
      response.msg +
      "</div>",
    "导入结果",
    { dangerouslyUseHTMLString: true }
  );
  getList();
};
/** 提交上传文件 */
function submitDetailFileForm() {
  proxy.$refs["uploadDetailRef"].submit();
}
/** 导出按钮操作 */
function handleExport() {
  proxy.download(
    "inventory/historicalDocuments/headReceiptExport",
    {
      ...queryParams.value,
    },
    `单据表_${new Date().getTime()}.xlsx`
  );
}
/** 明细导出按钮操作 */
function handleDetailExport() {
  proxy.download(
    "inventory/historicalDocuments/detailReceiptExport",
    {
      ...queryParams.value,
    },
    `单据明细表_${new Date().getTime()}.xlsx`
  );
}
getList();
</script>

<style scoped>
.form-item {
  width: 200px;
}
</style>
