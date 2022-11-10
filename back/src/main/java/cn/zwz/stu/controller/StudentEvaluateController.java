package cn.zwz.stu.controller;

import cn.zwz.basics.utils.PageUtil;
import cn.zwz.basics.utils.ResultUtil;
import cn.zwz.basics.baseVo.PageVo;
import cn.zwz.basics.baseVo.Result;
import cn.zwz.basics.utils.SecurityUtil;
import cn.zwz.data.entity.User;
import cn.zwz.data.service.IUserService;
import cn.zwz.data.utils.ZwzNullUtils;
import cn.zwz.stu.entity.StudentEvaluate;
import cn.zwz.stu.service.IStudentEvaluateService;
import cn.hutool.core.util.StrUtil;
import cn.zwz.stu.utils.EvaluateUtils;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;
import java.util.Objects;


/**
 * @author 郑为中
 * @email 916077357@qq.com
 */
@Slf4j
@RestController
@Api(tags = "学生评价")
@RequestMapping("/zwz/studentEvaluate")
@Transactional
public class StudentEvaluateController {

    @Autowired
    private IStudentEvaluateService iStudentEvaluateService;

    @Autowired
    private EvaluateUtils evaluateUtils;

    @Autowired
    private IUserService iUserService;

    @RequestMapping(value = "/getOneByStudent", method = RequestMethod.GET)
    @ApiOperation(value = "学生查询自己的评价")
    public Result<StudentEvaluate> getOneByStudent(){
        return new ResultUtil<StudentEvaluate>().setData(evaluateUtils.getMyStudentEvaluate());
    }

    @RequestMapping(value = "/editYuShuWai", method = RequestMethod.GET)
    @ApiOperation(value = "填写语数外评价")
    public Result<StudentEvaluate> editYuShuWai(@RequestParam String id,@RequestParam float yu,@RequestParam float shu,@RequestParam float wai){
        StudentEvaluate evaluate = iStudentEvaluateService.getById(id);
        if(evaluate == null) {
            return ResultUtil.error("评价单不存在");
        }
        evaluate.setAchievementOne(BigDecimal.valueOf(yu));
        evaluate.setAchievementTwo(BigDecimal.valueOf(shu));
        evaluate.setAchievementThree(BigDecimal.valueOf(wai));
        evaluate.setAchievementSum(BigDecimal.valueOf((yu + shu + wai) / 3));
        double oneSum = (evaluate.getAchievementSum().floatValue() +  evaluate.getQuestionnaireOne().floatValue()) / 2 + evaluate.getCompetitionMine().floatValue();
        evaluate.setAnsOne(BigDecimal.valueOf(oneSum));
        double ansSum = (evaluate.getAnsOne().floatValue() + evaluate.getAnsTwo().floatValue() + evaluate.getAnsThree().floatValue()) / 3;
        evaluate.setAnsSum(BigDecimal.valueOf(ansSum));
        iStudentEvaluateService.saveOrUpdate(evaluate);
        return new ResultUtil<StudentEvaluate>().setData(iStudentEvaluateService.getById(id));
    }

    @RequestMapping(value = "/editXueYeZiPing", method = RequestMethod.GET)
    @ApiOperation(value = "填写学业自评问卷分")
    public Result<Object> editXueYeZiPing(@RequestParam float grade){
        StudentEvaluate evaluate = evaluateUtils.getMyStudentEvaluate();
        evaluate.setQuestionnaireOne(BigDecimal.valueOf(grade));
        double oneSum = (evaluate.getAchievementSum().floatValue() +  evaluate.getQuestionnaireOne().floatValue()) / 2 + evaluate.getCompetitionMine().floatValue();
        evaluate.setAnsOne(BigDecimal.valueOf(oneSum));
        double ansSum = (evaluate.getAnsOne().floatValue() + evaluate.getAnsTwo().floatValue() + evaluate.getAnsThree().floatValue()) / 3;
        evaluate.setAnsSum(BigDecimal.valueOf(ansSum));
        iStudentEvaluateService.saveOrUpdate(evaluate);
        return ResultUtil.success();
    }

    @RequestMapping(value = "/editPinDeZiPing", method = RequestMethod.GET)
    @ApiOperation(value = "填写品德自评问卷分")
    public Result<Object> editPinDeZiPing(@RequestParam float grade){
        StudentEvaluate evaluate = evaluateUtils.getMyStudentEvaluate();
        evaluate.setQuestionnaireTwo(BigDecimal.valueOf(grade));
        double twoSum = (evaluate.getQuestionnaireTwo().floatValue() +  evaluate.getQuestionnaireThree().floatValue()) / 2;
        evaluate.setAnsTwo(BigDecimal.valueOf(twoSum));
        double ansSum = (evaluate.getAnsOne().floatValue() + evaluate.getAnsTwo().floatValue() + evaluate.getAnsThree().floatValue()) / 3;
        evaluate.setAnsSum(BigDecimal.valueOf(ansSum));
        iStudentEvaluateService.saveOrUpdate(evaluate);
        return ResultUtil.success();
    }

