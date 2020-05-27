package ypc.zwz.dao;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import core.dao.Dao;
import ypc.zwz.model.SysUser;
import ypc.zwz.model.Tel;

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
