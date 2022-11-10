package cn.zwz.stu.controller;

import cn.zwz.basics.utils.PageUtil;
import cn.zwz.basics.utils.ResultUtil;
import cn.zwz.basics.baseVo.PageVo;
import cn.zwz.basics.baseVo.Result;
import cn.zwz.data.utils.ZwzNullUtils;
import cn.zwz.stu.entity.Questionnaire;
import cn.zwz.stu.entity.StudentEvaluate;
import cn.zwz.stu.service.IQuestionnaireService;
import cn.zwz.stu.utils.EvaluateUtils;
import cn.zwz.stu.utils.StrToListUtils;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;


/**
 * @author 郑为中
 * @email 916077357@qq.com
 */
@Slf4j
@RestController
@Api(tags = "问卷")
@RequestMapping("/zwz/questionnaire")
@Transactional
public class QuestionnaireController {

    @Autowired
    private IQuestionnaireService iQuestionnaireService;

    @Autowired
    private EvaluateUtils evaluateUtils;

    @RequestMapping(value = "/getOneByType", method = RequestMethod.GET)
    @ApiOperation(value = "根据类型查询学生的单个问卷")
    public Result<List<String>> getOneByType(@RequestParam int type){
        StudentEvaluate se = evaluateUtils.getMyStudentEvaluate();
        QueryWrapper<Questionnaire> qw = new QueryWrapper<>();
        qw.eq("evaluate_id",se.getId());
        qw.eq("type",type);
        List<Questionnaire> questionnaireList = iQuestionnaireService.list(qw);
        if(questionnaireList.size() < 1) {
            return new ResultUtil<List<String>>().setData(new ArrayList<>());
        }
        return new ResultUtil<List<String>>().setData(StrToListUtils.getListByStr(questionnaireList.get(0).getValue()));
    }

    @RequestMapping(value = "/saveOneByType", method = RequestMethod.GET)
    @ApiOperation(value = "保存单个问卷")
    public Result<Object> getOneByType(@RequestParam int type, @RequestParam String value){
        StudentEvaluate studentEvaluate = evaluateUtils.getMyStudentEvaluate();
        QueryWrapper<Questionnaire> qw = new QueryWrapper<>();
        qw.eq("evaluate_id",studentEvaluate.getId());
        qw.eq("type",type);
        List<Questionnaire> questionnaireList = iQuestionnaireService.list(qw);
        if(questionnaireList.size() < 1) {
            Questionnaire qu = new Questionnaire();
            qu.setType(type);
            qu.setValue(value);
            qu.setEvaluateId(studentEvaluate.getId());
            qu.setStatus(1);
            iQuestionnaireService.saveOrUpdate(qu);
        } else {
            Questionnaire questionnaire = questionnaireList.get(0);
            questionnaire.setValue(value);
            questionnaire.setStatus(1);
            iQuestionnaireService.saveOrUpdate(questionnaire);
        }
        return ResultUtil.success();
    }

    @RequestMapping(value = "/getOne", method = RequestMethod.GET)
    @ApiOperation(value = "查询单条问卷")
    public Result<Questionnaire> get(@RequestParam String id){
        return new ResultUtil<Questionnaire>().setData(iQuestionnaireService.getById(id));
    }

    @RequestMapping(value = "/count", method = RequestMethod.GET)
    @ApiOperation(value = "查询全部问卷个数")
    public Result<Long> getCount(){
        return new ResultUtil<Long>().setData(iQuestionnaireService.count());
    }

    @RequestMapping(value = "/getAll", method = RequestMethod.GET)
    @ApiOperation(value = "查询全部问卷")
    public Result<List<Questionnaire>> getAll(){
        return new ResultUtil<List<Questionnaire>>().setData(iQuestionnaireService.list());
    }

    @RequestMapping(value = "/getByPage", method = RequestMethod.GET)
    @ApiOperation(value = "查询问卷")
    public Result<IPage<Questionnaire>> getByPage(@ModelAttribute Questionnaire questionnaire ,@ModelAttribute PageVo page){
        QueryWrapper<Questionnaire> qw = new QueryWrapper<>();
        if(!ZwzNullUtils.isNull(questionnaire.getCreateBy())) {
        }
        IPage<Questionnaire> data = iQuestionnaireService.page(PageUtil.initMpPage(page),qw);
        return new ResultUtil<IPage<Questionnaire>>().setData(data);
    }

    @RequestMapping(value = "/insertOrUpdate", method = RequestMethod.POST)
    @ApiOperation(value = "增改问卷")
    public Result<Questionnaire> saveOrUpdate(Questionnaire questionnaire){
        if(iQuestionnaireService.saveOrUpdate(questionnaire)){
            return new ResultUtil<Questionnaire>().setData(questionnaire);
        }
        return ResultUtil.error();
    }

    @RequestMapping(value = "/insert", method = RequestMethod.POST)
    @ApiOperation(value = "新增问卷")
    public Result<Questionnaire> insert(Questionnaire questionnaire){
        iQuestionnaireService.saveOrUpdate(questionnaire);
        return new ResultUtil<Questionnaire>().setData(questionnaire);
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ApiOperation(value = "编辑问卷")
    public Result<Questionnaire> update(Questionnaire questionnaire){
        iQuestionnaireService.saveOrUpdate(questionnaire);
        return new ResultUtil<Questionnaire>().setData(questionnaire);
    }

    @RequestMapping(value = "/delByIds", method = RequestMethod.POST)
    @ApiOperation(value = "删除问卷")
    public Result<Object> delByIds(@RequestParam String[] ids){
        for(String id : ids){
            iQuestionnaireService.removeById(id);
        }
        return ResultUtil.success();
    }
}
