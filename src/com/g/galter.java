package com.g;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
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
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

@WebServlet(description = "修改", urlPatterns = { "/galter" })
public class galter extends HttpServlet{
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = "jdbc:mysql://localhost:3306/test?useSSL=false&serverTimezone=UTC&useUnicode=true&characterEncoding=utf-8";
		String username = "root";
		String password = "";
		Connection conn = null;
		PreparedStatement ps = null;
		response.setContentType("text/html;charset=utf-8");
		String sno=new String(request.getParameter("sno"));
		String sname=new String(request.getParameter("sname"));
		String sdept=new String(request.getParameter("sdept"));
		int c1=Integer.parseInt(request.getParameter("c1"));
		int c2=Integer.parseInt(request.getParameter("c2"));
		int c3=Integer.parseInt(request.getParameter("c3"));
		int c4=Integer.parseInt(request.getParameter("c4"));
		int c5=Integer.parseInt(request.getParameter("c5"));
		int c6=Integer.parseInt(request.getParameter("c6"));
		String oldsno=new String(request.getParameter("oldsno"));
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(url,username,password);
			String sql = "UPDATE studentgrade SET sno=?, sname=?,sdept=?,高等数学=?,离散数学=?,大学物理=?,Java=?,python=?,c语言=? where sno=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, sno);
			ps.setString(2, sname);
			ps.setString(3, sdept);	
			ps.setInt(4, c1);
			ps.setInt(5, c2);
			ps.setInt(6, c3);
			ps.setInt(7, c4);
			ps.setInt(8, c5);
			ps.setInt(9, c6);
			ps.setString(10, oldsno);
			ps.executeUpdate();
			response.sendRedirect(request.getHeader("Referer"));

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
		
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}


