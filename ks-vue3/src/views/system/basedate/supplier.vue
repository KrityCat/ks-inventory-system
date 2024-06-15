<template>
  <!-- 供应商资料 -->
  <div class="app-container">
    <el-row :gutter="20">
      <el-col :span="24" :xs="24">
        <el-form
          :inline="true"
          v-show="showSearch"
          ref="queryRef"
          :model="queryParams"
          label-width="90px"
        >
          <el-form-item label="供应商编号" prop="supplierCode">
            <el-input
              v-model="queryParams.supplierCode"
              placeholder="请输入供应商编号"
              style="width: 200px"
              clearable
              @keyup.enter="handleQuery"
            />
          </el-form-item>
          <el-form-item label="供应商名称" prop="supplierName">
            <el-input
              v-model="queryParams.supplierName"
              placeholder="请输入供应商名称"
              clearable
              style="width: 200px"
            />
          </el-form-item>
          <el-form-item label="业务员" prop="supplierSalesPerson">
            <el-input
              v-model="queryParams.supplierSalesPerson"
              placeholder="请输入业务员"
              style="width: 200px"
            />
          </el-form-item>
          <el-form-item label="联系人" prop="supplierContacts">
            <el-input
              v-model="queryParams.supplierContacts"
              placeholder="请输入联系人"
              style="width: 200px"
            />
          </el-form-item>
          <el-form-item label="联系电话" prop="supplierContactNumber">
            <el-input
              v-model="queryParams.supplierContactNumber"
              placeholder="请输入联系电话"
              style="width: 200px"
            />
          </el-form-item>
          <el-form-item label="单位地址" prop="supplierWorkAddress">
            <el-input
              v-model="queryParams.supplierWorkAddress"
              placeholder="请输入单位地址"
              style="width: 200px"
            />
          </el-form-item>
          <el-form-item label="状态" prop="status">
            <el-select
              v-model="queryParams.status"
              placeholder="请选择"
              clearable
              style="width: 200px"
            >
              <el-option
                v-for="dict in sys_normal_disable"
                :key="dict.value"
                :label="dict.label"
                :value="dict.value"
              />
            </el-select>
          </el-form-item>
          <el-form-item>
            <el-button
              type="primary"
              icon="Search"
              @click="handleQuery"
              v-hasPermi="['baseDate:supplier:list']"
              >查询</el-button
            >
            <el-button icon="Refresh" @click="resetQuery">重置</el-button>
          </el-form-item>
        </el-form>
        <el-row :gutter="10" class="mb8">
          <el-col :span="1.5">
            <el-button
              type="primary"
              plain
              icon="Plus"
              @click="handleAdd"
              v-hasPermi="['baseDate:supplier:add']"
              >新增</el-button
            >
          </el-col>
          <el-col :span="1.5">
            <el-button
              type="success"
              plain
              icon="Edit"
              :disabled="single"
              @click="handleUpdate"
              v-hasPermi="['baseDate:supplier:update']"
              >修改</el-button
            >
          </el-col>
          <el-col :span="1.5">
            <el-button
              type="danger"
              plain
              icon="Delete"
              :disabled="multiple"
              @click="handleDelete"
              v-hasPermi="['baseDate:supplier:remove']"
              >删除</el-button
            >
          </el-col>
          <el-col :span="1.5">
            <el-button
              type="info"
              plain
              icon="Upload"
              @click="handleImport"
              v-hasPermi="['baseDate:supplier:import']"
              >导入</el-button
            >
          </el-col>
          <el-col :span="1.5">
            <el-button
              type="warning"
              plain
              icon="Download"
              @click="handleExport"
              v-hasPermi="['baseDate:supplier:export']"
              >导出</el-button
            >
          </el-col>
          <right-toolbar
            v-model:showSearch="showSearch"
            @queryTable="getList"
            :columns="columns"
          ></right-toolbar>
        </el-row>

        <!-- 表格数据 -->
        <el-table
          border
          v-loading="loading"
          :data="supplierList"
          @selection-change="handleSelectionChange"
        >
          <el-table-column type="selection" width="50" align="center" />
          <el-table-column
            label="供应商编号"
            align="center"
            prop="supplierCode"
            v-if="columns[0].visible"
          />
          <el-table-column
            label="供应商名称"
            align="center"
            prop="supplierName"
            v-if="columns[1].visible"
          />
          <el-table-column
            label="业务员"
            align="center"
            prop="supplierSalesPerson"
            v-if="columns[2].visible"
          />
          <el-table-column
            label="联系人"
            align="center"
            prop="supplierContacts"
            v-if="columns[3].visible"
          />
          <el-table-column
            label="联系电话"
            align="center"
            prop="supplierContactNumber"
            v-if="columns[4].visible"
          />
          <el-table-column
            label="单位地址"
            align="center"
            prop="supplierWorkAddress"
            :show-overflow-tooltip="true"
            v-if="columns[5].visible"
          />
          <el-table-column
            label="邮编"
            align="center"
            prop="supplierPostalCode"
            v-if="columns[6].visible"
          />
          <el-table-column
            label="期初欠款"
            align="center"
            prop="supplierOpeningDebt"
            v-if="columns[7].visible"
          />
          <el-table-column
            label="开户银行"
            align="center"
            prop="supplierOpeningBank"
            v-if="columns[8].visible"
          />
          <el-table-column
            label="银行账号"
            align="center"
            prop="supplierAccountNumber"
            v-if="columns[9].visible"
          />
          <el-table-column
            label="纳税号"
            align="center"
            prop="supplierTaxId"
            v-if="columns[10].visible"
          />
          <el-table-column
            label="公司主页"
            align="center"
            prop="supplierCompanyHomepage"
            v-if="columns[11].visible"
          />
          <el-table-column
            label="电子邮箱"
            align="center"
            prop="supplierEmail"
            v-if="columns[12].visible"
          />
          <el-table-column
            label="公司法人"
            align="center"
            prop="supplierLegalPerson"
            v-if="columns[13].visible"
          />
          <el-table-column
            label="状态"
            align="center"
            prop="status"
            v-if="columns[14].visible"
          >
            <template #default="scope">
              <dict-tag
                :options="sys_normal_disable"
                :value="scope.row.status"
              />
            </template>
          </el-table-column>
          <el-table-column
            label="备注"
            align="center"
            prop="remarks"
            :show-overflow-tooltip="true"
            v-if="columns[15].visible"
          />
          <el-table-column
            label="创建者"
            align="center"
            prop="createBy"
            v-if="columns[16].visible"
          />
          <el-table-column
            label="创建时间"
            align="center"
            prop="createTime"
            v-if="columns[17].visible"
          >
            <template #default="scope">
              <span>{{ parseTime(scope.row.createTime) }}</span>
            </template>
          </el-table-column>
          <el-table-column
            label="更新者"
            align="center"
            prop="updateBy"
            v-if="columns[18].visible"
          />
          <el-table-column
            label="更新时间"
            align="center"
            prop="updateTime"
            v-if="columns[19].visible"
          >
            <template #default="scope">
              <span>{{ parseTime(scope.row.updateTime) }}</span>
            </template>
          </el-table-column>
          <el-table-column
            fixed="right"
            label="操作"
            align="center"
            width="100"
            class-name="small-padding fixed-width"
          >
            <template #default="scope">
              <el-tooltip
                content="修改"
                placement="top"
                v-if="scope.row.supplierId !== 0"
              >
                <el-button
                  link
                  type="primary"
                  icon="Edit"
                  @click="handleUpdate(scope.row)"
                  v-hasPermi="['baseDate:supplier:update']"
                ></el-button>
              </el-tooltip>
              <el-tooltip
                content="删除"
                placement="top"
                v-if="scope.row.supplierId !== 0"
              >
                <el-button
                  link
                  type="primary"
                  icon="Delete"
                  @click="handleDelete(scope.row)"
                  v-hasPermi="['baseDate:supplier:remove']"
                ></el-button>
              </el-tooltip>
            </template>
          </el-table-column>
        </el-table>
        <!-- 分页组件 -->
        <pagination
          v-show="total > 0"
          :total="total"
          v-model:page="queryParams.pageNum"
          v-model:limit="queryParams.pageSize"
          @pagination="getList"
        />
      </el-col>
    </el-row>

    <!-- 添加或修改供应商配置对话框 -->
    <el-dialog :title="title" v-model="open" width="700px" append-to-body>
      <el-form
        :model="form"
        :rules="rules"
        ref="supplierRef"
        label-width="100px"
      >
        <el-row>
          <el-col :span="12">
            <el-form-item label="供应商编号" prop="supplierCode">
              <el-input
                v-model="form.supplierCode"
                placeholder="请输入供应商编号"
                maxlength="30"
              />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="供应商名称" prop="supplierName">
              <el-input
                v-model="form.supplierName"
                placeholder="请输入供应商名称"
                maxlength="30"
              />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="业务员" prop="supplierSalesPerson">
              <el-input
                v-model="form.supplierSalesPerson"
                placeholder="请输入业务员"
                maxlength="30"
              />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="联系人" prop="supplierContacts">
              <el-input
                v-model="form.supplierContacts"
                placeholder="请输入联系人"
                maxlength="30"
              />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="联系电话" prop="supplierContactNumber">
              <el-input
                v-model="form.supplierContactNumber"
                placeholder="请输入联系电话"
                maxlength="30"
              />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="邮编" prop="supplierPostalCode">
              <el-input
                v-model="form.supplierPostalCode"
                placeholder="请输入邮编"
                maxlength="30"
              />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="期初欠款" prop="supplierOpeningDebt">
              <el-input
                v-model="form.supplierOpeningDebt"
                placeholder="请输入期初欠款"
                maxlength="30"
              />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="开户银行" prop="supplierOpeningBank">
              <el-input
                v-model="form.supplierOpeningBank"
                placeholder="请输入开户银行"
                maxlength="30"
              />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="银行账号" prop="supplierAccountNumber">
              <el-input
                v-model="form.supplierAccountNumber"
                placeholder="请输入银行账号"
                maxlength="30"
              />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="纳税号" prop="supplierTaxId">
              <el-input
                v-model="form.supplierTaxId"
                placeholder="请输入纳税号"
                maxlength="30"
              />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="公司主页" prop="supplierCompanyHomepage">
              <el-input
                v-model="form.supplierCompanyHomepage"
                placeholder="请输入公司主页"
                maxlength="30"
              />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="电子邮箱" prop="supplierEmail">
              <el-input
                v-model="form.supplierEmail"
                placeholder="请输入电子邮箱"
                maxlength="30"
              />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="公司法人" prop="supplierLegalPerson">
              <el-input
                v-model="form.supplierLegalPerson"
                placeholder="请输入公司法人"
                maxlength="30"
              />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="状态" prop="status">
              <el-select v-model="form.status" placeholder="请选择" clearable>
                <!-- <el-option
                    v-for="dict in sys_normal_disable"
                    :key="dict.value"
                    :label="dict.label"
                    :value="dict.value"/> -->
                <el-option label="正常" :value="0"></el-option>
                <el-option label="停用" :value="1"></el-option>
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="24">
            <el-form-item label="单位地址" prop="supplierWorkAddress">
              <el-input
                v-model="form.supplierWorkAddress"
                placeholder="请输入单位地址"
              />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="24">
            <el-form-item label="备注">
              <el-input
                v-model="form.remarks"
                type="textarea"
                placeholder="请输入备注"
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

    <!-- 供应商导入对话框 -->
    <el-dialog
      :title="upload.title"
      v-model="upload.open"
      width="400px"
      append-to-body
    >
      <el-upload
        ref="uploadRef"
        :limit="1"
        accept=".xlsx, .xls"
        :headers="upload.headers"
        :action="upload.url + '?updateSupport=' + upload.updateSupport"
        :disabled="upload.isUploading"
        :on-progress="handleFileUploadProgress"
        :on-success="handleFileSuccess"
        :auto-upload="false"
        drag
      >
        <el-icon class="el-icon--upload"><upload-filled /></el-icon>
        <div class="el-upload__text">将文件拖到此处，或<em>点击上传</em></div>
        <template #tip>
          <div class="el-upload__tip text-center">
            <div class="el-upload__tip">
              <el-checkbox
                v-model="upload.updateSupport"
              />是否更新已经存在的供应商数据
            </div>
            <span>仅允许导入xls、xlsx格式文件。</span>
            <el-link
              type="primary"
              :underline="false"
              style="font-size: 12px; vertical-align: baseline"
              @click="importTemplate"
              >下载模板</el-link
            >
          </div>
        </template>
      </el-upload>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitFileForm">确 定</el-button>
          <el-button @click="upload.open = false">取 消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="Supplier">
