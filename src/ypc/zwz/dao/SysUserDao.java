package ypc.zwz.dao;

import java.util.List;

import core.dao.Dao;
import ypc.zwz.model.SysUser;

/**
 * 
 * @author 郑为中
 * 绍兴文理学院元培学院 计算机1701
 * 《数据库编程》 期末作品
 */

public interface SysUserDao extends Dao<SysUser> {
	List<Object[]> queryExportedSysUserDao(Long[] ids);
	
	SysUser login(String a_name);
	
	SysUser findByName(String a_name);
}
