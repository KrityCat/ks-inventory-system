<template>
  <div class="app-container">
    <el-row :gutter="20">
      <!--货品类型-->
      <el-col :span="4" :xs="24">
        <div class="head-container">
          <el-input
            v-model="productTypeName"
            placeholder="请输入货品类型名称"
            clearable
            prefix-icon="Search"
            style="margin-bottom: 20px"
          />
        </div>
        <div class="head-container">
          <el-tree
            :data="typeOptions"
            :props="{ label: 'label', children: 'children' }"
            :expand-on-click-node="false"
            :filter-node-method="filterNode"
            ref="typeTreeRef"
            node-key="id"
            highlight-current
            default-expand-all
            @node-click="handleNodeClick"
          />
        </div>
      </el-col>
      <!--查询条件-->
      <el-col :span="20" :xs="24">
        <el-form
          :model="queryParams"
          ref="queryRef"
          :inline="true"
          v-show="showSearch"
          label-width="90px"
        >
          <el-form-item label="货品编号" prop="productCode">
            <el-input
              v-model="queryParams.productCode"
              placeholder="请输入货品编号"
              clearable
              style="width: 180px"
              @keyup.enter="handleQuery"
            />
          </el-form-item>
          <el-form-item label="货品名称" prop="productName">
            <el-input
              v-model="queryParams.productName"
              placeholder="请输入货品名称"
              clearable
              style="width: 180px"
              @keyup.enter="handleQuery"
            />
          </el-form-item>
          <el-form-item label="商品规格" prop="productSpecifications">
            <el-input
              v-model="queryParams.productSpecifications"
              placeholder="请输入商品规格"
              clearable
              style="width: 180px"
              @keyup.enter="handleQuery"
            />
          </el-form-item>
          <el-form-item label="计量单位" prop="measureUnit">
            <el-input
              v-model="queryParams.measureUnit"
              placeholder="请输入计量单位"
              clearable
              style="width: 180px"
              @keyup.enter="handleQuery"
            />
          </el-form-item>
          <el-form-item label="货品条码" prop="productBarcode">
            <el-input
              v-model="queryParams.productBarcode"
              placeholder="请输入货品条码"
              clearable
              style="width: 180px"
              @keyup.enter="handleQuery"
            />
          </el-form-item>
          <el-form-item label="默认仓库" prop="defaultWarehouse">
            <el-input
              v-model="queryParams.defaultWarehouse"
              placeholder="请输入默认仓库"
              clearable
              style="width: 180px"
              @keyup.enter="handleQuery"
            />
          </el-form-item>
          <el-form-item label="状态" prop="status">
            <el-select
              v-model="queryParams.status"
              placeholder="状态"
              clearable
              style="width: 180px"
            >
              <el-option
                v-for="dict in sys_normal_disable"
                :key="dict.value"
                :label="dict.label"
                :value="dict.value"
              />
            </el-select>
          </el-form-item>
          <el-form-item label="创建时间" style="width: 308px">
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
            <el-button type="primary" icon="Search" @click="handleQuery"
              >搜索</el-button
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
              v-hasPermi="['baseDate:product:add']"
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
              v-hasPermi="['baseDate:product:edit']"
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
              v-hasPermi="['baseDate:product:remove']"
              >删除</el-button
            >
          </el-col>
          <el-col :span="1.5">
            <el-button
              type="info"
              plain
              icon="Upload"
              @click="handleImport"
              v-hasPermi="['baseDate:product:import']"
              >导入</el-button
            >
          </el-col>
          <el-col :span="1.5">
            <el-button
              type="warning"
              plain
              icon="Download"
              @click="handleExport"
              v-hasPermi="['baseDate:product:export']"
              >导出</el-button
            >
          </el-col>
          <right-toolbar
            v-model:showSearch="showSearch"
            @queryTable="getList"
            :columns="columns"
          ></right-toolbar>
        </el-row>

        <el-table
          border
          v-loading="loading"
          :data="productList"
          @selection-change="handleSelectionChange"
        >
          <el-table-column type="selection" width="50" align="center" />
          <el-table-column
            label="货品编号"
            align="center"
            key="productCode"
            prop="productCode"
            v-if="columns[0].visible"
          />
          <el-table-column
            label="货品名称"
            align="center"
            key="productName"
            prop="productName"
            v-if="columns[1].visible"
          />
          <el-table-column
            label="货品类型"
            align="center"
            key="productTypeName"
            prop="type.productTypeName"
            v-if="columns[2].visible"
          />
          <el-table-column
            label="商品规格"
            align="center"
            key="productSpecifications"
            prop="productSpecifications"
            v-if="columns[3].visible"
          />
          <el-table-column
            label="计量单位"
            align="center"
            key="measureUnit"
            prop="measureUnit"
            v-if="columns[4].visible"
          />
          <el-table-column
            label="产地"
            align="center"
            key="producer"
            prop="producer"
            v-if="columns[5].visible"
          />
          <el-table-column
            label="成本价"
            align="center"
            key="costPrice"
            prop="costPrice"
            v-if="columns[6].visible"
          />
          <el-table-column
            label="参考售价"
            align="center"
            key="price"
            prop="price"
            v-if="columns[7].visible"
          />
          <el-table-column
            label="货品条码"
            align="center"
            key="productBarcode"
            prop="productBarcode"
            v-if="columns[8].visible"
          />
          <el-table-column
            label="库存上限"
            align="center"
            key="upperLimit"
            prop="upperLimit"
            v-if="columns[9].visible"
          />
          <el-table-column
            label="库存下限"
            align="center"
            key="lowerLimit"
            prop="lowerLimit"
            v-if="columns[10].visible"
          />
          <el-table-column
            label="默认仓库"
            align="center"
            key="defaultWarehouse"
            prop="defaultWarehouse"
            v-if="columns[11].visible"
          />
          <el-table-column
            label="状态"
            align="center"
            key="status"
            v-if="columns[12].visible"
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
            key="notes"
            prop="notes"
            v-if="columns[13].visible"
          />
          <el-table-column
            label="创建者"
            align="center"
            prop="createBy"
            v-if="columns[14].visible"
          />
          <el-table-column
            label="创建时间"
            align="center"
            prop="createTime"
            v-if="columns[15].visible"
          >
            <template #default="scope">
              <span>{{ parseTime(scope.row.createTime) }}</span>
            </template>
          </el-table-column>
          <el-table-column
            label="更新者"
            align="center"
            prop="updateBy"
            v-if="columns[16].visible"
          />
          <el-table-column
            label="更新时间"
            align="center"
            prop="updateTime"
            :show-overflow-tooltip="true"
            v-if="columns[17].visible"
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
              <el-tooltip content="修改" placement="top">
                <el-button
                  link
                  type="primary"
                  icon="Edit"
                  @click="handleUpdate(scope.row)"
                  v-hasPermi="['baseDate:product:edit']"
                ></el-button>
              </el-tooltip>
              <el-tooltip content="删除" placement="top">
                <el-button
                  link
                  type="primary"
                  icon="Delete"
                  @click="handleDelete(scope.row)"
                  v-hasPermi="['baseDate:product:remove']"
                ></el-button>
              </el-tooltip>
            </template>
          </el-table-column>
        </el-table>
        <pagination
          v-show="total > 0"
          :total="total"
          v-model:page="queryParams.pageNum"
          v-model:limit="queryParams.pageSize"
          @pagination="getList"
        />
      </el-col>
    </el-row>

    <!-- 添加或修改货品资料配置对话框 -->
    <el-dialog :title="title" v-model="open" width="600px" append-to-body>
      <el-form :model="form" :rules="rules" ref="productRef" label-width="80px">
        <el-row>
          <el-col :span="12">
            <el-form-item label="货品编号" prop="productCode">
              <el-input
                v-model="form.productCode"
                placeholder="请输入货品编号"
                maxlength="30"
              />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="货品名称" prop="productName">
              <el-input
                v-model="form.productName"
                placeholder="请输入货品名称"
                maxlength="30"
              />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="货品类型" prop="productType">
              <el-tree-select
                v-model="form.productType"
                :data="typeOptions"
                :props="{ value: 'id', label: 'label', children: 'children' }"
                value-key="id"
                placeholder="请选择货品类型"
                check-strictly
              />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="货品规格" prop="productSpecifications">
              <el-input
                v-model="form.productSpecifications"
                placeholder="请输入货品规格"
                maxlength="30"
              />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="计量单位" prop="measureUnit">
              <el-input
                v-model="form.measureUnit"
                placeholder="请输入计量单位"
                maxlength="30"
              />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="货品条码" prop="productBarcode">
              <el-input
                v-model="form.productBarcode"
                placeholder="请输入货品条码"
                maxlength="30"
              />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="24">
            <el-form-item label="产地" prop="producer">
              <el-input
                v-model="form.producer"
                placeholder="请输入产地"
                maxlength="30"
              />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="成本价" prop="costPrice">
              <el-input
                v-model="form.costPrice"
                placeholder="请输入成本价"
                maxlength="30"
              />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="参考售价" prop="price">
              <el-input
                v-model="form.price"
                placeholder="请输入参考售价"
                maxlength="30"
              />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="库存上限" prop="upperLimit">
              <el-input
                v-model="form.upperLimit"
                placeholder="请输入库存上限"
                maxlength="30"
              />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="库存下限" prop="lowerLimit">
              <el-input
                v-model="form.lowerLimit"
                placeholder="请输入库存下限"
                maxlength="30"
              />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="默认仓库" prop="defaultWarehouse">
              <el-input
                v-model="form.defaultWarehouse"
                placeholder="请输入默认仓库"
                maxlength="30"
              />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="状态">
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
        <el-row>
          <el-col :span="24">
            <el-form-item label="备注">
              <el-input
                v-model="form.notes"
                type="textarea"
                placeholder="请输入内容"
              ></el-input>
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

    <!-- 货品导入对话框 -->
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
              />是否更新已经存在的货品数据
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

