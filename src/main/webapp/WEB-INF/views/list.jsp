<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	pageContext.setAttribute("basePath",request.getContextPath());
%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>分写显示所有员工列表</title>

		<!-- WEB路径问题：
			不是以 / 开头的相对路径以当前目录为基准查找资源，易出问题
			以 / 开头的相对路径以服务器根目录为基准查找资源
		-->
		<link type="text/css" rel="stylesheet" href="${basePath}/static/bootstrap/css/bootstrap.min.css" >
		<script type="text/javascript" src="${basePath}/static/bootstrap/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="${basePath}/static/js/jquery-3.2.1.min.js" ></script>
	</head>
	<body>
		<!-- 构建页面 -->
		<div class="container">
			<!-- 标题行 -->
			<div class="row">
				<div class="col-md-12">
					<h1>SSM-CRUD实战项目</h1>
				</div>
			</div>
			<!-- 按钮 -->
			<div class="row">
				<div class="col-md-4 col-md-offset-8">
					<button class="btn btn-primary" >新增</button>
					<button class="btn btn-danger" >批量删除</button>
				</div>
			</div>
			<!-- 显示表格 -->
			<div class="row">
				<div class="col-md-12">
					<table class="table table-striped table-hover">
						<tr>
							<th>ID</th>
							<th>Name</th>
							<th>Gender</th>
							<th>E-Mail</th>
							<th>Department</th>
							<th>Operation</th>
						</tr>
						<c:forEach items="${pageInfo.list}" var="emp">
							<tr>
								<td>${emp.empId}</td>
								<td>${emp.empName}</td>
								<td>${emp.gender == "M" ? "男" : "女"}</td>
								<td>${emp.email}</td>
								<td>${emp.department.deptName}</td>
								<td>
									<button class="btn btn-primary btn-sm">
										<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
										编辑
									</button>
									<button class="btn btn-danger btn-sm">
										<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
										删除
									</button>
								</td>
							</tr>
						</c:forEach>
					</table>
				</div>
			</div>
			<!-- 分页信息 -->
			<div class="row">
				<div class="col-md-6">
					当前为${pageInfo.pageNum}页，共${pageInfo.pages}页，一共有${pageInfo.total}条记录！
				</div>
				<div class="col-md-6">
					<nav aria-label="Page navigation">
  						<ul class="pagination">
  							<li>
  								<a href="${basePath}/emps?pageNum=1">首页</a>
    						</li>
  							<li>
  								<c:if test="${pageInfo.hasPreviousPage}">
  									<a href="${basePath}/emps?pageNum=${pageInfo.pageNum - 1}" aria-label="Previous">
        								<span aria-hidden="true">&laquo;</span>
      								</a>
  								</c:if>
    						</li>
    						<c:forEach items="${pageInfo.navigatepageNums}" var="pageNum">
    							<c:if test="${pageNum == pageInfo.pageNum}">
    								<li class="active"><a href="#">${pageNum}</a></li>
    							</c:if>
    							<c:if test="${pageNum != pageInfo.pageNum}">
    								<li><a href="${basePath}/emps?pageNum=${pageNum}">${pageNum}</a></li>
    							</c:if>
    						</c:forEach>
    						<c:if test="${pageInfo.hasNextPage}">
    							<li>
      								<a href="${basePath}/emps?pageNum=${pageInfo.pageNum + 1}" aria-label="Next">
        								<span aria-hidden="true">&raquo;</span>
      								</a>
    							</li>
    						</c:if>
    						<li>
  								<a href="${basePath}/emps?pageNum=${pageInfo.pages}">末页</a>
  							</li>
  						</ul>
					</nav>
				</div>
			</div>
		</div>
	</body>
</html>