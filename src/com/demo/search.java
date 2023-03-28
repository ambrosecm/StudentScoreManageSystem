package com.demo;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

@WebServlet(description = "查询", urlPatterns = { "/search" })
public class search extends HttpServlet{
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = "jdbc:mysql://localhost:3306/test?useSSL=false&serverTimezone=UTC&useUnicode=true&characterEncoding=utf-8";
		String username = "root";
		String password = "";
		response.setContentType("text/html;charset=utf-8");
		String sno1=new String(request.getParameter("sno"));
		String sname1=new String(request.getParameter("sname"));
		String ssex1=new String(request.getParameter("ssex"));
		String sdept1=new String(request.getParameter("sdept"));
		Connection conn = null;
		PreparedStatement ps = null;
		List<Map> list =new ArrayList<Map>();
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(url,username,password);
			String sql = "select * from students where sno LIKE '%"+sno1+"%' and sname LIKE '%"+sname1+"%' and ssex LIKE '%"+ssex1+"%' and sdept LIKE '%"+sdept1+"%'";
			ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				
				String sno = rs.getString("sno");
				String sname = rs.getString("sname");
				Integer sage= rs.getInt("sage");
				String ssex = rs.getString("ssex");
				String sdept = rs.getString("sdept");
				Map map = new HashMap(); 	
				map.put("sno", sno);
				map.put("sname", sname);			
				map.put("sage",sage);		
				map.put("ssex", ssex);
				map.put("sdept",sdept);
				list.add(map);	
			}
		
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			if(ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		
		HttpSession session = request.getSession();
		session.setAttribute("key_lists",list);//将list集合数据放入到request中共享
		response.sendRedirect("/StudentScoreManageSystem/admin/tab_student.jsp");
		
		
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}


