package com.forestry.controller.sys;

import java.io.IOException;
import java.io.OutputStream;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.forestry.core.ForestryBaseController;
import com.forestry.model.sys.SysUser;
import com.forestry.model.sys.Tel;
import com.forestry.service.sys.TelService;

import core.extjs.ExtJSBaseParameter;
import core.extjs.ListView;
import core.support.QueryResult;
import core.util.BeanUtils;
import org.apache.commons.lang.StringUtils;

/**
 * 
 * @author 郑为中
 * 绍兴文理学院元培学院 计算机1701
 * 《数据库编程》 期末作品
 */

@Controller
@RequestMapping("/sys/tel")
public class TelController extends ForestryBaseController<Tel> {
	
	@Resource
	private TelService telService;

	
	@RequestMapping(value = "/saveTel", method = { RequestMethod.POST, RequestMethod.GET })
	public void doSave(Tel entity, HttpServletRequest request, HttpServletResponse response) throws IOException {
		ExtJSBaseParameter parameter = ((ExtJSBaseParameter) entity);
		String name=(String)request.getParameter("name");	
		if (CMD_EDIT.equals(parameter.getCmd())) {
			//部分修改，会自动修改bean类的属性值未NULL
			
//			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");//注意月份是MM
//	        java.util.Date  registDate= new Date(System.currentTimeMillis());
//			entity.setRegistDate(new java.sql.Date(registDate.getTime()));
			
			telService.updateTel(entity);
		} else if (CMD_NEW.equals(parameter.getCmd())) {
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");//注意月份是MM
	        java.util.Date  registDate= new Date(System.currentTimeMillis());
			entity.setRegistDate(new java.sql.Date(registDate.getTime()));
			SysUser sysUser=(SysUser)request.getSession().getAttribute(SESSION_SYS_USER);
			entity.setOwnerId(sysUser.getId());
			telService.persist(entity);
		}
		parameter.setCmd(CMD_EDIT);
		parameter.setSuccess(true);
		writeJSON(response, parameter);
	}
	
	@RequestMapping(value = "/getTelList", method = { RequestMethod.POST, RequestMethod.GET })
	public void getHouseList(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		System.out.println("--------------------------------");
		Integer firstResult = Integer.valueOf(request.getParameter("start"));
		Integer maxResults = Integer.valueOf(request.getParameter("limit"));
		String sortedObject = null;
		String sortedValue = null;
		List<LinkedHashMap<String, Object>> sortedList = mapper.readValue(request.getParameter("sort"), List.class);
		for (int i = 0; i < sortedList.size(); i++) {
			Map<String, Object> map = sortedList.get(i);
			sortedObject = (String) map.get("property");
			sortedValue = (String) map.get("direction");
		}
		Tel tel = new Tel();
//		String houseName = request.getParameter("houseName");
//		if (StringUtils.isNotBlank(houseName)) {
//			houseName=URLDecoder.decode(houseName, "UTF-8");
//			tel.set$like_houseName(houseName);
//		}
//		String checkOpion = request.getParameter("checkOpion");
//		//checkOpion=URLDecoder.decode(request.getParameter("checkOpion"),"utf-8");
//		if (StringUtils.isNotBlank(checkOpion)) {
//			checkOpion=URLDecoder.decode(checkOpion, "UTF-8");
//			tel.set$eq_checkOpion(checkOpion);
//		}
		String relationshipId = request.getParameter("relationshipId");
		if (StringUtils.isNotBlank(relationshipId)) {
			relationshipId=URLDecoder.decode(relationshipId, "UTF-8");
			tel.set$eq_relationshipId(Long.valueOf(relationshipId));
		}
//		String departmentId = request.getParameter("departmentId");
//		System.out.println(departmentId);
//		if (StringUtils.isNotBlank(departmentId)) {
//			departmentId=URLDecoder.decode(departmentId, "UTF-8");
//			tel.set$eq_relationshipId(Long.valueOf(departmentId));
//		}
//		SysUser sysUser=(SysUser)request.getSession().getAttribute(SESSION_SYS_USER);
//		if(sysUser.getUserGrade().equals("2级")){//若是普通1级管理人员，可以查询全部数据
//			Long loginerDepartmentId = sysUser.getDepartmentId();
//			tel.set$eq_departmentId(loginerDepartmentId);
//		}
		
		SysUser sysUser=(SysUser)request.getSession().getAttribute(SESSION_SYS_USER);
		
		tel.set$eq_ownerId(sysUser.getId());
		System.out.println(sysUser.getId());
		
		tel.setFirstResult(firstResult);
		tel.setMaxResults(maxResults);
		Map<String, String> sortedCondition = new HashMap<String, String>();
		sortedCondition.put(sortedObject, sortedValue);
		tel.setSortedConditions(sortedCondition);
		QueryResult<Tel> queryResult = telService.doPaginationQuery(tel);
		ListView<Tel> forestryListView = new ListView<Tel>();
		forestryListView.setData(queryResult.getResultList());
		forestryListView.setTotalRecord(queryResult.getTotalCount());
		writeJSON(response, forestryListView);
	}

	@RequestMapping("/deleteTel")
	public void deleteTel(HttpServletRequest request, HttpServletResponse response, @RequestParam("ids") Long[] ids) throws IOException {
		boolean flag = telService.deleteByPK(ids);//ids=[1,12,13]
		if (flag) {
			writeJSON(response, "{success:true}");
		} else {
			writeJSON(response, "{success:false}");
		}
	}
	
