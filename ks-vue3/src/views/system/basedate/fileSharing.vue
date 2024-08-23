<template>
  <!-- 文件共享 -->
  <div class="app-container">
    <el-row :gutter="20">
      <el-col :span="24" :xs="24">
        <el-form
          :inline="true"
          ref="queryRef"
          :model="queryParams"
          label-width="120px"
        >
          <el-form-item label="文件名称" prop="fileName">
            <el-input
              v-model="queryParams.fileName"
              placeholder="请输入文件名称"
              style="width: 250px"
              clearable
              @keyup.enter="handleQuery"
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
            <el-upload
              class="upload-demo"
              ref="upload"
              action="#"
              :data="paramsObj"
              :http-request="
                (file) => {
                  return uploadFile(file);
                }
              "
              :show-file-list="false"
              :before-upload="beforeUpload"
            >
              <el-button plain type="success" icon="Upload">上传文件</el-button>
            </el-upload>
          </el-col>
        </el-row>

        <!-- 表格数据 -->
        <el-table border v-loading="loading" :data="fileSharingList">
          <el-table-column
            label="序号"
            align="center"
            type="index"
            width="60"
          />
          <el-table-column label="文件名称" align="center" prop="fileName" />
          <el-table-column label="文件下载" align="center" prop="fileName">
            <template #default="scope">
              <el-link type="primary">
                <a
                  target="_blank"
                  :href="FileUrl + scope.row.fileUrl"
                  download
                  >{{ scope.row.fileName }}</a
                >
              </el-link>
            </template>
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
              <el-tooltip content="修改文件名称" placement="top">
                <el-button
                  link
                  type="primary"
                  icon="Edit"
                  @click="handleUpdate(scope.row)"
                  v-hasPermi="['baseDate:fileSharing:update']"
                ></el-button>
              </el-tooltip>
              <el-tooltip content="删除" placement="top">
                <el-button
                  link
                  type="primary"
                  icon="Delete"
                  @click="handleDelete(scope.row)"
                  v-hasPermi="['baseDate:fileSharing:remove']"
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

    <!-- 添加或修改文件配置对话框 -->
    <el-dialog :title="title" v-model="open" width="600px" append-to-body>
      <el-form
        :model="form"
        :rules="rules"
        ref="fileSharingRef"
        label-width="80px"
      >
        <el-row>
          <el-col :span="24">
            <el-form-item label="文件名称" prop="fileName">
              <el-input
                v-model="form.fileName"
                placeholder="请输入文件名称"
                maxlength="30"
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
  </div>
</template>

<script setup name="fileSharing">
import {
  listFile,
  getFile,
  addFileName,
  updateFileName,
  fileUpload,
  delFile,
} from "@/api/basedate/fileSharing";
import { ref } from "vue";

const { proxy } = getCurrentInstance();

// 查询结果表
const fileSharingList = ref([]);
const FileUrl = import.meta.env.VITE_APP_BASE_API;
// 窗口开关
const open = ref(false);
// 加载
const loading = ref(true);
const ids = ref([]);
// 总条数
const total = ref(0);
// 窗口标题
const title = ref("");
// 数据范围
const dateRange = ref([]);

const data = reactive({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 50,
    fileName: undefined,
  },
  rules: {
    fileName: [
      { required: true, message: "文件名称不能为空", trigger: "blur" },
    ],
  },
});

const { queryParams, form, rules } = toRefs(data);

/** 查询文件列表 */
function getList() {
  loading.value = true;
  listFile(proxy.addDateRange(queryParams.value)).then((response) => {
    fileSharingList.value = response.rows;
    total.value = response.total;
    loading.value = false;
  });
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
/** 重置操作表单 */
function reset() {
  form.value = {
    fileName: undefined,
    fileUrl: undefined,
  };
  proxy.resetForm("fileSharingRef");
}
/** 取消按钮 */
function cancel() {
  open.value = false;
  reset();
}
/** 修改按钮操作 */
function handleUpdate(row) {
  reset();
  const fileId = row.fileId || ids.value;
  getFile(fileId).then((response) => {
    form.value = response.data;
    open.value = true;
    title.value = "修改文件名称";
  });
}

/** 提交按钮 */
function submitForm() {
  proxy.$refs["fileSharingRef"].validate((valid) => {
    if (valid) {
      updateFileName(form.value).then((response) => {
        proxy.$modal.msgSuccess("修改成功");
        open.value = false;
        getList();
      });
    }
  });
}
/** 上传按钮 */
async function uploadFile(file) {
  const formData = new FormData();
  formData.append("file", file.file);
  await fileUpload(formData);
  await addFileName(form.value);
  proxy.$modal.msgSuccess("上传成功");
  getList();
}
/** 删除按钮操作 */
function handleDelete(row) {
  const fileIds = row.fileId || ids.value;
  const fileNames = row.fileName || ids.value;
  proxy.$modal
    .confirm('确认要删除名称为"' + fileNames + '"的文件?')
    .then(function () {
      return delFile(fileIds);
    })
    .then(() => {
      getList();
      proxy.$modal.msgSuccess("删除成功");
    })
    .catch(() => {});
}
getList();
</script>
