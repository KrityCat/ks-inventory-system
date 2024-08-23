<template>
  <!-- 销售单据制作 -->
  <div class="app-container">
    <el-row :gutter="10">
      <el-col :span="24" :xs="24">
        <el-form
          :inline="true"
          label-width="100px"
          :model="form"
          ref="orderRef"
          :rules="rules"
        >
          <el-form-item label="系统单号" prop="systematicReceipt">
            <el-input
              class="form-item"
              v-model="form.systematicReceipt"
              disabled
            ></el-input>
          </el-form-item>
          <el-form-item label="原始单号" prop="originalReceipt">
            <el-input
              v-model="form.originalReceipt"
              class="form-item"
              clearable
            />
          </el-form-item>
          <el-form-item label="单据类型" prop="receiptType">
            <el-radio-group class="form-item" v-model="form.receiptType">
              <el-radio-button
                label="3"
                :value="3"
                @change="outbound"
                v-hasPermi="['sales:salesReceiptProcessing:Outbound']"
                >销售出库</el-radio-button
              >
              <el-radio-button
                label="4"
                :value="4"
                @change="retreat"
                v-hasPermi="['sales:salesReceiptProcessing:retreat']"
                >销售退库</el-radio-button
              >
            </el-radio-group>
          </el-form-item>
          <el-form-item label="单据状态" prop="receiptStatus">
            <el-radio-group class="form-item" v-model="form.receiptStatus">
              <el-radio-button label="1" :value="1">待审核</el-radio-button>
              <el-radio-button label="2" :value="2" :disabled="takeEffect"
                >已审核</el-radio-button
              >
            </el-radio-group>
          </el-form-item>
          <el-form-item label="出货日期" prop="invoiceDate">
            <el-date-picker
              v-model="form.invoiceDate"
              type="date"
              placeholder="请选择出货日期"
              format="YYYY/MM/DD"
              value-format="YYYY-MM-DD"
            ></el-date-picker>
          </el-form-item>
          <el-form-item label="调出仓库" prop="retrievalIds" v-if="retrieval">
            <el-select
              class="form-item"
              v-model="form.retrievalIds"
              placeholder="请输入仓库"
              filterable
              clearable
              remote
              :remote-method="remoteWarehouse"
              :loading="loading"
              remote-show-suffix
            >
              <el-option
                v-for="item in warehouseOptions"
                :key="item.warehouseId"
                :label="item.warehouseName"
                :value="item.warehouseId"
              ></el-option>
            </el-select>
          </el-form-item>
          <el-form-item
            label="调入仓库"
            prop="warehousingIds"
            v-if="warehousing"
          >
            <el-select
              class="form-item"
              v-model="form.warehousingIds"
              placeholder="请输入仓库"
              filterable
              clearable
              remote
              :remote-method="remoteWarehouse"
              :loading="loading"
              remote-show-suffix
            >
              <el-option
                v-for="item in warehouseOptions"
                :key="item.warehouseId"
                :label="item.warehouseName"
                :value="item.warehouseId"
              ></el-option>
            </el-select>
          </el-form-item>
          <el-form-item
            label="经手人"
            prop="userIds"
            v-hasPermi="['sales:salesReceiptProcessing:selectUser']"
          >
            <el-select
              class="form-item"
              v-model="form.userIds"
              placeholder="请选择"
              filterable
              clearable
            >
              <el-option
                v-for="item in userOptions"
                :key="item.userId"
                :label="item.userName"
                :value="item.userId"
              ></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="客户" prop="customerIds">
            <el-select
              class="form-item"
              v-model="form.customerIds"
              placeholder="请输入客户"
              filterable
              clearable
              remote
              :remote-method="remoteCustomer"
              :loading="loading"
              remote-show-suffix
            >
              <el-option
                v-for="item in customerOptions"
                :key="item.customerId"
                :label="item.customerName"
                :value="item.customerId"
              ></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="计划单号" prop="planReceipt">
            <el-input v-model="form.planReceipt" class="form-item" clearable />
          </el-form-item>
          <el-form-item label="备注" prop="receiptNotes">
            <el-input
              v-model="form.receiptNotes"
              class="form-item"
              type="textarea"
            />
          </el-form-item>
          <el-form-item label="定金" prop="deposit">
            <el-input
              v-model="form.deposit"
              class="form-item"
              clearable
              oninput="value=value.replace(/[^0-9.]/g,'').replace(/\.{2,}/g,'.').replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3')"
            />
          </el-form-item>
          <el-form-item label="总金额" prop="totalAmount">
            <el-input
              v-model="form.totalAmount"
              class="form-item"
              disabled="disabled"
              :formatter="
                (value) => `￥ ${value}`.replace(/\B(?=(\d{3})+(?!\d))/g, ',')
              "
              :parser="(value) => value.replace(/\￥\s?|(,*)/g, '')"
            />
          </el-form-item>
          <el-form-item label="总金额(大写)" prop="capitalizeTotalAmount">
            <el-input
              v-model="form.capitalizeTotalAmount"
              class="form-item"
              disabled="disabled"
            />
          </el-form-item>
          <el-form-item label="是否售后安装" prop="afterSalesInstallation">
            <el-radio-group
              class="form-item"
              v-model="form.afterSalesInstallation"
            >
              <el-radio-button label="0" :value="0">是</el-radio-button>
              <el-radio-button label="1" :value="1">否</el-radio-button>
            </el-radio-group>
          </el-form-item>
          <div v-if="finding">
            <el-divider />
            <el-form-item
              label="审核结果"
              prop="findingOfAudit"
              :disabled="['sales:salesReceiptProcessing:takeEffect']"
            >
              <el-select
                v-model="form.findingOfAudit"
                filterable
                clearable
                class="form-item"
              >
                <el-option
                  v-for="dict in finding_of_audit"
                  :key="dict.value"
                  :label="dict.label"
                  :value="dict.value"
                />
              </el-select>
            </el-form-item>
            <el-form-item
              label="审核意见"
              prop="reviewComments"
              :disabled="['sales:salesReceiptProcessing:takeEffect']"
            >
              <el-input
                v-model="form.reviewComments"
                clearable
                style="width: 530px"
              />
            </el-form-item>
          </div>
        </el-form>
        <div>
          <div>
            <el-row :gutter="10">
              <el-col :span="1.5">
                <div>货品明细</div>
              </el-col>
            </el-row>
          </div>
          <div>
            <el-table
              border
              :data="form.details"
              show-summary
              :summary-method="getSummaries"
            >
              <el-table-column
                label="序号"
                align="center"
                type="index"
                width="60"
              />
              <el-table-column
                label="货品编号"
                align="center"
                prop="productCode"
                width="180"
              >
                <template #default="scope">
                  <el-select
                    v-model="scope.row.productCode"
                    placeholder="请输入货品编号"
                    @change="changeProduct(scope.$index, scope.row)"
                    filterable
                    remote
                    :remote-method="remoteProductCode"
                    :loading="loading"
                    remote-show-suffix
                  >
                    <el-option
                      v-for="item in productOptions"
                      :key="item.productId"
                      :label="item.productCode"
                      :value="item.productId"
                    ></el-option>
                  </el-select>
                </template>
              </el-table-column>
              <el-table-column
                label="货品名称"
                align="center"
                prop="productName"
                width="300"
              >
                <template #default="scope">
                  <el-select
                    v-model="scope.row.productName"
                    placeholder="请输入货品名称"
                    @change="changeProduct(scope.$index, scope.row)"
                    filterable
                    remote
                    :remote-method="remoteProductName"
                    :loading="loading"
                    remote-show-suffix
                  >
                    <el-option
                      v-for="item in productOptions"
                      :key="item.productId"
                      :label="item.productName"
                      :value="item.productId"
                    ></el-option>
                  </el-select>
                </template>
              </el-table-column>
              <el-table-column
                label="类型"
                align="center"
                prop="productTypeName"
              />
              <el-table-column
                label="规格"
                align="center"
                prop="productSpecifications"
                width="100"
              >
                <template #default="scope">
                  <el-input
                    v-model="scope.row.productSpecifications"
                  ></el-input>
                </template>
              </el-table-column>
              <el-table-column label="单位" align="center" prop="measureUnit">
                <template #default="scope">
                  <el-input v-model="scope.row.measureUnit"></el-input>
                </template>
              </el-table-column>
              <el-table-column label="产地" align="center" prop="producer" />
              <el-table-column
                label="库存数量"
                align="center"
                prop="inventoryQty"
              />
              <el-table-column
                label="数量"
                align="center"
                prop="planQuantity"
                width="100"
              >
                <template #default="scope">
                  <el-input
                    v-model="scope.row.planQuantity"
                    @change="calculateDetails(scope.row)"
                    oninput="value=value.replace(/[^0-9.]/g,'').replace(/\.{2,}/g,'.').replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2')"
                  ></el-input>
                </template>
              </el-table-column>
              <el-table-column
                label="单价"
                align="center"
                prop="univalence"
                width="150"
              >
                <template #default="scope">
                  <el-input
                    v-model="scope.row.univalence"
                    @change="calculateDetails(scope.row)"
                    oninput="value=value.replace(/[^0-9.]/g,'').replace(/\.{2,}/g,'.').replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3')"
                  ></el-input>
                </template>
              </el-table-column>
              <el-table-column
                label="折扣"
                align="center"
                prop="discount"
                width="80"
              >
                <template #default="scope">
                  <el-input
                    v-model="scope.row.discount"
                    @change="calculateDetails(scope.row)"
                    oninput="value=value.replace(/[^0-9.]/g,'').replace(/\.{2,}/g,'.').replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3')"
                  ></el-input>
                </template>
              </el-table-column>
              <el-table-column
                label="金额"
                align="center"
                prop="money"
                width="150"
              >
                <template #default="scope">
                  <el-input
                    v-model="scope.row.money"
                    oninput="value=value.replace(/[^0-9.]/g,'').replace(/\.{2,}/g,'.').replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3')"
                  ></el-input>
                </template>
              </el-table-column>
              <el-table-column
                label="成本"
                align="center"
                prop="cost"
                width="180"
              >
                <template #default="scope">
                  <el-input
                    v-model="scope.row.cost"
                    oninput="value=value.replace(/[^0-9.]/g,'').replace(/\.{2,}/g,'.').replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3')"
                  ></el-input>
                </template>
              </el-table-column>
              <el-table-column label="备注" align="center" width="180">
                <template #default="scope">
                  <el-input v-model="scope.row.remarks"></el-input>
                </template>
              </el-table-column>
              <el-table-column fixed="right" label="操作" align="center">
                <template #default="scope">
                  <el-button
                    type="danger"
                    plain
                    round
                    @click="form.details.splice(scope.$index, 1)"
                    >删除</el-button
                  >
                </template>
              </el-table-column>
            </el-table>
          </div>
          <el-affix class="tc mt16 footer" position="bottom" :offset="20">
            <el-button
              color="#BB5500"
              icon="Plus"
              round
              @click="addOrder"
              v-hasPermi="['sales:salesReceiptProcessing:add']"
              >新增单据</el-button
            >
            <el-button
              color="#00AAAA"
              icon="Plus"
              round
              @click="addItem"
              v-hasPermi="['sales:salesReceiptProcessing:detail']"
              >添加明细</el-button
            >
            <el-button
              color="#626aef"
              icon="Upload"
              round
              @click="customerAdd"
              v-hasPermi="['baseDate:customer:add']"
              >新增客户</el-button
            >
            <el-button
              type="warning"
              icon="Upload"
              round
              @click="handleAdd"
              v-hasPermi="['baseDate:product:add']"
              >新增货品</el-button
            >
            <el-button
              @click="submitForm"
              type="primary"
              icon="position"
              round
              v-hasPermi="['sales:salesReceiptProcessing:save']"
              >保存单据</el-button
            >
            <el-button
              @click="takeEffectForm"
              type="success"
              icon="Check"
              round
              :disabled="takeEffectBtn"
              v-hasPermi="['sales:salesReceiptProcessing:takeEffect']"
              >审核单据</el-button
            >
            <el-button
              @click="printOut"
              color="#626aef"
              icon="Printer"
              round
              :disabled="printBtn"
              v-hasPermi="['sales:salesReceiptProcessing:printOut']"
              >打印单据</el-button
            >
            <el-tooltip
              class="box-item"
              content="删除单据，重新制作"
              placement="top"
            >
              <el-button
                @click="deleteOrder"
                type="danger"
                icon="delete"
                round
                :disabled="printBtn"
                v-hasPermi="['sales:salesReceiptProcessing:delete']"
                ref="ref22"
                >删除单据</el-button
              >
            </el-tooltip>
            <el-tooltip
              class="box-item"
              content="取消制作，返回查询"
              placement="top"
            >
              <el-button type="info" round icon="close" @click="cancel"
                >取消制作</el-button
              >
            </el-tooltip>
          </el-affix>
        </div>
      </el-col>
    </el-row>
  </div>

  <!-- 添加客户配置对话框 -->
  <el-dialog
    :title="titleCustomer"
    v-model="openCustomer"
    width="700px"
    append-to-body
  >
    <el-form
      :model="customerForm"
      :rules="rules"
      ref="customerRef"
      label-width="80px"
    >
      <el-row>
        <el-col :span="12">
          <el-form-item label="客户编号" prop="customerCode">
            <el-input
              v-model="customerForm.customerCode"
              placeholder="请输入客户编号"
              maxlength="30"
            />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="客户名称" prop="customerName">
            <el-input
              v-model="customerForm.customerName"
              placeholder="请输入客户名称"
              maxlength="30"
            />
          </el-form-item>
        </el-col>
      </el-row>
      <el-row>
        <el-col :span="12">
          <el-form-item label="业务员" prop="customerSalesPerson">
            <el-input
              v-model="customerForm.customerSalesPerson"
              placeholder="请输入业务员"
              maxlength="30"
            />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="联系人" prop="customerContacts">
            <el-input
              v-model="customerForm.customerContacts"
              placeholder="请输入联系人"
              maxlength="30"
            />
          </el-form-item>
        </el-col>
      </el-row>
      <el-row>
        <el-col :span="12">
          <el-form-item label="联系电话" prop="customerContactNumber">
            <el-input
              v-model="customerForm.customerContactNumber"
              placeholder="请输入联系电话"
              maxlength="30"
            />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="邮编" prop="customerPostalCode">
            <el-input
              v-model="customerForm.customerPostalCode"
              placeholder="请输入邮编"
              maxlength="30"
            />
          </el-form-item>
        </el-col>
      </el-row>
      <el-row>
        <el-col :span="12">
          <el-form-item label="期初欠款" prop="customerOpeningDebt">
            <el-input
              v-model="customerForm.customerOpeningDebt"
              placeholder="请输入期初欠款"
              maxlength="30"
            />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="开户银行" prop="customerOpeningBank">
            <el-input
              v-model="customerForm.customerOpeningBank"
              placeholder="请输入开户银行"
              maxlength="30"
            />
          </el-form-item>
        </el-col>
      </el-row>
      <el-row>
        <el-col :span="12">
          <el-form-item label="银行账号" prop="customerAccountNumber">
            <el-input
              v-model="customerForm.customerAccountNumber"
              placeholder="请输入银行账号"
              maxlength="30"
            />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="纳税号" prop="customerTaxId">
            <el-input
              v-model="customerForm.customerTaxId"
              placeholder="请输入纳税号"
              maxlength="30"
            />
          </el-form-item>
        </el-col>
      </el-row>
      <el-row>
        <el-col :span="12">
          <el-form-item label="公司主页" prop="customerCompanyHomepage">
            <el-input
              v-model="customerForm.customerCompanyHomepage"
              placeholder="请输入公司主页"
              maxlength="30"
            />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="电子邮箱" prop="customerEmail">
            <el-input
              v-model="customerForm.customerEmail"
              placeholder="请输入电子邮箱"
              maxlength="30"
            />
          </el-form-item>
        </el-col>
      </el-row>
      <el-row>
        <el-col :span="12">
          <el-form-item label="公司法人" prop="customerLegalPerson">
            <el-input
              v-model="customerForm.customerLegalPerson"
              placeholder="请输入公司法人"
              maxlength="30"
            />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="状态" prop="status">
            <el-select
              v-model="customerForm.status"
              placeholder="请选择"
              clearable
            >
              <el-option
                v-for="dict in sys_normal_disable"
                :key="dict.value"
                :label="dict.label"
                :value="dict.value"
              />
            </el-select>
          </el-form-item>
        </el-col>
      </el-row>
      <el-row>
        <el-col :span="24">
          <el-form-item label="单位地址" prop="customerWorkAddress">
            <el-input
              v-model="customerForm.customerWorkAddress"
              placeholder="请输入单位地址"
            />
          </el-form-item>
        </el-col>
      </el-row>
      <el-row>
        <el-col :span="24">
          <el-form-item label="备注">
            <el-input
              v-model="customerForm.remarks"
              type="textarea"
              placeholder="请输入备注"
            />
          </el-form-item>
        </el-col>
      </el-row>
    </el-form>
    <template #footer>
      <div class="dialog-footer">
        <el-button type="primary" @click="submitCustomerForm">确 定</el-button>
        <el-button @click="cancelCustomerForm">取 消</el-button>
      </div>
    </template>
  </el-dialog>

  <!-- 添加货品配置对话框 -->
  <el-dialog :title="title" v-model="open" width="600px" append-to-body>
    <el-form
      :model="productForm"
      :rules="rules"
      ref="productRef"
      label-width="80px"
    >
      <el-row>
        <el-col :span="12">
          <el-form-item label="货品编号" prop="productCode">
            <el-input
              v-model="productForm.productCode"
              placeholder="请输入货品编号"
              maxlength="30"
            />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="货品名称" prop="productName">
            <el-input
              v-model="productForm.productName"
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
              v-model="productForm.productType"
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
              v-model="productForm.productSpecifications"
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
              v-model="productForm.measureUnit"
              placeholder="请输入计量单位"
              maxlength="30"
            />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="货品条码" prop="productBarcode">
            <el-input
              v-model="productForm.productBarcode"
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
              v-model="productForm.producer"
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
              v-model="productForm.costPrice"
              placeholder="请输入成本价"
              maxlength="30"
            />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="参考售价" prop="univalence">
            <el-input
              v-model="productForm.univalence"
              placeholder="请输入参考售价"
              maxlength="30"
            />
          </el-form-item>
        </el-col>
      </el-row>
      <el-row>
        <el-col :span="12">
          <el-form-item label="销售折扣" prop="discount">
            <el-input
              v-model="form.discount"
              placeholder="请输入销售折扣"
              maxlength="30"
            />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="库存数量" prop="costPrice">
            <el-input
              v-model="form.inventoryQty"
              placeholder="系统自动计算"
              disabled
            />
          </el-form-item>
        </el-col>
      </el-row>
      <el-row>
        <el-col :span="12">
          <el-form-item label="库存上限" prop="upperLimit">
            <el-input
              v-model="productForm.upperLimit"
              placeholder="请输入库存上限"
              maxlength="30"
            />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="库存下限" prop="lowerLimit">
            <el-input
              v-model="productForm.lowerLimit"
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
              v-model="productForm.defaultWarehouse"
              placeholder="请输入默认仓库"
              maxlength="30"
            />
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="状态">
            <el-radio-group v-model="productForm.status">
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
              v-model="productForm.notes"
              type="textarea"
              placeholder="请输入内容"
            ></el-input>
          </el-form-item>
        </el-col>
      </el-row>
    </el-form>
    <template #footer>
      <div class="dialog-footer">
        <el-button type="primary" @click="submitProductForm">确 定</el-button>
        <el-button @click="cancelProductForm">取 消</el-button>
      </div>
    </template>
  </el-dialog>
