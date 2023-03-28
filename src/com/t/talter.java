package com.t;

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

@WebServlet(description = "修改", urlPatterns = { "/talter" })
public class talter extends HttpServlet{
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = "jdbc:mysql://localhost:3306/test?useSSL=false&serverTimezone=UTC&useUnicode=true&characterEncoding=utf-8";
		String username = "root";
		String password = "";
		Connection conn = null;
		PreparedStatement ps = null;
		response.setContentType("text/html;charset=utf-8");
		String tno=new String(request.getParameter("tno"));
		String tname=new String(request.getParameter("tname"));
		int tage=Integer.parseInt(request.getParameter("tage"));
		String tsex=new String(request.getParameter("tsex"));
		String tco=new String(request.getParameter("tco"));
		String tphone=new String(request.getParameter("tphone"));
		String oldtno=new String(request.getParameter("oldtno"));
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(url,username,password);
			String sql = "UPDATE teachers SET tno=?, tname=?, tage=?, tsex=?,tco=?,tphone=? where tno=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, tno);
			ps.setString(2, tname);
			ps.setInt(3, tage);
			ps.setString(4, tsex);
			ps.setString(5, tco);
			ps.setString(6, tphone);
			ps.setString(7, oldtno);
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
	public static int executeUpdate(Connection conn, String sql, Object[] param) {
		int result = 0;
		PreparedStatement ps = null;
		try {
			ps = conn.prepareStatement(sql);
			if(param != null) {
				for(int i=0; i<param.length; i++) {
					ps.setObject(i+1, param[i]);
				}
			}
			result = ps.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	public static String isSuccess(int count) {
		if(count > 0) {
			return "操作成功！";
		}else {
			return "操作失败";
		}
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
