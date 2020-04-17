package com.forestry.service.sys;

import java.util.List;

import com.forestry.model.sys.Config;

import core.service.Service;

/**
 * 
 * @author 郑为中
 * 绍兴文理学院元培学院 计算机1701
 * 《数据库编程》 期末作品
 */

public interface ConfigService extends Service<Config> {

	List<Config> getConfigList(List<Config> resultList);

}