import { getToken } from "@/utils/auth";
import {
  listSupplier,
  getSupplier,
  addSupplier,
  updateSupplier,
  delSupplier,
} from "@/api/basedate/supplier";

const { proxy } = getCurrentInstance();
const { sys_normal_disable } = proxy.useDict("sys_normal_disable");

// 查询结果表
const supplierList = ref([]);
// 窗口开关
const open = ref(false);
// 加载
const loading = ref(true);
// 隐藏查询
const showSearch = ref(true);
const ids = ref([]);
// 多选显示修改按钮
const single = ref(true);
// 多选显示删除按钮
const multiple = ref(true);
// 总条数
const total = ref(0);
// 窗口标题
const title = ref("");
// 数据范围
const dateRange = ref([]);
/*** 供应商导入参数 */
const upload = reactive({
  // 是否显示弹出层（供应商导入）
  open: false,
  // 弹出层标题（供应商导入）
  title: "",
  // 是否禁用上传
  isUploading: false,
  // 是否更新已经存在的供应商数据
  updateSupport: 0,
  // 设置上传的请求头部
  headers: { Authorization: "Bearer " + getToken() },
  // 上传的地址
  url: import.meta.env.VITE_APP_BASE_API + "/baseDate/supplier/importData",
});
// 列显隐信息
const columns = ref([
  { key: 0, label: `供应商编号`, visible: true },
  { key: 1, label: `供应商名称`, visible: true },
  { key: 2, label: `业务员`, visible: true },
  { key: 3, label: `联系人`, visible: true },
  { key: 4, label: `联系电话`, visible: true },
  { key: 5, label: `单位地址`, visible: true },
  { key: 6, label: `邮编`, visible: true },
  { key: 7, label: `期初欠款`, visible: true },
  { key: 8, label: `开户银行`, visible: true },
  { key: 9, label: `银行账号`, visible: true },
  { key: 10, label: `纳税号`, visible: true },
  { key: 11, label: `公司主页`, visible: true },
  { key: 12, label: `电子邮箱`, visible: true },
  { key: 13, label: `公司法人`, visible: true },
  { key: 14, label: `状态`, visible: true },
  { key: 15, label: `备注`, visible: true },
  { key: 16, label: `创建者`, visible: true },
  { key: 17, label: `创建时间`, visible: true },
  { key: 18, label: `更新者`, visible: true },
  { key: 19, label: `更新时间`, visible: true },
]);

