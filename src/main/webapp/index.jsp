<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	pageContext.setAttribute("basePath", request.getContextPath());
%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>分页显示所有员工列表</title>

<!-- WEB路径问题：
			不是以 / 开头的相对路径以当前目录为基准查找资源，易出问题
			以 / 开头的相对路径以服务器根目录为基准查找资源
		-->
<script type="text/javascript"
	src="${basePath}/static/js/jquery-3.2.1.min.js"></script>
<link type="text/css" rel="stylesheet"
	href="${basePath}/static/bootstrap/css/bootstrap.min.css">
<script type="text/javascript"
	src="${basePath}/static/bootstrap/js/bootstrap.min.js"></script>
</head>
<body>

	<!-- Modal -->
	<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">添加员工</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label for="empName_add_input" class="col-sm-2 control-label">姓名：</label>
							<div class="col-sm-10">
								<input name="empName" type="text" class="form-control"
									id="empName_add_input" placeholder="员工姓名"> <span
									class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="email_add_input" class="col-sm-2 control-label">邮箱：</label>
							<div class="col-sm-10">
								<input name="email" type="email" class="form-control"
									id="email_add_input" placeholder="电子邮箱"> <span
									class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">性别：</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender1" value="M" checked="checked">
									男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender2" value="F"> 女
								</label>
							</div>
						</div>
						<div class="form-group">
							<label for="dept_add_select" class="col-sm-2 control-label">部门：</label>
							<div class="col-sm-4">
								<select id="dept_add_select" name="deptId" class="form-control">

								</select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button id="emp_save_button" type="button" class="btn btn-primary">保存</button>
				</div>
			</div>
		</div>
	</div>

	<!-- Modal -->
	<!-- 修改员工信息模态框 -->
	<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">修改员工信息</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label for="empName_update_input" class="col-sm-2 control-label">姓名：</label>
							<div class="col-sm-10">
								<p id="empName_update_static" class="form-control-static"></p>
								<span class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="email_update_input" class="col-sm-2 control-label">邮箱：</label>
							<div class="col-sm-10">
								<input name="email" type="email" class="form-control"
									id="email_update_input" placeholder="电子邮箱"> <span
									class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">性别：</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender1_update_input" value="M"
									checked="checked"> 男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender2_update_input" value="F"> 女
								</label>
							</div>
						</div>
						<div class="form-group">
							<label for="dept_add_select" class="col-sm-2 control-label">部门：</label>
							<div class="col-sm-4">
								<select id="dept_update_select" name="deptId"
									class="form-control">

								</select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button id="emp_update_button" type="button"
						class="btn btn-primary">修改</button>
				</div>
			</div>
		</div>
	</div>

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
				<button id="emp_add_modal_btn" class="btn btn-primary">新增</button>
				<button id="emp_delete_all_btn" class="btn btn-danger">批量删除</button>
			</div>
		</div>
		<!-- 显示表格 -->
		<div class="row">
			<div class="col-md-12">
				<table id="emps_table" class="table table-striped table-hover">
					<thead>
						<tr>
							<th>
								<input id="check_all" type="checkbox" />
							</th>
							<th>ID</th>
							<th>Name</th>
							<th>Gender</th>
							<th>E-Mail</th>
							<th>Department</th>
							<th>Operation</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
		</div>
		<!-- 分页信息 -->
		<div class="row">
			<div id="page_info_area" class="col-md-6"></div>
			<div id="page_nav_area" class="col-md-6"></div>
		</div>
	</div>
</body>

