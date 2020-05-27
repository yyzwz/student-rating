package ypc.zwz.dao;

import java.util.List;

import org.hibernate.Query;

import core.dao.Dao;
import ypc.zwz.model.HouseType;

/**
 * 
 * @author 郑为中
 * 绍兴文理学院元培学院 计算机1701
 * 《数据库编程》 期末作品
 */

public interface HouseTypeDao extends Dao<HouseType> {

	public List<Object[]> queryExportedHouseType(Long[] ids);
}
