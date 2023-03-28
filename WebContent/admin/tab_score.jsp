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
<title>学生成绩信息</title>
<link rel="stylesheet" type="text/css" href="/StudentScoreManageSystem/dist/css/easyui.css" />
<link rel="stylesheet" type="text/css" href="/StudentScoreManageSystem/dist/css/icon.css" />
<script type="text/javascript" src="/StudentScoreManageSystem/dist/js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="/StudentScoreManageSystem/dist/js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="/StudentScoreManageSystem/dist/js/loading.js"></script>
</head>
<script type="text/javascript">

function closeStudentWinwow() {
	$("#studentWindow").window("close");

}
function addStudent() {
	
	$("#studentWindow").window({
		title : "添加学生信息",
		iconCls : "icon-add",
		collapsible : false,
		minimizable : false,
		maximizable : false
	});
}
function addStudentSubmit() {
	if(document.getElementById("sno").value==""||document.getElementById("sname").value==""){
		alert("请填写完整信息");
		return;
	}else{
	var form=document.getElementById("studentForm");
	form.action="/StudentScoreManageSystem/gadd";
	form.submit();}
	searchStudent();
	alert("添加成功");
	

}
var row;
function editStudent() {
	var rows = $("#studentDatagrid").datagrid("getSelections");
	if (rows == "") {
		alert("请选择一条记录");
		return;
	}
	if (rows.length > 1) {
		alert("请不要选中多条记录");
		return;
	}
	
	$("#studentWindow1").window({
		title : "修改学生信息",
		iconCls : "icon-edit",
		collapsible : false,
		minimizable : false,
		maximizable : false
	});	
	row = rows[0];
	$.ajaxSettings.async = false; //设置同步
	$("#studentForm1").form("load", {
		"sno" : row.sno,
		"sname" : row.sname,
		"sdept" : row.sdept,
		"c1" : row.c1,
		"c2" : row.c2,
		"c3" : row.c3,
		"c4" : row.c4,
		"c5" : row.c5,
		"c6" : row.c6
	});
	
}
function editStudentSubmit() {
	if(document.getElementById("sno1").value==""||document.getElementById("sname1").value==""||document.getElementById("sdept1").value==""){
		alert("请填写完整信息");
		return;
	}else{
		location.href="/StudentScoreManageSystem/galter?sno="+document.getElementById("sno1").value+"&sname="+document.getElementById("sname1").value+"&sdept="+document.getElementById("sdept1").value+"&c1="+document.getElementById("c11").value+"&c2="+document.getElementById("c21").value+"&c3="+document.getElementById("c31").value+"&c4="+document.getElementById("c41").value+"&c5="+document.getElementById("c51").value+"&c6="+document.getElementById("c61").value+"&oldsno="+row.sno;
		
	}
	searchStudent();
	alert("修改成功");

}
function deleteStudent() {
	var snos = [];
	var rows = $("#studentDatagrid").datagrid("getSelections");
	if (rows.length < 1) {
		alert("请选中至少一条数据");
		return;
	} else {
		if (!confirm("确定要删除吗?")) {
			return;
		}
		for (var i = 0; i < rows.length; i++) {
			
			snos.push(rows[i].sno);
		}
		var snostring=snos.join(",");
		
		location.href="/StudentScoreManageSystem/gdelete?sno="+snostring;
		searchStudent();
		alert("删除成功，共删除"+rows.length+"条记录");
	}

}
function searchStudent() {

		var searchno=$("#searchno").val();
		var searchname=$("#searchname").val();
		var searchdept=$("#searchdept").val();
		var searchcourse=$("#searchcourse").val();
		
		location.href="/StudentScoreManageSystem/gsearch?sno="+searchno+"&sname="+searchname+"&course="+searchcourse+"&sdept="+searchdept;
	
}
function refreshStudent(){
	searchStudent();
	}
	
	