</template>

<script setup name="salesDocumentProcessing">
import { getToken } from "@/utils/auth";
import { useRouter } from "vue-router";
import { listUser, getUserProfile } from "@/api/system/user";
import { listCustomer, addCustomer } from "@/api/basedate/customer";
import { listWarehouse } from "@/api/basedate/warehouse";
import {
  addProduct,
  listProduct,
  productTypeTreeSelect,
} from "@/api/basedate/product";
import {
  getSalesOrder,
  saveSalesReceipt,
  delSalesReceipt,
} from "@/api/sales/salesDocumentProcessing";
import { viewUrl } from "@/api/jimu/jiMuReport";
import { saveSalesOrder } from "@/api/sales/salesOrderProcessing";
import { saveAfterSales } from "@/api/aftersales/afterSalesOrderProcessing";
import { randomId } from "@/utils/RandomUtils";
import RMBConverter from "@/utils/RMBConverter";
import { ref } from "vue";

const { proxy } = getCurrentInstance();
const { finding_of_audit } = proxy.useDict("finding_of_audit");
const { print_selected_files } = proxy.useDict("print_selected_files");
const { sys_normal_disable } = proxy.useDict("sys_normal_disable");
const { print_selected_sizes } = proxy.useDict("print_selected_sizes");

// 订单状态下拉框
const takeEffect = ref(false);
const takeEffectBtn = ref(false);
const finding = ref(false);
const printBtn = ref(false);
const retrieval = ref(true);
const warehousing = ref(false);
const loading = ref(false);
const router = useRouter();
const printOptions = ref(undefined);
const openUrl = ref("");
// 窗口标题
const title = ref("");
const open = ref(false);
const openCustomer = ref(false);
const titleCustomer = ref("");

