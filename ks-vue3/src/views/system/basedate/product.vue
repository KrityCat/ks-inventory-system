<template>
  <div class="app-container">
    <el-row :gutter="20">
      <!--货品类型-->
      <el-col :span="4" :xs="24">
        <div class="head-container">
          <el-input
              v-model="productTypeName"
              clearable
              placeholder="请输入货品类型名称"
              prefix-icon="Search"
              style="margin-bottom: 20px"
          />
        </div>
        <div class="head-container">
          <el-tree
              ref="typeTreeRef"
              :data="typeOptions"
              :expand-on-click-node="false"
              :filter-node-method="filterNode"
              :props="{ label: 'label', children: 'children' }"
              default-expand-all
              highlight-current
              node-key="id"
              @node-click="handleNodeClick"
          />
        </div>
      </el-col>
      <!--查询条件-->
      <el-col :span="20" :xs="24">
        <el-form
            v-show="showSearch"
            ref="queryRef"
            :inline="true"
            :model="queryParams"
            label-width="90px"
        >
          <el-form-item label="货品编号" prop="productCode">
            <el-input
                v-model="queryParams.productCode"
                clearable
                placeholder="请输入货品编号"
                style="width: 180px"
                @keyup.enter="handleQuery"
            />
          </el-form-item>
          <el-form-item label="货品名称" prop="productName">
            <el-input
                v-model="queryParams.productName"
                clearable
                placeholder="请输入货品名称"
                style="width: 180px"
                @keyup.enter="handleQuery"
            />
          </el-form-item>
          <el-form-item label="商品规格" prop="productSpecifications">
            <el-input
                v-model="queryParams.productSpecifications"
                clearable
                placeholder="请输入商品规格"
                style="width: 180px"
                @keyup.enter="handleQuery"
            />
          </el-form-item>
          <el-form-item label="计量单位" prop="measureUnit">
            <el-input
                v-model="queryParams.measureUnit"
                clearable
                placeholder="请输入计量单位"
                style="width: 180px"
                @keyup.enter="handleQuery"
            />
          </el-form-item>
          <el-form-item label="货品条码" prop="productBarcode">
            <el-input
                v-model="queryParams.productBarcode"
                clearable
                placeholder="请输入货品条码"
                style="width: 180px"
                @keyup.enter="handleQuery"
            />
          </el-form-item>
          <el-form-item label="默认仓库" prop="defaultWarehouse">
            <el-input
                v-model="queryParams.defaultWarehouse"
                clearable
                placeholder="请输入默认仓库"
                style="width: 180px"
                @keyup.enter="handleQuery"
            />
          </el-form-item>
          <el-form-item label="状态" prop="status">
            <el-select
                v-model="queryParams.status"
                clearable
                placeholder="状态"
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
                end-placeholder="结束日期"
                range-separator="-"
                start-placeholder="开始日期"
                type="daterange"
                value-format="YYYY-MM-DD"
            ></el-date-picker>
          </el-form-item>
          <el-form-item>
            <el-button icon="Search" type="primary" @click="handleQuery"
            >搜索
            </el-button
            >
            <el-button icon="Refresh" @click="resetQuery">重置</el-button>
          </el-form-item>
        </el-form>

        <el-row :gutter="10" class="mb8">
          <el-col :span="1.5">
            <el-button
                v-hasPermi="['baseDate:product:add']"
                icon="Plus"
                plain
                type="primary"
                @click="handleAdd"
            >新增
            </el-button
            >
          </el-col>
          <el-col :span="1.5">
            <el-button
                v-hasPermi="['baseDate:product:update']"
                :disabled="single"
                icon="Edit"
                plain
                type="success"
                @click="handleUpdate"
            >修改
            </el-button
            >
          </el-col>
          <el-col :span="1.5">
            <el-button
                v-hasPermi="['baseDate:product:remove']"
                :disabled="multiple"
                icon="Delete"
                plain
                type="danger"
                @click="handleDelete"
            >删除
            </el-button
            >
          </el-col>
          <el-col :span="1.5">
            <el-button
                v-hasPermi="['baseDate:product:import']"
                icon="Upload"
                plain
                type="info"
                @click="handleImport"
            >导入
            </el-button
            >
          </el-col>
          <el-col :span="1.5">
            <el-button
                v-hasPermi="['baseDate:product:export']"
                icon="Download"
                plain
                type="warning"
                @click="handleExport"
            >导出
            </el-button
            >
          </el-col>
          <right-toolbar
              v-model:showSearch="showSearch"
              :columns="columns"
              @queryTable="getList"
          ></right-toolbar>
        </el-row>

        <el-table
            v-loading="loading"
            :data="productList"
            border
            @selection-change="handleSelectionChange"
        >
          <el-table-column align="center" type="selection" width="50"/>
          <el-table-column
              v-if="columns[0].visible"
              key="productCode"
              align="center"
              label="货品编号"
              prop="productCode"
          />
          <el-table-column
              v-if="columns[1].visible"
              key="productName"
              align="center"
              label="货品名称"
              prop="productName"
              width="250"
          />
          <el-table-column
              v-if="columns[2].visible"
              key="productTypeName"
              align="center"
              label="货品类型"
              prop="type.productTypeName"
              width="100"
          />
          <el-table-column
              v-if="columns[3].visible"
              key="productSpecifications"
              align="center"
              label="商品规格"
              prop="productSpecifications"
          />
          <el-table-column
              v-if="columns[4].visible"
              key="measureUnit"
              align="center"
              label="计量单位"
              prop="measureUnit"
          />
          <el-table-column
              v-if="columns[5].visible"
              key="producer"
              align="center"
              label="产地"
              prop="producer"
          />
          <el-table-column
              v-if="columns[6].visible"
              key="costPrice"
              align="center"
              label="成本价"
              prop="costPrice"
          />
          <el-table-column
              v-if="columns[7].visible"
              key="univalence"
              align="center"
              label="参考售价"
              prop="univalence"
          />
          <el-table-column
              v-if="columns[18].visible"
              key="discount"
              align="center"
              label="销售折扣"
              prop="discount"
          />
          <el-table-column
              v-if="columns[8].visible"
              key="productBarcode"
              align="center"
              label="货品条码"
              prop="productBarcode"
          />
          <el-table-column
              v-if="columns[9].visible"
              key="upperLimit"
              align="center"
              label="库存上限"
              prop="upperLimit"
          />
          <el-table-column
              v-if="columns[10].visible"
              key="lowerLimit"
              align="center"
              label="库存下限"
              prop="lowerLimit"
          />
          <el-table-column
              v-if="columns[11].visible"
              key="defaultWarehouse"
              align="center"
              label="默认仓库"
              prop="defaultWarehouse"
          />
          <el-table-column
              v-if="columns[12].visible"
              key="status"
              align="center"
              label="状态"
          >
            <template #default="scope">
              <dict-tag
                  :options="sys_normal_disable"
                  :value="scope.row.status"
              />
            </template>
          </el-table-column>
          <el-table-column
              v-if="columns[13].visible"
              key="notes"
              align="center"
              label="备注"
              prop="notes"
          />
          <el-table-column
              v-if="columns[14].visible"
              align="center"
              label="创建者"
              prop="createBy"
          />
          <el-table-column
              v-if="columns[15].visible"
              align="center"
              label="创建时间"
              prop="createTime"
          >
            <template #default="scope">
              <span>{{ parseTime(scope.row.createTime) }}</span>
            </template>
          </el-table-column>
          <el-table-column
              v-if="columns[16].visible"
              align="center"
              label="更新者"
              prop="updateBy"
          />
          <el-table-column
              v-if="columns[17].visible"
              :show-overflow-tooltip="true"
              align="center"
              label="更新时间"
              prop="updateTime"
          >
            <template #default="scope">
              <span>{{ parseTime(scope.row.updateTime) }}</span>
            </template>
          </el-table-column>
          <el-table-column
              align="center"
              class-name="small-padding fixed-width"
              fixed="right"
              label="操作"
              width="100"
          >
            <template #default="scope">
              <el-tooltip content="修改" placement="top">
                <el-button
                    v-hasPermi="['baseDate:product:update']"
                    icon="Edit"
                    link
                    type="primary"
                    @click="handleUpdate(scope.row)"
                ></el-button>
              </el-tooltip>
              <el-tooltip content="删除" placement="top">
                <el-button
                    v-hasPermi="['baseDate:product:remove']"
                    icon="Delete"
                    link
                    type="primary"
                    @click="handleDelete(scope.row)"
                ></el-button>
              </el-tooltip>
            </template>
          </el-table-column>
        </el-table>
        <pagination
            v-show="total > 0"
            v-model:limit="queryParams.pageSize"
            v-model:page="queryParams.pageNum"
            :total="total"
            @pagination="getList"
        />
      </el-col>
    </el-row>

    <!-- 添加或修改货品资料配置对话框 -->
    <el-dialog v-model="open" :title="title" append-to-body width="600px">
      <el-form ref="productRef" :model="form" :rules="rules" label-width="80px">
        <el-row>
          <el-col :span="12">
            <el-form-item label="货品编号" prop="productCode">
              <el-input
                  v-model="form.productCode"
                  maxlength="30"
                  placeholder="请输入货品编号"
              />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="货品名称" prop="productName">
              <el-input
                  v-model="form.productName"
                  maxlength="30"
                  placeholder="请输入货品名称"
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
                  check-strictly
                  node-key="id"
                  placeholder="请选择货品类型"
                  value-key="id"
              />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="货品规格" prop="productSpecifications">
              <el-input
                  v-model="form.productSpecifications"
                  maxlength="30"
                  placeholder="请输入货品规格"
              />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="计量单位" prop="measureUnit">
              <el-input
                  v-model="form.measureUnit"
                  maxlength="30"
                  placeholder="请输入计量单位"
              />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="货品条码" prop="productBarcode">
              <el-input
                  v-model="form.productBarcode"
                  maxlength="30"
                  placeholder="请输入货品条码"
              />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="24">
            <el-form-item label="产地" prop="producer">
              <el-input
                  v-model="form.producer"
                  maxlength="30"
                  placeholder="请输入产地"
              />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="成本价" prop="costPrice">
              <el-input
                  v-model="form.costPrice"
                  maxlength="30"
                  placeholder="请输入成本价"
              />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="参考售价" prop="univalence">
              <el-input
                  v-model="form.univalence"
                  maxlength="30"
                  placeholder="请输入参考售价"
              />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="销售折扣" prop="discount">
              <el-input
                  v-model="form.discount"
                  maxlength="30"
                  placeholder="请输入销售折扣"
              />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="库存数量" prop="costPrice">
              <el-input
                  v-model="form.inventoryQty"
                  disabled
                  placeholder="系统自动计算"
              />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="24">
            <el-form-item label="库存锁单" prop="costPrice">
              <el-input
                  v-model="form.lockInventoryQty"
              />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="库存上限" prop="upperLimit">
              <el-input
                  v-model="form.upperLimit"
                  maxlength="30"
                  placeholder="请输入库存上限"
              />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="库存下限" prop="lowerLimit">
              <el-input
                  v-model="form.lowerLimit"
                  maxlength="30"
                  placeholder="请输入库存下限"
              />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="默认仓库" prop="defaultWarehouse">
              <el-input
                  v-model="form.defaultWarehouse"
                  maxlength="30"
                  placeholder="请输入默认仓库"
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
                >{{ dict.label }}
                </el-radio
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
                  placeholder="请输入内容"
                  type="textarea"
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
        v-model="upload.open"
        :title="upload.title"
        append-to-body
        width="400px"
    >
      <el-upload
          ref="uploadRef"
          :action="upload.url + '?updateSupport=' + upload.updateSupport"
          :auto-upload="false"
          :disabled="upload.isUploading"
          :headers="upload.headers"
          :limit="1"
          :on-progress="handleFileUploadProgress"
          :on-success="handleFileSuccess"
          accept=".xlsx, .xls"
          drag
      >
        <el-icon class="el-icon--upload">
          <upload-filled/>
        </el-icon>
        <div class="el-upload__text">将文件拖到此处，或<em>点击上传</em></div>
        <template #tip>
          <div class="el-upload__tip text-center">
            <div class="el-upload__tip">
              <el-checkbox
                  v-model="upload.updateSupport"
              />
              是否更新已经存在的货品数据
            </div>
            <span>仅允许导入xls、xlsx格式文件。</span>
            <el-link
                :underline="false"
                style="font-size: 12px; vertical-align: baseline"
                type="primary"
                @click="importTemplate"
            >下载模板
            </el-link
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

