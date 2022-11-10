package cn.zwz.stu.utils;

import cn.zwz.basics.utils.SecurityUtil;
import cn.zwz.data.entity.User;
import cn.zwz.data.service.IUserService;
import cn.zwz.stu.entity.StudentEvaluate;
import cn.zwz.stu.service.IStudentEvaluateService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;
import java.util.List;

/**
 * 评价单工具类
 * @author 郑为中
 */
@Component
public class EvaluateUtils {

    @Autowired
    private SecurityUtil securityUtil;

    @Autowired
    private IStudentEvaluateService iStudentEvaluateService;

    @Autowired
    private IUserService iUserService;

    public StudentEvaluate getMyStudentEvaluate() {
        // 找到评价单
        User currUser = securityUtil.getCurrUser();
        QueryWrapper<StudentEvaluate> seQw = new QueryWrapper<>();
        seQw.eq("user_id",currUser.getId());
        List<StudentEvaluate> evaluateList = iStudentEvaluateService.list(seQw);
        StudentEvaluate se = null;
        if(evaluateList.size() < 1) {
            se = EvaluateUtils.getBlackStudentEvaluate(currUser.getId());
            iStudentEvaluateService.saveOrUpdate(se);
        } else {
            se = evaluateList.get(0);
        }
        return se;
    }

    public StudentEvaluate getMyStudentEvaluate(String userId) {
        // 找到评价单
        User currUser = iUserService.getById(userId);
        if(currUser == null) {
            return null;
        }
        QueryWrapper<StudentEvaluate> seQw = new QueryWrapper<>();
        seQw.eq("user_id",currUser.getId());
        List<StudentEvaluate> evaluateList = iStudentEvaluateService.list(seQw);
        StudentEvaluate se = null;
        if(evaluateList.size() < 1) {
            se = EvaluateUtils.getBlackStudentEvaluate(currUser.getId());
            iStudentEvaluateService.saveOrUpdate(se);
        } else {
            se = evaluateList.get(0);
        }
        return se;
    }

    public static StudentEvaluate getBlackStudentEvaluate(String userId) {
        StudentEvaluate evaluate = new StudentEvaluate();
        evaluate.setUserId(userId);
        evaluate.setAchievementOne(BigDecimal.ZERO);
        evaluate.setAchievementTwo(BigDecimal.ZERO);
        evaluate.setAchievementThree(BigDecimal.ZERO);
        evaluate.setAchievementSum(BigDecimal.ZERO);
        evaluate.setQuestionnaireOne(BigDecimal.ZERO);
        evaluate.setCompetitionMine(BigDecimal.ZERO);
        evaluate.setAnsOne(BigDecimal.ZERO);

        evaluate.setQuestionnaireTwo(BigDecimal.ZERO);
        evaluate.setQuestionnaireThree(BigDecimal.ZERO);
        evaluate.setAnsTwo(BigDecimal.ZERO);

        evaluate.setQuestionnaireFour(BigDecimal.ZERO);
        evaluate.setQuestionnaireSix(BigDecimal.ZERO);
        evaluate.setQuestionnaireSeven(BigDecimal.ZERO);
        evaluate.setAnsThree(BigDecimal.ZERO);

        evaluate.setAnsSum(BigDecimal.ZERO);
        return evaluate;
    }
}
