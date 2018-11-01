<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link rel="stylesheet" type="text/css" href="css/pullToRefresh.css">
<link href="http://cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css" rel="stylesheet">
<link href="bootstrap3.3.5/css/app.css" rel="stylesheet">
<link rel="stylesheet" href="bootstrap3.3.5/css/myInfoStyle.css" />
<link rel="stylesheet" type="text/css" href="css/task.css?random=3.1">
<link rel="stylesheet" type="text/css" href="http://cdn.bootcss.com/font-awesome/4.2.0/css/font-awesome.css">
<script type="text/javascript"	src="js/iscroll.js"></script>
<script type="text/javascript"	src="js/pullToRefresh.js"></script>
<script src="http://libs.baidu.com/jquery/1.9.1/jquery.min.js"></script>
<script src="http://cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<title>战绩榜</title>
<script>
function goToOnLineGame(activityId) {
	window.location.href="${base}/weixin/baseoauth?action=onlineGame&activityId="+activityId;
}
</script>
</head>
<body>
	<div  class="m-b"  style="background-color: #5bc0de;">
				<div class="row" style="padding: 5px; margin-left:0px; margin-right:0px;">
					<div class="col-xs-3 " style="padding-left: 0px;">
						<img id="userImgUrl" class="img-circle" style="width:60px;height:60px;" src="${obj.wechatUser.headImgUrl}" >
					</div>
					<div class="col-xs-8" style="color:white;">
						<div class="row">
							<div class="col-xs-6" style=" ">
								<p class="h6">${obj.wechatUser.nickName}</p>	
								<input id="userId" type="hidden" value="${obj.wechatUser.userId}">							
							</div>
							<div class="col-xs-6" style="padding-left:0px">
								<p class="h6">总胜率：${obj.user.forecastAccuracy}</p>
							</div>
						</div>
						<div class="row" >
							<div class="col-xs-6" style=" ">
								<a id="transPointsRecords"><p class="h6"  id="level-display">城池：${obj.userPoints.allPoints-obj.userPoints.lockedPoints}/${obj.userPoints.allPoints}</p></a>
							</div>
							<div class="col-xs-6" style="padding-left:0px">
								<p class="h6" id="level-honest"> </p>								
							</div>
						</div>
					</div>

				</div>
		</div>

	<div class="box">
		<div class="box-header with-border">
			<h4 style="font-size:0.22rem" class="box-title label label-info">赢场</h4>

		</div>
		<div id="unReadBox" class="box-body">
			<c:choose>

				<c:when
					test="${obj.listOfWinAct != null && obj.listOfWinAct.size() > 0 }">
					<c:forEach var="perAct" items="${obj.listOfWinAct}"
						varStatus="preIndex">
						<div class = "row">
							<div class="col-xs-9" style="font-weight: bold" onclick="goToOnLineGame('${perAct.activity_id}')">
								${perAct.activity_desc}
							</div>
							<c:choose>
								<c:when test="${perAct.result_status == 1}">
									<div class="col-xs-3" style="font-weight: bold"; color:blue;>支持胜</div>
								</c:when>
								<c:otherwise>
									<div class="col-xs-3" style="font-weight: bold; color:blue;">反对胜</div>
								</c:otherwise>
							</c:choose>
							<br><br>						
						</div>
					</c:forEach>
				</c:when>
			</c:choose>
		</div>
	</div>
	<div id="moreRecord" class="btn btn-sm btn-default btn-block"
		onclick="displayMore()">点击查看更多</div>
		
		
	<div class="box" style="margin-top: 0.3rem;">
		<div class="box-header with-border">
			<h4 style="font-size:0.22rem" class="box-title label label-info">输场</h4>

		</div>
		<div id="MostRedBox" class="box-body">
			<c:choose>
				<c:when
					test="${obj.listOfLoseAct != null && obj.listOfLoseAct.size() > 0 }">
					<c:forEach var="perAct" items="${obj.listOfLoseAct}">
						<div class = "row">
							<div class="col-xs-9" style="font-weight: bold" onclick="goToOnLineGame('${perAct.activity_id}')">
								${perAct.activity_desc}
							</div>
							<c:choose>
								<c:when test="${perAct.result_status == 1}">
									<div class="col-xs-3" style="font-weight: bold; color:blue;">支持胜</div>
								</c:when>
								<c:otherwise>
									<div class="col-xs-3" style="font-weight: bold; color:blue;">反对胜</div>
								</c:otherwise>
							</c:choose>
							<br><br>
						</div>
					</c:forEach>
				</c:when>
			</c:choose>
		</div>
	</div>
	<div id="moreRecord" class="btn btn-sm btn-default btn-block"
		onclick="displayMore()">点击查看更多</div>
		
<div class="footerHome">
	<div class="footerMune">
		<a href="${base}/weixin/baseoauth?action=challengIndex" style="text-decoration: none;">
    	<i class="fa fa-paint-brush fa-2x"></i>
        <p>发起</p>
        </a>
    </div>
	
	<div class="footerMune">
		<a href="${base}/weixin/baseoauth?action=findActivity" style="text-decoration: none;">
    	<i class="fa fa-eye fa-2x"></i>
        <p>发现</p>
        </a>
    </div>
	<div class="footerMune">
		<a href="${base}/myActivityIndex?userId=${obj.openId}&ownerOrParter=1"  style="text-decoration: none;">
    	<i class="fa fa-bars fa-2x"></i>
        <p>我的</p>
        </a>
    </div> 
    <div class="footerMune">
		<a href="${base}/weixin/baseoauth?action=myInfoIndex" style="text-decoration: none;">
    	<i class="fa fa-user fa-2x"></i>
        <p>设置</p>
        </a>
    </div>
</div>

<script >
(function(doc, win) {
                var docEl = doc.documentElement,
                                resizeEvt = 'orientationchange' in window ? 'orientationchange' : 'resize',
                                recalc = function() {
                                                var clientWidth = docEl.clientWidth;
                                                if (!clientWidth) return;
                                                docEl.style.fontSize = 100 * (clientWidth / 750) + 'px';
                                };
                if (!doc.addEventListener) return;
                win.addEventListener(resizeEvt, recalc, false);
                doc.addEventListener('DOMContentLoaded', recalc, false);
})(document, window)
</script>

</body>


</html>