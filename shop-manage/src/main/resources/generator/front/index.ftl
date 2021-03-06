<template>
  <div class="app-container">
    <div class="filter-container">
<#if hasQuery>
  <#if queryColumns??>
    <#list queryColumns as column>
      <el-input v-model="listQuery.${column.changeColumnName}" placeholder="<#if column.columnTitle != ''>${column.columnTitle}<#else>${column.changeColumnName}</#if>" style="width: 200px;" class="filter-item"/>
    </#list>
  </#if>
      <el-button v-waves class="filter-item" type="primary" icon="el-icon-search" @click="handleFilter">{{ $t('table.search') }}</el-button>
</#if>
      <el-button v-permission="'ROLE_SUPER_ADMIN'" class="filter-item" style="margin-left: 10px;" type="primary" icon="el-icon-edit" @click="handleCreate">{{ $t('table.add') }}</el-button>
    </div>
    <!--表格渲染-->
    <el-table
      v-loading="listLoading"
      :data="list"
      border
      fit
      highlight-current-row
      style="width: 100%;">
<#if columns??>
  <#list columns as column>
    <#if column.columnShow>
      <#if column.columnType != "TIMESTAMP">
      <el-table-column prop="${column.changeColumnName}" label="<#if column.columnTitle != ''>${column.columnTitle}<#else>${column.changeColumnName}</#if>"/>
      <#else>
      <el-table-column prop="${column.changeColumnName}" label="<#if column.columnTitle != ''>${column.columnTitle}<#else>${column.changeColumnName}</#if>">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.${column.changeColumnName}) }}</span>
        </template>
      </el-table-column>
      </#if>
    </#if>
  </#list>
</#if>
      <el-table-column label="操作" width="180" fixed="right" class-name="small-padding fixed-width" align="center">
        <template slot-scope="scope">
          <el-button v-permission="'ROLE_SUPER_ADMIN'" type="primary" size="mini" @click="handleModify(scope.row)">编辑</el-button>
          <el-button v-permission="'ROLE_SUPER_ADMIN'" type="danger" size="mini" @click="handleDelete(scope.row.id)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>
    <!--分页组件-->
    <pagination v-show="total>0" :total="total" :page.sync="listQuery.page" :limit.sync="listQuery.pageSize" @pagination="getList" />
    <i-form ref="dataForm" :form-data="formData"/>
  </div>
</template>

<script>
import { fetchList, del } from '@/api/${changeClassName}'
import waves from '@/directive/waves' // Waves directive
import permission from '@/directive/permission'
import Pagination from '@/components/Pagination' // Secondary package based on el-pagination
import IForm from './form'
export default {
  components: { Pagination, IForm },
  directives: { waves, permission },
  data() {
    return {
      list: null,
      total: 0,
      listLoading: true,
      listQuery: {
        page: 1,
        pageSize: 20<#if hasQuery>,</#if>
<#if hasQuery>
  <#if queryColumns??>
    <#list queryColumns as column>
        ${column.changeColumnName}: ''<#if column_has_next>,</#if>
    </#list>
  </#if>
</#if>
      },
      formData: {}
    }
  },
  created() {
    this.getList()
  },
  methods: {
    getList() {
      this.listLoading = true
      fetchList(this.listQuery).then(response => {
        this.list = response.data
        this.total = response.total

        setTimeout(() => {
          this.listLoading = false
        }, 1500)
      }).catch(() => {
        this.listLoading = false
      })
    },
    handleFilter() {
      this.listQuery.page = 1
      this.getList()
    },
    handleCreate() {
      const _this = this.$refs['dataForm']
      _this.dialogStatus = 'create'
      _this.dialogFormVisible = true
      this.formData = {}
    },
    handleModify(row) {
      this.formData = Object.assign({}, row) // copy obj
      const _this = this.$refs['dataForm']
      _this.dialogStatus = 'update'
      _this.dialogFormVisible = true
    },
    handleDelete(id) {
      del(id).then(() => {
        this.$message({
          type: 'success',
          message: '删除成功'
        })
      })
    }
  }
}
</script>

<style scoped>

</style>