<script setup name="Product">
import { getToken } from "@/utils/auth";
import {
  delProduct,
  updateProduct,
  addProduct,
  listProduct,
  getProduct,
  productTypeTreeSelect,
} from "@/api/basedate/product";

const { proxy } = getCurrentInstance();
const { sys_normal_disable } = proxy.useDict("sys_normal_disable");

const productList = ref([]);
const open = ref(false);
const loading = ref(true);
const showSearch = ref(true);
const ids = ref([]);
const single = ref(true);
const multiple = ref(true);
const total = ref(0);
const title = ref("");
const dateRange = ref([]);
const productTypeName = ref("");
const typeOptions = ref(undefined);
/*** 货品导入参数 */
const upload = reactive({
  // 是否显示弹出层（货品导入）
  open: false,
  // 弹出层标题（货品导入）
  title: "",
  // 是否禁用上传
  isUploading: false,
  // 是否更新已经存在的货品数据
  updateSupport: 0,
  // 设置上传的请求头部
  headers: { Authorization: "Bearer " + getToken() },
  // 上传的地址
  url: import.meta.env.VITE_APP_BASE_API + "/baseDate/product/importData",
});
// 列显隐信息
const columns = ref([
  { key: 0, label: `货品编号`, visible: true },
  { key: 1, label: `货品名称`, visible: true },
  { key: 2, label: `货品类型`, visible: true },
  { key: 3, label: `商品规格`, visible: true },
  { key: 4, label: `计量单位`, visible: true },
  { key: 5, label: `产地`, visible: true },
  { key: 6, label: `成本价`, visible: true },
  { key: 7, label: `参考售价`, visible: true },
  { key: 8, label: `货品条码`, visible: true },
  { key: 9, label: `库存上限`, visible: true },
  { key: 10, label: `库存下限`, visible: true },
  { key: 11, label: `默认仓库`, visible: true },
  { key: 12, label: `状态`, visible: true },
  { key: 13, label: `备注`, visible: true },
  { key: 14, label: `创建者`, visible: true },
  { key: 15, label: `创建时间`, visible: true },
  { key: 16, label: `更新者`, visible: true },
  { key: 17, label: `更新时间`, visible: true },
]);

