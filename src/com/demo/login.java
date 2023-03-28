package com.demo;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;


@WebServlet(description = "登录", urlPatterns = { "/login" })

public class login extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		//逻辑步骤：1、获取Form中的数据；2、对数据进行业务逻辑处理操作；3、返回处理结果数据
		String url = "jdbc:mysql://localhost:3306/test?useSSL=false&serverTimezone=UTC&useUnicode=true&characterEncoding=utf-8";
		String username = "root";
		String password = "";
		String u=new String(request.getParameter("username").getBytes("ISO-8859-1"),"UTF-8");
		String p=new String(request.getParameter("password").getBytes("ISO-8859-1"),"UTF-8");
		response.setContentType("text/html;charset=gb2312");
		
		try {
			//1.注册数据库驱动
			Class.forName("com.mysql.cj.jdbc.Driver");
			//2.通过DriverManager获取数据库连接
			Connection conn = DriverManager.getConnection(url,username,password);
			//3.生成一个Statement对象
			Statement stmt=conn.createStatement();
			ResultSet rs=stmt.executeQuery("select * from logintable");
			int f=0;
			HttpSession session = request.getSession();
			session.setAttribute("username",u);//将list集合数据放入到request中共享
			
			while(rs.next()) {
				if(u.equals(rs.getString("username"))&&p.equals(rs.getString("password"))&&(rs.getInt("id")==1)){
					response.sendRedirect("/StudentScoreManageSystem/admin/admin_main.jsp");
				}else if(u.equals(rs.getString("username"))&&p.equals(rs.getString("password"))&&(rs.getInt("id")==2)){
					response.sendRedirect("/StudentScoreManageSystem/teacher/teacher_main.jsp");
				}else if(u.equals(rs.getString("username"))&&p.equals(rs.getString("password"))){
					response.sendRedirect("/StudentScoreManageSystem/student/student_main.jsp");
				}
				if(f==0) {
				response.getWriter().print("<script>alert(\"登录失败，请检查您的账号密码是否正确\");javascript :history.back(-1); </script>");
				}
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("getConnection()错误");
		}	
	}
	//如果Form使用的是POST方法，则进入doPost方法
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}