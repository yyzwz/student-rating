package ypc.zwz.service;

import java.util.List;

import core.service.Service;
import ypc.zwz.model.SysUser;

/**
 * 
 * @author 郑为中
 * 绍兴文理学院元培学院 计算机1701
 * 《数据库编程》 期末作品
 */

public interface SysUserService extends Service<SysUser> {

	List<SysUser> getSysUserList(List<SysUser> resultList);
	List<Object[]> queryExportedSysUser(Long[] ids);
}
