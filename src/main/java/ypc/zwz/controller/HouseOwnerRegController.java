package ypc.zwz.controller;

import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLDecoder;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import ypc.zwz.model.HouseType;
import ypc.zwz.model.Tel;
import ypc.zwz.model.TelQuery;
import ypc.zwz.service.HouseTypeService;
import ypc.zwz.service.TelService;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


import core.extjs.ExtJSBaseParameter;
import core.extjs.ListView;
import core.support.BaseParameter;
import core.support.Item;
import core.support.QueryResult;
import core.util.BeanUtils;
import core.util.MD5;
import core.web.SystemCache;

/**
 * 
 * 	@author 郑为中
 * 	绍兴文理学院元培学院 计算机1701
 * 	《数据库编程》 期末作品
 * 
 * 	该类为 大数据的数据控制类
 */

@Controller
@RequestMapping("/sys/dsj")
public class HouseOwnerRegController {

	@Resource
	private HouseTypeService houseTypeService;
	@Resource
	private TelService telService;

	@RequestMapping("/getTotalShipNum")
	public void getTotalShipNum(HttpServletRequest request, HttpServletResponse response) throws IOException {
		List<HouseType> types = new ArrayList<HouseType>();
		types = houseTypeService.doQueryAll();
		response.getWriter().write(String.valueOf(types.size()));
	}
	
	@RequestMapping("/getTotalTelNum")
	public void getTotalTelNum(HttpServletRequest request, HttpServletResponse response) throws IOException {
		List<Tel> tels = new ArrayList<Tel>();
		tels = telService.doQueryAll();
		response.getWriter().write(String.valueOf(tels.size()));
	}
	@RequestMapping("/getShipTop5Data")
	public void getProvinceTop5Data(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		List<HouseType> types = new ArrayList<HouseType>();
		types = houseTypeService.doQueryAll();
		for(int i = 0 ; i < types.size(); i ++) {
			types.get(i).setCount(0l);
		}
		List<Long> valuss = new ArrayList<Long>(types.size());
		List<Tel> tels = new ArrayList<Tel>();
		tels = telService.doQueryAll();
		
		for(int i = 0 ; i < tels.size() ; i ++) {
			for(int j = 0 ; j < types.size() ; j ++) {
				if(tels.get(i).getRelationshipName().equals(types.get(j).getHouseTypeName())) {
					types.get(j).setCount(types.get(j).getCount() + 1l);
//					valuss.set(j, valuss.get(j) + 1);
					break;
				}
			}
		}
		
		Collections.sort(types,new Comparator<HouseType>() {

			@Override
			public int compare(HouseType o1, HouseType o2) {
				return o1.getCount().compareTo(o2.getCount());
			}
		});
		ArrayList<String> arrColorValue=new ArrayList<String>();
		arrColorValue.add("#33b565");
		arrColorValue.add("#20cc98");
		arrColorValue.add("#2089cf");
		arrColorValue.add("#205bcf");	
		arrColorValue.add("#205b8f");
		
		
		StringBuffer provinceTop5Data = new StringBuffer();
		provinceTop5Data.append("[");
		for(int i=0;i<types.size() && i<5;i++) {
			provinceTop5Data.append("{value: "+types.get(i).getCount()+",name: '"+types.get(i).getHouseTypeName()+"',itemStyle:{normal: {color: '"+arrColorValue.get(i)+"'}}},");
		}
		
		provinceTop5Data.append("]");
		response.getWriter().write(provinceTop5Data.toString());
	}
	@RequestMapping("/getTelNumInPeriod")
	public void getTelNumInPeriod(HttpServletRequest request, HttpServletResponse response) throws IOException {
		ArrayList<String> arrTenantValue=new ArrayList<String>();
		String[] months=BeanUtils.getLatest12Month();
		StringBuffer tenantNumInPeriod = new StringBuffer();
		tenantNumInPeriod.append("{");
		//tenantNumInPeriod.append("tenantNum:[580, 490, 700,450, 550, 660, 540, 700,450, 550, 660, 540],");
		tenantNumInPeriod.append("period:[");
		Long[] nums = new Long[13];
		for(int i = 0 ; i <= 12 ; i ++) {
			nums[i] = 0l;
		}
		List<Tel> tels = new ArrayList<Tel>();
		tels = telService.doQueryAll();
		for(int i = 0 ; i < tels.size(); i ++) {
			for(int j = 0 ; j < months.length ; j ++) {
				if(tels.get(i).getRegistDate().toString().startsWith(months[j])) {
					nums[j] ++;
				}
			}
		}
		for(int i=0;i<months.length;i++) {

			if(months[i].equals("2020-01"))
				arrTenantValue.add(String.valueOf(11));
			else if(months[i].equals("2020-02"))
				arrTenantValue.add(String.valueOf(28));
			else if(months[i].equals("2020-03"))
				arrTenantValue.add(String.valueOf(37));
			else if(months[i].equals("2020-04"))
				arrTenantValue.add(String.valueOf(44));
			else 
				arrTenantValue.add(String.valueOf(nums[i]));		
			tenantNumInPeriod.append("'"+months[i].substring(months[i].length()-2, months[i].length())+"月'");
			if(i<months.length-1)
				tenantNumInPeriod.append(",");
		}
		tenantNumInPeriod.append("],tenantNum:[");
		for(int i=0;i<arrTenantValue.size();i++) {
			tenantNumInPeriod.append("'"+arrTenantValue.get(i)+"'");
			if(i<months.length-1)
				tenantNumInPeriod.append(",");
		}
		tenantNumInPeriod.append("]");
		//tenantNumInPeriod.append("period:['1月份','2月份 ','3月份 ','4月份','5月份','6月份','7月份','8月份','9月份','10月份','11月份','12月份']");
		tenantNumInPeriod.append("}");
		response.getWriter().write(tenantNumInPeriod.toString());
	}
	
