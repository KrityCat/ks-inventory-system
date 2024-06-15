<template>
  <div class="app-container home">
    <el-row :gutter="20">
      <el-col :sm="24" :lg="24">
        <el-card style="font-size: 20px">
          <div><span>工作台</span></div>
          <hr />
          <div>
            <el-row :gutter="40" class="panel-group">
              <el-col :xs="12" :sm="12" :lg="1">
                <img
                  :src="userStore.avatar"
                  style="
                    width: 50px;
                    height: 50px;
                    float: left;
                    margin-right: 10px;
                    border-radius: 50%;
                  "
                />
              </el-col>
              <el-col :xs="12" :sm="12" :lg="8">
                <p
                  style="
                    white-space: nowrap;
                    font-size: 16px;
                    margin-bottom: 8px;
                  "
                >
                  {{ state.user.userName }}, {{ state.hello }}
                </p>
              </el-col>
              <el-col :xs="12" :sm="12" :lg="6">
                <el-countdown format="DD [天] HH:mm:ss" :value="value2">
                  <template #title>
                    <div style="display: inline-flex; align-items: center">
                      <el-icon style="margin-right: 4px" :size="12">
                        <Calendar />
                      </el-icon>
                      距离下个月01日还剩
                    </div>
                  </template>
                </el-countdown>
              </el-col>
            </el-row>
          </div>
        </el-card>
      </el-col>
    </el-row>
    <el-divider />
    <el-row :gutter="20">
      <el-col :span="10">
        <el-card shadow="always" style="padding-bottom: 0px">
          <el-row :gutter="40" class="panel-group">
            <el-col :xs="12" :sm="12" :lg="12" class="card-panel-col">
              <div
                class="card-panel"
                @click="handleGo('/purchase/purchaseDocumentQuery')"
                v-hasPermi="['system:purchase:PurchaseOrderQuery']"
              >
                <div class="card-panel-icon-wrapper icon-people">
                  <svg-icon icon-class="search" class-name="card-panel-icon" />
                </div>
                <div class="card-panel-description">
                  <div class="card-panel-text">采购单据查询</div>
                  <el-statistic
                    :value="purchaseTotal"
                    :value-style="{
                      color: '#40c9c6',
                      'font-weight': 'bolder',
                      'font-size': '35px',
                    }"
                  />
                </div>
              </div>
            </el-col>
            <el-col :xs="12" :sm="12" :lg="12" class="card-panel-col">
              <div
                class="card-panel"
                @click="handleGo('/sales/salesDocumentQuery')"
                v-hasPermi="['system:sales:salesHeadQuery']"
              >
                <div class="card-panel-icon-wrapper icon-money">
                  <svg-icon icon-class="search" class-name="card-panel-icon" />
                </div>
                <div class="card-panel-description">
                  <div class="card-panel-text">销售单据查询</div>
                  <el-statistic
                    :value="salesTotal"
                    :value-style="{
                      color: '#f4516c',
                      'font-weight': 'bolder',
                      'font-size': '35px',
                    }"
                  />
                </div>
              </div>
            </el-col>
            <el-col :xs="12" :sm="12" :lg="12" class="card-panel-col">
              <div
                class="card-panel"
                @click="handleGo('/inventory/InventoryDocumentQuery')"
                v-hasPermi="['system:inventory:headReceiptQuery']"
              >
                <div class="card-panel-icon-wrapper icon-message">
                  <svg-icon icon-class="search" class-name="card-panel-icon" />
                </div>
                <div class="card-panel-description">
                  <div class="card-panel-text">库存单据查询</div>
                  <el-statistic
                    :value="inventoryTotal"
                    :value-style="{
                      color: '#36a3f7',
                      'font-weight': 'bolder',
                      'font-size': '35px',
                    }"
                  />
                </div>
              </div>
            </el-col>
            <el-col :xs="12" :sm="12" :lg="12" class="card-panel-col">
              <div
                class="card-panel"
                @click="handleGo('/basedate/warehouse')"
                v-hasPermi="['baseDate:warehouse:list']"
              >
                <div class="card-panel-icon-wrapper icon-people">
                  <svg-icon icon-class="table" class-name="card-panel-icon" />
                </div>
                <div class="card-panel-description">
                  <div class="card-panel-text">仓库</div>
                  <el-statistic
                    :value="warehouseTotal"
                    :value-style="{
                      color: '#40c9c6',
                      'font-weight': 'bolder',
                      'font-size': '35px',
                    }"
                  />
                </div>
              </div>
            </el-col>
            <el-col :xs="12" :sm="12" :lg="12" class="card-panel-col">
              <div
                class="card-panel"
                @click="handleGo('/basedate/supplier')"
                v-hasPermi="['baseDate:supplier:list']"
              >
                <div class="card-panel-icon-wrapper icon-money">
                  <svg-icon icon-class="peoples" class-name="card-panel-icon" />
                </div>
                <div class="card-panel-description">
                  <div class="card-panel-text">供应商</div>
                  <el-statistic
                    :value="supplierTotal"
                    :value-style="{
                      color: '#f4516c',
                      'font-weight': 'bolder',
                      'font-size': '35px',
                    }"
                  />
                </div>
              </div>
            </el-col>
            <el-col :xs="12" :sm="12" :lg="12" class="card-panel-col">
              <div
                class="card-panel"
                @click="handleGo('/basedate/customer')"
                v-hasPermi="['baseDate:customer:list']"
              >
                <div class="card-panel-icon-wrapper icon-message">
                  <svg-icon icon-class="star" class-name="card-panel-icon" />
                </div>
                <div class="card-panel-description">
                  <div class="card-panel-text">客户</div>
                  <el-statistic
                    :value="customerTotal"
                    :value-style="{
                      color: '#36a3f7',
                      'font-weight': 'bolder',
                      'font-size': '35px',
                    }"
                  />
                </div>
              </div>
            </el-col>
            <el-col :xs="12" :sm="12" :lg="12" class="card-panel-col">
              <div
                class="card-panel"
                @click="handleGo('/basedate/product')"
                v-hasPermi="['baseDate:product:list']"
              >
                <div class="card-panel-icon-wrapper icon-message">
                  <svg-icon icon-class="date" class-name="card-panel-icon" />
                </div>
                <div class="card-panel-description">
                  <div class="card-panel-text">货品资料</div>
                  <el-statistic
                    :value="productTotal"
                    :value-style="{
                      color: '#36a3f7',
                      'font-weight': 'bolder',
                      'font-size': '35px',
                    }"
                  />
                </div>
              </div>
            </el-col>
            <el-col :xs="12" :sm="12" :lg="12" class="card-panel-col">
              <div
                class="card-panel"
                @click="handleGo('/basedate/filesharing')"
                v-hasPermi="['baseDate:fileSharing:list']"
              >
                <div class="card-panel-icon-wrapper icon-message">
                  <svg-icon icon-class="upload" class-name="card-panel-icon" />
                </div>
                <div class="card-panel-description">
                  <div class="card-panel-text">文件共享</div>
                  <el-statistic
                    :value="fileTotal"
                    :value-style="{
                      color: '#36a3f7',
                      'font-weight': 'bolder',
                      'font-size': '35px',
                    }"
                  />
                </div>
              </div>
            </el-col>
          </el-row>
        </el-card>
      </el-col>
      <!-- <el-col :span="14">
        <el-card
          shadow="always"
          style="padding-bottom: 20px; font-size: 14px; margin-bottom: 20px"
        >
          <div ref="warn"><strong>货品库存预警</strong></div>
        </el-card>
      </el-col> -->
    </el-row>
  </div>
