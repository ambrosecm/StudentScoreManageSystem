package com.g;

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

@WebServlet(description = "查询", urlPatterns = { "/gsearch" })
public class gsearch extends HttpServlet{
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = "jdbc:mysql://localhost:3306/test?useSSL=false&serverTimezone=UTC&useUnicode=true&characterEncoding=utf-8";
		String username = "root";
		String password = "";
		response.setContentType("text/html;charset=utf-8");
		String sno1=new String(request.getParameter("sno"));
		String sname1=new String(request.getParameter("sname"));
		String sdept1=new String(request.getParameter("sdept"));
		String course1=new String(request.getParameter("course"));
		course1=course1.toLowerCase();
		Connection conn = null;
		PreparedStatement ps = null;
		List<Map> list =new ArrayList<Map>();
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(url,username,password);
			String sql = "select * from studentgrade where sno LIKE '%"+sno1+"%' and sname LIKE '%"+sname1+"%'  and sdept LIKE '%"+sdept1+"%'";
			ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				
				String sno = rs.getString("sno");
				String sname = rs.getString("sname");
				String sdept = rs.getString("sdept");
				Integer c1= rs.getInt("高等数学");
				Integer c2= rs.getInt("离散数学");
				Integer c3= rs.getInt("大学物理");
				Integer c4= rs.getInt("Java");
				Integer c5= rs.getInt("python");
				Integer c6= rs.getInt("c语言");
				Map map = new HashMap(); 
				if(course1.equals("")) {
					map.put("sno", sno);
					map.put("sname", sname);			
					map.put("sdept",sdept);
					map.put("c1",c1);		
					map.put("c2", c2);
					map.put("c3",c3);		
					map.put("c4", c4);
					map.put("c5",c5);		
					map.put("c6", c6);
					list.add(map);
				}else if(course1.indexOf("高等数学")>=0) {
					if((c1+"")=="") {}else {
					map.put("sno", sno);
					map.put("sname", sname);			
					map.put("sdept",sdept);
					map.put("c1",c1);		
					map.put("c2", c2);
					map.put("c3",c3);		
					map.put("c4", c4);
					map.put("c5",c5);		
					map.put("c6", c6);
					list.add(map);
					}
				
				}else if(course1.indexOf("离散数学")>=0) {
					if((c2+"")=="") {}else {
						map.put("sno", sno);
						map.put("sname", sname);			
						map.put("sdept",sdept);
						map.put("c1",c1);		
						map.put("c2", c2);
						map.put("c3",c3);		
						map.put("c4", c4);
						map.put("c5",c5);		
						map.put("c6", c6);
						list.add(map);
						}
					
				}else if(course1.indexOf("大学物理")>=0) {
					if((c3+"")=="") {}else {
						map.put("sno", sno);
						map.put("sname", sname);			
						map.put("sdept",sdept);
						map.put("c1",c1);		
						map.put("c2", c2);
						map.put("c3",c3);		
						map.put("c4", c4);
						map.put("c5",c5);		
						map.put("c6", c6);
						list.add(map);
						}
						
				}else if(course1.indexOf("java")>=0) {
					if((c4+"")=="") {}else {
						map.put("sno", sno);
						map.put("sname", sname);			
						map.put("sdept",sdept);
						map.put("c1",c1);		
						map.put("c2", c2);
						map.put("c3",c3);		
						map.put("c4", c4);
						map.put("c5",c5);		
						map.put("c6", c6);
						list.add(map);
						}
						
				}else if(course1.indexOf("python")>=0) {
					if((c5+"")=="") {}else {
						map.put("sno", sno);
						map.put("sname", sname);			
						map.put("sdept",sdept);
						map.put("c1",c1);		
						map.put("c2", c2);
						map.put("c3",c3);		
						map.put("c4", c4);
						map.put("c5",c5);		
						map.put("c6", c6);
						list.add(map);
						}
						
				}else if(course1.indexOf("c语言")>=0) {
					if((c6+"")=="") {}else {
						map.put("sno", sno);
						map.put("sname", sname);			
						map.put("sdept",sdept);
						map.put("c1",c1);		
						map.put("c2", c2);
						map.put("c3",c3);		
						map.put("c4", c4);
						map.put("c5",c5);		
						map.put("c6", c6);
						list.add(map);
					}
					
				}
				
					
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
		session.setAttribute("key_listg",list);//将list集合数据放入到request中共享
		response.sendRedirect("/StudentScoreManageSystem/admin/tab_score.jsp");
		
		
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}