<script name="Product" setup>
import {getToken} from "@/utils/auth";
import {
  addProduct,
  delProduct,
  getProduct,
  listProduct,
  productTypeTreeSelect,
  updateProduct,
} from "@/api/basedate/product";

const {proxy} = getCurrentInstance();
const {sys_normal_disable} = proxy.useDict("sys_normal_disable");

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
  headers: {Authorization: "Bearer " + getToken()},
  // 上传的地址
  url: import.meta.env.VITE_APP_BASE_API + "/baseDate/product/importData",
});
// 列显隐信息
const columns = ref([
  {key: 0, label: `货品编号`, visible: true},
  {key: 1, label: `货品名称`, visible: true},
  {key: 2, label: `货品类型`, visible: true},
  {key: 3, label: `商品规格`, visible: true},
  {key: 4, label: `计量单位`, visible: true},
  {key: 5, label: `产地`, visible: true},
  {key: 6, label: `成本价`, visible: true},
  {key: 7, label: `参考售价`, visible: true},
  {key: 18, label: `销售折扣`, visible: true},
  {key: 8, label: `货品条码`, visible: true},
  {key: 9, label: `库存上限`, visible: true},
  {key: 10, label: `库存下限`, visible: true},
  {key: 11, label: `默认仓库`, visible: true},
  {key: 12, label: `状态`, visible: true},
  {key: 13, label: `备注`, visible: true},
  {key: 14, label: `创建者`, visible: true},
  {key: 15, label: `创建时间`, visible: true},
  {key: 16, label: `更新者`, visible: true},
  {key: 17, label: `更新时间`, visible: true},
]);

