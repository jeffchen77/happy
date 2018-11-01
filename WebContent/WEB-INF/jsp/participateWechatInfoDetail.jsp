<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
		<link rel="stylesheet" type="text/css" href="http://cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">
		<link rel="stylesheet" type="text/css" href="css/qscui.css">
		<link rel="stylesheet" href="bootstrap3.3.5/css/myInfoStyle.css" />
		<link rel="stylesheet" type="text/css" href="css/upgrade.css">
		<link rel="stylesheet" type="text/css" href="http://cdn.bootcss.com/font-awesome/4.2.0/css/font-awesome.min.css">
		<link rel="stylesheet" type="text/css" href="http://www.bootcss.com/p/buttons/css/buttons.css ">
		<link rel="stylesheet" type="text/css" href="http://sandbox.runjs.cn/uploads/rs/340/ustg8wvx/weui.css">
		<link rel="stylesheet" type="text/css" href="bootstrap3.3.5/css/app.css">
		<script type="text/javascript"	src="http://sandbox.runjs.cn/uploads/rs/340/ustg8wvx/weui.js"></script>
		<script type="text/javascript"	src="http://libs.baidu.com/jquery/1.9.1/jquery.min.js"></script>
		<script type="text/javascript"	src="http://cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
		<script type="text/javascript"	src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<title>参与人列表</title>
</head>
<body>
	<div class="container" style="background-color:white;padding:10px 5px 0px 5px;">
		<div class="row">
			<c:choose>
				<c:when test="${obj.yesParticipateWechatInfo != null && obj.yesParticipateWechatInfo.size()>0}">
					<div class="col-xs-6">
						<c:forEach var="yesPartiWechatInfo" items="${obj.yesParticipateWechatInfo}" varStatus="preIndex">
							<div class="row">
								<div class="col-xs-4" style="padding-left: 20px;">
									<img   class="img-circle" style="width:60px;height:60px;" src="${yesPartiWechatInfo.headImgUrl}"  >
								</div>
								<div class="col-xs-8" style="padding-left: 35px;">
									<span>${yesPartiWechatInfo.nickName}</span>
								</div>
							</div>
						</c:forEach>
					</div>
				</c:when>
			</c:choose>
			<c:choose>
				<c:when test="${obj.noParticipateWechatInfo != null && obj.noParticipateWechatInfo.size()>0}">
					<div class="col-xs-6">
						<c:forEach var="noPartiWechatInfo" items="${obj.noParticipateWechatInfo}" varStatus="preIndex">
							<div class="row">
								<div class="col-xs-6 pull-right" style="padding-left: 0px;">
									<img   class="img-circle" style="width:60px;height:60px;" src="${noPartiWechatInfo.headImgUrl}"  >
								</div>
								<div class="col-xs-6 pull-right" style="padding-left: 0px;">
									<span class=" pull-right">${noPartiWechatInfo.nickName}</span>
								</div>
							</div>
						</c:forEach>
					</div>
				</c:when>
			</c:choose>
		</div>
	</div>
</body>
</html>