package ypc.zwz.controller;

import java.io.IOException;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import ypc.zwz.core.ForestryBaseController;
import ypc.zwz.model.RoleAuthority;
import ypc.zwz.service.RoleAuthorityService;

/**
 * 	@author 郑为中
 * 	绍兴文理学院元培学院 计算机1701
 * 	《数据库编程》 期末作品
 * 	用于管理主页左侧区域的菜单列表 和AuthorityController一起搭配使用
 */

@Controller
@RequestMapping("/sys/roleauthority")
public class RoleAuthorityController extends ForestryBaseController<RoleAuthority> {

	@Resource
	private RoleAuthorityService roleAuthorityService;

	@RequestMapping(value = "/saveRoleAuthority")
	public void saveRoleAuthority(HttpServletRequest request, HttpServletResponse response) throws IOException {
		Short role = Short.valueOf(request.getParameter("role"));
		String ids = request.getParameter("ids");
		roleAuthorityService.deleteByProperties("role", role);
		String[] idsValue = ids.split(",");
		for (int i = 0; i < idsValue.length; i++) {
			RoleAuthority roleAuthority = new RoleAuthority();
			roleAuthority.setRole(role);
			roleAuthority.setAuthorityId(idsValue[i]);
			roleAuthorityService.persist(roleAuthority);
		}
		writeJSON(response, "{success:true}");
	}

}
