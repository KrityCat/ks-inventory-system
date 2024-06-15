<template>
  <!-- 仓库资料 -->
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
          <el-form-item label="仓库编号" prop="warehouseId">
            <el-input
              v-model="queryParams.warehouseId"
              placeholder="请输入仓库编号"
              style="width: 250px"
              clearable
              @keyup.enter="handleQuery"
            />
          </el-form-item>
          <el-form-item label="仓库名称" prop="warehouseName">
            <el-input
              v-model="queryParams.warehouseName"
              placeholder="请输入仓库名称"
              clearable
              style="width: 250px"
            />
          </el-form-item>
          <el-form-item label="负责人" prop="warehouseDirector">
            <el-input
              v-model="queryParams.warehouseDirector"
              placeholder="请输入负责人"
              style="width: 250px"
            />
          </el-form-item>
          <el-form-item label="联系电话" prop="warehouseTelephone">
            <el-input
              v-model="queryParams.warehouseTelephone"
              placeholder="请输入联系电话"
              style="width: 250px"
            />
          </el-form-item>
          <el-form-item label="仓库地址" prop="warehouseAddress">
            <el-input
              v-model="queryParams.warehouseAddress"
              placeholder="请输入仓库地址"
              style="width: 250px"
            />
          </el-form-item>
          <el-form-item label="仓库状态" prop="warehouseValid">
            <el-select
              v-model="queryParams.warehouseValid"
              placeholder="请选择"
              clearable
              style="width: 250px"
            >
              <el-option
                v-for="dict in sys_normal_disable"
                :key="dict.value"
                :label="dict.label"
                :value="dict.value"
              />
            </el-select>
          </el-form-item>
          <el-form-item label="备注" prop="warehouseNotes">
            <el-input
              v-model="queryParams.warehouseNotes"
              placeholder="请输入备注"
              style="width: 250px"
            />
          </el-form-item>
          <el-form-item>
            <el-button
              type="primary"
              icon="Search"
              @click="handleQuery"
              v-hasPermi="['baseDate:warehouse:list']"
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
              v-hasPermi="['baseDate:warehouse:add']"
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
              v-hasPermi="['baseDate:warehouse:update']"
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
              v-hasPermi="['baseDate:warehouse:remove']"
              >删除</el-button
            >
          </el-col>
          <el-col :span="1.5">
            <el-button
              type="info"
              plain
              icon="Upload"
              @click="handleImport"
              v-hasPermi="['baseDate:warehouse:import']"
              >导入</el-button
            >
          </el-col>
          <el-col :span="1.5">
            <el-button
              type="warning"
              plain
              icon="Download"
              @click="handleExport"
              v-hasPermi="['baseDate:warehouse:export']"
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
          :data="warehouseList"
          @selection-change="handleSelectionChange"
          :row-key="(row) => row.warehouseId"
        >
          <el-table-column type="selection" width="50" align="center" />
          <el-table-column
            label="仓库编号"
            align="center"
            prop="warehouseId"
            v-if="columns[0].visible"
          />
          <el-table-column
            label="仓库名称"
            align="center"
            prop="warehouseName"
            v-if="columns[1].visible"
            :show-overflow-tooltip="true"
          />
          <el-table-column
            label="负责人"
            align="center"
            prop="warehouseDirector"
            v-if="columns[2].visible"
          />
          <el-table-column
            label="联系电话"
            align="center"
            prop="warehouseTelephone"
            v-if="columns[3].visible"
          />
          <el-table-column
            label="仓库地址"
            align="center"
            prop="warehouseAddress"
            :show-overflow-tooltip="true"
          />
          <el-table-column
            label="仓库状态"
            align="center"
            prop="warehouseValid"
            v-if="columns[4].visible"
          >
            <template #default="scope">
              <dict-tag
                :options="sys_normal_disable"
                :value="scope.row.warehouseValid"
              />
            </template>
          </el-table-column>
          <el-table-column
            label="备注"
            align="center"
            prop="warehouseNotes"
            v-if="columns[5].visible"
            :show-overflow-tooltip="true"
          />
          <el-table-column
            label="创建者"
            align="center"
            prop="createBy"
            v-if="columns[6].visible"
          />
          <el-table-column
            label="创建时间"
            align="center"
            prop="createTime"
            v-if="columns[7].visible"
            :show-overflow-tooltip="true"
          >
            <template #default="scope">
              <span>{{ parseTime(scope.row.createTime) }}</span>
            </template>
          </el-table-column>
          <el-table-column
            label="更新者"
            align="center"
            prop="updateBy"
            v-if="columns[8].visible"
          />
          <el-table-column
            label="更新时间"
            align="center"
            prop="updateTime"
            v-if="columns[9].visible"
            :show-overflow-tooltip="true"
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
                v-if="scope.row.warehouseId !== 0"
              >
                <el-button
                  link
                  type="primary"
                  icon="Edit"
                  @click="handleUpdate(scope.row)"
                  v-hasPermi="['baseDate:warehouse:update']"
                ></el-button>
              </el-tooltip>
              <el-tooltip
                content="删除"
                placement="top"
                v-if="scope.row.warehouseId !== 0"
              >
                <el-button
                  link
                  type="primary"
                  icon="Delete"
                  @click="handleDelete(scope.row)"
                  v-hasPermi="['baseDate:warehouse:remove']"
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

    <!-- 添加或修改仓库配置对话框 -->
    <el-dialog :title="title" v-model="open" width="600px" append-to-body>
      <el-form
        :model="form"
        :rules="rules"
        ref="warehouseRef"
        label-width="80px"
      >
        <el-row>
          <el-col :span="12">
            <el-form-item label="仓库名称" prop="warehouseName">
              <el-input
                v-model="form.warehouseName"
                placeholder="请输入仓库名称"
                maxlength="30"
              />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="负责人" prop="warehouseDirector">
              <el-input
                v-model="form.warehouseDirector"
                placeholder="请输入负责人"
                maxlength="11"
              />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="联系电话" prop="warehouseTelephone">
              <el-input
                v-model="form.warehouseTelephone"
                placeholder="请输入联系电话"
                maxlength="12"
              />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="状态" prop="warehouseValid">
              <el-select
                v-model="form.warehouseValid"
                placeholder="请选择"
                clearable
              >
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
            <el-form-item label="地址" prop="warehouseAddress">
              <el-input
                v-model="form.warehouseAddress"
                placeholder="请输入地址"
              />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="24">
            <el-form-item label="备注">
              <el-input
                v-model="form.warehouseNotes"
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

    <!-- 用户导入对话框 -->
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
              />是否更新已经存在的仓库数据
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

