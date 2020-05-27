package core.util;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class CheckCodeServlet extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
            this.doPost(request, response);
	}	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		   //1.取出请求参数code的值
	       String checkcode=request.getParameter("code");
	      //2.取出session中封装的属性名为code的属性值
	       HttpSession session=request.getSession();
	       String sessioncode=String.valueOf(session.getAttribute("code"));
	      //3.判断请求参数值和会话属性值是否相同
	       if(checkcode.equals(sessioncode)){
	    	   //如果相同,说明用户输入的验证码正确,请求转发给/login处理
	    	   this.gotoPage("login", request, response);	       
	        }else{ 
	            request.setAttribute("codeMsg","验证码错误");//请求中封装验证码错误信息，请求转发回login.jsp
	            this.gotoPage("public/login.jsp", request, response);	      
	      } 
	}
	//定义方法用来请求转发到某个url
    private void gotoPage(String url,HttpServletRequest request, HttpServletResponse response)
					throws ServletException, IOException {
		RequestDispatcher dispatcher=request.getRequestDispatcher(url);
		dispatcher.forward(request, response);
	}
}