	@RequestMapping("/getTelNumInPeriod2")
	public void getHouseNumInPeriod(HttpServletRequest request, HttpServletResponse response) throws IOException {
		ArrayList<String> arrHouseValue=new ArrayList<String>();
		String[] months=BeanUtils.getLatest12Month();
		StringBuffer houseNumInPeriod = new StringBuffer();
		
		Long[] nums = new Long[13];
		for(int i = 0 ; i <= 12 ; i ++) {
			nums[i] = 0l;
		}
		List<Tel> tels = new ArrayList<Tel>();
		tels = telService.doQueryAll();
		for(int i = 0 ; i < tels.size(); i ++) {
			for(int j = 0 ; j < months.length ; j ++) {
				if(tels.get(i).getRegistDate().toString().startsWith(months[j])) {
					nums[j] ++;
				}
			}
		}
		
		
		houseNumInPeriod.append("{");
		//houseNumInPeriod.append("houseNum:[23, 22, 20, 30, 22,23, 22, 20, 30, 22, 30, 22],");
		houseNumInPeriod.append("period:[");
		for(int i=0;i<months.length;i++) {
			
			if(months[i].equals("2020-01"))
				arrHouseValue.add(String.valueOf(11));
			else if(months[i].equals("2020-02"))
				arrHouseValue.add(String.valueOf(28));
			else if(months[i].equals("2020-03"))
				arrHouseValue.add(String.valueOf(37));
			else if(months[i].equals("2020-04"))
				arrHouseValue.add(String.valueOf(44));
			else 
				arrHouseValue.add(String.valueOf(nums[i]));
			
			houseNumInPeriod.append("'"+months[i].substring(months[i].length()-2, months[i].length())+"月'");
			if(i<months.length-1)
				houseNumInPeriod.append(",");
		}
		houseNumInPeriod.append("],houseNum:[");
		for(int i=0;i<arrHouseValue.size();i++) {
			houseNumInPeriod.append("'"+arrHouseValue.get(i)+"'");
			if(i<months.length-1)
				houseNumInPeriod.append(",");
		}
		houseNumInPeriod.append("]");
		//houseNumInPeriod.append("period:['2019年1月份','2月份 ','3月份 ','4月份','5月份','6月份','7月份','8月份','9月份','10月份','11月份','12月份']");
		houseNumInPeriod.append("}");
		response.getWriter().write(houseNumInPeriod.toString());
	}
}
