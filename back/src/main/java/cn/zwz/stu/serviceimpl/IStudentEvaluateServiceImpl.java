package cn.zwz.stu.serviceimpl;

import cn.zwz.stu.mapper.StudentEvaluateMapper;
import cn.zwz.stu.entity.StudentEvaluate;
import cn.zwz.stu.service.IStudentEvaluateService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 学生评价 服务层接口实现
 * @author 郑为中
 */
@Slf4j
@Service
@Transactional
public class IStudentEvaluateServiceImpl extends ServiceImpl<StudentEvaluateMapper, StudentEvaluate> implements IStudentEvaluateService {

    @Autowired
    private StudentEvaluateMapper studentEvaluateMapper;
}