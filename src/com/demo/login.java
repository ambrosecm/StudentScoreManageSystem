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


@WebServlet(description = "��¼", urlPatterns = { "/login" })

public class login extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		//�߼����裺1����ȡForm�е����ݣ�2�������ݽ���ҵ���߼����������3�����ش���������
		String url = "jdbc:mysql://localhost:3306/test?useSSL=false&serverTimezone=UTC&useUnicode=true&characterEncoding=utf-8";
		String username = "root";
		String password = "";
		String u=new String(request.getParameter("username").getBytes("ISO-8859-1"),"UTF-8");
		String p=new String(request.getParameter("password").getBytes("ISO-8859-1"),"UTF-8");
		response.setContentType("text/html;charset=gb2312");
		
		try {
			//1.ע�����ݿ�����
			Class.forName("com.mysql.cj.jdbc.Driver");
			//2.ͨ��DriverManager��ȡ���ݿ�����
			Connection conn = DriverManager.getConnection(url,username,password);
			//3.����һ��Statement����
			Statement stmt=conn.createStatement();
			ResultSet rs=stmt.executeQuery("select * from logintable");
			int f=0;
			HttpSession session = request.getSession();
			session.setAttribute("username",u);//��list�������ݷ��뵽request�й���
			
			while(rs.next()) {
				if(u.equals(rs.getString("username"))&&p.equals(rs.getString("password"))&&(rs.getInt("id")==1)){
					response.sendRedirect("/StudentScoreManageSystem/admin/admin_main.jsp");
				}else if(u.equals(rs.getString("username"))&&p.equals(rs.getString("password"))&&(rs.getInt("id")==2)){
					response.sendRedirect("/StudentScoreManageSystem/teacher/teacher_main.jsp");
				}else if(u.equals(rs.getString("username"))&&p.equals(rs.getString("password"))){
					response.sendRedirect("/StudentScoreManageSystem/student/student_main.jsp");
				}
				if(f==0) {
				response.getWriter().print("<script>alert(\"��¼ʧ�ܣ����������˺������Ƿ���ȷ\");javascript :history.back(-1); </script>");
				}
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("getConnection()����");
		}	
	}
	//���Formʹ�õ���POST�����������doPost����
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}