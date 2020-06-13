package ypc.zwz.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLDecoder;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.RequestContext;

import core.extjs.ExtJSBaseParameter;
import core.extjs.ListView;
import core.support.QueryResult;
import core.util.BeanUtils;
import core.util.ForestryUtils;
import net.sf.json.JSONObject;
import ypc.zwz.core.ForestryBaseController;
import ypc.zwz.model.HouseType;
import ypc.zwz.model.SysUser;
import ypc.zwz.model.Tel;
import ypc.zwz.service.HouseTypeService;
import ypc.zwz.service.TelService;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang3.time.DateFormatUtils;

/**
 * 	@author 郑为中
 * 	绍兴文理学院元培学院 计算机1701
 * 	《数据库编程》 期末作品
 * 
 * 	通讯录相关的Controller
 */

@Controller
@RequestMapping("/sys/tel")
public class TelController extends ForestryBaseController<Tel> {
	
	private static SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd");
	
	/**
	 * 	Spring自动注入
	 */
	@Resource
	private TelService telService;
	
	@Resource
	private HouseTypeService houseTypeService;

	/**
	 * @author 郑为中
	 * 导入功能
	 */
	@RequestMapping("/downloadImportedFile")
	public ResponseEntity<byte[]> downloadImportedFile() throws IOException {
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
		headers.setContentDispositionFormData("attachment", "template.xlsx");
		File filePath = new File(getClass().getClassLoader().getResource("/").getPath().replace("/WEB-INF/classes/", "/static/download/attachment/" + "template.xlsx"));
		return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(filePath), headers, HttpStatus.CREATED);
	}
	
	private static SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");

	@RequestMapping(value = "/importForestryFile", method = RequestMethod.POST)
	public void importForestryFile(@RequestParam(value = "importedFile", required = false) MultipartFile file, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RequestContext requestContext = new RequestContext(request);
		JSONObject json = new JSONObject();
		if (!file.isEmpty()) {
			if (file.getSize() > 2097152) {
				json.put("msg", requestContext.getMessage("g_fileTooLarge"));
			} else {
				try {
					String originalFilename = file.getOriginalFilename();
					String fileName = sdf.format(new Date()) + ForestryUtils.getRandomString(3) + originalFilename.substring(originalFilename.lastIndexOf("."));
					File filePath = new File(getClass().getClassLoader().getResource("/").getPath().replace("/WEB-INF/classes/", "/static/download/attachment/" + DateFormatUtils.format(new Date(), "yyyyMM")));
					if (!filePath.exists()) {
						filePath.mkdirs();
					}
					String serverFile = filePath.getAbsolutePath() + "\\" + fileName;
					file.transferTo(new File(serverFile));

					String fileType = fileName.substring(fileName.lastIndexOf(".") + 1);
					if (!fileType.equalsIgnoreCase("xls") && !fileType.equalsIgnoreCase("xlsx")) {
						json.put("success", false);
						json.put("msg", requestContext.getMessage("g_notValidExcel"));
						writeJSON(response, json.toString());
						return;
					}
					int count = 0;
					StringBuilder stringBuilder = new StringBuilder();
					InputStream xls = new FileInputStream(serverFile);
					Workbook wb = null;
					Sheet sheet = null;
					Row currentRow = null;
					Row headRow = null;
					Cell currentCell = null;
					if (fileType.equals("xls")) {
						wb = new HSSFWorkbook(xls);
					} else if (fileType.equals("xlsx")) {
						wb = new XSSFWorkbook(xls);
					}
					sheet = wb.getSheetAt(0);// excel中至少会存在一个sheet页
					int rowNum = sheet.getPhysicalNumberOfRows();// 物理有效行数
					Object[] rowValues = null;// excel中一行树木信息
					List<Object[]> models = new ArrayList<Object[]>();// excel中全部树木信息
					if (rowNum > 1) {
						headRow = sheet.getRow(0);
						columns: for (int i = 1; i < rowNum; i++) {
							currentRow = sheet.getRow(i);
							if (currentRow != null) {
								rowValues = new Object[5];
								// int cellNum = currentRow.getLastCellNum();// 总单元格数目
								for (short j = 0; j < 5; j++) {
									try {
										currentCell = currentRow.getCell(j);
										Object obj = null;
										if (currentCell == null) {
											obj = "";
										} else {
											switch (currentCell.getCellType()) {
												case Cell.CELL_TYPE_BLANK:
													obj = "";
													break;
												case Cell.CELL_TYPE_STRING:
													obj = currentCell.getRichStringCellValue();
													break;
												case Cell.CELL_TYPE_NUMERIC:
													if (HSSFDateUtil.isCellDateFormatted(currentCell)) {
														double d = currentCell.getNumericCellValue();
														Date date = HSSFDateUtil.getJavaDate(d);
														obj = sdfDate.format(date);
													} else {
														NumberFormat nf = NumberFormat.getInstance();
														nf.setGroupingUsed(false);//true时的格式：1,234,567,890
														obj = nf.format(currentCell.getNumericCellValue());
													}
													break;
												default:
													obj = "";
													break;
											}
										}
										String cellVal = obj.toString();
										rowValues[j] = cellVal;
									} catch (IllegalStateException e) {
										rowValues = null;
										stringBuilder.append("第" + i + "行," + headRow.getCell(j).getRichStringCellValue() + "列输入了非法值，未导入成功！");
										continue columns;
									} catch (NullPointerException e) {
										rowValues = null;
										stringBuilder.append("第" + i + "行," + headRow.getCell(j).getRichStringCellValue() + "列输入了空值，未导入成功!");
										continue columns;
									} catch (Exception e) {
										rowValues = null;
										stringBuilder.append(e.getMessage());
										continue columns;
									}
								}
								if (rowValues != null) {
									models.add(rowValues);
								}
							}
						}
					} else if (rowNum <= 1 && rowNum > 0) {// 表示模版中只存在头部信息
						json.put("success", false);
						json.put("msg", "Excel表格中没有需要导入 的内容！");
						writeJSON(response, json.toString());
						return;
					} else if (rowNum <= 0) {// 表示这是一个空sheet页
						json.put("success", false);
						json.put("msg", "所导入文件格式不正确，请下载模板！");
						writeJSON(response, json.toString());
						return;
					}
					List<Tel> list = objectToForestry(models,request);// Object-->Forestry
					for (int i = 0; i < list.size(); i++) {
						if (StringUtils.isBlank("" + list.get(i).getTel()) || StringUtils.isBlank(list.get(i).getName())) {
							stringBuilder.append("第" + (i + 1) + "行记录的姓名或电话有空值，导入失败。");
							continue;
						}
//						Tel checkForestryEpcId = telService.getByProerties("id", list.get(i).getId());
//						if (checkForestryEpcId != null) {
//							stringBuilder.append("第" + (i + 1) + "行记录的epc编码已存在，导入失败。");
//							continue;
//						}
						if (list.get(i).getRelationshipId() == null) {
							stringBuilder.append("第" + (i + 1) + "行记录的关系名不存在，导入失败。");
							continue;
						}
						telService.persist(list.get(i));
						count++;
					}

					json.put("success", true);
					json.put("msg", count + "条记录导入完成。" + stringBuilder.toString());
				} catch (Exception e) {
					e.printStackTrace();
					json.put("success", false);
					json.put("msg", requestContext.getMessage("g_operateFailure"));
					writeJSON(response, json.toString());
				}
			}
		} else {
			json.put("success", false);
			json.put("msg", requestContext.getMessage("g_uploadNotExists"));
		}
		writeJSON(response, json.toString());
	}
	
	private List<Tel> objectToForestry(List<Object[]> models, HttpServletRequest request) {
		List<Tel> telList = new ArrayList<Tel>();
		Tel tel = null;
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
		SysUser sysUser=(SysUser)request.getSession().getAttribute(SESSION_SYS_USER);
		List<HouseType> types = new ArrayList<HouseType>();
		types = houseTypeService.doQueryAll();
		for (int i = 0; i < models.size(); i++) {
			try {
				tel = new Tel();
				
				tel.setName(models.get(i)[0].toString());
				tel.setTel(models.get(i)[1].toString());
				String relationshipName = models.get(i)[2].toString();
				tel.setRelationshipName(relationshipName);
				tel.setQq(models.get(i)[3].toString());
				tel.setAddress(models.get(i)[4].toString());
				
				
				for(int j = 0 ; i < types.size() ; i ++) {
					if(types.get(j).getHouseTypeName().equals(relationshipName)) {
						tel.setRelationshipId(types.get(j).getId());
						break;
					}
				}
				if(tel.getRelationshipId() == null) {
					System.out.println("信息无效");
				}
				
		        java.util.Date  registDate= new Date(System.currentTimeMillis());
				tel.setRegistDate(new java.sql.Date(registDate.getTime()));
				tel.setOwnerId(sysUser.getId());
//				if (StringUtils.isBlank(models.get(i)[2].toString())) {
//					forestry.setPlantTime(null);
//				} else {
//					forestry.setPlantTime(sdfDate.parse(models.get(i)[2].toString()));
//				}
//				if (StringUtils.isBlank(models.get(i)[3].toString())) {
//					forestry.setRegistDate(null);
//				} else {
//					forestry.setRegistDate(sdfDate.parse(models.get(i)[3].toString()));
//				}
//				ForestryType forestryType = forestryTypeService.getByProerties("name", models.get(i)[4].toString());
//				forestry.setForestryType(forestryType);
				telList.add(tel);
			} catch (Exception e) {
				e.printStackTrace();
				continue;
			}
		}
		return telList;
	}
	
	/**
	 * 	@author 郑为中
	 * 	查询 / 修改通讯录数据
	 */
	@RequestMapping(value = "/saveTel", method = { RequestMethod.POST, RequestMethod.GET })
	public void doSave(Tel entity, HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		ExtJSBaseParameter parameter = ((ExtJSBaseParameter) entity);
		
		if (CMD_EDIT.equals(parameter.getCmd())) {
			//部分修改，属性值为null的不变，不会null的会更新
			telService.updateTel(entity);
		} 
		else if (CMD_NEW.equals(parameter.getCmd())) {
			// 日期格式化
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
	        java.util.Date  registDate= new Date(System.currentTimeMillis());
	        
	        // 更新注册时间
			entity.setRegistDate(new java.sql.Date(registDate.getTime()));
			SysUser sysUser=(SysUser)request.getSession().getAttribute(SESSION_SYS_USER);
			
			// 用户ID
			entity.setOwnerId(sysUser.getId());
			// System.out.println("添加用户的姓名 = " + entity.getName());
			
			// 插入数据库
			telService.persist(entity);
		}
		parameter.setCmd(CMD_EDIT);
		parameter.setSuccess(true);
		writeJSON(response, parameter);
	}
	

	/**
	 * @author 郑为中
	 * 获取通讯录列表 （简单查询）
	 * 
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/getTelList", method = { RequestMethod.POST, RequestMethod.GET })
	public void getHouseList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//页数
		Integer firstResult = Integer.valueOf(request.getParameter("start"));
		Integer maxResults = Integer.valueOf(request.getParameter("limit"));
		String sortedObject = null;
		String sortedValue = null;
		
		// 排序策略
		List<LinkedHashMap<String, Object>> sortedList = mapper.readValue(request.getParameter("sort"), List.class);
		for (int i = 0; i < sortedList.size(); i++) {
			Map<String, Object> map = sortedList.get(i);
			sortedObject = (String) map.get("property");
			sortedValue = (String) map.get("direction");
		}
		
		// 创建Tel模板对象
		Tel tel = new Tel();
		
		//判断是否条件查询
		String relationshipId = request.getParameter("relationshipId");
		if (StringUtils.isNotBlank(relationshipId)) {
			relationshipId=URLDecoder.decode(relationshipId, "UTF-8");
			// 把条件加入条件区域
			tel.set$eq_relationshipId(Long.valueOf(relationshipId));
		}
		
		//当前登入用户  把登入用户ID以作为条件之一，因为只需查找自己的通讯录
		SysUser sysUser=(SysUser)request.getSession().getAttribute(SESSION_SYS_USER);
		tel.set$eq_ownerId(sysUser.getId());
		// System.out.println("当前查询通讯录的用户ID = " + sysUser.getId());
		tel.setFirstResult(firstResult);
		tel.setMaxResults(maxResults);
		Map<String, String> sortedCondition = new HashMap<String, String>();
		sortedCondition.put(sortedObject, sortedValue);
		tel.setSortedConditions(sortedCondition);
		
		// 开始查询  渲染到前端
		QueryResult<Tel> queryResult = telService.doPaginationQuery(tel);
		ListView<Tel> forestryListView = new ListView<Tel>();
		forestryListView.setData(queryResult.getResultList());
		forestryListView.setTotalRecord(queryResult.getTotalCount());
		writeJSON(response, forestryListView);
	}

	
	/**
	 * @author 郑为中
	 * 指定ID删除通讯录数据
	 * 
	 * @param request
	 * @param response
	 * @param ids
	 * @throws IOException
	 */
	@RequestMapping("/deleteTel")
	public void deleteTel(HttpServletRequest request, HttpServletResponse response, @RequestParam("ids") Long[] ids) throws IOException {
		boolean flag = telService.deleteByPK(ids);//ids=[1,12,13]
		if (flag) {
			writeJSON(response, "{success:true}");
		} else {
			writeJSON(response, "{success:false}");
		}
	}
	
	
	/**
	 * @author 郑为中
	 * 查询指定条件的通讯录 (复杂查询)
	 * 
	 * @param request
	 * @param response
	 * @throws Exception
	 */
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
		// 创建Tel模板对象
		Tel tel = new Tel();
		// 获取name，即姓名，如果获取到说明用户名是条件之一，需要加入条件区域
		String name = request.getParameter("name");
		if (StringUtils.isNotBlank(name)) {
			name=URLDecoder.decode(name, "UTF-8");
			// 加入条件区域  下同
			tel.set$like_name(name);
		}
		// 电话号码
		String telNum = request.getParameter("tel");
		if (StringUtils.isNotBlank(telNum)) {
			telNum=URLDecoder.decode(telNum, "UTF-8");
			tel.set$like_tel(telNum);
		}
		// 关系类型
		String relationshipId = request.getParameter("relationshipId");
		if (StringUtils.isNotBlank(relationshipId)) {
			relationshipId=URLDecoder.decode(relationshipId, "UTF-8");
			tel.set$eq_relationshipId(Long.valueOf(relationshipId));
		}
		//从Session对象中获取当前登入用户
		SysUser sysUser=(SysUser)request.getSession().getAttribute(SESSION_SYS_USER);
		//把登入用户ID以作为条件之一，因为只需查找自己的通讯录
		tel.set$eq_ownerId(sysUser.getId());
		System.out.println("复杂查询的当前用户ID = " + sysUser.getId());
		tel.setFirstResult(firstResult);
		tel.setMaxResults(maxResults);
		Map<String, String> sortedCondition = new HashMap<String, String>();
		sortedCondition.put(sortedObject, sortedValue);
		tel.setSortedConditions(sortedCondition);
		// 开始查询
		QueryResult<Tel> queryResult = telService.doPaginationQuery(tel);
		ListView<Tel> forestryListView = new ListView<Tel>();
		forestryListView.setData(queryResult.getResultList());
		forestryListView.setTotalRecord(queryResult.getTotalCount());
		// 渲染到前台
		writeJSON(response, forestryListView);
	}
	
	/**
	 * @author 郑为中
	 * 导出通讯录数据为Excel
	 * 
	 * @param request
	 * @param response
	 * @param ids
	 * @throws Exception
	 */
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
			
			// 创建
			cell0 = row.createCell(0);
			cell1 = row.createCell(1);
			cell2 = row.createCell(2);
			cell3 = row.createCell(3);
			cell4 = row.createCell(4);
			cell5 = row.createCell(5);
			
			// 写值
			cell0.setCellValue(BeanUtils.getValuleInObject(forestry[0]));
			cell1.setCellValue(BeanUtils.getValuleInObject(forestry[1]));
			cell2.setCellValue(BeanUtils.getValuleInObject(forestry[2]));
			cell3.setCellValue(BeanUtils.getValuleInObject(forestry[3]));
			cell4.setCellValue(BeanUtils.getValuleInObject(forestry[4]));
			cell5.setCellValue(BeanUtils.getValuleInObject(forestry[5]));	
			
			// 设置列宽
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
			// 导出
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
