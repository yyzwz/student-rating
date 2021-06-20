package ypc.zwz.dao.impl;

import java.util.List;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import core.dao.BaseDao;
import ypc.zwz.dao.SysUserDao;
import ypc.zwz.model.SysUser;

/**
 * 
 * @author 郑为中
 * 绍兴文理学院元培学院 计算机1701
 * 《数据库编程》 期末作品
 */

@Repository
public class SysUserDaoImpl extends BaseDao<SysUser> implements SysUserDao {

	public SysUserDaoImpl() {
		super(SysUser.class);
	}
	@Override
	public List<Object[]> queryExportedSysUserDao(Long[] ids) {
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < ids.length; i++) {
			sb.append(ids[i] + ",");
		}
		Query query = getSession().createSQLQuery(
				"select f.user_name,f.real_name,f.tel, f.email,f.last_logintime ,f.role from sys_user f where  f.id in (" + sb.deleteCharAt(sb.toString().length() - 1).toString() + ")");
		return query.list();
	}
	
	@Override
	public SysUser login(String a_name) {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public SysUser findByName(String a_name) {
		// TODO Auto-generated method stub
		return null;
	}
}
