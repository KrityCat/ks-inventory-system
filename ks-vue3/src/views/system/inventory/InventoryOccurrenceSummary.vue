<template>
  <!-- 库存发生汇总 -->
  <div class="app-container">
    <el-row :gutter="20">
      <el-col :span="24" :xs="24">
        <el-form
            v-show="showSearch"
            ref="queryRef"
            :inline="true"
            :model="queryParams"
            label-width="100px"
        >
          <el-form-item label="发生时间" style="width: 388px">
            <el-date-picker
                v-model="dateRange"
                end-placeholder="结束日期"
                range-separator="-"
                start-placeholder="开始日期"
                type="daterange"
                value-format="YYYY-MM-DD"
            ></el-date-picker>
          </el-form-item>
          <el-form-item label="货品编号" prop="productCode">
            <el-input
                v-model="queryParams.productCode"
                class="form-item"
                clearable
                placeholder="请输入货品编号"
                @keyup.enter="handleQuery"
            />
          </el-form-item>
          <el-form-item label="货品名称" prop="productName">
            <el-input
                v-model="queryParams.productName"
                class="form-item"
                clearable
                placeholder="请输入货品名称"
                @keyup.enter="handleQuery"
            />
          </el-form-item>
          <el-form-item label="货品类型" prop="productType">
            <el-tree-select
                v-model="form.productType"
                :data="typeOptions"
                :props="{ value: 'id', label: 'label', children: 'children' }"
                check-strictly
                class="form-item"
                clearable
                placeholder="请选择货品类型"
                value-key="id"
            />
          </el-form-item>
          <el-form-item label="商品规格" prop="productSpecifications">
            <el-input
                v-model="queryParams.productSpecifications"
                class="form-item"
                clearable
                placeholder="请输入商品规格"
                @keyup.enter="handleQuery"
            />
          </el-form-item>
          <el-form-item label="仓库" prop="warehousingId">
            <el-select
                v-model="queryParams.warehousingId"
                class="form-item"
                clearable
                filterable
                placeholder="请选择"
            >
              <el-option
                  v-for="item in warehouseOptions"
                  :key="item.warehouseId"
                  :label="item.warehouseName"
                  :value="item.warehouseId"
              ></el-option>
            </el-select>
          </el-form-item>
          <el-form-item>
            <el-button
                v-hasPermi="['inventory:inventoryOccurrenceSummary:list']"
                icon="Search"
                type="primary"
                @click="handleQuery"
            >查询
            </el-button
            >
            <el-button icon="Refresh" @click="resetQuery">重置</el-button>
          </el-form-item>
        </el-form>
        <el-row :gutter="10" class="mb8">
          <el-col :span="1.5">
            <el-button
                v-hasPermi="['inventory:inventoryOccurrenceSummary:export']"
                disable="disable"
                icon="Download"
                plain
                type="danger"
                @click="handleDetailExport"
            >导出
            </el-button
            >
          </el-col>
          <right-toolbar
              v-model:showSearch="showSearch"
              @queryTable="getList"
          ></right-toolbar>
        </el-row>

        <el-table
            v-loading="loading"
            :data="occurrenceSummaryList"
            border
            show-summary
        >
          <el-table-column
              align="center"
              label="序号"
              type="index"
              width="60"
          />
          <el-table-column align="center" label="仓库">
            <template #default="scope">
              <span>{{ scope.row.retrievalName || scope.row.warehousingName }}</span>
            </template>
          </el-table-column>
          <el-table-column
              align="center"
              label="货品编号"
              prop="productCode"
          />
          <el-table-column
              align="center"
              label="货品名称"
              prop="productName"
          />
          <el-table-column
              align="center"
              label="货品类型"
              prop="productTypeName"
          />
          <el-table-column
              align="center"
              label="规格"
              prop="productSpecifications"
          />
          <el-table-column
              align="center"
              label="单位"
              prop="measureUnit"
          />
          <el-table-column align="center" label="期初结存">
            <el-table-column
                align="center"
                label="数量"
                prop="obplanQuantity"
            />
            <el-table-column align="center" label="金额" prop="obmoney"/>
          </el-table-column>
          <el-table-column align="center" label="本期入库">
            <el-table-column
                align="center"
                label="数量"
                prop="eiplanQuantity"
            />
            <el-table-column align="center" label="金额" prop="eimoney"/>
          </el-table-column>
          <el-table-column align="center" label="本期出库">
            <el-table-column
                align="center"
                label="数量"
                prop="erplanQuantity"
            />
            <el-table-column align="center" label="金额" prop="ermoney"/>
          </el-table-column>
          <el-table-column align="center" label="期末结存">
            <el-table-column
                align="center"
                label="数量"
                prop="cbplanQuantity"
            />
            <el-table-column align="center" label="金额" prop="cbmoney"/>
          </el-table-column>
        </el-table>
        <!-- 分页组件 -->
        <pagination
            v-show="total > 0"
            v-model:limit="queryParams.pageSize"
            v-model:page="queryParams.pageNum"
            :total="total"
            @pagination="getList"
        />
      </el-col>
    </el-row>
  </div>
</template>

<script name="InventoryOccurrenceSummary" setup>
import {listWarehouse} from "@/api/basedate/warehouse";
import {inventorySummaryQuery} from "@/api/inventory/inventoryOccurrenceSummary";
import {productTypeTreeSelect} from "@/api/basedate/product";

const {proxy} = getCurrentInstance();

// 查询结果表
const occurrenceSummaryList = ref([]);
const warehouseOptions = ref(undefined);
// 隐藏查询
const showSearch = ref(true);
// 加载
const loading = ref(true);
// 总条数
const total = ref(0);
// 数据范围
const dateRange = ref([]);
const typeOptions = ref(undefined);

const data = reactive({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 50,
    productCode: undefined,
    productName: undefined,
    productType: undefined,
    productSpecifications: undefined,
    warehouseId: undefined,
  },
  rules: {},
});

const {queryParams, form, rules} = toRefs(data);

function Options() {
  listWarehouse().then((response) => {
    warehouseOptions.value = response.rows;
  });
  productTypeTreeSelect().then((response) => {
    typeOptions.value = response.data;
  });
}

/** 查询货品发生汇总 */
function getList() {
  loading.value = true;
  inventorySummaryQuery(
      proxy.addDateRange(queryParams.value, dateRange.value)
  ).then((response) => {
    occurrenceSummaryList.value = response.rows;
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
  typeOptions.value = undefined;
  dateRange.value = [];
  proxy.resetForm("queryRef");
  handleQuery();
  reset();
}

/** 重置操作表单 */
function reset() {
  form.value = {
    productCode: undefined,
    productName: undefined,
    productType: undefined,
    productSpecifications: undefined,
    warehouseId: undefined,
  };
  proxy.resetForm("queryRef");
}

/** 导出按钮操作 */
function handleDetailExport() {
  proxy.download(
      "inventory/inventoryOccurrenceSummary/export",
      {
        ...queryParams.value,
      },
      `货品发生汇总_${new Date().getTime()}.xlsx`
  );
  proxy.$modal.msgSuccess("浏览器正在下载，请稍等！");
}


getList();
Options();
</script>

<style scoped>
.form-item {
  width: 200px;
}
</style>