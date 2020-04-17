package com.forestry.dao.sys;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.forestry.model.sys.SysUser;
import com.forestry.model.sys.Tel;

import core.dao.Dao;

/**
 * 
 * @author 郑为中
 * 绍兴文理学院元培学院 计算机1701
 * 《数据库编程》 期末作品
 */

public interface TelDao extends Dao<Tel> {
	
	List<Object[]> queryExportedTel(Long[] ids);

	
    void updateTel(Tel tel);
    int saveTelTwoDimensionalCode(HttpServletRequest request, String filePath,Long id);//saveHouseTwoDimensionalCode
}