const data = reactive({
  userOptions: undefined,
  customerOptions: undefined,
  warehouseOptions: undefined,
  productOptions: undefined,
  typeOptions: undefined,
  option: {
    warehouseId: undefined,
    warehouseName: undefined,
    supplierId: undefined,
    supplierName: undefined,
    customerId: undefined,
    customerName: undefined,
    productCode: undefined,
    productName: undefined,
    pageSize: 50,
  },
  customerForm: {},
  productForm: {
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
  // 表单参数
  form: {
    details: [],
    systematicReceipt: null,
    originalReceipt: null,
    receiptType: 3,
    receiptCategory: 2,
    receiptStatus: null,
    retrievalIds: null,
    warehousingIds: null,
    customerIds: null,
    userIds: null,
    invoiceDate: null,
    planReceipt: null,
    receiptNotes: null,
    deposit: null,
    totalAmount: null,
    capitalizeTotalAmount: null,
    afterSalesInstallation: null,
    findingOfAudit: null,
    reviewComments: null,
    // 销售订单
    systematicOrderForm: null,
    originalOrderForm: null,
    orderFormType: 2,
    orderFormStatus: 2,
    deliveryDate: null,
    orderFormNotes: null,
    orderFormAmount: null,
    orderCapitalizeAmount: null,
    // 售后安装单
    serviceType: 1,
    // 打印ID
    printId: null,
    printSize: undefined,
  },
  // 表单校验
  rules: {
    receiptType: [
      { required: true, message: "单据类型不能不选", trigger: "blur" },
    ],
    warehousingIds: [
      { required: true, message: "调入仓库不能为空", trigger: "blur" },
    ],
    retrievalIds: [
      { required: true, message: "调出仓库不能为空", trigger: "blur" },
    ],
    userIds: [{ required: true, message: "经手人不能为空", trigger: "blur" }],
    customerIds: [{ required: true, message: "客户不能为空", trigger: "blur" }],
    deliveryDate: [
      { required: true, message: "交货日期不能为空", trigger: "blur" },
    ],
    customerCode: [
      { required: true, message: "客户编号不能为空", trigger: "blur" },
      { max: 30, message: "客户编号长度不能大于 30 ", trigger: "blur" },
    ],
    customerName: [
      { required: true, message: "客户名称不能为空", trigger: "blur" },
      { max: 30, message: "客户名称长度不能大于 30 ", trigger: "blur" },
    ],
    status: [{ required: true, message: "状态不能为空", trigger: "blur" }],
    customerEmail: [
      {
        type: "email",
        message: "请输入正确的邮箱地址",
        trigger: ["blur", "change"],
      },
    ],
    customerContactNumber: [
      {
        pattern: /^1[3|4|5|6|7|8|9][0-9]\d{8}$/,
        message: "请输入正确的手机号码",
        trigger: "blur",
      },
    ],
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

const {
  userOptions,
  customerOptions,
  warehouseOptions,
  productOptions,
  typeOptions,
  option,
  customerForm,
  productForm,
  form,
  rules,
} = toRefs(data);

function initialization() {
  const { systematicReceipt } = proxy.$route.query;
  if (systematicReceipt) {
    loadDetail(systematicReceipt);
  } else {
    reset();
    takeEffect.value = true;
    takeEffectBtn.value = true;
    printBtn.value = true;
  }
}
function getNowTime() {
  var now = new Date();
  var year = now.getFullYear(); //得到年份
  var month = now.getMonth(); //得到月份
  var date = now.getDate(); //得到日期
  month = month + 1;
  month = month.toString().padStart(2, "0");
  date = date.toString().padStart(2, "0");
  var defaultDate = `${year}-${month}-${date}`;
  return defaultDate;
}
async function getList() {
  option.value.pageSize = 500;
  listUser(option.value).then((response) => {
    userOptions.value = response.rows;
  });
  getUserProfile().then((response) => {
    form.value.userIds = response.data.userId;
  });
  optionReset();
}
/** 新增按钮操作 */
async function addOrder() {
  await router.push({ path: "/index" });
  router.push({ path: "/sales/salesDocumentProcessing" });
}
/** 销售出库 */
function outbound() {
  form.value.systematicReceipt = "XC-" + randomId();
  retrieval.value = true;
  warehousing.value = false;
}
function retreat() {
  form.value.systematicReceipt = "XT-" + randomId();
  retrieval.value = false;
  warehousing.value = true;
}
/** 统计金额和成本 */
function calculateDetails(row) {
  row.money = row.cost = Number(
    Math.abs(row.planQuantity) * row.univalence * row.discount
  ).toFixed(2);
}
/** 取消按钮 */
function cancel() {
  router.push({ path: "/sales/salesDocumentQuery" });
}
/** 提交按钮 */
function submitForm() {
  proxy.$refs["orderRef"].validate(async (valid) => {
    if (form.value.details.length === 0) {
      proxy.$modal.msgError("货品明细不能为空");
    } else if (!valid) {
      return;
    }
    const details = form.value.details.map((it) => {
      return {
        systematicOrderForm: form.value.systematicOrderForm,
        systematicReceipt: form.value.systematicReceipt,
        productId: it.productId,
        retrievalId: form.value.retrievalIds,
        warehouseId: form.value.warehousingIds,
        customerId: form.value.customerIds,
        productSpecifications: it.productSpecifications,
        measureUnit: it.measureUnit,
        planQuantity: it.planQuantity,
        univalence: it.univalence,
        discount: it.discount,
        money: it.money,
        cost: it.cost,
        remarks: it.remarks,
      };
    });
    const reqs = { ...form.value, details };
    await saveSalesReceipt(reqs);
    await saveSalesOrder(reqs);
    proxy.$modal.msgSuccess("销售单据保存成功");
    cancel();
  });
}
/** 审核按钮 */
function takeEffectForm() {
  proxy.$refs["orderRef"].validate(async (valid) => {
    if (form.value.details.length == 0) {
      proxy.$modal.msgError("货品明细不能为空");
    } else if (!valid) {
      return;
    }
    const details = form.value.details.map((it) => {
      return {
        systematicOrderForm: form.value.systematicOrderForm,
        systematicReceipt: form.value.systematicReceipt,
        productId: it.productId,
        retrievalId: form.value.retrievalIds,
        warehouseId: form.value.warehousingIds,
        customerId: form.value.customerIds,
        productSpecifications: it.productSpecifications,
        measureUnit: it.measureUnit,
        planQuantity: it.planQuantity,
        univalence: it.univalence,
        discount: it.discount,
        money: it.money,
        cost: it.cost,
        remarks: it.remarks,
      };
    });
    form.value.receiptStatus = 2;
    const reqs = { ...form.value, details };
    await saveSalesReceipt(reqs);
    await saveSalesOrder(reqs);
    proxy.$modal.msgSuccess("销售出库单审核成功");
    if (form.value.afterSalesInstallation === 0) {
      await saveAfterSales(reqs);
      proxy.$modal.msgSuccess("售后安装单新建成功");
    }
    cancel();
  });
}
function loadDetail(systematicReceipt) {
  getSalesOrder(systematicReceipt).then((response) => {
    option.value.warehouseId = response.data.warehousingIds;
    listWarehouse(option.value).then((response) => {
      warehouseOptions.value = response.rows;
    });
    option.value.customerId = response.data.customerIds;
    listCustomer(option.value).then((response) => {
      customerOptions.value = response.rows;
    });
    optionReset();
    if (response.data.receiptStatus === 1) {
      takeEffect.value = true;
    } else if (response.data.receiptStatus === 2) {
      takeEffectBtn.value = true;
    }
    printBtn.value = false;
    finding.value = true;
    const details = response.data.details;
    const product = response.data.product;
    const map = {};
    (product || []).forEach((it) => {
      map[it.productId] = it;
    });
    form.value = {
      ...response.data,
      // 销售订单
      systematicOrderForm: response.data.systematicReceipt,
      originalOrderForm: response.data.originalReceipt,
      orderFormType: 2,
      orderFormStatus: 2,
      deliveryDate: response.data.invoiceDate,
      orderFormNotes: response.data.receiptNotes,
      orderFormAmount: response.data.totalAmount,
      orderCapitalizeAmount: response.data.capitalizeTotalAmount,
      // 售后安装单
      serviceType: 1,
      details,
    };
    form.value.warehousingIds = Number(response.data.warehousingIds);
    form.value.retrievalIds = Number(response.data.retrievalIds);
    form.value.userIds = Number(response.data.userIds);
    form.value.customerIds = Number(response.data.customerIds);
  });
}
//自定义合计行
function getSummaries(param) {
  const { columns, data } = param;
  const sums = [];
  columns.forEach((column, index) => {
    if (index === 0) {
      sums[index] = "合计";
      return;
    }

    if (column.property !== undefined) {
      const values = data.map((item) => Number(item[column.property]));
      if (!values.every((value) => isNaN(value))) {
        sums[index] = values.reduce((prev, curr) => {
          const value = Number(curr);
          if (!isNaN(value)) {
            return prev + curr;
          } else {
            return prev;
          }
        }, 0);
        if (index === 11) {
          sums[index] = Number(sums[index]).toFixed(2);
          form.value.totalAmount = sums[index];
          form.value.capitalizeTotalAmount = RMBConverter.numberToChinese(
            sums[index]
          );
        } else if (index === 12) {
          sums[index] = Number(sums[index]).toFixed(2);
        }
      } else {
        sums[index] = "";
      }
      if ([1, 2, 3, 4, 5, 6, 10].includes(index)) {
        sums[index] = "";
      }
    }
  });
  return sums;
}
// 表单重置
function reset() {
  form.value = {
    systematicReceipt: null,
    originalReceipt: null,
    receiptType: null,
    receiptCategory: 2,
    receiptStatus: 1,
    invoiceDate: getNowTime(),
    retrievalIds: null,
    warehousingIds: null,
    customerIds: null,
    userIds: null,
    planReceipt: null,
    receiptNotes: null,
    deposit: null,
    totalAmount: null,
    capitalizeTotalAmount: null,
    afterSalesInstallation: 1,
    findingOfAudit: null,
    reviewComments: null,
    // 销售订单
    systematicOrderForm: null,
    originalOrderForm: null,
    orderFormType: 2,
    orderFormStatus: 2,
    deliveryDate: null,
    orderFormNotes: null,
    orderFormAmount: null,
    orderCapitalizeAmount: null,
    // 售后安装单
    serviceType: 1,
    printId: null,
    details: [],
  };
  proxy.resetForm("orderRef");
}
/** 重置操作客户表单 */
function customerReset() {
  form.value = {
    customerCode: undefined,
    customerName: undefined,
    customerSalesPerson: undefined,
    customerContacts: undefined,
    customerContactNumber: undefined,
    customerWorkAddress: undefined,
    customerPostalCode: undefined,
    customerOpeningDebt: undefined,
    customerOpeningBank: undefined,
    customerAccountNumber: undefined,
    customerTaxId: undefined,
    customerCompanyHomepage: undefined,
    customerEmail: undefined,
    customerLegalPerson: undefined,
    status: undefined,
    remarks: undefined,
  };
  proxy.resetForm("customerRef");
}
/** 重置操作货品表单 */
function productReset() {
  productForm.value = {
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
// 添加货品
function addItem() {
  form.value.details.push({});
}
// 选择货品
function changeProduct(index, row) {
  form.value.details[index] = {
    productId: null,
    productCode: null,
    productName: null,
    productTypeName: null,
    productSpecifications: null,
    measureUnit: null,
    producer: null,
    inventoryQty: null,
    retrievalId: null,
    warehousingId: null,
  };
  let lists = [];
  productOptions.value.forEach((item) => {
    if (row.productCode == item.productId) {
      lists = item;
    } else if (row.productName == item.productId) {
      lists = item;
    }
  });
  form.value.details[index] = {
    systematicOrderForm: form.value.systematicOrderForm,
    systematicReceipt: form.value.systematicReceipt,
    productId: lists.productId,
    productCode: lists.productCode,
    productName: lists.productName,
    productTypeName: lists.productTypeName,
    productSpecifications: lists.productSpecifications,
    measureUnit: lists.measureUnit,
    producer: lists.producer,
    inventoryQty: lists.inventoryQty,
    retrievalId: form.value.retrievalIds,
    warehousingId: form.value.warehousingIds,
    customerId: form.value.customerIds,
    planQuantity: 0,
    univalence: lists.univalence,
    discount: lists.discount,
    money: 0,
    cost: 0,
    remarks: null,
  };
  form.value.details = [...form.value.details];
}
/** 打印按钮 */
async function printOut() {
  form.value.printId = print_selected_files.value[3].label;
  form.value.printSize = print_selected_sizes.value[3].label;
  await viewUrl().then((res) => {
    openUrl.value = res;
  });
  const printUrl =
    openUrl.value +
    "/" +
    form.value.printId +
    "?token=Bearer " +
    getToken() +
    "&systematicReceipt=" +
    form.value.systematicReceipt +
    "&pageSize=" +
    form.value.printSize;
  window.open(printUrl, "_blank");
}
/** 删除按钮操作 */
function deleteOrder() {
  getSalesOrder(form.value.systematicReceipt).then((response) => {
    const details = response.data.details;
    proxy.$modal
      .confirm(
        "确认要删除系统编号为" + form.value.systematicReceipt + "的销售单据?"
      )
      .then(function () {
        return delSalesReceipt(details);
      })
      .then(() => {
        proxy.$modal.msgSuccess(
          "已删除系统编号为" + form.value.systematicReceipt + "的销售单据。"
        );
        reset();
      })
      .catch(() => {});
  });
}
/** 查询货品类型下拉树结构 */
function getProductTypeTree() {
  productTypeTreeSelect().then((response) => {
    typeOptions.value = response.data;
  });
}
/** 新增客户按钮操作 */
function customerAdd() {
  customerReset();
  openCustomer.value = true;
  titleCustomer.value = "新增客户";
}
/** 提交客户按钮 */
function submitCustomerForm() {
  proxy.$refs["customerRef"].validate((valid) => {
    if (valid) {
      addCustomer(customerForm.value);
      proxy.$modal.msgSuccess(
        "已新增编号为" + customerForm.value.customerCode + "的客户"
      );
      openCustomer.value = false;
      listCustomer(option.value).then((response) => {
        customerOptions.value = response.rows;
      });
    }
  });
}
/** 取消客户按钮 */
function cancelCustomerForm() {
  openCustomer.value = false;
}
/** 新增货品按钮操作 */
function handleAdd() {
  productReset();
  getProductTypeTree();
  open.value = true;
  title.value = "添加货品";
}
/** 提交货品按钮 */
function submitProductForm() {
  proxy.$refs["productRef"].validate((valid) => {
    if (valid) {
      addProduct(productForm.value);
      proxy.$modal.msgSuccess(
        "已新增编号为" + productForm.value.productCode + "的货品"
      );
      open.value = false;
      listProduct(option.value).then((response) => {
        productOptions.value = response.rows;
      });
    }
  });
}
/** 取消货品按钮 */
function cancelProductForm() {
  open.value = false;
}
/** 重置下拉框表单 */
function optionReset() {
  option.value = {
    warehouseId: undefined,
    warehouseName: undefined,
    supplierId: undefined,
    supplierName: undefined,
    customerId: undefined,
    customerName: undefined,
    productCode: undefined,
    productName: undefined,
    pageSize: 50,
  };
}
// 查询仓库名称
function remoteWarehouse(query) {
  optionReset();
  if (query) {
    loading.value = true;
    setTimeout(() => {
      option.value.warehouseName = query;
      listWarehouse(option.value).then((response) => {
        warehouseOptions.value = response.rows;
      });
      loading.value = false;
      warehouseOptions.value = list.value.filter((item) => {
        return item.label.toLowerCase().includes(query.toLowerCase());
      });
    }, 200);
  } else {
    listWarehouse(option.value).then((response) => {
      warehouseOptions.value = response.rows;
    });
  }
}
// 查询客户名称
function remoteCustomer(query) {
  optionReset();
  if (query) {
    loading.value = true;
    setTimeout(() => {
      option.value.customerName = query;
      listCustomer(option.value).then((response) => {
        customerOptions.value = response.rows;
      });
      loading.value = false;
      customerOptions.value = list.value.filter((item) => {
        return item.label.toLowerCase().includes(query.toLowerCase());
      });
    }, 200);
  } else {
    listCustomer(option.value).then((response) => {
      customerOptions.value = response.rows;
    });
  }
}
// 查询货品编号
function remoteProductCode(query) {
  optionReset();
  if (query) {
    loading.value = true;
    setTimeout(() => {
      option.value.productCode = query;
      listProduct(option.value).then((response) => {
        productOptions.value = response.rows;
      });
      loading.value = false;
      productOptions.value = list.value.filter((item) => {
        return item.label.toLowerCase().includes(query.toLowerCase());
      });
    }, 200);
  } else {
    listProduct(option.value).then((response) => {
      productOptions.value = response.rows;
    });
  }
}
// 查询货品名称
function remoteProductName(query) {
  optionReset();
  if (query) {
    loading.value = true;
    setTimeout(() => {
      option.value.productName = query;
      listProduct(option.value).then((response) => {
        productOptions.value = response.rows;
      });
      loading.value = false;
      productOptions.value = list.value.filter((item) => {
        return item.label.toLowerCase().includes(query.toLowerCase());
      });
    }, 200);
  } else {
    listProduct(option.value).then((response) => {
      productOptions.value = response.rows;
    });
  }
}

initialization();
getList();
</script>

<style scoped>
.form-item {
  width: 200px;
}
.footer {
  text-align: center;
}
</style>
