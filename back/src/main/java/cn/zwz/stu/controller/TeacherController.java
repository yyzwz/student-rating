package cn.zwz.stu.controller;

import cn.zwz.basics.baseVo.Result;
import cn.zwz.basics.utils.ResultUtil;
import cn.zwz.basics.utils.SecurityUtil;
import cn.zwz.data.entity.Department;
import cn.zwz.data.entity.DepartmentHeader;
import cn.zwz.data.entity.User;
import cn.zwz.data.service.IDepartmentHeaderService;
import cn.zwz.data.service.IDepartmentService;
import cn.zwz.data.service.IUserService;
import cn.zwz.stu.entity.StudentEvaluate;
import cn.zwz.stu.service.IStudentEvaluateService;
import cn.zwz.stu.utils.EvaluateUtils;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.checkerframework.checker.units.qual.A;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/**
 * @author 郑为中
 * @email 916077357@qq.com
 */
@Slf4j
@RestController
@Api(tags = "教师评价")
@RequestMapping("/zwz/teacher")
@Transactional
public class TeacherController {

    @Autowired
    private EvaluateUtils evaluateUtils;

    @Autowired
    private IDepartmentService iDepartmentService;

    @Autowired
    private IDepartmentHeaderService iDepartmentHeaderService;

    @Autowired
    private IUserService iUserService;

    @Autowired
    private SecurityUtil securityUtil;

    @RequestMapping(value = "/getMyStudentEvaluate", method = RequestMethod.GET)
    @ApiOperation(value = "查询自己班级的评价单")
    public Result<List<StudentEvaluate>> getMyStudentEvaluate(@RequestParam(required = false,defaultValue = "") String username, @RequestParam(required = false,defaultValue = "0") Float grades1, @RequestParam(required = false,defaultValue = "100") Float grades2){
        User currUser = securityUtil.getCurrUser();
        QueryWrapper<DepartmentHeader> dhQw = new QueryWrapper<>();
        dhQw.eq("user_id",currUser.getId());
        List<DepartmentHeader> departmentHeaderList = iDepartmentHeaderService.list(dhQw);
        List<Department> myDepartmentList = new ArrayList<>();
        for (DepartmentHeader dh : departmentHeaderList) {
            Department department = iDepartmentService.getById(dh.getDepartmentId());
            if(department != null) {
                myDepartmentList.add(department);
            }
        }
        List<User> myStudentList = new ArrayList<>();
        for (Department department : myDepartmentList) {
            QueryWrapper<User> userQw = new QueryWrapper<>();
            userQw.eq("department_id",department.getId());
            userQw.like("username",username);
            userQw.notLike("nickname","老师");
            // userQw.inSql("id","select id form a_user where id in (select distinct user_id from a_user_role where role_id = '496138616573953')");
            myStudentList.addAll(iUserService.list(userQw));
        }
        List<User> myStudentListAns = new ArrayList<>();
        for (User user : myStudentList) {
            boolean flag = false;
            for (User u : myStudentListAns) {
                if(Objects.equals(user.getId(),u.getId())) {
                    flag = true;
                    break;
                }
            }
            if(!flag) {
                myStudentListAns.add(user);
            }
        }
        List<StudentEvaluate> evaluateList = new ArrayList<>();
        for (User user : myStudentListAns) {
            StudentEvaluate se = evaluateUtils.getMyStudentEvaluate(user.getId());
            if(se != null) {
                float v = se.getAnsSum().floatValue();
                if(v >= grades1 && v <= grades2) {
                    se.setUserName(user.getNickname());
                    se.setUserClass(user.getDepartmentTitle());
                    evaluateList.add(se);
                }
            }
        }
        return new ResultUtil<List<StudentEvaluate>>().setData(evaluateList);
    }
}
