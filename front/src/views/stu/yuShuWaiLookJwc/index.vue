<template>
<div class="search">
    <edit v-if="currView=='edit'" @close="currView='index'" @submited="submited" :data="formData" />
    <Card v-show="currView=='index'">
        <Row @keydown.enter.native="handleSearch">
            <Form ref="searchForm" :model="searchForm" inline :label-width="0">
                <Form-item ref="searchForm" :model="searchForm" inline :label-width="0" style="display:flex;">
                    <Form-item label="" prop="title">
                        <Input type="text" v-model="tempFindUserName" placeholder="学号" clearable style="width: 200px" />
                    </Form-item>
                    <Form-item label="">
                        <InputNumber :max="tempFindMaxNumber" :min="1" v-model="tempFindMinNumber"></InputNumber>
                    </Form-item>-
                    <Form-item label="">
                        <InputNumber :max="100" :min="tempFindMinNumber" v-model="tempFindMaxNumber"></InputNumber>
                    </Form-item>
                    <Form-item style="margin-left:10px;" class="br">
                        <Button @click="getDataList" type="primary" icon="ios-search" size="small" ghost>搜索</Button>
                        <Button @click="getDataList" type="warning" size="small" icon="md-refresh" ghost>重置</Button>
                        <Button @click="excelData" type="success" icon="md-paper-plane" size="small" ghost>导出</Button>
                    </Form-item>
                    <!-- <Form-item style="position:fixed;right:50px;top:130px">
                        <Button type="info" @click="showFilterPanelFlag = !showFilterPanelFlag" class="showFilterPanelFlag" icon="md-settings" size="small" ghost>
                            列筛选</Button>
                        <Button type="warning" @click="modal1 = true" class="showFilterPanelFlag" icon="ios-help-circle-outline" size="small" ghost>
                            使用教程</Button>
                        <Modal v-model="modal1" title="使用教程">
                            <p>1.XXXXXXXXXXXXXXXXXXXXXXXX</p>
                            <p>2.XXXXXXXXXXXXXXXXXXXXXXXX</p>
                            <p>3.XXXXXXXXXXXXXXXXXXXXXXXX</p>
                        </Modal>
                    </Form-item> -->
                </Form-item>
            </Form>
        </Row>
        <Row class="operation" style="position:relative;">
            <transition>
                <div v-show="showFilterPanelFlag" class="filter-panel">
                    <CheckboxGroup v-model="selected">
                        <div v-for="item in mycolumns" :key="item.key">
                            <Checkbox :label="item.title" style="margin: 2px 5px"></Checkbox>
                        </div>
                    </CheckboxGroup>
                </div>
            </transition>
        </Row>
        <Row v-show="openTip"> </Row>
        <Row>
            <Table :loading="loading" :height="tableHeight" border stripe size="small" :columns="columns" :data="data" ref="table" sortable="custom" @on-sort-change="changeSort" @on-selection-change="changeSelect" @on-row-click="rowClick" :row-class-name="rowClassNmae"></Table>
        </Row>
    </Card>
</div>
</template>