</template>

<script setup name="Index">
import { useRouter } from "vue-router";
import dayjs from "dayjs";
import useUserStore from "@/store/modules/user";
import { getUserProfile } from "@/api/system/user";
import { listPurchaseOrder } from "@/api/purchase/PurchaseDocumentQuery";
import { listSalesOrder } from "@/api/sales/SalesDocumentQuery";
import { headReceiptQuery } from "@/api/inventory/inventoryDocumentQuery";
import { listCustomer } from "@/api/basedate/customer";
import { listWarehouse } from "@/api/basedate/warehouse";
import { listSupplier } from "@/api/basedate/supplier";
import { listProduct } from "@/api/basedate/product";
import { listFile } from "@/api/basedate/fileSharing";

const date = ref(new Date());
const router = useRouter();
const version = ref("1.0.1");
const userStore = useUserStore();
// 条数
const purchaseTotal = ref(0);
const salesTotal = ref(0);
const inventoryTotal = ref(0);
const warehouseTotal = ref(0);
const supplierTotal = ref(0);
const customerTotal = ref(0);
const productTotal = ref(0);
const fileTotal = ref(0);
const value2 = ref(dayjs().add(1, "month").startOf("month"));
const state = reactive({
  user: {},
  hello: {},
  nowTime: "",
});
function helloTimes() {
  let hh = new Date().getHours();
  if (0 < hh && hh < 12) {
    state.hello = "上午好";
  } else if (hh < 18) {
    state.hello = "下午好";
  } else {
    state.hello = "晚上好";
  }
}
function handleGo(path) {
  router.push(path);
}