    @RequestMapping(value = "/editPinDeTaPing", method = RequestMethod.GET)
    @ApiOperation(value = "填写品德教评问卷分")
    public Result<Object> editPinDeTaPing(@RequestParam String id,@RequestParam float grade){
        StudentEvaluate evaluate = iStudentEvaluateService.getById(id);
        if(evaluate == null) {
            return ResultUtil.error("学生评价单不存在");
        }
        evaluate.setQuestionnaireThree(BigDecimal.valueOf(grade));
        double twoSum = (evaluate.getQuestionnaireTwo().floatValue() +  evaluate.getQuestionnaireThree().floatValue()) / 2;
        evaluate.setAnsTwo(BigDecimal.valueOf(twoSum));
        double ansSum = (evaluate.getAnsOne().floatValue() + evaluate.getAnsTwo().floatValue() + evaluate.getAnsThree().floatValue()) / 3;
        evaluate.setAnsSum(BigDecimal.valueOf(ansSum));
        iStudentEvaluateService.saveOrUpdate(evaluate);
        return ResultUtil.success();
    }

    @RequestMapping(value = "/editShenXinZiPing", method = RequestMethod.GET)
    @ApiOperation(value = "填写身心自评问卷分")
    public Result<Object> editShenXinZiPing(@RequestParam float grade){
        StudentEvaluate evaluate = evaluateUtils.getMyStudentEvaluate();
        evaluate.setQuestionnaireFour(BigDecimal.valueOf(grade));
        double threeSum = (evaluate.getQuestionnaireFour().floatValue() + evaluate.getQuestionnaireSix().floatValue() + evaluate.getQuestionnaireSeven().floatValue()) / 3;
        evaluate.setAnsThree(BigDecimal.valueOf(threeSum));
        double ansSum = (evaluate.getAnsOne().floatValue() + evaluate.getAnsTwo().floatValue() + evaluate.getAnsThree().floatValue()) / 3;
        evaluate.setAnsSum(BigDecimal.valueOf(ansSum));
        iStudentEvaluateService.saveOrUpdate(evaluate);
        return ResultUtil.success();
    }

    @RequestMapping(value = "/editShenXinTaPing", method = RequestMethod.GET)
    @ApiOperation(value = "填写品身心教评问卷分")
    public Result<Object> editShenXinTaPing(@RequestParam String id,@RequestParam float grade){
        StudentEvaluate evaluate = iStudentEvaluateService.getById(id);
        if(evaluate == null) {
            return ResultUtil.error("学生评价单不存在");
        }
        evaluate.setQuestionnaireSix(BigDecimal.valueOf(grade));
        double threeSum = (evaluate.getQuestionnaireFour().floatValue() + evaluate.getQuestionnaireSix().floatValue() + evaluate.getQuestionnaireSeven().floatValue()) / 3;
        evaluate.setAnsThree(BigDecimal.valueOf(threeSum));
        double ansSum = (evaluate.getAnsOne().floatValue() + evaluate.getAnsTwo().floatValue() + evaluate.getAnsThree().floatValue()) / 3;
        evaluate.setAnsSum(BigDecimal.valueOf(ansSum));
        iStudentEvaluateService.saveOrUpdate(evaluate);
        return ResultUtil.success();
    }

    @RequestMapping(value = "/editSports", method = RequestMethod.GET)
    @ApiOperation(value = "填写体育分数")
    public Result<StudentEvaluate> editSports(@RequestParam String id,@RequestParam float sports){
        StudentEvaluate evaluate = iStudentEvaluateService.getById(id);
        if(evaluate == null) {
            return ResultUtil.error("评价单不存在");
        }
        evaluate.setQuestionnaireSeven(BigDecimal.valueOf(sports));
        double threeSum = (evaluate.getQuestionnaireFour().floatValue() + evaluate.getQuestionnaireSix().floatValue() + evaluate.getQuestionnaireSeven().floatValue()) / 3;
        evaluate.setAnsThree(BigDecimal.valueOf(threeSum));
        double ansSum = (evaluate.getAnsOne().floatValue() + evaluate.getAnsTwo().floatValue() + evaluate.getAnsThree().floatValue()) / 3;
        evaluate.setAnsSum(BigDecimal.valueOf(ansSum));
        iStudentEvaluateService.saveOrUpdate(evaluate);
        return new ResultUtil<StudentEvaluate>().setData(iStudentEvaluateService.getById(id));
    }

