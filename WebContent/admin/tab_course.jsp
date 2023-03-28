<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*"
import="java.sql.*"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>学生选课信息</title>
	<link rel="stylesheet" type="text/css" href="/StudentScoreManageSystem/dist/css/easyui.css"/>
		<link rel="stylesheet" type="text/css" href="/StudentScoreManageSystem/dist/css/icon.css"/>
		<link rel="stylesheet" type="text/css" href="/StudentScoreManageSystem/dist/css/bootstrap.css"/>
		<script type="text/javascript" src="/StudentScoreManageSystem/dist/js/jquery-3.1.1.min.js"></script>
		<script type="text/javascript" src="/StudentScoreManageSystem/dist/js/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="/StudentScoreManageSystem/dist/js/loading.js"></script>
		<script >
		
		function closeCourseWindow(){
				$("#courseWindow").window("close");
			}
		function addCourse(){
			$("#courseWindow").window({
				title:"添加课程信息",
				iconCls:"icon-add",
				collapsible:false,
				minimizable:false,
				maximizable:false
			});
		}
		function courseFormSubmit(){
			if(document.getElementById("sno").value==""||document.getElementById("sname").value==""||document.getElementById("sdept").value==""||document.getElementById("course").value==""){
				alert("请填写完整信息");
				return;
			}else{
			var form=document.getElementById("courseForm");
			form.action="/StudentScoreManageSystem/cadd";
			form.submit();}
			searchCourse();
			alert("添加成功");
			}
		var row;
		function editCourse(){
			
			var rows=$("#courseDatagrid").datagrid("getSelections");
			if(rows==""){
				alert("请选择一条记录");
				return ;
			}
			if(rows.length>1){
				alert("请不要选中多条记录");
				return ;
			}
			$("#courseWindow1").window({
				title:"修改课程信息",
				iconCls:"icon-edit",
				collapsible:false,
				minimizable:false,
				maximizable:false
			});
			row = rows[0];
			$.ajaxSettings.async = false; //设置同步
			$("#courseForm1").form("load",{
				"sno" : row.sno,
				"sname" : row.sname,
				"sdept" : row.sdept,
				"course" :row.course
				});
			
		}
		function editcourseFormSubmit(){
			if(document.getElementById("sno1").value==""||document.getElementById("sname1").value==""||
				document.getElementById("sdept1").value==""||document.getElementById("course1").value==""){
			alert("请填写完整信息");
			return;
			}else{
			location.href="/StudentScoreManageSystem/calter?sno="+document.getElementById("sno1").value+"&sname="+document.getElementById("sname1").value+"&sdept="+document.getElementById("sdept1").value+"&course="+document.getElementById("course1").value+"&oldsno="+row.sno+"&oldcourse="+row.course;
			}
			
			searchCourse();
			alert("修改成功");
		}
		
		
		function deleteCourse(){
			var snos=[];
			var courses=[];
			var rows=$("#courseDatagrid").datagrid("getSelections");
			if(rows.length<1){
				alert("请选中至少一条数据");
				return ;
			}else{
				if(!confirm("确定要删除吗?")){
					return;
				}
				for(var i=0;i<rows.length;i++){
					snos.push(rows[i].sno);
					courses.push(rows[i].course);
				}
			}
			var snostring=snos.join(",");
			var coursestring=courses.join(",");

			location.href="/StudentScoreManageSystem/cdelete?sno="+snostring+"&course="+coursestring;
			searchCourse();
			alert("删除成功，共删除"+rows.length+"条记录");
		}
		function searchCourse(){
			var searchno=$("#searchno").val();
	 		var searchname=$("#searchname").val();
	 		var searchdept=$("#searchdept").val();
	 		var searchcourse=$("#searchcourse").val();
	 		
	 		location.href="/StudentScoreManageSystem/csearch?sno="+searchno+"&sname="+searchname+"&sdept="+searchdept+"&course="+searchcourse;
			
			}
		function refreshCourse(){
			searchCourse();
			}
	</script>
	</head>
	<body>
	<div id='loading' style="position:absolute;z-index:1000;top:0px;left:0px;width:100%;height:100%;background:#DDDDDB;text-align:center;padding-top: 20%;"></div>
		<table class="easyui-datagrid" id="courseDatagrid" 
			 fit="true" toolbar="#tb" pagination="true" rowNumbers="true" >
			<thead>
				<tr>
					<th field="ck" checkbox="true"></th>
					<th field="sno">学号</th>
					<th field="sname">姓名</th>
					<th field="sdept">专业</th>
					<th field="course">已选课程</th>
				</tr>
			</thead>
		<tbody>
		<%!
		public static final int PAGESIZE = 15;    //每页行数
		int pageCount;
		int curPage = 1;
		%>
		<%
		try{
		List<Map> topiclist = (List<Map>)(session.getAttribute("key_listc"));
		
		int size = topiclist.size();
		
		pageCount = (size%PAGESIZE==0)?(size/PAGESIZE):(size/PAGESIZE+1);
		
		String tmp = request.getParameter("curPage");
		
		if(tmp==null){
			tmp="1";
		}
		curPage = Integer.parseInt(tmp);  
		List list1;
		if(curPage*PAGESIZE>size){list1=topiclist.subList((curPage-1)*PAGESIZE, size);}else{list1=topiclist.subList((curPage-1)*PAGESIZE, curPage*PAGESIZE);}
		session.setAttribute("key_listc1",list1);
		}
	    catch(Exception e){  
	          
	    } 
		%>
			<c:forEach items="${key_listc1}" var="usr" varStatus="idx">
        <tr>
        	<td></td>
			<td>${usr.sno}</td>
			<td>${usr.sname}</td> 
			<td>${usr.sdept}</td> 
			<td>${usr.course}</td>

		</tr>
		</c:forEach>
		<tr>
				<a href = "tab_course.jsp?curPage=1" >首页</a>  
				<a href = "tab_course.jsp?curPage=<%=curPage-1%>" >上一页</a>  
				<a href = "tab_course.jsp?curPage=<%=curPage+1%>" >下一页</a>  
				<a href = "tab_course.jsp?curPage=<%=pageCount%>" >尾页</a>  
				第<%=curPage%>页/共<%=pageCount%>页  
		</tr>
		</tbody>
		</table>
		<div id="tb">
			<div style="margin-bottom:10px">
				<a href="javascript:addCourse()" class="easyui-linkbutton" iconCls="icon-add">添加</a>
				<a href="javascript:editCourse()" class="easyui-linkbutton" iconCls="icon-edit">修改</a>
				<a href="javascript:deleteCourse()" class="easyui-linkbutton" iconCls="icon-clear">删除</a>
			</div>
			<div style="margin-bottom:10px">
				<span>学号:</span> <input type="text" name="searchno" id="searchno"/>
				<span>姓名:</span> <input type="text" name="searchname" id="searchname" /> 
				<span>专业:</span> <input type="text" name="searchdept" id="searchdept" /> 
				<span>课程名称:</span>
				<input type="text" id="searchcourse" name="searchcourse" placeHolder="请输入要搜索课程的关键字"/>
				<a href="javascript:searchCourse()" class="easyui-linkbutton" iconCls="icon-search" >搜索</a>
				<a href="javascript:refreshCourse()" class="easyui-linkbutton" iconCls="icon-reset">刷新</a>
			
			</div>
		</div>
		
    
		<div id="courseWindow"  style="width:300px;padding:20px">
			<form  id="courseForm" method="post">
				<table style="border-collapse:separate;border-spacing:0px 10px;">
					<tr>
					<td>学号</td>
					<td><input type="text" name="sno" id="sno" autocomplete="off"/></td>
				</tr>
				<tr>
					<td>姓名:</td>
					<td><input type="text" name="sname" id="sname" autocomplete="off"/></td>
				</tr>
				<tr>
					<td>专业:</td>
					<td>
						<input type="text" id="sdept" name="sdept" autocomplete="off">
					</td>
				</tr>
				<tr>
					<td>添加课程:</td>
					<td>
						<input type="text" id="course" name="course" autocomplete="off">
					</td>
				</tr>
					<tr>
						<td><a href="javascript:courseFormSubmit()" id="sub"
						class="easyui-linkbutton" iconCls="icon-submit" >提交</a></td>
					</tr>
					
				</table>
			</form>
		</div>
		<div id="courseWindow1"  style="width:300px;padding:20px">
			<form  id="courseForm1" method="post">
				<table style="border-collapse:separate;border-spacing:0px 10px;">
					<tr>
					<td>学号</td>
					<td><input type="text" name="sno" id="sno1" autocomplete="off"/></td>
				</tr>
				<tr>
					<td>姓名:</td>
					<td><input type="text" name="sname" id="sname1" autocomplete="off"/></td>
				</tr>
				<tr>
					<td>专业:</td>
					<td>
						<input type="text" id="sdept1" name="sdept" autocomplete="off">
					</td>
				</tr>
				<tr>
					<td>修改课程为:</td>
					<td>
						<input type="text" id="course1" name="course" autocomplete="off">
					</td>
				</tr>
					<tr>
						<td><a href="javascript:editcourseFormSubmit()" id="id1"class="easyui-linkbutton" iconCls="icon-submit" >提交</a></td>
					</tr>
					
				</table>
			</form>
		</div>
	</body>

	

		
	
</html>
