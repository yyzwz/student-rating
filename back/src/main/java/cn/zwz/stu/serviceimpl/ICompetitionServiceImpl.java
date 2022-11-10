package cn.zwz.stu.serviceimpl;

import cn.zwz.stu.mapper.CompetitionMapper;
import cn.zwz.stu.entity.Competition;
import cn.zwz.stu.service.ICompetitionService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 学科竞赛 服务层接口实现
 * @author 郑为中
 */
@Slf4j
@Service
@Transactional
public class ICompetitionServiceImpl extends ServiceImpl<CompetitionMapper, Competition> implements ICompetitionService {

    @Autowired
    private CompetitionMapper competitionMapper;
}