<script setup name="Warehouse">
import { getToken } from "@/utils/auth";
import {
  listWarehouse,
  getWarehouse,
  addWarehouse,
  updateWarehouse,
  delWarehouse,
} from "@/api/basedate/warehouse";

const { proxy } = getCurrentInstance();
const { sys_normal_disable } = proxy.useDict("sys_normal_disable");

// 查询结果表
const warehouseList = ref([]);
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
/*** 仓库导入参数 */
const upload = reactive({
  // 是否显示弹出层（仓库导入）
  open: false,
  // 弹出层标题（仓库导入）
  title: "",
  // 是否禁用上传
  isUploading: false,
  // 是否更新已经存在的仓库数据
  updateSupport: 0,
  // 设置上传的请求头部
  headers: { Authorization: "Bearer " + getToken() },
  // 上传的地址
  url: import.meta.env.VITE_APP_BASE_API + "/baseDate/warehouse/importData",
});

// 列显隐信息
const columns = ref([
  { key: 0, label: `仓库编号`, visible: true },
  { key: 1, label: `仓库名称`, visible: true },
  { key: 2, label: `负责人`, visible: true },
  { key: 3, label: `联系电话`, visible: true },
  { key: 4, label: `仓库地址`, visible: true },
  { key: 5, label: `仓库状态`, visible: true },
  { key: 6, label: `备注`, visible: true },
  { key: 7, label: `创建者`, visible: true },
  { key: 8, label: `创建时间`, visible: true },
  { key: 9, label: `更新者`, visible: true },
  { key: 10, label: `更新时间`, visible: true },
]);

const data = reactive({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    warehouseId: undefined,
    warehouseName: undefined,
    warehouseDirector: undefined,
    warehouseTelephone: undefined,
    warehouseAddress: undefined,
    warehouseValid: undefined,
    warehouseNotes: undefined,
  },
  rules: {
    warehouseName: [
      { required: true, message: "仓库名称不能为空", trigger: "blur" },
      { max: 20, message: "仓库名称长度不能大于 20 ", trigger: "blur" },
    ],
    warehouseDirector: [
      { required: true, message: "负责人不能为空", trigger: "blur" },
      { max: 10, message: "负责人长度不能大于 10 ", trigger: "blur" },
    ],
    warehouseTelephone: [
      { required: true, message: "联系电话不能为空", trigger: "blur" },
      {
        pattern: /^1[3|4|5|6|7|8|9][0-9]\d{8}$/,
        message: "请输入正确的手机号码",
        trigger: "blur",
      },
    ],
    warehouseValid: [
      { required: true, message: "状态不能为空", trigger: "blur" },
    ],
  },
});

const { queryParams, form, rules } = toRefs(data);

/** 查询仓库列表 */
function getList() {
  loading.value = true;
  listWarehouse(proxy.addDateRange(queryParams.value, dateRange.value)).then(
    (response) => {
      warehouseList.value = response.rows;
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
  upload.title = "仓库导入";
  upload.open = true;
}
/** 下载模板操作 */
function importTemplate() {
  proxy.download(
    "/baseDate/warehouse/importTemplate",
    {},
    `仓库资料导入模板_${new Date().getTime()}.xlsx`
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
    warehouseName: undefined,
    warehouseDirector: undefined,
    warehouseTelephone: undefined,
    warehouseAddress: undefined,
    warehouseValid: undefined,
    warehouseNotes: undefined,
  };
  proxy.resetForm("warehouseRef");
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
  title.value = "新增仓库";
}
/** 修改按钮操作 */
function handleUpdate(row) {
  reset();
  const warehouseId = row.warehouseId || ids.value;
  getWarehouse(warehouseId).then((response) => {
    form.value = response.data;
    open.value = true;
    title.value = "修改仓库";
  });
}
/** 提交按钮 */
function submitForm() {
  proxy.$refs["warehouseRef"].validate((valid) => {
    if (valid) {
      if (form.value.warehouseId != undefined) {
        updateWarehouse(form.value).then((response) => {
          proxy.$modal.msgSuccess("修改成功");
          open.value = false;
          getList();
        });
      } else {
        addWarehouse(form.value).then((response) => {
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
  const warehouseIds = row.warehouseId || ids.value;
  proxy.$modal
    .confirm('确认要删除编号为"' + warehouseIds + '"的仓库?')
    .then(function () {
      return delWarehouse(warehouseIds);
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
    "baseDate/warehouse/export",
    {
      ...queryParams.value,
    },
    `仓库资料_${new Date().getTime()}.xlsx`
  );
}
/** 多选框选中数据 */
function handleSelectionChange(selection) {
  ids.value = selection.map((item) => item.warehouseId);
  single.value = selection.length != 1;
  multiple.value = !selection.length;
}
getList();
</script>