<script>
import {
    getStudentEvaluateList
} from "./api.js";
import edit from "./edit.vue";
export default {
    name: "single-window",
    components: {
        edit
    },
    data() {
        return {
            tableHeight: 0,
            selected: [
                "选择",
                "序号",
                "学生姓名",
                "学生班级",
                "学业水平得分",
                "品德与社会化水平得分",
                "身心健康得分",
                "体育得分",
                "最终成绩",
                "创建时间",
                "创建者",
                "修改时间",
                "修改者",
                "操作",
            ],
            tempFindUserName: "",
            tempFindMinNumber: 0,
            tempFindMaxNumber: 100,
            modal1: false,
            openTip: true,
            formData: {},
            currView: "index",
            loading: true,
            searchForm: {
                pageNumber: 1,
                pageSize: 15,
                sort: "createTime",
                order: "desc",
            },
            selectList: [],
            selectCount: 0,
            selectRow: 0,
            columns: [{
                    type: "selection",
                    width: 60,
                    title: "选择",
                    align: "center",
                    fixed: "left",
                },
                {
                    title: "序号",
                    width: 85,
                    align: "center",
                    fixed: "left",
                    sortType: true,
                    render: (h, params) => {
                        return h(
                            "span",
                            params.index +
                            (this.searchForm.pageNumber - 1) * this.searchForm.pageSize +
                            1
                        );
                    },
                },
                {
                    title: "学生ID",
                    key: "userId",
                    minWidth: 120,
                    tooltip: true,
                    sortable: false,
                },
                {
                    title: "学生姓名",
                    key: "userName",
                    minWidth: 120,
                    tooltip: true,
                    sortable: false,
                },
                {
                    title: "学生班级",
                    key: "userClass",
                    minWidth: 120,
                    tooltip: true,
                    sortable: false,
                },
                {
                    title: "学业水平得分",
                    key: "ansOne",
                    minWidth: 200,
                    tooltip: true,
                    sortable: false,
                },
                {
                    title: "品德与社会化水平得分",
                    key: "ansTwo",
                    minWidth: 200,
                    tooltip: true,
                    sortable: false,
                },
                {
                    title: "身心健康得分",
                    key: "ansThree",
                    minWidth: 200,
                    tooltip: true,
                    sortable: false,
                },
                {
                    title: "体育得分",
                    key: "questionnaireSeven",
                    minWidth: 200,
                    tooltip: true,
                    sortable: false,
                },
                {
                    title: "最终成绩",
                    key: "ansSum",
                    minWidth: 200,
                    tooltip: true,
                    sortable: false,
                },
                {
                    title: "创建时间",
                    key: "createTime",
                    sortable: true,
                    sortType: "desc",
                    minWidth: 180,
                    align: "center",
                    tooltip: true,
                },
                {
                    title: "创建者",
                    key: "createBy",
                    sortable: true,
                    sortType: "desc",
                    minWidth: 100,
                    align: "center",
                    tooltip: true,
                },
                {
                    title: "修改时间",
                    key: "updateTime",
                    minWidth: 180,
                    align: "center",
                    tooltip: true,
                },
                {
                    title: "修改者",
                    key: "updateBy",
                    minWidth: 100,
                    align: "center",
                    tooltip: true,
                },
                {
                    title: "操作",
                    key: "action",
                    align: "center",
                    width: 150,
                    fixed: "right",
                    render: (h, params) => {
                        return h("div", [
                            h(
                                "Button", {
                                    props: {
                                        type: "primary",
                                        size: "small",
                                        icon: "ios-create-outline",
                                        ghost: true
                                    },
                                    style: {
                                        marginRight: "5px"
                                    },
                                    on: {
                                        click: () => {
                                            this.edit(params.row);
                                        }
                                    }
                                },
                                "详情"
                            ),
                        ]);
                    }
                }
            ],
            data: [],
            pageNumber: 1,
            pageSize: 10,
            total: 0,
            showFilterPanelFlag: false,
        };
    },
    methods: {
        init() {
            this.getDataList();
        },
        getDataList() {
            var that = this;
            this.loading = true;
            getStudentEvaluateList({
                username: that.tempFindUserName,
                grades1: that.tempFindMinNumber,
                grades2: that.tempFindMaxNumber
            }).then(res => {
                this.loading = false;
                if (res.success) {
                    this.data = res.result;
                }
            });
        },
        submited() {
            this.currView = "index";
            this.getDataList();
        },
        changePage(v) {
            this.searchForm.pageNumber = v;
            this.getDataList();
            this.clearSelectAll();
        },
        changePageSize(v) {
            this.searchForm.pageSize = v;
            this.getDataList();
        },
        rowClick(row, index) {
            this.selectRow = row;
        },
        rowClassNmae(row, index) {
            if (row.id == this.selectRow.id) {
                return "rowClassNmaeColor";
            }
            return "";
        },
        excelData() {
            this.$refs.table.exportCsv({
                filename: "导出结果",
            });
        },
        handleReset() {
            this.$refs.searchForm.resetFields();
            this.searchForm.pageNumber = 1;
            this.searchForm.pageSize = 15;
            this.getDataList();
        },
        changeSort(e) {
            this.searchForm.sort = e.key;
            this.searchForm.order = e.order;
            if (e.order === "normal") {
                this.searchForm.order = "";
            }
            this.getDataList();
        },
        clearSelectAll() {
            this.$refs.table.selectAll(false);
        },
        changeSelect(e) {
            this.selectList = e;
            this.selectCount = e.length;
        },
        edit(v) {
            for (let attr in v) {
                if (v[attr] == null) {
                    v[attr] = "";
                }
            }
            let str = JSON.stringify(v);
            let data = JSON.parse(str);
            this.formData = data;
            this.currView = "edit";
        },
    },
    mounted() {
        this.init();
        this.tableHeight = Number(window.innerHeight - 273);
        this.mycolumns = this.columns;
        let showcolumns = [];
        for (var i = 0; i < this.selected.length; i++) {
            var item = this.selected[i];
            for (var j = 0; j < this.columns.length; j++) {
                if (this.columns[j].title == item) {
                    showcolumns.push(this.columns[j]);
                }
            }
        }
        this.columns = showcolumns;
    },
    watch: {
        selected: function (newcolumns) {
            let showcolumns = [];
            for (var i = 0; i < this.mycolumns.length; i++) {
                var item = this.mycolumns[i];
                if (item.title == undefined) showcolumns.push(item);
                else if (newcolumns.contains(item.title)) showcolumns.push(item);
            }
            this.columns = showcolumns;
        },
    },
};
</script>

<style lang="less">
.search {
    .operation {
        margin-bottom: 2vh;
    }

    .select-count {
        font-weight: 600;
        color: #40a9ff;
    }

    .select-clear {
        margin-left: 10px;
    }

    .page {
        margin-top: 2vh;
    }

    .drop-down {
        margin-left: 5px;
    }
}

.filter-panel {
    width: 166px;
    min-height: 120px;
    height: 200px;
    position: absolute;
    background-color: white;
    z-index: 9999;
    margin-left: 1px;
    overflow-y: scroll;
    border: 1px solid blue;
    top: 35px;
    right: 10px;
}

.openSearch {
    position: absolute;
    right: 240px;
}

.openTip {
    position: absolute;
    right: 130px;
}

.showFilterPanelFlag {
    position: static !important;
    right: 10px;
    margin-right: 10px;
}

.ivu-table td {
    height: 38px !important;
}

.ivu-table-cell-with-expand {
    height: 38px !important;
    line-height: 38px !important;
}

.ivu-table .rowClassNmaeColor td {
    background-color: #b0b3b6 !important;
    color: #ffffff !important;
    font-size: 12px;
}
</style>
