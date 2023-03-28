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
<title>教师管理</title>
<link rel="stylesheet" type="text/css" href="/StudentScoreManageSystem/dist/css/easyui.css" />
<link rel="stylesheet" type="text/css" href="/StudentScoreManageSystem/dist/css/icon.css" />
<script type="text/javascript" src="/StudentScoreManageSystem/dist/js/jquery-3.1.1.min.js">
</script>
<script type="text/javascript" src="/StudentScoreManageSystem/dist/js/jquery.easyui.min.js">
</script>
<script type="text/javascript" src="/StudentScoreManageSystem/dist/js/loading.js"></script>
<script type="text/javascript" src="/StudentScoreManageSystem/dist/js/country.js"></script>
<script type="text/javascript" src="/StudentScoreManageSystem/dist/js/address.js"></script>
<script>

	function closeTeacherWindow(){
			$("#teacherWindow").window("close");
			}
	function addTeacher() {

		$("#teacherWindow").window({
			title : "添加教师信息",
			iconCls : "icon-add",
			collapsible:false,
			minimizable:false,
		    maximizable:false
		});
	}
	function teacherFormSubmit(){
		if(document.getElementById("tno").value==""||document.getElementById("tname").value==""||document.getElementById("tage").value==""||
				document.getElementById("tsex").value==""||document.getElementById("tco").value==""){
			alert("请填写完整信息");
			return;
		}else{
		var form=document.getElementById("teacherForm");
		form.action="/StudentScoreManageSystem/tadd";
		form.submit();}
		searchTeacher();
		alert("添加成功");
	}
	var row;
	function editTeacher() {
		
		var rows = $("#teacherDatagrid").datagrid("getSelections");
		if (rows == "") {
			alert("请选择一条记录");
			return;
		}
		if (rows.length > 1) {
			alert("请不要选中多条记录");
			return;
		}
		$("#teacherWindow1").window({
			title : "修改教师信息",
			iconCls : "icon-edit",
			collapsible:false,
			minimizable:false,
		    maximizable:false 
		});
		row=rows[0];
		$.ajaxSettings.async = false; //设置同步
		$("#teacherForm1").form("load",{
			"tno" : row.tno,
			"tname" : row.tname,
			"tsex" : row.tsex,
			"tage" : row.tage,
			"tco" : row.tco,
			"tphone" : row.tphone
		});
	}
	function editteacherFormSubmit() {
		if(document.getElementById("tno1").value==""||document.getElementById("tname1").value==""||document.getElementById("tage1").value==""||
				document.getElementById("tsex1").value==""||document.getElementById("tco1").value==""){
			alert("请填写完整信息");
			return;
		}else{
			location.href="/StudentScoreManageSystem/talter?tno="+document.getElementById("tno1").value+"&tname="+document.getElementById("tname1").value+"&tage="+document.getElementById("tage1").value+"&tco="+document.getElementById("tco1").value+"&tsex="+document.getElementById("tsex1").value+"&tphone="+document.getElementById("tphone1").value+"&oldtno="+row.tno;
			}
		searchTeacher();
		alert("修改成功");

	}
	function deleteTeacher() {
		var tnos = [];
		var rows = $("#teacherDatagrid").datagrid("getSelections");
		if (rows.length < 1) {
			alert("请选中至少一条数据");
			return;
		} else {
			if (!confirm("确定要删除吗?")) {
				return;
			}
			for (var i = 0; i < rows.length; i++) {
				
				tnos.push(rows[i].tno);
			}
			var tnostring=tnos.join(",");
			
			location.href="/StudentScoreManageSystem/tdelete?tno="+tnostring;
			searchTeacher();
			alert("删除成功，共删除"+rows.length+"条记录");
			
		}
	}
	function searchTeacher() {
		var searchno=$("#searchno").val();
 		var searchname=$("#searchname").val();
 		var searchsex=$("#searchsex").val();
 		var searchdept=$("#searchdept").val();
 		location.href="/StudentScoreManageSystem/tsearch?tno="+searchno+"&tname="+searchname+"&tsex="+searchsex+"&tco="+searchdept;
	
	}
	
	function refreshTeacher(){
		searchTeacher();
		}
	function load(){
		
	}
</script>
</head>

