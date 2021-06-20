package ypc.zwz.dao.impl;

import java.util.List;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import core.dao.BaseDao;
import ypc.zwz.dao.HouseTypeDao;
import ypc.zwz.model.HouseType;

/**
 * 
 * @author 郑为中
 * 绍兴文理学院元培学院 计算机1701
 * 《数据库编程》 期末作品
 */

@Repository
public class HouseTypeDaoImpl extends BaseDao<HouseType> implements HouseTypeDao {

	public HouseTypeDaoImpl() {
		super(HouseType.class);
	}
	@Override
	public List<Object[]> queryExportedHouseType(Long[] ids) {
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < ids.length; i++) {
			sb.append(ids[i] + ",");
		}
		Query query = getSession().createSQLQuery(
				"select f.HouseTypeName,f.HouseTypeDesc from housetype f where  f.id in (" + sb.deleteCharAt(sb.toString().length() - 1).toString() + ")");
		return query.list();
	}
}