function getUser() {
  getUserProfile().then((response) => {
    state.user = response.data;
  });
}
/** 查询数据总条数列表 */
function getList() {
  listPurchaseOrder().then((response) => {
    purchaseTotal.value = response.total;
  });
  listSalesOrder().then((response) => {
    salesTotal.value = response.total;
  });
  headReceiptQuery().then((response) => {
    inventoryTotal.value = response.total;
  });
  listWarehouse().then((response) => {
    warehouseTotal.value = response.total;
  });
  listSupplier().then((response) => {
    supplierTotal.value = response.total;
  });
  listCustomer().then((response) => {
    customerTotal.value = response.total;
  });
  listProduct().then((res) => {
    productTotal.value = res.total;
  });
  listFile().then((response) => {
    fileTotal.value = response.total;
  });
}
getUser();
getList();
helloTimes();
</script>

<style scoped lang="scss">
.home {
  blockquote {
    padding: 10px 20px;
    margin: 0 0 20px;
    font-size: 17.5px;
    border-left: 5px solid #eee;
  }
  hr {
    margin-top: 20px;
    margin-bottom: 20px;
    border: 0;
    border-top: 1px solid #eee;
  }
  .col-item {
    margin-bottom: 20px;
  }

  ul {
    padding: 0;
    margin: 0;
  }

  font-family: "open sans", "Helvetica Neue", Helvetica, Arial, sans-serif;
  font-size: 13px;
  color: #676a6c;
  overflow-x: hidden;

  ul {
    list-style-type: none;
  }

  h4 {
    margin-top: 0px;
  }

  h2 {
    margin-top: 10px;
    font-size: 26px;
    font-weight: 100;
  }

  p {
    margin-top: 10px;

    b {
      font-weight: 700;
    }
  }

  .update-log {
    ol {
      display: block;
      list-style-type: decimal;
      margin-block-start: 1em;
      margin-block-end: 1em;
      margin-inline-start: 0;
      margin-inline-end: 0;
      padding-inline-start: 40px;
    }
  }
}
.home-wrapper .li {
  float: left;
  width: 25%;
  font-size: 12px;
  color: rgb(185, 181, 189);
}

.da {
  float: left;
  width: 25%;
  font-size: 20px;
}

.first {
  float: left;
  margin-bottom: 20px;
}

.el-table .warning-row {
  background: rgb(39, 138, 230);
}
.panel-group {
  margin-top: 18px;

  .card-panel-col {
    margin-bottom: 10px;
  }

  .card-panel {
    height: 108px;
    cursor: pointer;
    font-size: 12px;
    position: relative;
    overflow: hidden;
    color: #666;
    background: #fff;
    box-shadow: 4px 4px 40px rgba(0, 0, 0, 0.05);
    border-color: rgba(0, 0, 0, 0.05);

    &:hover {
      .card-panel-icon-wrapper {
        color: #fff;
      }

      .icon-people {
        background: #40c9c6;
      }

      .icon-message {
        background: #36a3f7;
      }

      .icon-money {
        background: #f4516c;
      }
    }

    .icon-people {
      color: #40c9c6;
    }

    .icon-message {
      color: #36a3f7;
    }

    .icon-money {
      color: #f4516c;
    }

    .card-panel-icon-wrapper {
      float: left;
      margin: 14px 0 0 14px;
      padding: 16px;
      transition: all 0.38s ease-out;
      border-radius: 6px;
    }

    .card-panel-icon {
      float: left;
      font-size: 48px;
    }

    .card-panel-description {
      // float: right;
      font-weight: bold;
      margin: 26px;
      margin-left: 0px;

      .card-panel-text {
        line-height: 18px;
        color: rgba(0, 0, 0, 0.45);
        font-size: 16px;
        margin-bottom: 12px;
      }

      .card-panel-num {
        font-size: 20px;
      }
    }
  }
}

@media (max-width: 550px) {
  .card-panel-description {
    display: none;
  }

  .card-panel-icon-wrapper {
    float: none !important;
    width: 100%;
    height: 100%;
    margin: 0 !important;

    .svg-icon {
      display: block;
      margin: 14px auto !important;
      float: none !important;
    }
  }
}
</style>
