<template>
  <!-- 打印文件查询 -->
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
          <el-form-item label="主键" prop="id">
            <el-input
              v-model="queryParams.id"
              style="width: 250px"
              clearable
              @keyup.enter="handleQuery"
            />
          </el-form-item>
          <el-form-item label="编码" prop="code">
            <el-input
              v-model="queryParams.code"
              clearable
              style="width: 250px"
            />
          </el-form-item>
          <el-form-item label="名称" prop="name">
            <el-input v-model="queryParams.name" style="width: 250px" />
          </el-form-item>
          <el-form-item>
            <el-button
              type="primary"
              icon="Search"
              @click="handleQuery"
              v-hasPermi="['baseDate:customer:list']"
              >查询</el-button
            >
            <el-button icon="Refresh" @click="resetQuery">重置</el-button>
          </el-form-item>
        </el-form>
        <el-row :gutter="10" class="mb8">
          <right-toolbar
            v-model:showSearch="showSearch"
            @queryTable="getList"
            :columns="columns"
          ></right-toolbar>
        </el-row>

        <!-- 表格数据 -->
        <el-table border v-loading="loading" :data="jmReportList">
          <el-table-column
            label="主键"
            align="center"
            prop="id"
            width="200"
            v-if="columns[0].visible"
          />
          <el-table-column
            label="编码"
            align="center"
            prop="code"
            width="200"
            v-if="columns[1].visible"
          />
          <el-table-column
            label="名称"
            align="center"
            prop="name"
            width="200"
            v-if="columns[2].visible"
          />
          <el-table-column
            label="说明"
            align="center"
            prop="note"
            v-if="columns[3].visible"
          />
          <el-table-column
            label="状态"
            align="center"
            prop="status"
            v-if="columns[4].visible"
          />
          <el-table-column
            label="类型"
            align="center"
            prop="type"
            v-if="columns[5].visible"
          />
          <el-table-column
            label="请求地址"
            align="center"
            prop="apiUrl"
            v-if="columns[6].visible"
          />
          <el-table-column
            label="删除标识"
            align="center"
            prop="delFlag"
            v-if="columns[7].visible"
          />
          <el-table-column
            label="是否模板"
            align="center"
            prop="template"
            v-if="columns[8].visible"
          />
          <el-table-column
            label="浏览次数"
            align="center"
            prop="viewCount"
            v-if="columns[9].visible"
          />
          <el-table-column
            label="创建者"
            align="center"
            prop="createBy"
            v-if="columns[10].visible"
          />
          <el-table-column
            label="创建时间"
            align="center"
            prop="createTime"
            width="170"
            v-if="columns[11].visible"
          >
            <template #default="scope">
              <span>{{ parseTime(scope.row.createTime) }}</span>
            </template>
          </el-table-column>
          <el-table-column
            label="更新者"
            align="center"
            prop="updateBy"
            v-if="columns[12].visible"
          />
          <el-table-column
            label="更新时间"
            align="center"
            prop="updateTime"
            width="170"
            v-if="columns[13].visible"
          >
            <template #default="scope">
              <span>{{ parseTime(scope.row.updateTime) }}</span>
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
  </div>
</template>

<script setup name="jmReportQuery">
import { listJiMuReport } from "@/api/jimu/jiMuReport";

const { proxy } = getCurrentInstance();

// 查询结果表
const jmReportList = ref([]);
// 加载
const loading = ref(true);
// 隐藏查询
const showSearch = ref(true);
// 总条数
const total = ref(0);
// 数据范围
const dateRange = ref([]);
// 列显隐信息
const columns = ref([
  { key: 0, label: `主键`, visible: true },
  { key: 1, label: `编码`, visible: true },
  { key: 2, label: `名称`, visible: true },
  { key: 3, label: `说明`, visible: true },
  { key: 4, label: `状态`, visible: true },
  { key: 5, label: `类型`, visible: true },
  { key: 6, label: `请求地址`, visible: true },
  { key: 7, label: `删除标识`, visible: true },
  { key: 8, label: `是否模板`, visible: true },
  { key: 9, label: `浏览次数`, visible: true },
  { key: 10, label: `创建者`, visible: true },
  { key: 11, label: `创建时间`, visible: true },
  { key: 12, label: `更新者`, visible: true },
  { key: 13, label: `更新时间`, visible: true },
]);

const data = reactive({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 50,
    id: undefined,
    code: undefined,
    name: undefined,
  },
  rules: {},
});

const { queryParams, form, rules } = toRefs(data);

/** 查询客户列表 */
function getList() {
  loading.value = true;
  listJiMuReport(proxy.addDateRange(queryParams.value, dateRange.value)).then(
    (response) => {
      jmReportList.value = response.rows;
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
getList();
</script>