<script type="text/javascript">

	var totalRecords;
	var currentPage;

	//页面加载完成后发送ajax请求
	$(function() {
		to_page(1);
	});

	function to_page(pageNum) {
		$.ajax({
			url : "${basePath}/emps_json",
			data : "pageNum=" + pageNum,
			type : "GET",
			success : function(result) {
				console.log(result);
				//1.解析显示员工数据
				build_emps_table(result);
				//2.显示分页信息
				build_page_info(result);
				//3.显示分页条
				build_page_nav(result);
			}
		});
	}

	function build_emps_table(result) {
		$("#emps_table tbody").empty();

		var emps = result.info.pageInfo.list;
		$.each(emps, function(index, item) {
			console.log(item.empName);
			var checkBoxTd = $("<td><input type='checkbox' class='check_item' /></td>");
			var empIdTd = $("<td></td>").append(item.empId);
			var empNameTd = $("<td></td>").append(item.empName);
			var genderTd = $("<td></td>").append(item.gender == 'M' ? "男" : "女");
			var emailTd = $("<td></td>").append(item.email);
			var deptNameTd = $("<td></td>").append(item.department.deptName);
			var editButton = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
				.append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
				.append("编辑").attr("edit-id",item.empId);
			var deleteButton = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
				.append($("<span></span>").addClass("glyphicon glyphicon-trash"))
				.append("删除").attr("delete-id",item.empId);
			var btnTd = $("<td></td>").append(editButton).append(" ").append(deleteButton);
			$("<tr></tr>").append(checkBoxTd)
				.append(empIdTd)
				.append(empNameTd)
				.append(genderTd)
				.append(emailTd)
				.append(deptNameTd)
				.append(btnTd)
				.appendTo("#emps_table tbody");
		});
	}

	function build_page_info(result) {
		$("#page_info_area").empty();

		$("#page_info_area").append("当前为第" + result.info.pageInfo.pageNum +
			"页，共" + result.info.pageInfo.pages +
			"页，一共有" + result.info.pageInfo.total + "条记录！");

		totalRecords = result.info.pageInfo.total;
		currentPage = result.info.pageInfo.pageNum;
	}

	function build_page_nav(result) {
		$("#page_nav_area").empty();

		var ulist = $("<ul></ul>").addClass("pagination");
		var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
		var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;").attr("href", "#"));
		if (!result.info.pageInfo.hasPreviousPage) {
			firstPageLi.addClass("disabled");
			prePageLi.addClass("disabled");
		} else {
			firstPageLi.click(function() {
				to_page(1);
			});
			prePageLi.click(function() {
				to_page(result.info.pageInfo.pageNum - 1);
			});
		}

		var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;").attr("href", "#"));
		var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));
		if (!result.info.pageInfo.hasNextPage) {
			nextPageLi.addClass("disabled");
			lastPageLi.addClass("disabled");
		} else {
			lastPageLi.click(function() {
				to_page(result.info.pageInfo.pages);
			});
			nextPageLi.click(function() {
				to_page(result.info.pageInfo.pageNum + 1);
			});
		}

		ulist.append(firstPageLi).append(prePageLi);
		$.each(result.info.pageInfo.navigatepageNums, function(index, item) {
			var numLi = $("<li></li>").append($("<a></a>").append(item));
			if (result.info.pageInfo.pageNum == item) {
				numLi.addClass("active");
			}
			numLi.click(function() {
				to_page(item);
			});
			ulist.append(numLi);
		});
		ulist.append(nextPageLi).append(lastPageLi);

		var navEle = $("<nav></nav>").append(ulist).appendTo("#page_nav_area");
	}

	//弹出模态框
	$("#emp_add_modal_btn").click(function() {

		//重置整个表单数据
		form_reset("#empAddModal form");

		getDepts("#dept_add_select");

		$('#empAddModal').modal({
			backdrop : "static"
		});
	});

	function form_reset(ele) {
		$(ele)[0].reset();
		//清空表单样式
		$(ele).find("*").removeClass("has-error has-success");
		$(ele).find(".help-block").text("");
	}

	//查询所有部门信息
	function getDepts(ele) {
		//清空下拉列表的信息
		$(ele).empty()

		$.ajax({
			url : "${basePath}/depts",
			type : "GET",
			success : function(result) {
				console.log(result);
				$.each(result.info.depts, function() {
					var optionEle = $("<option></option>").append(this.deptName).attr("value", this.deptId);
					optionEle.appendTo(ele);
				});
			}
		});
	}

	function validate_add_form() {
		var empName = $("#empName_add_input").val();
		var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/
		regName.test(empName)
		if (!regName.test(empName)) {
			//alert("用户名应由2-5位中文或6-16位字母数字组合！！！")
			show_validate_msg("#empName_add_input", "error", "用户名应由2-5位中文或6-16位字母数字组合！！！")

			return false
		} else {
			show_validate_msg("#empName_add_input", "success", "")
		//$("#empName_add_input").parent().addClass("has-success");
		//$("#empName_add_input").next("span").text("");
		}

		var email = $("#email_add_input").val()
		var regEmail = /^([a-zA-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/
		if (!regEmail.test(email)) {
			//alert("邮箱格式不正确！！！")
			show_validate_msg("#email_add_input", "error", "邮箱格式不正确！！！")
			//$("#email_add_input").parent().addClass("has-error");
			//$("#email_add_input").next("span").text("邮箱格式不正确！！！");
			return false
		} else {
			show_validate_msg("#email_add_input", "success", "")
		//$("#email_add_input").parent().addClass("has-success");
		//$("#email_add_input").next("span").text("");
		}
		return true
	}

	function show_validate_msg(ele, status, msg) {
		//请删除状态
		$(ele).parent().removeClass("has-success has-error");
		$(ele).next("span").text("");
		if (status == "success") {
			$(ele).parent().addClass("has-success");
			$(ele).next("span").text(msg);
		} else if (status == "error") {
			$(ele).parent().addClass("has-error");
			$(ele).next("span").text(msg);
		}
	}

	//校验用户名是否可用
	$("#empName_add_input").change(function() {
		var empName = this.value;
		$.ajax({
			url : "${basePath}/checkUserName",
			data : "empName=" + empName,
			type : "POST",
			success : function(result) {
				if (result.code == 100) {
					show_validate_msg("#empName_add_input", "success", "用户名可用！！！");
					$("#emp_save_button").attr("ajax-va", "success");
				} else {
					show_validate_msg("#empName_add_input", "error", result.info.va_msg);
					$("#emp_save_button").attr("ajax-va", "error");
				}
			}
		});
	});

	$("#emp_save_button").click(function() {
		//获取表单数据
		var formData = $("#empAddModal form").serialize();
		console.log(formData);

		/* if (!validate_add_form()) {
			return false;
		} */

		if ($("#emp_save_button").attr("ajax-va") == "error") {
			return false
		}

		//提交表单数据
		$.ajax({
			url : "${basePath}/emp",
			type : "POST",
			data : formData,
			success : function(result) {
				if (result.code == 100) {
					$("#empAddModal").modal("hide")
					to_page(totalRecords)
				} else {
					//显示校验失败信息
					console.log(result);
					//显示错误字段的错误信息
					if (undefined != result.info.errorFields.email) {
						show_validate_msg("#email_add_input", "error", result.info.errorFields.email)
					}
					if (undefined != result.info.errorFields.empName) {
						show_validate_msg("#epmName_add_input", "error", result.info.errorFields.empName)
					}
				}
			}
		});
	});

	//绑定按钮点击事件
	//1.在创建按钮的时候绑定点击事件
	//2.使用live()方法，JQuery新版本没有live()方法，用on()方法替代
	$(document).on("click",".edit_btn",function(){
		//1.查询相关信息弹出模态框
		//$("#empName_update_static")
		getEmpInfo($(this).attr("edit-id"));
		getDepts("#empUpdateModal select");

		//把员工ID传递给更新按钮
		$("#emp_update_button").attr("edit-id",$(this).attr("edit-id"));
		$("#empUpdateModal").modal({
			backdrop: "static"
		});
	});

	function getEmpInfo(id){
		$.ajax({
			url:"${basePath}/emp/" + id,
			type: "GET",
			success: function(result){
				console.log(result);
				var empInfo = result.info.emp;
				$("#empName_update_static").text(empInfo.empName);
				$("#email_update_input").val(empInfo.email);
				$("#empUpdateModal input[name=gender]").val([empInfo.gender]);
				$("#empUpdateModal select").val([empInfo.deptId]);
			}
		});
	}

	//更新员工信息
	$("#emp_update_button").click(function(){
		//验证邮箱格式
		var email = $("#email_update_input").val()
		var regEmail = /^([a-zA-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/
		if (!regEmail.test(email)) {
			//alert("邮箱格式不正确！！！")
			show_validate_msg("#email_update_input", "error", "邮箱格式不正确！！！")
			//$("#email_add_input").parent().addClass("has-error");
			//$("#email_add_input").next("span").text("邮箱格式不正确！！！");
			return false
		} else {
			show_validate_msg("#email_update_input", "success", "")
		//$("#email_add_input").parent().addClass("has-success");
		//$("#email_add_input").next("span").text("");
		}

		//发送ajax请求保存更新数据
		$.ajax({
			url:"${basePath}/emp/" + $(this).attr("edit-id"),
			type: "PUT",
			data: $("#empUpdateModal form").serialize(),
			success: function(result){
				//alert(result.msg);
				//关闭对话框
				$("#empUpdateModal").modal("hide");
				//回到本页面
				to_page(currentPage);
			}
		});
	});

	//删除单个员工
	$(document).on("click",".delete_btn",function(){
		//弹出确认对话框
		var empName = $(this).parents("tr").find("td:eq(2)").text();
		if(confirm("确定要删除【" + empName + "】吗？？？")){
			$.ajax({
				url:"${basePath}/emp/" + $(this).attr("delete-id"),
				type: "DELETE",
				success: function(result){
					alert(result.msg);
					to_page(currentPage);
				}
			});
		}
	});

	//实现全选/全不选
	$("#check_all").click(function(){
		//$(this).prop("checked");
		$(".check_item").prop("checked",$(this).prop("checked"));
	});

	$(document).on("click",".check_item",function(){
		var flag = $(".check_item:checked").length == $(".check_item").length;
			$("#check_all").prop("checked",flag);
		//$("#check_all").porp("checked")
	});

	//批量删除员工
	$("#emp_delete_all_btn").click(function(){
		var empNames = "";
		var del_idstr = "";
		$.each($(".check_item:checked"),function(){
			empNames += $(this).parents("tr").find("td:eq(2)").text() + ",";
			del_idstr += $(this).parents("tr").find("td:eq(1)").text() + "-";
		});
		empNames = empNames.substring(0, empNames.length - 1);
		del_idstr = del_idstr.substring(0, del_idstr.length - 1);
		if(confirm("确认删除【" + empNames + "】吗？？？")){
			//发送AJAX请求
			$.ajax({
				url:"${basePath}/emp/" + del_idstr,
				type: "DELETE",
				success: function(result){
					alert(result.msg);
					to_page(currentPage);
				}
			});
		}
	});

</script>
</html>