package ypc.zwz.dao.impl;

import org.springframework.stereotype.Repository;

import core.dao.BaseDao;
import ypc.zwz.dao.ConfigDao;
import ypc.zwz.model.Config;

/**
 * 
 * @author 郑为中
 * 绍兴文理学院元培学院 计算机1701
 * 《数据库编程》 期末作品
 */

@Repository
public class ConfigDaoImpl extends BaseDao<Config> implements ConfigDao {

	public ConfigDaoImpl() {
		super(Config.class);
	}

}
