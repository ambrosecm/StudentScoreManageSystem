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

@WebServlet(description = "添加", urlPatterns = { "/tadd" })
public class tadd extends HttpServlet{
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = "jdbc:mysql://localhost:3306/test?useSSL=false&serverTimezone=UTC&useUnicode=true&characterEncoding=utf-8";
		String username = "root";
		String password = "";
		Connection conn = null;
		PreparedStatement ps = null;
		response.setContentType("text/html;charset=utf-8");
		String tno=new String(request.getParameter("tno").getBytes("ISO-8859-1"),"UTF-8");
		String tname=new String(request.getParameter("tname").getBytes("ISO-8859-1"),"UTF-8");
		int tage=Integer.parseInt(request.getParameter("tage"));
		String tsex=new String(request.getParameter("tsex").getBytes("ISO-8859-1"),"UTF-8");
		String tco=new String(request.getParameter("tco").getBytes("ISO-8859-1"),"UTF-8");
		String tphone=new String(request.getParameter("tphone").getBytes("ISO-8859-1"),"UTF-8");
		if(tno==""||tname==""||(tage+"")==""||tsex==""||tco==""){
			response.getWriter().print("<script>alert(\"添加失败，请填写完整信息\");javascript :history.back(-1);</script>");
		}else {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(url,username,password);
			String sql = "INSERT INTO teachers (tno,tname,tage,tsex,tco,tphone) VALUES(?,?,?,?,?,?)";
			ps = conn.prepareStatement(sql);
			ps.setString(1, tno);
			ps.setString(2, tname);
			ps.setInt(3, tage);
			ps.setString(4, tsex);
			ps.setString(5, tco);
			ps.setString(6, tphone);
			ps.executeUpdate();
			response.sendRedirect(request.getHeader("Referer"));
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("getConnection()错误");
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
		
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
