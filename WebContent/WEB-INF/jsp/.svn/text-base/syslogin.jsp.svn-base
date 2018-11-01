<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link
	href="http://cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css"
	rel="stylesheet">
<script src="http://libs.baidu.com/jquery/1.9.1/jquery.min.js"></script>
<script src="http://cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<title>系统管理员登录</title>
<script type="text/javascript">
	function formSubmit() {
		var user = document.getElementById("inputUsr").value;
		var pwd = document.getElementById("inputPwd").value;
		if (user == "" || pwd == "") {
			alert("用户名或者密码不能为空！");
			return;
		}
		$.ajax({
			url : '${base}/verifyPwdBefore',
			type : 'POST',
			data : {
				username : user,
				pwdword : pwd
			},
			async : true,
			dataType : 'json',
			success : function(data) {
				if ("1" == data) {
					$("#loginForm").submit();
				} else {
					alert("用户名或者密码错误！");
				}
			}
		});
	}

	///////////////////////////
	function formRest() {
		document.getElementById("inputUsr").value = "";
		document.getElementById("inputPwd").value = "";
	}
</script>
</head>
<body>
	<div class="container">
		<div class="row" style="margin-top: 100px;">
			<div class="col-sm-3"></div>
			<div class="col-sm-6">
				<div class="panel panel-default">
					<div class="panel-heading" style="text-align: center;">系统管理员登录界面</div>
					<div class="panel-body">

						<form class="form-horizontal" action="${base}/login" role="form" id="loginForm" method="post">

							<div class="form-group">
								<div class="input-group"
									style="margin-left: 60px; margin-right: 60px;">
									<span class="input-group-addon">用户名:</span> <input type="text"
										class="form-control" id="inputUsr" name="inputUsr"
										placeholder="请输入用户名">
								</div>
							</div>

							<div class="form-group">
								<div class="input-group"
									style="margin-left: 60px; margin-right: 60px;">
									<span class="input-group-addon">密 &nbsp; &nbsp;码:</span> <input
										type="password" class="form-control" id="inputPwd"
										name="inputPwd" placeholder="请输入密码">
								</div>
							</div>

							<div class="form-group" style="text-align: center;">
								<button type="button" class="btn btn-default active"
									onclick="formSubmit()">登录</button>
								<button type="button" class="btn btn-default active"
									onclick="formRest()">重置</button>
							</div>

						</form>

					</div>
				</div>
			</div>
			<div class="col-sm-3"></div>
		</div>
	</div>

</body>
</html>