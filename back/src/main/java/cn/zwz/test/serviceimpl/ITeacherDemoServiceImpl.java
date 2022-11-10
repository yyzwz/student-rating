package cn.zwz.test.serviceimpl;

import cn.zwz.test.entity.TeacherDemo;
import cn.zwz.test.mapper.TeacherDemoMapper;
import cn.zwz.test.service.ITeacherDemoService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 教师 服务层接口实现
 * @author 郑为中
 */
@Slf4j
@Service
@Transactional
public class ITeacherDemoServiceImpl extends ServiceImpl<TeacherDemoMapper, TeacherDemo> implements ITeacherDemoService {

    @Autowired
    private TeacherDemoMapper teacherDemoMapper;
}