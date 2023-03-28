<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*"
import="java.sql.*"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
    
<!DOCTYPE html>
<html style="height: 100%">
   <head>
   <title>学生成绩图表
   </title>
       <meta charset="utf-8">
       <%
       	String url = "jdbc:mysql://localhost:3306/test?useSSL=false&serverTimezone=UTC&useUnicode=true&characterEncoding=utf-8";
		String username = "root";
		String password = "";
		response.setContentType("text/html;charset=utf-8");
		try {
			//1.注册数据库驱动 #类库，调用现成的类库来访问
			//2.通过DriverManager获取数据库连接数据库
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/test?useSSL=false&serverTimezone=UTC&useUnicode=true&characterEncoding=utf8","root","");
			//3.生成一个Statement对象
			Statement stmt=conn.createStatement();
			//ResultSet结果集：获取的数据放到一个固定的数据结构里面
			int a=0;int b=0;int c=0;int d=0;int e=0;
			ResultSet rs=stmt.executeQuery("select * from studentgrade");
			List<Integer> list1=new ArrayList<Integer> ();
			while(rs.next()){
				Integer c1= rs.getInt("高等数学");
				Integer c2= rs.getInt("离散数学");
				Integer c3= rs.getInt("大学物理");
				Integer c4= rs.getInt("Java");
				Integer c5= rs.getInt("python");
				Integer c6= rs.getInt("c语言");
			
				if(c4<60){
					a++;
					
				}else if(c4>=60&&c4<70){
					b++;
					
				}else if(c4>=70&&c4<80){
					c++;
				}else if(c4>=80&&c4<90){
					d++;
				}else if(c4>=90&&c4<=100){
					e++;
				}	
			}
			list1.add(a);
			list1.add(b);
			list1.add(c);
			list1.add(d);
			list1.add(e);
			
			session.setAttribute("key_list4",list1);//将list集合数据放入到request中共享	
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				System.out.println("getConnection()错误");
			}
       %>
   </head>
   
   <body style="height: 100%; margin: 0">
   
   <form name="form" method="post" action="tab_score.jsp">
           　　 <input type="submit" value="返回">
   </form>
   <br>
  <table>
   <tr>
   <form name="form" method="post" action="map_score.jsp">
           　　 <input type="submit" value="高等数学">
   </form>
   <form name="form" method="post" action="c2.jsp">
           　　 <input type="submit" value="离散数学">
   </form>
   <form name="form" method="post" action="c3.jsp">
           　　 <input type="submit" value="大学物理">
   </form>
   <form name="form" method="post" action="c4.jsp">
           　　 <input type="submit" value="Java">
   </form>
   <form name="form" method="post" action="c5.jsp">
           　　 <input type="submit" value="python">
   </form>
   <form name="form" method="post" action="c6.jsp">
           　　 <input type="submit" value="c语言">
   </form>
    </tr>
   </table>
   
       <div id="container" style="height: 100%"></div>
       <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/echarts/dist/echarts.min.js"></script>
       <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/echarts-gl/dist/echarts-gl.min.js"></script>
       <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/echarts-stat/dist/ecStat.min.js"></script>
       <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/echarts/dist/extension/dataTool.min.js"></script>
       <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/echarts/map/js/china.js"></script>
       <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/echarts/map/js/world.js"></script>
       
       <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/echarts/dist/extension/bmap.min.js"></script>
       <script type="text/javascript">
       
var dom = document.getElementById("container");
var myChart = echarts.init(dom);
var app = {};
option = null;
option = {
    tooltip: {
        trigger: "axis",
        axisPointer: {
            type: "cross",
            crossStyle: {
                color: "#999"
            }
        }
    },
    toolbox: {
        feature: {
            dataView: {show: true, readOnly: false},
            magicType: {show: true, type: ["line", "bar"]},
            restore: {show: true},
            saveAsImage: {show: true}
        }
    },
    xAxis: [
        {
            type: "category",
            data: ["60分以下", "60-70", "70-80","80-90","90-100"],
            axisPointer: {
                type: "shadow"
            }
        }
    ],
    yAxis: [
        {
            type: "value",
            name: "人数",
            min: 0,
            max: 100,
            interval: 5,
            axisLabel: {
                formatter: "{value}"
            }
        },
        
    ],
    series: [
        {
            name: "人数",
            type: "bar",
            data: ${key_list4}
        },
        
    ]
};
;
if (option && typeof option === "object") {
    myChart.setOption(option, true);
}
       </script>
       
       
   </body>
</html>