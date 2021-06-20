package ypc.zwz.dao.impl;

import org.springframework.stereotype.Repository;

import core.dao.BaseDao;
import ypc.zwz.dao.RoleAuthorityDao;
import ypc.zwz.model.RoleAuthority;

/**
 * 
 * @author 郑为中
 * 绍兴文理学院元培学院 计算机1701
 * 《数据库编程》 期末作品
 */

@Repository
public class RoleAuthorityDaoImpl extends BaseDao<RoleAuthority> implements RoleAuthorityDao {

	public RoleAuthorityDaoImpl() {
		super(RoleAuthority.class);
	}
}
