package ypc.zwz.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import core.service.BaseService;
import ypc.zwz.dao.RoleAuthorityDao;
import ypc.zwz.model.RoleAuthority;
import ypc.zwz.service.RoleAuthorityService;

/**
 * 
 * @author 郑为中
 * 绍兴文理学院元培学院 计算机1701
 * 《数据库编程》 期末作品
 */

@Service
public class RoleAuthorityServiceImpl extends BaseService<RoleAuthority> implements RoleAuthorityService {

	private RoleAuthorityDao roleAuthorityDao;

	@Resource
	public void setRoleAuthorityDao(RoleAuthorityDao roleAuthorityDao) {
		this.roleAuthorityDao = roleAuthorityDao;
		this.dao = roleAuthorityDao;
	}

}