const data = reactive({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    productId: undefined,
    productCode: undefined,
    productName: undefined,
    productType: undefined,
    productSpecifications: undefined,
    measureUnit: undefined,
    producer: undefined,
    costPrice: undefined,
    price: undefined,
    productBarcode: undefined,
    upperLimit: undefined,
    lowerLimit: undefined,
    defaultWarehouse: undefined,
    notes: undefined,
    status: undefined,
  },
  rules: {
    productCode: [
      { required: true, message: "货品编号不能为空", trigger: "blur" },
    ],
    productName: [
      { required: true, message: "货品名称不能为空", trigger: "blur" },
    ],
    productType: [
      { required: true, message: "货品类型不能为空", trigger: "blur" },
    ],
    measureUnit: [
      { required: true, message: "计量单位不能为空", trigger: "blur" },
    ],
  },
});

const { queryParams, form, rules } = toRefs(data);

/** 通过条件过滤节点  */
const filterNode = (value, data) => {
  if (!value) return true;
  return data.label.indexOf(value) !== -1;
};
/** 根据名称筛选部门树 */
watch(productTypeName, (val) => {
  proxy.$refs["typeTreeRef"].filter(val);
});
/** 查询货品类型下拉树结构 */
function getProductTypeTree() {
  productTypeTreeSelect().then((response) => {
    typeOptions.value = response.data;
  });
}
/** 查询货品列表 */
function getList() {
  loading.value = true;
  listProduct(proxy.addDateRange(queryParams.value, dateRange.value)).then(
    (res) => {
      loading.value = false;
      productList.value = res.rows;
      total.value = res.total;
    }
  );
}
/** 节点单击事件 */
function handleNodeClick(data) {
  queryParams.value.productType = data.id;
  handleQuery();
}
/** 搜索按钮操作 */
function handleQuery() {
  queryParams.value.pageNum = 1;
  getProductTypeTree();
  getList();
}
/** 重置按钮操作 */
function resetQuery() {
  dateRange.value = [];
  proxy.resetForm("queryRef");
  queryParams.value.productId = undefined;
  proxy.$refs.typeTreeRef.setCurrentKey(null);
  handleQuery();
}
/** 删除按钮操作 */
function handleDelete(row) {
  const productIds = row.productId || ids.value;
  proxy.$modal
    .confirm('是否确认删除编号为"' + productIds + '"的货品？')
    .then(function () {
      return delProduct(productIds);
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
    "baseDate/product/export",
    {
      ...queryParams.value,
    },
    `货品资料_${new Date().getTime()}.xlsx`
  );
}
/** 选择条数  */
function handleSelectionChange(selection) {
  ids.value = selection.map((item) => item.productId);
  single.value = selection.length != 1;
  multiple.value = !selection.length;
}
/** 导入按钮操作 */
function handleImport() {
  upload.title = "货品导入";
  upload.open = true;
}
/** 下载模板操作 */
function importTemplate() {
  proxy.download(
    "baseDate/product/importTemplate",
    {},
    `货品资料_${new Date().getTime()}.xlsx`
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
    productId: undefined,
    productCode: undefined,
    productName: undefined,
    productType: undefined,
    productSpecifications: undefined,
    measureUnit: undefined,
    phonenumber: undefined,
    producer: undefined,
    costPrice: undefined,
    price: undefined,
    productBarcode: undefined,
    upperLimit: undefined,
    lowerLimit: undefined,
    defaultWarehouse: undefined,
    notes: undefined,
    status: "0",
  };
  proxy.resetForm("productRef");
}
/** 取消按钮 */
function cancel() {
  open.value = false;
  reset();
}
/** 新增按钮操作 */
function handleAdd() {
  getProductTypeTree();
  reset();
  open.value = true;
  title.value = "添加货品";
}
/** 修改按钮操作 */
function handleUpdate(row) {
  getProductTypeTree();
  reset();
  const productId = row.productId || ids.value;
  getProduct(productId).then((response) => {
    form.value = response.data;
    open.value = true;
    title.value = "修改货品";
  });
}
/** 提交按钮 */
function submitForm() {
  proxy.$refs["productRef"].validate((valid) => {
    if (valid) {
      if (form.value.productId != undefined) {
        updateProduct(form.value).then((response) => {
          proxy.$modal.msgSuccess("修改成功");
          open.value = false;
          getList();
        });
      } else {
        addProduct(form.value).then((response) => {
          proxy.$modal.msgSuccess("新增成功");
          open.value = false;
          getList();
        });
      }
    }
  });
}

getProductTypeTree();
getList();
</script>
