package com.t;

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

@WebServlet(description = "查询", urlPatterns = { "/tsearch" })
public class tsearch extends HttpServlet{
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = "jdbc:mysql://localhost:3306/test?useSSL=false&serverTimezone=UTC&useUnicode=true&characterEncoding=utf-8";
		String username = "root";
		String password = "";
		response.setContentType("text/html;charset=utf-8");
		String tno1=new String(request.getParameter("tno"));
		String tname1=new String(request.getParameter("tname"));
		String tsex1=new String(request.getParameter("tsex"));
		String tco1=new String(request.getParameter("tco"));
		Connection conn = null;
		PreparedStatement ps = null;
		List<Map> list =new ArrayList<Map>();
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(url,username,password);
			String sql = "select * from teachers where tno LIKE '%"+tno1+"%' and tname LIKE '%"+tname1+"%' and tsex LIKE '%"+tsex1+"%' and tco LIKE '%"+tco1+"%'";
			ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				
				String tno = rs.getString("tno");
				String tname = rs.getString("tname");
				Integer tage= rs.getInt("tage");
				String tsex = rs.getString("tsex");
				String tco = rs.getString("tco");
				String tphone = rs.getString("tphone");
				Map map = new HashMap(); 	
				map.put("tno", tno);
				map.put("tname", tname);			
				map.put("tage",tage);		
				map.put("tsex", tsex);
				map.put("tco",tco);
				map.put("tphone",tphone);
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
		session.setAttribute("key_listt",list);//将list集合数据放入到request中共享
		response.sendRedirect("/StudentScoreManageSystem/admin/tab_teacher.jsp");
		
		
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
