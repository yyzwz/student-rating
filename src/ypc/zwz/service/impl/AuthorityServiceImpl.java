package ypc.zwz.service.impl;

import java.util.List;
import java.util.regex.Pattern;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import core.service.BaseService;
import ypc.zwz.dao.AuthorityDao;
import ypc.zwz.model.Authority;
import ypc.zwz.model.RoleAuthority;
import ypc.zwz.service.AuthorityService;

/**
 * 
 * @author 郑为中
 * 绍兴文理学院元培学院 计算机1701
 * 《数据库编程》 期末作品
 */

@Service
public class AuthorityServiceImpl extends BaseService<Authority> implements AuthorityService {

	private AuthorityDao authorityDao;

	@Resource
	public void setAuthorityDao(AuthorityDao authorityDao) {
		this.authorityDao = authorityDao;
		this.dao = authorityDao;
	}

	@Override
	public List<Authority> queryByParentIdAndRole(Short role) {
		return authorityDao.queryByParentIdAndRole(role);
	}

	@Override
	public List<Authority> queryChildrenByParentIdAndRole(Long parentId, Short role) {
		return authorityDao.queryChildrenByParentIdAndRole(parentId, role);
	}

	@Override
	public String querySurfaceAuthorityList(List<RoleAuthority> queryByProerties, Long id, String buttons) {
		StringBuilder sb = new StringBuilder();
		String[] buttonsArray = buttons.split(",");
		for (RoleAuthority roleAuthority : queryByProerties) {
			if (!isNumeric(roleAuthority.getAuthorityId())) {
				for (int z = 0; z < buttonsArray.length; z++) {
					if ((id + buttonsArray[z]).equalsIgnoreCase(roleAuthority.getAuthorityId())) {
						sb.append(buttonsArray[z] + ",");
					}
				}
			}
		}
		return sb.toString();
	}

	private static boolean isNumeric(String str) {
		Pattern pattern = Pattern.compile("[0-9]*");
		return pattern.matcher(str).matches();
	}

}
