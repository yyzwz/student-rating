package ypc.zwz.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import core.service.BaseService;
import ypc.zwz.dao.HouseTypeDao;
import ypc.zwz.model.HouseType;
import ypc.zwz.service.HouseTypeService;

/**
 * 
 * @author 郑为中
 * 绍兴文理学院元培学院 计算机1701
 * 《数据库编程》 期末作品
 */

@Service
public class HouseTypeServiceImpl extends BaseService<HouseType> implements HouseTypeService {

	private HouseTypeDao houseTypeDao;

	@Resource
	public void setSysUserDao(HouseTypeDao houseTypeDao) {
		this.houseTypeDao = houseTypeDao;
		this.dao = houseTypeDao;
	}


	@Override
	public List<Object[]> queryExportedHouseType(Long[] ids) {
		return houseTypeDao.queryExportedHouseType(ids);
	}

}
