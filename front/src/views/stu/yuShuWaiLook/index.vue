<template>
<div class="search">
    <Card>
        <Divider>学业发展水平</Divider>
        <Row :gitter="16">
            <Col span="6">
            <Card>语文成绩：{{dataObj.achievementOne}}</Card>
            </Col>
            <Col span="6">
            <Card>数学成绩：{{dataObj.achievementTwo}}</Card>
            </Col>
            <Col span="6">
            <Card>外语成绩：{{dataObj.achievementThree}}</Card>
            </Col>
            <Col span="6">
            <Card>均分成绩：{{dataObj.achievementSum}}</Card>
            </Col>
        </Row>
        <Row :gitter="16">
            <Col span="6">
            <Card>自评问卷分值：{{dataObj.questionnaireOne}}</Card>
            </Col>
            <Col span="6">
            <Card>获奖加分：{{dataObj.competitionMine}}</Card>
            </Col>
            <Col span="6">
            <Card>学业发展水平得分：{{dataObj.ansOne}}</Card>
            </Col>
        </Row>
        <Divider>品德与社会化水平</Divider>
        <Row :gitter="16">
            <Col span="6">
            <Card>品德自评问卷分值：{{dataObj.questionnaireTwo}}</Card>
            </Col>
            <Col span="6">
            <Card>品德教师问卷分值：{{dataObj.questionnaireThree}}</Card>
            </Col>
            <Col span="6">
            <Card>品德与社会化水平得分：{{dataObj.ansTwo}}</Card>
            </Col>
        </Row>
        <Divider>身心健康水平</Divider>
        <Row :gitter="16">
            <Col span="6">
            <Card>身心健康自评分值：{{dataObj.questionnaireFour}}</Card>
            </Col>
            <Col span="6">
            <Card>身心健康教师分值：{{dataObj.questionnaireSix}}</Card>
            </Col>
            <Col span="6">
            <Card>教务处体育成绩：{{dataObj.questionnaireSeven}}</Card>
            </Col>
            <Col span="6">
            <Card>品德与社会化水平得分：{{dataObj.ansThree}}</Card>
            </Col>
        </Row>
        <Divider>总计</Divider>
        <Row :gitter="16">
            <Col span="6">
            <Card>总分：{{dataObj.ansSum}}</Card>
            </Col>
        </Row>
    </Card>
</div>
</template>

<script>
import {
    getOneByStudent
} from "./api.js";
export default {
    name: "single-window",
    components: {},
    data() {
        return {
            dataObj: {
                achievementOne: 0,
                achievementTwo: 0,
                achievementThree: 0,
                achievementSum: 0,
                questionnaireOne: 0,
                competitionMine: 0,
                ansOne: 0
            }
        };
    },
    methods: {
        init() {
            this.getOneByStudentFx();
        },
        getOneByStudentFx() {
            var that = this;
            getOneByStudent().then(res => {
                console.log(res);
                if (res.success) {
                    that.dataObj = res.result;
                }
            })
        }
    },
    mounted() {
        this.init();
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