const data = reactive({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 50,
    productId: undefined,
    productCode: undefined,
    productName: undefined,
    productType: undefined,
    productSpecifications: undefined,
    measureUnit: undefined,
    producer: undefined,
    costPrice: undefined,
    univalence: undefined,
    productBarcode: undefined,
    upperLimit: undefined,
    lowerLimit: undefined,
    defaultWarehouse: undefined,
    notes: undefined,
    status: undefined,
  },
  rules: {
    productCode: [
      {required: true, message: "货品编号不能为空", trigger: "blur"},
    ],
    productName: [
      {required: true, message: "货品名称不能为空", trigger: "blur"},
    ],
    productType: [
      {required: true, message: "货品类型不能为空", trigger: "blur"},
    ],
    productSpecifications: [
      {required: true, message: "货品规格不能为空", trigger: "blur"},
    ],
    measureUnit: [
      {required: true, message: "计量单位不能为空", trigger: "blur"},
    ],
  },
});

const {queryParams, form, rules} = toRefs(data);

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
  queryParams.value.productType = undefined;
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
      .catch(() => {
      });
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
      {dangerouslyUseHTMLString: true}
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
    univalence: undefined,
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
  reset();
  getProductTypeTree();
  open.value = true;
  title.value = "添加货品";
}

/** 修改按钮操作 */
function handleUpdate(row) {
  reset();
  getProductTypeTree();
  const productId = row.productId || ids.value;
  getProduct(productId).then((response) => {
    form.value = response.data;
    open.value = true;
    title.value = "修改货品";
    form.value.productType = Number(response.data.productType);
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
