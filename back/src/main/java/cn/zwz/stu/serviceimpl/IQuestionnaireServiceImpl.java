package cn.zwz.stu.serviceimpl;

import cn.zwz.stu.mapper.QuestionnaireMapper;
import cn.zwz.stu.entity.Questionnaire;
import cn.zwz.stu.service.IQuestionnaireService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 问卷 服务层接口实现
 * @author 郑为中
 */
@Slf4j
@Service
@Transactional
public class IQuestionnaireServiceImpl extends ServiceImpl<QuestionnaireMapper, Questionnaire> implements IQuestionnaireService {

    @Autowired
    private QuestionnaireMapper questionnaireMapper;
}