package ypc.zwz.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import ypc.zwz.core.ForestryBaseController;
import ypc.zwz.model.SysUser;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.util.Random;
import javax.imageio.ImageIO;

/**
 * 
 * 		@author 郑为中 
 * 		绍兴文理学院元培学院 计算机1701 
 * 		《数据库编程》 期末作品
 * 
 * 		用于生成首页验证码，检验首页验证码是否正确
 */

@Controller
@RequestMapping("/code")
public class CodeController extends ForestryBaseController<SysUser> {

	/**
	 * 	@author 郑为中
	 * 
	 * 	检验登入页的验证码
	 * 	正确返回 "true"
	 * 	错误返回 "false"
	 */
	@RequestMapping(value = "/checkcode")
	public String checkCode(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1.取出请求参数code的值
		String checkcode = request.getParameter("code");
		// 2.取出session中封装的属性名为code的属性值
		HttpSession session = request.getSession();
		String sessioncode = String.valueOf(session.getAttribute("code"));
		// 3.判断请求参数值和会话属性值是否相同
		if (checkcode.equals(sessioncode)) {
			return "true";
		} 
		else {
			request.setAttribute("codeMsg", "验证码错误");// 请求中封装验证码错误信息，请求转发回login.jsp
			return "false";
		}
	}
	
	/**
	 * 	@author 郑为中
	 * 
	 *  生成登入页的验证码
	 *  返回jpeg图片
	 */
	@RequestMapping(value = "/createcode")
	public void createCode(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1.设置页面类型		
		response.setContentType("image/jpeg");
		//设置页面不缓存
		response.setHeader("Pragma", "no-cache");
		response.setHeader("cache-control", "no-cache");
		response.setDateHeader("expires", 0);
		//2.绘制动态图像
		//定义验证码图片大小
		int width=60;
		int height=20;
		//创建能在内存中修改的图片对象
		BufferedImage image=new BufferedImage(width,height,BufferedImage.TYPE_INT_RGB);
		//获取绘制图片的Graphics对象
		Graphics g=image.getGraphics();
		//画图片
		//设置背景图片的颜色
		g.setColor(getRandColor(200,250));
		//画背景图片
		g.fillRect(0, 0, width, height);
		//设置干扰线颜色
		g.setColor(getRandColor(20,30));
		//画出干扰线
		Random random=new Random();
		for(int i=0;i<1000;i++){
			//设置起始点坐标
			int x=random.nextInt(width);
			int y=random.nextInt(height);
			//设置结束点坐标，从起始点增量
			int x1=random.nextInt(12);
			int y1=random.nextInt(12);
			g.drawLine(x, y, x+x1, y+y1);
		}
		//定义变量codestr用来表示在会话中保存的验证码
		String codestr="";
		//定义随机字符取值范围的字符串数组
		String [] str={"A","B","C","D","E","F","G","H","I","J","K","L","M","N","P","Q","R","S","T","U","V","W","X","Y","Z","a","b","c","d","e","f","g","h","i","j","k","m","n","p","q","r","s","t","u","v","w","x","y","z"};
		//画出随机字符
		for(int i=0;i<4;i++){
			String rand="";
			if(random.nextBoolean()){
				rand=String.valueOf(random.nextInt(10));	
			}else{
				int index=random.nextInt(49);//获取一个随机整数作为要取的数组元素的下标索引
				rand=str[index];
			}
			//设置字体颜色
			g.setColor(getRandColor(20,130));
			//设置字体
			g.setFont(new Font("Times New Roman",Font.PLAIN,18));
			//画出表达式
			g.drawString(rand,13*i+6,16);	
			codestr+=rand;
		}			
		//3.把4位验证码字符串保存在session中
		HttpSession session=request.getSession();
		session.setAttribute("code",codestr);			
		//4.把缓存图片输出到客户端，设置输出图片的格式		  
		ImageIO.write(image, "JPEG", response.getOutputStream());  
		//5.清空缓存，释放资源		
		response.getOutputStream().flush();     
		response.getOutputStream().close();     
		response.flushBuffer(); 
	}
	//	返回 rgb 颜色
	Color getRandColor(int fc,int bc){
		Random random=new Random();
		if(fc>255){
			fc=255;
		}
		if(bc>255){
			bc=255;
		}
		int r=fc+random.nextInt(bc-fc);
		int g=fc+random.nextInt(bc-fc);
		int b=fc+random.nextInt(bc-fc);
		return new Color(r,g,b);
	} 
}