    @RequestMapping(value = "/getOne", method = RequestMethod.GET)
    @ApiOperation(value = "查询单条学生评价")
    public Result<StudentEvaluate> get(@RequestParam String id){
        return new ResultUtil<StudentEvaluate>().setData(iStudentEvaluateService.getById(id));
    }

    @RequestMapping(value = "/count", method = RequestMethod.GET)
    @ApiOperation(value = "查询全部学生评价个数")
    public Result<Long> getCount(){
        return new ResultUtil<Long>().setData(iStudentEvaluateService.count());
    }

    @RequestMapping(value = "/getAll", method = RequestMethod.GET)
    @ApiOperation(value = "查询全部学生评价")
    public Result<List<StudentEvaluate>> getAll(){
        return new ResultUtil<List<StudentEvaluate>>().setData(iStudentEvaluateService.list());
    }

    @RequestMapping(value = "/getAllOnSports", method = RequestMethod.GET)
    @ApiOperation(value = "查询全部学生评价-体育打分")
    public Result<List<StudentEvaluate>> getAllOnSports(@RequestParam(required = false,defaultValue = "") String username,@RequestParam(required = false,defaultValue = "0") Float grades1,@RequestParam(required = false,defaultValue = "100") Float grades2){
        QueryWrapper<StudentEvaluate> qw = new QueryWrapper<>();
        // qw.inSql("id","select id from a_student_evaluate where user_id in ( select id from a_user where department_title not like '教师组' )");
        qw.inSql("id","select id from a_student_evaluate where user_id in ( select id from a_user where username like '%" + username + "%' )");
        qw.inSql("id","select id from a_student_evaluate where user_id in ( select distinct user_id from a_user where nickname not like '%老师%')");
        qw.ge("ans_sum",grades1);
        qw.le("ans_sum",grades2);
        List<StudentEvaluate> studentEvaluateList = iStudentEvaluateService.list(qw);
        for (StudentEvaluate se : studentEvaluateList) {
            if(!ZwzNullUtils.isNull(se.getUserId())) {
                User user = iUserService.getById(se.getUserId());
                if(user != null) {
                    se.setUserName(user.getNickname());
                    se.setUserClass(user.getDepartmentTitle());
                }
            }
        }
        return new ResultUtil<List<StudentEvaluate>>().setData(studentEvaluateList);
    }

    @RequestMapping(value = "/getByPage", method = RequestMethod.GET)
    @ApiOperation(value = "查询学生评价")
    public Result<IPage<StudentEvaluate>> getByPage(@ModelAttribute StudentEvaluate studentEvaluate ,@ModelAttribute PageVo page){
        QueryWrapper<StudentEvaluate> qw = new QueryWrapper<>();
        if(!ZwzNullUtils.isNull(studentEvaluate.getCreateBy())) {
        }
        IPage<StudentEvaluate> data = iStudentEvaluateService.page(PageUtil.initMpPage(page),qw);
        return new ResultUtil<IPage<StudentEvaluate>>().setData(data);
    }

    @RequestMapping(value = "/insertOrUpdate", method = RequestMethod.POST)
    @ApiOperation(value = "增改学生评价")
    public Result<StudentEvaluate> saveOrUpdate(StudentEvaluate studentEvaluate){
        if(iStudentEvaluateService.saveOrUpdate(studentEvaluate)){
            return new ResultUtil<StudentEvaluate>().setData(studentEvaluate);
        }
        return ResultUtil.error();
    }

    @RequestMapping(value = "/insert", method = RequestMethod.POST)
    @ApiOperation(value = "新增学生评价")
    public Result<StudentEvaluate> insert(StudentEvaluate studentEvaluate){
        iStudentEvaluateService.saveOrUpdate(studentEvaluate);
        return new ResultUtil<StudentEvaluate>().setData(studentEvaluate);
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ApiOperation(value = "编辑学生评价")
    public Result<StudentEvaluate> update(StudentEvaluate studentEvaluate){
        iStudentEvaluateService.saveOrUpdate(studentEvaluate);
        return new ResultUtil<StudentEvaluate>().setData(studentEvaluate);
    }

    @RequestMapping(value = "/delByIds", method = RequestMethod.POST)
    @ApiOperation(value = "删除学生评价")
    public Result<Object> delByIds(@RequestParam String[] ids){
        for(String id : ids){
            iStudentEvaluateService.removeById(id);
        }
        return ResultUtil.success();
    }
}