const data = reactive({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    supplierCode: undefined,
    supplierName: undefined,
    supplierSalesPerson: undefined,
    supplierContacts: undefined,
    supplierContactNumber: undefined,
    supplierWorkAddress: undefined,
    status: undefined,
  },
  rules: {
    supplierCode: [
      { required: true, message: "供应商编号不能为空", trigger: "blur" },
      { max: 30, message: "供应商编号长度不能大于 30 ", trigger: "blur" },
    ],
    supplierName: [
      { required: true, message: "供应商名称不能为空", trigger: "blur" },
      { max: 30, message: "供应商名称长度不能大于 30 ", trigger: "blur" },
    ],
    status: [{ required: true, message: "状态不能为空", trigger: "blur" }],
    supplierEmail: [
      {
        type: "email",
        message: "请输入正确的邮箱地址",
        trigger: ["blur", "change"],
      },
    ],
    supplierContactNumber: [
      {
        pattern: /^1[3|4|5|6|7|8|9][0-9]\d{8}$/,
        message: "请输入正确的手机号码",
        trigger: "blur",
      },
    ],
  },
});

const { queryParams, form, rules } = toRefs(data);

/** 查询供应商列表 */
function getList() {
  loading.value = true;
  listSupplier(proxy.addDateRange(queryParams.value, dateRange.value)).then(
    (response) => {
      supplierList.value = response.rows;
      total.value = response.total;
      loading.value = false;
    }
  );
}
/** 查询按钮操作 */
function handleQuery() {
  queryParams.value.pageNum = 1;
  getList();
}
/** 重置按钮操作 */
function resetQuery() {
  dateRange.value = [];
  proxy.resetForm("queryRef");
  handleQuery();
}
/** 导入按钮操作 */
function handleImport() {
  upload.title = "供应商导入";
  upload.open = true;
}
/** 下载模板操作 */
function importTemplate() {
  proxy.download(
    "/baseDate/supplier/importTemplate",
    {},
    `供应商资料导入模板_${new Date().getTime()}.xlsx`
  );
}
/**文件上传中处理 */
const handleFileUploadProgress = (event, file, fileList) => {
  upload.isUploading = true;
};
/** 文件上传成功处理 */
const handleFileSuccess = (response, file, fileList) => {
  upload.open = false;
  upload.isUploading = false;
  proxy.$refs["uploadRef"].handleRemove(file);
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
function submitFileForm() {
  proxy.$refs["uploadRef"].submit();
}
/** 重置操作表单 */
function reset() {
  form.value = {
    supplierCode: undefined,
    supplierName: undefined,
    supplierSalesPerson: undefined,
    supplierContacts: undefined,
    supplierContactNumber: undefined,
    supplierWorkAddress: undefined,
    supplierPostalCode: undefined,
    supplierOpeningDebt: undefined,
    supplierOpeningBank: undefined,
    supplierAccountNumber: undefined,
    supplierTaxId: undefined,
    supplierCompanyHomepage: undefined,
    supplierEmail: undefined,
    supplierLegalPerson: undefined,
    status: undefined,
    remarks: undefined,
  };
  proxy.resetForm("supplierRef");
}
/** 取消按钮 */
function cancel() {
  open.value = false;
  reset();
}
/** 新增按钮 */
function handleAdd() {
  reset();
  open.value = true;
  title.value = "新增供应商";
}
/** 修改按钮操作 */
function handleUpdate(row) {
  reset();
  const supplierId = row.supplierId || ids.value;
  getSupplier(supplierId).then((response) => {
    form.value = response.data;
    open.value = true;
    title.value = "修改供应商";
  });
}
/** 提交按钮 */
function submitForm() {
  proxy.$refs["supplierRef"].validate((valid) => {
    if (valid) {
      if (form.value.supplierId != undefined) {
        updateSupplier(form.value).then((response) => {
          proxy.$modal.msgSuccess("修改成功");
          open.value = false;
          getList();
        });
      } else {
        addSupplier(form.value).then((response) => {
          proxy.$modal.msgSuccess("新增成功");
          open.value = false;
          getList();
        });
      }
    }
  });
}
/** 删除按钮操作 */
function handleDelete(row) {
  const supplierIds = row.supplierId || ids.value;
  proxy.$modal
    .confirm("确认要删除编号为" + supplierIds + "的供应商?")
    .then(function () {
      return delSupplier(supplierIds);
    })
    .then(() => {
      getList();
      proxy.$modal.msgSuccess("删除成功");
    })
    .catch(() => {});
}
/** 导出按钮操作 */
function handleExport() {
  proxy.download(
    "baseDate/supplier/export",
    {
      ...queryParams.value,
    },
    `供应商资料_${new Date().getTime()}.xlsx`
  );
}
/** 多选框选中数据 */
function handleSelectionChange(selection) {
  ids.value = selection.map((item) => item.supplierId);
  single.value = selection.length != 1;
  multiple.value = !selection.length;
}
getList();
</script>
