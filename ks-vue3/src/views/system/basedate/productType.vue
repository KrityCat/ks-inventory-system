<template>
  <div class="app-container">
    <el-form
      :model="queryParams"
      ref="queryRef"
      :inline="true"
      v-show="showSearch"
    >
      <el-form-item label="货品名称" prop="productTypeName">
        <el-input
          v-model="queryParams.productTypeName"
          placeholder="请输入货品名称"
          clearable
          style="width: 200px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select
          v-model="queryParams.status"
          placeholder="货品类型状态"
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
          v-hasPermi="['baseDate:productType:list']"
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
          v-hasPermi="['baseDate:productType:add']"
          >新增</el-button
        >
      </el-col>
      <el-col :span="1.5">
        <el-button type="info" plain icon="Sort" @click="toggleExpandAll"
          >展开/折叠</el-button
        >
      </el-col>
      <right-toolbar
        v-model:showSearch="showSearch"
        @queryTable="getList"
      ></right-toolbar>
    </el-row>

    <el-table
      v-if="refreshTable"
      v-loading="loading"
      :data="typeList"
      row-key="productTypeId"
      :default-expand-all="isExpandAll"
      :tree-props="{ children: 'children', hasChildren: 'hasChildren' }"
    >
      <el-table-column
        prop="productTypeName"
        label="货品名称"
        width="260"
      ></el-table-column>
      <el-table-column
        prop="orderNum"
        label="排序"
        width="200"
      ></el-table-column>
      <el-table-column prop="status" label="状态" width="100">
        <template #default="scope">
          <dict-tag :options="sys_normal_disable" :value="scope.row.status" />
        </template>
      </el-table-column>
      <el-table-column
        label="创建时间"
        align="center"
        prop="createTime"
        width="200"
      >
        <template #default="scope">
          <span>{{ parseTime(scope.row.createTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column
        label="操作"
        align="center"
        class-name="small-padding fixed-width"
      >
        <template #default="scope">
          <el-button
            link
            type="primary"
            icon="Edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['baseDate:productType:edit']"
            >修改</el-button
          >
          <el-button
            link
            type="primary"
            icon="Plus"
            @click="handleAdd(scope.row)"
            v-hasPermi="['baseDate:productType:add']"
            >新增</el-button
          >
          <el-button
            v-if="scope.row.parentId != 0"
            link
            type="primary"
            icon="Delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['baseDate:productType:remove']"
            >删除</el-button
          >
        </template>
      </el-table-column>
    </el-table>

    <!-- 添加或修改货品类型对话框 -->
    <el-dialog :title="title" v-model="open" width="600px" append-to-body>
      <el-form ref="typeRef" :model="form" :rules="rules" label-width="80px">
        <el-row>
          <el-col :span="24" v-if="form.parentId !== 0">
            <el-form-item label="上级类型" prop="parentId">
              <el-tree-select
                v-model="form.parentId"
                :data="TypeOptions"
                :props="{
                  value: 'productTypeId',
                  label: 'productTypeName',
                  children: 'children',
                }"
                value-key="productTypeId"
                placeholder="选择上级货品类型"
                check-strictly
              />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="类型名称" prop="productTypeName">
              <el-input
                v-model="form.productTypeName"
                placeholder="请输入货品类型"
              />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="显示排序" prop="orderNum">
              <el-input-number
                v-model="form.orderNum"
                controls-position="right"
                :min="0"
              />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="类型状态">
              <el-radio-group v-model="form.status">
                <el-radio
                  v-for="dict in sys_normal_disable"
                  :key="dict.value"
                  :label="dict.value"
                  >{{ dict.label }}</el-radio
                >
              </el-radio-group>
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

<script setup name="productType">
import {
  listProductType,
  getProductType,
  listProductTypeExcludeChild,
  addProductType,
  updateProductType,
  delProductType,
} from "@/api/basedate/productType";

const { proxy } = getCurrentInstance();
const { sys_normal_disable } = proxy.useDict("sys_normal_disable");

const typeList = ref([]);
const open = ref(false);
const loading = ref(true);
const showSearch = ref(true);
const title = ref("");
const TypeOptions = ref([]);
const isExpandAll = ref(true);
const refreshTable = ref(true);

const data = reactive({
  form: {},
  queryParams: {
    productTypeName: undefined,
    status: undefined,
  },
  rules: {
    parentId: [
      { required: true, message: "上级货品类型不能为空", trigger: "blur" },
    ],
    productTypeName: [
      { required: true, message: "货品类型名称不能为空", trigger: "blur" },
    ],
    orderNum: [
      { required: true, message: "显示排序不能为空", trigger: "blur" },
    ],
  },
});

const { queryParams, form, rules } = toRefs(data);

/** 查询货品类型列表 */
function getList() {
  loading.value = true;
  listProductType(queryParams.value).then((response) => {
    typeList.value = proxy.handleTree(response.data, "productTypeId");
    loading.value = false;
  });
}
/** 取消按钮 */
function cancel() {
  open.value = false;
  reset();
}
/** 表单重置 */
function reset() {
  form.value = {
    productTypeId: undefined,
    parentId: undefined,
    productTypeName: undefined,
    orderNum: 0,
    leader: undefined,
    phone: undefined,
    email: undefined,
    status: "0",
  };
  proxy.resetForm("typeRef");
}
/** 搜索按钮操作 */
function handleQuery() {
  getList();
}
/** 重置按钮操作 */
function resetQuery() {
  proxy.resetForm("queryRef");
  handleQuery();
}
/** 新增按钮操作 */
function handleAdd(row) {
  reset();
  listProductType().then((response) => {
    TypeOptions.value = proxy.handleTree(response.data, "productTypeId");
  });
  if (row != undefined) {
    form.value.parentId = row.productTypeId;
  }
  open.value = true;
  title.value = "添加货品类型";
}
/** 展开/折叠操作 */
function toggleExpandAll() {
  refreshTable.value = false;
  isExpandAll.value = !isExpandAll.value;
  nextTick(() => {
    refreshTable.value = true;
  });
}
/** 修改按钮操作 */
function handleUpdate(row) {
  reset();
  listProductTypeExcludeChild(row.productTypeId).then((response) => {
    TypeOptions.value = proxy.handleTree(response.data, "productTypeId");
  });
  getProductType(row.productTypeId).then((response) => {
    form.value = response.data;
    open.value = true;
    title.value = "修改货品类型";
  });
}
/** 提交按钮 */
function submitForm() {
  proxy.$refs["typeRef"].validate((valid) => {
    if (valid) {
      if (form.value.productTypeId != undefined) {
        updateProductType(form.value).then((response) => {
          proxy.$modal.msgSuccess("修改成功");
          open.value = false;
          getList();
        });
      } else {
        addProductType(form.value).then((response) => {
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
  proxy.$modal
    .confirm('是否确认删除名称为"' + row.productTypeName + '"的数据项?')
    .then(function () {
      return delProductType(row.productTypeId);
    })
    .then(() => {
      getList();
      proxy.$modal.msgSuccess("删除成功");
    })
    .catch(() => {});
}

getList();
</script>
