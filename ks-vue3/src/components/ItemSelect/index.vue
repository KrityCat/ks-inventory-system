<template>
  <div class="prod-sku-select-wrapper">
    <div>
      <el-form
        inline="inline"
        ref="queryRef"
        label-width="90px">
        <el-form-item label="货品编号" prop="productCode">
            <el-input
                v-model="queryParams.productCode"
                placeholder="请输入货品编号"
                clearable
                class="form-item"
                @keyup.enter="handleQuery"/>
        </el-form-item>
        <el-form-item label="货品名称" prop="productName">
            <el-input
                v-model="queryParams.productName"
                placeholder="请输入货品名称"
                clearable
                class="form-item"
                @keyup.enter="handleQuery"/>
        </el-form-item>
        <el-form-item label="货品类型">
          <el-tree-select
            v-model="queryParams.productType"
            :data="typeOptions"
            :props="{ value: 'id', label: 'label', children: 'children' }"
            value-key="id"
            placeholder="请选择货品类型"
            check-strictly
            clearable/>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" icon="Search" @click="clickQuery">查询</el-button>
          <!-- <el-button icon="Refresh" @click="resetQuery">重置</el-button> -->
        </el-form-item>
      </el-form>
    </div>
    <div class="m-table-wrap">
      <table class="m-table" v-if="list.length !== 0">
        <thead>
          <tr class="m-tr">
            <th class="m-th">
              <!-- <el-checkbox
                :value="leftAllChecked === 1"
                @input="leftAllChecked = $event"
                :indeterminate="leftAllChecked === 2"
                :disabled="editableList.length === 0"
              ></el-checkbox> -->
            </th>
            <th class="m-th">货品编号</th>
            <th class="m-th">货品名称</th>
            <th class="m-th">类型</th>
            <th class="m-th">规格</th>
            <th class="m-th">单位</th>
            <th class="m-th">产地</th>
          </tr>
        </thead>
        <tbody class="m-body">
          <tr class="m-tr" v-for="p in list" :key="p.productId">
            <td class="m-td">
              <el-checkbox
                v-model="p.checked"
                :disabled="rightListKeySet.has(p.productId)">
              </el-checkbox>
            </td>
            <td class="m-td"> {{ p.productCode }} </td>
            <td class="m-td"> {{ p.productName }} </td>
            <td class="m-td"> {{ p.type.productTypeName }} </td>
            <td class="m-td"> {{ p.productSpecifications }} </td>
            <td class="m-td"> {{ p.measureUnit }} </td>
            <td class="m-td"> {{ p.producer }} </td>
          </tr>
        </tbody>
      </table>
      <el-empty v-else :image-size="64"></el-empty>
    </div>
    <pagination
      v-show="total > 0"
      :total="total"
      :page.sync="pageReq.page"
      :limit.sync="pageReq.size"
      @pagination="loadAll"/>
  </div>
</template>

<script>
import { listProduct, productTypeTreeSelect } from "@/api/basedate/product";

export default {
  name: "ItemSelect",
  props: ['data'],
  data() {
    return {
      dateRange: undefined,
      checkAll: false,
      //物料类别
      typeOptions: [],
      queryParams: {
        productCode: null,
        productName: null,
        productType: null,
        productSpecifications: null,
        measureUnit: null,
        producer: null,
      },
      list: [],
      total: 0,
      pageReq: {
        page: 1,
        size: 10,
      },
      rightList: [],
      rightListKeySet: new Set
    };
  },
  computed: {
    leftAllChecked: {
      get() {
        return this.editableList.length > 0 &&
        this.editableList.every((it) => it.checked)
          ? 1
          : this.editableList.some((it) => it.checked)
            ? 2
            : 0;
      },
      set(v) {
        this.editableList.forEach((it) => (it.checked = v));
      },
    },
    editableList() {
      return this.list.filter((it) => !this.rightListKeySet.has(it.productId));
    },
    leftCheckedList() {
      return this.list.filter((it) => it.checked);
    // },
    // resetQuery() {
    //   this.dateRange = [];
    //   proxy.value.resetForm("queryRef");
    }
  },
  watch: {
    rightList: {
      handler(newVal, oldVal) {
        const set = new Set();
        newVal.forEach((it) => set.add(it.productId));
        this.rightListKeySet = set;
      },
      deep: true
    }
  },
  created() {
    if (this.data) {
      this.initDetailsList(this.data)
    }
    this.loadAll();
    productTypeTreeSelect().then((response) => {
      this.typeOptions = response.data;
    });
  },
  methods: {
    initDetailsList(list) {
      this.rightList = list.map(it => {
        return it.prod
      })
    },
    loadAll() {
      const pageReq = {...this.pageReq};
      pageReq.page -= 1;
      listProduct(this.queryParams, pageReq).then((res) => {
        const {rows, total} = res;
        rows.forEach((it) => (it.checked = false));
        this.list = rows;
        this.total = total;
      });
    },
    clickQuery() {
      this.pageReq.page = 1;
      this.loadAll();
    },
    getRightList() {
      this.moveRight();
      return this.rightList;
    },
    moveRight() {
      for (let it of this.leftCheckedList) {
        if (!this.rightListKeySet.has(it.productId)) {
          it.checked = false;
          this.rightList.push({...it, checked: false});
        }
      }
    },
  },
};
</script>

<style scoped lang="scss">
.form-item{
    width: 280px
}
.m-table-wrap {
  color: rgba(0, 0, 0, .65);
  font-size: 14px;
  line-height: 1.5714285714285714;
  border-radius: 8px 8px 0 0;
  .m-table {
    display: table;
    table-layout: fixed;
    width: 100%;
    text-align: left;
    border-radius: 8px 8px 0 0;
    border-collapse: separate;
    border-spacing: 0;
    margin: 0;
    .m-th {
      padding: 16px;
      color: rgba(0, 0, 0, .85);
      font-weight: 500;
      text-align: left;
      background: #fafafa;
      border: none;
      border-bottom: 1px solid #f0f0f0;;
      transition: background .3s ease;
      &:first-child {
        border-top-left-radius: 8px;
      }
      &:last-child {
        border-top-right-radius: 8px;
      }
    }
    .m-body {
      position: relative;
      .m-tr-loading {
        border: none;
        background-color: #FFF;
        .m-loading {
          position: absolute;
          width: 100%;
          height: 100%;
        }
      }
      .m-tr-empty {
        border: none;
        background-color: #FFF;
        &:hover {
          background: #FFF;
        }
        .m-td-empty {
          padding: 16px;
          border: none;
          border-bottom: 1px solid #f0f0f0;;
          .empty {
            margin: 32px 0;
          }
        }
      }
    }
    .m-tr {
      border: none;
      background-color: #FFF;
      transition: background-color .3s;
      .m-td {
        padding: 16px;
        border: none;
        border-bottom: 1px solid #f0f0f0;;
        transition: background .3s;
        overflow: hidden;
        white-space: nowrap;
        text-overflow: ellipsis;
      }
      &:hover {
        background-color: #fafafa;
      }
    }
  }
}

</style>