	@RequestMapping(value = "/queryTel")
	public void queryTel(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Integer firstResult = Integer.valueOf(request.getParameter("start"));
		Integer maxResults = Integer.valueOf(request.getParameter("limit"));
		String sortedObject = null;
		String sortedValue = null;
		List<LinkedHashMap<String, Object>> sortedList = mapper.readValue(request.getParameter("sort"), List.class);
		for (int i = 0; i < sortedList.size(); i++) {
			Map<String, Object> map = sortedList.get(i);
			sortedObject = (String) map.get("property");
			sortedValue = (String) map.get("direction");
		}
		Tel tel = new Tel();
		String name = request.getParameter("name");
		if (StringUtils.isNotBlank(name)) {
			name=URLDecoder.decode(name, "UTF-8");
			tel.set$like_name(name);
		}
		String telNum = request.getParameter("tel");
		if (StringUtils.isNotBlank(telNum)) {
			telNum=URLDecoder.decode(telNum, "UTF-8");
			tel.set$like_tel(telNum);
		}
		String relationshipId = request.getParameter("relationshipId");
		if (StringUtils.isNotBlank(relationshipId)) {
			relationshipId=URLDecoder.decode(relationshipId, "UTF-8");
			tel.set$eq_relationshipId(Long.valueOf(relationshipId));
		}
//		String departmentId = request.getParameter("departmentId");
//		if (StringUtils.isNotBlank(departmentId)) {
//			departmentId=URLDecoder.decode(departmentId, "UTF-8");
//			house.set$eq_departmentId(Long.valueOf(departmentId));
//		}
//		String checkOpion = request.getParameter("checkOpion");
//		//checkOpion=URLDecoder.decode(request.getParameter("checkOpion"),"utf-8");
//		if (StringUtils.isNotBlank(checkOpion)) {
//			checkOpion=URLDecoder.decode(checkOpion, "UTF-8");
//			house.set$eq_checkOpion(checkOpion);
//		}
		SysUser sysUser=(SysUser)request.getSession().getAttribute(SESSION_SYS_USER);
		
		tel.set$eq_ownerId(sysUser.getId());
		System.out.println(sysUser.getId());
		tel.setFirstResult(firstResult);
		tel.setMaxResults(maxResults);
		Map<String, String> sortedCondition = new HashMap<String, String>();
		sortedCondition.put(sortedObject, sortedValue);
		tel.setSortedConditions(sortedCondition);
		QueryResult<Tel> queryResult = telService.doPaginationQuery(tel);
		ListView<Tel> forestryListView = new ListView<Tel>();
		forestryListView.setData(queryResult.getResultList());
		forestryListView.setTotalRecord(queryResult.getTotalCount());
		writeJSON(response, forestryListView);
	}
	
	@RequestMapping(value = "/getExportedTelList", method = { RequestMethod.POST, RequestMethod.GET })
	public void exportForestry(HttpServletRequest request, HttpServletResponse response, @RequestParam("ids") Long[] ids) throws Exception {
		List<Object[]> forestryList = telService.queryExportedTel(ids);
		//创建一个新的Excel
		HSSFWorkbook workBook = new HSSFWorkbook();
		//创建sheet页
		HSSFSheet sheet = workBook.createSheet("通讯录信息");
		//设置第一行为Header
		HSSFRow row = sheet.createRow(0);
		HSSFCell cell0 = row.createCell(0);
		HSSFCell cell1 = row.createCell(1);
		HSSFCell cell2 = row.createCell(2);
		HSSFCell cell3 = row.createCell(3);
		HSSFCell cell4 = row.createCell(4);
		HSSFCell cell5 = row.createCell(5);
		
		cell0.setCellValue("编号");
		cell1.setCellValue("姓名");
		cell2.setCellValue("电话号码");
		cell3.setCellValue("关系");
		cell4.setCellValue("家庭地址");
		cell5.setCellValue("登记日期");
		
		for (int i = 0; i < forestryList.size(); i++) {
			Object[] forestry = forestryList.get(i);
			row = sheet.createRow(i + 1);
			cell0 = row.createCell(0);
			cell1 = row.createCell(1);
			cell2 = row.createCell(2);
			cell3 = row.createCell(3);
			cell4 = row.createCell(4);
			cell5 = row.createCell(5);

			cell0.setCellValue(BeanUtils.getValuleInObject(forestry[0]));
			cell1.setCellValue(BeanUtils.getValuleInObject(forestry[1]));
			cell2.setCellValue(BeanUtils.getValuleInObject(forestry[2]));
			cell3.setCellValue(BeanUtils.getValuleInObject(forestry[3]));
			cell4.setCellValue(BeanUtils.getValuleInObject(forestry[4]));
			cell5.setCellValue(BeanUtils.getValuleInObject(forestry[5]));
			
			sheet.setColumnWidth(0, 6000);
			sheet.setColumnWidth(1, 6000);
			sheet.setColumnWidth(2, 6000);
			sheet.setColumnWidth(3, 6000);
			sheet.setColumnWidth(4, 6000);
			sheet.setColumnWidth(5, 6000);

		}
		response.reset();
		response.setContentType("application/msexcel;charset=UTF-8");
		try {
			response.addHeader("Content-Disposition", "attachment;filename=file.xls");
			OutputStream out = response.getOutputStream();
			workBook.write(out);
			out.flush();
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
