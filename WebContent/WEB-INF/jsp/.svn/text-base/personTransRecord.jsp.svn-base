<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="viewport"
			content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
		<title>交易流水</title>
		<link href="http://cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css" rel="stylesheet">
		<link rel="stylesheet" type="text/css" href="css/qscui.css">
		<link rel="stylesheet" type="text/css" href="css/upgrade.css">
		<link rel="stylesheet" type="text/css" href="http://cdn.bootcss.com/font-awesome/4.2.0/css/font-awesome.min.css">
		<link rel="stylesheet" type="text/css" href="http://www.bootcss.com/p/buttons/css/buttons.css ">
		<script type="text/javascript" src="http://sandbox.runjs.cn/uploads/rs/340/ustg8wvx/weui.js"></script>
		<link rel="stylesheet" type="text/css" href="http://sandbox.runjs.cn/uploads/rs/340/ustg8wvx/weui.css">
		<link href="http://cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap-theme.min.css" rel="stylesheet">
		<link href="bootstrap3.3.5/css/app.css" rel="stylesheet">
		<script src="http://libs.baidu.com/jquery/1.9.1/jquery.min.js"></script>
		<script src="http://cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

	</head>
	<body>
		<div id="personTransRecord" class="container" >
			<c:choose>
				<c:when test="${obj!=null && obj.size()>0}"> 	
					<c:forEach var="perRecord" items="${obj}" varStatus="preIndex">
						<div class="row" style="background-color:white;margin:5px 2px 5px 2px;">
							<div class="col-xs-3 m-t" style="padding-left: 5px;">
								<span class="h6"><fmt:formatDate value="${perRecord.transTime}" pattern="yyyy/MM/dd HH:mm" /></span>
							</div>
							<div class="col-xs-3 m-t" style="padding-left: 0px;text-align:center;">
								<img id="userImgUrl" class="img-circle" style="width:50px;height:50px;" src="${perRecord.headImgUrl}" >
							</div>
							<div class="col-xs-6">
							     <div class="row">
									<div  class="col-xs-12 m-t" style="text-align:center;">
										<c:choose>
											<c:when test="${perRecord.transPoints>=0}">
												<p class="h6" style="color:red;"><b>${perRecord.transPoints}</b></p>
											</c:when>
											<c:otherwise>
												<p class="h6" style="color:green;"><b>${perRecord.transPoints}</b></p>
											</c:otherwise>	
										</c:choose>
									</div>
								</div>
								<div class="row" >
									<div class="col-xs-6 m-t" style="text-align:center; ">
										<p class="h6">${perRecord.befTransPoints}</p>
									</div>
									<div  class="col-xs-6 m-t" style="padding-left:0px;text-align:center;">
										<p class="h6">${perRecord.aftTransPoints}</p>								
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<div class="container" style="background-color:white; padding-bottom:30px;">
						<div class="h5 text-muted" style="padding-top:50px;text-align:center;">
							<span>亲，你还城池交易记录！</span>		
						</div>
					</div>
				</c:otherwise>
			</c:choose> 
		</div>
	</body>
</html>