<body onload="load()">
<div id='loading' style="position:absolute;z-index:1000;top:0px;left:0px;width:100%;height:100%;background:#DDDDDB;text-align:center;padding-top: 20%;"></div>
	<table id="teacherDatagrid" class="easyui-datagrid"  rowNumbers="true"
		fitColumns="true" fit="true" toolbar="#tb" pagination="true">
		<thead>
			<tr>
				<th field="ck" checkbox="true"></th>
				<th field="tno">职工号</th>
				<th field="tname">姓名</th>
				<th field="tage">年龄</th>
				<th field="tsex">性别</th>
				<th field="tco" >教授课程</th>
				<th field="tphone">手机号码</th>
			
			</tr>
		</thead>
		<%!
		public static final int PAGESIZE = 15;    //每页行数
		int pageCount;
		int curPage = 1;
		%>
		<%
		try{
		List<Map> topiclist = (List<Map>)(session.getAttribute("key_listt"));
		
		int size = topiclist.size();
		
		pageCount = (size%PAGESIZE==0)?(size/PAGESIZE):(size/PAGESIZE+1);
		
		String tmp = request.getParameter("curPage");
		
		if(tmp==null){
			tmp="1";
		}
		curPage = Integer.parseInt(tmp);  
		List list1;
		if(curPage*PAGESIZE>size){list1=topiclist.subList((curPage-1)*PAGESIZE, size);}else{list1=topiclist.subList((curPage-1)*PAGESIZE, curPage*PAGESIZE);}
		session.setAttribute("key_listt1",list1);
		}
	    catch(Exception e){  
	          
	    } 
		%>
		<c:forEach items="${key_listt1}" var="usr" varStatus="idx">
        <tr>
        	<td></td>
			<td>${usr.tno}</td>
			<td>${usr.tname}</td> 
			<td>${usr.tage}</td> 
			<td>${usr.tsex}</td>
			<td>${usr.tco}</td>
			<td>${usr.tphone}</td>
		</tr>
		</c:forEach>
		<tr>
				<a href = "tab_teacher.jsp?curPage=1" >首页</a>  
				<a href = "tab_teacher.jsp?curPage=<%=curPage-1%>" >上一页</a>  
				<a href = "tab_teacher.jsp?curPage=<%=curPage+1%>" >下一页</a>  
				<a href = "tab_teacher.jsp?curPage=<%=pageCount%>" >尾页</a>  
				第<%=curPage%>页/共<%=pageCount%>页  
		</tr>
		
	</table>
	<div id="tb" style="padding: 5px">
		<div style="margin-bottom: 10px">
			<span>职工号:</span> <input type="text" name="searchno" id="searchno"/> 
			<span>姓名:</span> <input type="text" name="searchname" id="searchname" value="" /> 
			<span>性别:</span>
			<select id="searchsex" name="searchsex">
				<option value="">请输入</option>
				<option value="男">男</option>
				<option value="女">女</option>
			</select> 
			<span>教授课程:</span> 
			<input type="text" name="searchdept" id="searchdept"/>
			<a href="javascript:searchTeacher()" class="easyui-linkbutton" iconCls="icon-search">搜索</a>
			<a href="javascript:refreshTeacher()" class="easyui-linkbutton" iconCls="icon-reset">刷新</a>
		</div>
		<div style="margin-bottom: 10px">
			<a class="easyui-linkbutton" href="javascript:addTeacher()" iconCls="icon-add">添加</a> 
			<a id="edit" href="javascript:editTeacher()" class="easyui-linkbutton" iconCls="icon-edit">修改</a>
			<a id="delete" href="javascript:deleteTeacher()" class="easyui-linkbutton" iconCls="icon-cancel">删除</a>
		</div>
	</div>
	
	<div id="teacherWindow"  style="width:600px;height:400px;padding:20px">
		<form  method="post" id="teacherForm">
			<table style="border-collapse:separate;border-spacing:0px 10px">
				<tr>
					<td>职工号:</td>
					<td><input type="text" name="tno" id="tno" autocomplete="off"/></td>
				</tr>
				<tr>
					<td>姓名:</td>
					<td><input type="text" name="tname" id="tname" autocomplete="off"/></td>
				</tr>
				<tr>
					<td>性别:</td>
					<td><select name="tsex" id="tsex">
							<option value="男">男</option>
							<option value="女">女</option>
					</select></td>
				</tr>
				<tr>
					<td>年龄</td>
					<td><input type="text" name="tage"  id="tage" autocomplete="off"/></td>
				</tr>
				<tr>
					<td>教授课程:</td>
					<td>
						<input type="text" id="tco" name="tco" autocomplete="off">
					</td>
				</tr>
				<tr>
					<td>手机号:</td>
					<td>
						<input type="text" id="tphone" name="tphone" autocomplete="off">
					</td>
				</tr>
				<tr>
					<td><a href="javascript:teacherFormSubmit()" id="sub" 
						class="easyui-linkbutton" iconCls="icon-submit">提交</a></td>
				</tr>
			</table>
		</form>
	</div>
	<div id="teacherWindow1"  style="width:600px;height:400px;padding:20px">
		<form  method="post" id="teacherForm1">
			<table style="border-collapse:separate;border-spacing:0px 10px">
				<tr>
					<td>职工号:</td>
					<td><input type="text" name="tno" id="tno1" autocomplete="off"/></td>
				</tr>
				<tr>
					<td>姓名:</td>
					<td><input type="text" name="tname" id="tname1" autocomplete="off"/></td>
				</tr>
				<tr>
					<td>性别:</td>
					<td><select name="tsex" id="tsex1">
							<option value="男">男</option>
							<option value="女">女</option>
					</select></td>
				</tr>
				<tr>
					<td>年龄</td>
					<td><input type="text" name="tage"  id="tage1" autocomplete="off"/></td>
				</tr>
				<tr>
					<td>教授课程:</td>
					<td>
						<input type="text" id="tco1" name="tco" autocomplete="off">
					</td>
				</tr>
				<tr>
					<td>手机号:</td>
					<td>
						<input type="text" id="tphone1" name="tphone" autocomplete="off">
					</td>
				</tr>
				<tr>
					<td><a href="javascript:editteacherFormSubmit()" id="sub1" 
						class="easyui-linkbutton" iconCls="icon-submit">提交</a></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>