</script>
<body>
<div id='loading' style="position:absolute;z-index:1000;top:0px;left:0px;width:100%;height:100%;background:#DDDDDB;text-align:center;padding-top: 20%;"></div>
	<table id="studentDatagrid" class="easyui-datagrid"	 rowNumbers="true" fitColumns="true"
		toolbar="#tb" pagination="true" fit="true" >
		<thead >
			<tr  >
				<th field="ck" checkbox="true"></th>
				<th field="sno" >学号</th>
				<th field="sname">姓名</th>
				<th field="sdept">专业</th>
				<th field="c1">高等数学</th>
				<th field="c2">离散数学</th>
				<th field="c3">大学物理</th>
				<th field="c4">Java</th>
				<th field="c5">python</th>
				<th field="c6">c语言</th>
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
		List<Map> topiclist = (List<Map>)(session.getAttribute("key_listg"));
		
		int size = topiclist.size();
		
		pageCount = (size%PAGESIZE==0)?(size/PAGESIZE):(size/PAGESIZE+1);
		
		String tmp = request.getParameter("curPage");
		
		if(tmp==null){
			tmp="1";
		}
		curPage = Integer.parseInt(tmp);  
		List list1;
		if(curPage*PAGESIZE>size){list1=topiclist.subList((curPage-1)*PAGESIZE, size);}else{list1=topiclist.subList((curPage-1)*PAGESIZE, curPage*PAGESIZE);}
		session.setAttribute("key_listg1",list1);
		}
	    catch(Exception e){  
	          
	    } 
		%>
		<c:forEach items="${key_listg1}" var="usr" varStatus="idx">
        <tr>
        	<td></td>
			<td>${usr.sno}</td>
			<td>${usr.sname}</td> 
			<td>${usr.sdept}</td>
			<td>${usr.c1}</td> 
			<td>${usr.c2}</td>
			<td>${usr.c3}</td> 
			<td>${usr.c4}</td>
			<td>${usr.c5}</td> 
			<td>${usr.c6}</td>
		</tr>
		</c:forEach>
		<tr>
				<a href = "tab_score.jsp?curPage=1" >首页</a>  
				<a href = "tab_score.jsp?curPage=<%=curPage-1%>" >上一页</a>  
				<a href = "tab_score.jsp?curPage=<%=curPage+1%>" >下一页</a>  
				<a href = "tab_score.jsp?curPage=<%=pageCount%>" >尾页</a>  
				第<%=curPage%>页/共<%=pageCount%>页  
		</tr>
		</tbody>
	</table>
	<div id="tb" style="padding: 5px">
		<div style="margin-bottom: 10px">
		
			<span>学号:</span> <input type="text" name="searchno" id="searchno"/>
			<span>姓名:</span> <input type="text" name="searchname" id="searchname" value="" /> 
			<span>专业:</span> <input type="text" name="searchdept" id="searchdept"/>
			<span>学科:</span> <input type="text" name="searchcourse" id="searchcourse"/>
			<a href="javascript:searchStudent()" class="easyui-linkbutton" iconCls="icon-search">搜索</a>
			<a href="javascript:refreshStudent()" class="easyui-linkbutton" iconCls="icon-reset">刷新</a>
			
		</div>

		<div style="margin-bottom: 10px">
			<a href="javascript:addStudent()" class="easyui-linkbutton" iconCls="icon-add">添加学生</a> 
			<a id="edit" href="javascript:editStudent()" class="easyui-linkbutton" iconCls="icon-edit">修改学生</a> 
			<a id="delete" href="javascript:deleteStudent()" class="easyui-linkbutton" iconCls="icon-clear">删除学生</a>
			<form name="form" method="post" action="map_score.jsp">
           　　 <input type="submit" value="图表显示">
        　　</form>
		</div>
	</div>
	
	<div  id="studentWindow" style="width:800px;padding:10px">
		<form  method="post" id="studentForm">
			<table style="border-collapse: separate; border-spacing: 0px 10px;">
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
					<td>高等数学:</td>
					<td>
						<input type="text" id="c1" name="c1" autocomplete="off">
					</td>
				</tr>
				<tr>
					<td>离散数学:</td>
					<td>
						<input type="text" id="c2" name="c2" autocomplete="off">
					</td>
				</tr>
				<tr>
					<td>大学物理:</td>
					<td>
						<input type="text" id="c3" name="c3" autocomplete="off">
					</td>
				</tr>
				<tr>
					<td>Java:</td>
					<td>
						<input type="text" id="c4" name="c4" autocomplete="off">
					</td>
				</tr>
				<tr>
					<td>python:</td>
					<td>
						<input type="text" id="c5" name="c5" autocomplete="off">
					</td>
				</tr>
				<tr>
					<td>c语言:</td>
					<td>
						<input type="text" id="c6" name="c6" autocomplete="off">
					</td>
				</tr>
				<tr>
					<td><a href="javascript:addStudentSubmit()" id="sub"
						class="easyui-linkbutton" iconCls="icon-submit">提交</a></td>
				</tr>
			</table>
		</form>
	</div>
	<div  id="studentWindow1" style="width:800px;padding:10px">
		<form  method="post" id="studentForm1">
			<table style="border-collapse: separate; border-spacing: 0px 10px;">
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
					<td>高等数学:</td>
					<td>
						<input type="text" id="c11" name="c1" autocomplete="off">
					</td>
				</tr>
				<tr>
					<td>离散数学:</td>
					<td>
						<input type="text" id="c21" name="c2" autocomplete="off">
					</td>
				</tr>
				<tr>
					<td>大学物理:</td>
					<td>
						<input type="text" id="c31" name="c3" autocomplete="off">
					</td>
				</tr>
				<tr>
					<td>Java:</td>
					<td>
						<input type="text" id="c41" name="c4" autocomplete="off">
					</td>
				</tr>
				<tr>
					<td>python:</td>
					<td>
						<input type="text" id="c51" name="c5" autocomplete="off">
					</td>
				</tr>
				<tr>
					<td>c语言:</td>
					<td>
						<input type="text" id="c61" name="c6" autocomplete="off">
					</td>
				</tr>
				<tr>
					<td><a href="javascript:editStudentSubmit()" id="sub1"
						class="easyui-linkbutton" iconCls="icon-submit">提交</a></td>
				</tr>
			</table>
		</form>
	</div>
</body>

</html>