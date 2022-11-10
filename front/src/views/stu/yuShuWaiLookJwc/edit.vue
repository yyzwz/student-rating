<template>
<div>
    <Card>
        <div slot="title">
            <div class="edit-head">
                <a @click="close" class="back-title">
                    <Icon type="ios-arrow-back" />返回
                </a>
                <div class="head-name">编辑</div>
                <span></span>
                <a @click="close" class="window-close">
                    <Icon type="ios-close" size="31" class="ivu-icon-ios-close" />
                </a>
            </div>
        </div>
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
    </Card>
</div>
</template>

<script>
import {
    editStudentEvaluate,
    editYuShuWai
} from "./api.js";
export default {
    name: "edit",
    components: {},
    props: {
        data: Object
    },
    data() {
        return {
            submitLoading: false,
            form: {
                userId: "",
                achievementOne: 0,
                achievementTwo: 0,
                achievementThree: 0,
                achievementSum: 0,
            },
            formValidate: {},
            dataObj: {}
        };
    },
    methods: {
        init() {
            this.dataObj = this.data;
            console.log(this.dataObj);
        },
        
        close() {
            this.$emit("close", true);
        },
        submited() {
            this.$emit("submited", true);
        }
    },
    mounted() {
        this.init();
    }
};
</script>

<style lang="less">
.edit-head {
    display: flex;
    align-items: center;
    justify-content: space-between;
    position: relative;

    .back-title {
        color: #515a6e;
        display: flex;
        align-items: center;
    }

    .head-name {
        display: inline-block;
        height: 20px;
        line-height: 20px;
        font-size: 16px;
        color: #17233d;
        font-weight: 500;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }

    .window-close {
        z-index: 1;
        font-size: 12px;
        position: absolute;
        right: 0px;
        top: -5px;
        overflow: hidden;
        cursor: pointer;

        .ivu-icon-ios-close {
            color: #999;
            transition: color .2s ease;
        }
    }

    .window-close .ivu-icon-ios-close:hover {
        color: #444;
    }
}
</style>
