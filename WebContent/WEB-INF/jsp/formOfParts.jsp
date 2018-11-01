<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
		<link rel="stylesheet" type="text/css" href="http://cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">
		<link rel="stylesheet" type="text/css" href="http://sandbox.runjs.cn/uploads/rs/340/ustg8wvx/weui.css">
		<link rel="stylesheet" type="text/css" href="bootstrap3.3.5/css/app.css">
		<script src="js/Chart-1.0.1-beta.4.js"></script>
<!-- 		<link rel="stylesheet" type="text/css" href="css/qscui.css"> -->
		<link rel="stylesheet" href="bootstrap3.3.5/css/myInfoStyle.css" />
<!-- 		<link rel="stylesheet" type="text/css" href="css/upgrade.css"> -->
		<link rel="stylesheet" type="text/css" href="http://cdn.bootcss.com/font-awesome/4.2.0/css/font-awesome.min.css">
		<link rel="stylesheet" type="text/css" href="http://www.bootcss.com/p/buttons/css/buttons.css ">
		<link rel="stylesheet" type="text/css" href="http://sandbox.runjs.cn/uploads/rs/340/ustg8wvx/weui.css">
		<link rel="stylesheet" type="text/css" href="bootstrap3.3.5/css/app.css">
		<script type="text/javascript"	src="http://sandbox.runjs.cn/uploads/rs/340/ustg8wvx/weui.js"></script>
		<script type="text/javascript"	src="http://libs.baidu.com/jquery/1.9.1/jquery.min.js"></script>
		<script type="text/javascript"	src="http://cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
		<script type="text/javascript"	src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<title>参与者报表统计</title>

<script>
	var win = ${obj.win};
	var lose = ${obj.lose};
// var win = 8;
// var lose = 6;
	var data = [
		{
			label: "反对者",
			value : lose,
			color :"#F38630"
		}	,
		{
			label: "支持者",
			value: win,
			color: "#69D2E7"
		}
				
	];
	
	var chartPie = null;
	window.onload = function(){				
		var ctx = document.getElementById("myChart").getContext("2d");
		chartPie = new Chart(ctx).Pie(data, {segmentShowStroke : false, showTooltips : 1});
		initEvent(chartPie, clickCall);
	}
	
	function clickCall(evt) {
		var segments = chartPie.getSegmentsAtEvent(evt);
		
		if ( segments.length > 0 ) {
			var segment = segments[0];
			/* alert( segment.label + ": " + segment.value); */
		}
	}
	
	function initEvent(chart, handler) {
		var method = handler;
		var eventType = "click";
		var node = chart.chart.canvas;
		
		if (node.addEventListener) {
			node.addEventListener(eventType, method);
		} else if (node.attachEvent) {
			node.attachEvent("on" + eventType, method);
		} else {
			node["on" + eventType] = method;
		}
	}
	function choosePer( num ){
		window.location.href="${base}/formOfPartsInAct?actId=${obj.actId}&percent="+num;
	}
	function activityDetail()
	{
		var actId= "${obj.actId}";
		window.location.href="${base}/weixin/baseoauth?action=onlineGame&activityId="+actId;
	}
	
	function goToActListOfUser(userId){
		var templateId = "${obj.templateId}";
		window.location.href="${base}/gameListOfUser?userId="+userId+"&templateId="+templateId;
	}
</script>
</head>
<body>
	<div class="container" style="background-color:white;padding:10px 5px 0px 5px;">
		<div id="legend" class="row">
			
		
			<div class="col-xs-4" style="background-color:#69D2E7;">
				<span >支持者：${obj.win}/${obj.lose + obj.win}
				</span>
			</div>
			<div class="col-xs-4 " style="background-color:#F38630;">
				<span  class="pull-right" >反对者：${obj.lose}/${obj.lose + obj.win}
				</span>
			</div>
			
			<div class="col-xs-4 "  >
				<span  class="pull-right" > 
				</span>
			</div>
		</div>
		<br>
		<div class="row" >
			<div class="col-xs-4 " >
				<canvas id="myChart"  >
				</canvas>
			</div>
			<div class="col-xs-4 "   style="width:49%;float:right;">
				<div class="row "  >
					<button onclick="choosePer(70)"  class="pull-right">骨灰玩家</button>
				</div>
				<div class="row " >
					<button onclick="choosePer(60)"  class="pull-right">资深专家</button>
				</div>
				<div class="row" >
					<button onclick="choosePer(50)"  class="pull-right">五成功力</button>
				</div>
				<div class="row">
					<button onclick="choosePer(0)"  class="pull-right">所有成员</button>
				</div>
			</div>
		</div>
	</div>	
	<div class="row" >
					<button onclick="activityDetail()"  class="center">返回活动详情</button>
	</div>
	<div class="container" style="background-color:white;padding:10px 5px 0px 5px;">
		<div class="box-header with-border">
			<h4 class="box-title label label-info">参与者列表</h4>
		</div>
		<div class="row">
				<c:choose>
				<c:when test="${obj.yesParticipateWechatInfo != null && obj.yesParticipateWechatInfo.size()>0}">
					<div class="col-xs-6">
						<c:forEach var="yesPartiWechatInfo" items="${obj.yesParticipateWechatInfo}" varStatus="preIndex">
							<div class="row"  >
								<div class="col-xs-4" style="padding-left: 20px;" onclick="goToActListOfUser('${yesPartiWechatInfo.user_id}')">
									<img   class="img-circle" style="width:60px;height:60px;" src="${yesPartiWechatInfo.headImgUrl}"  >
								</div>
								<div class="col-xs-8" style="padding-left: 35px;">
									<div class="row" >
										<span class=" pull-right">${yesPartiWechatInfo.nickName}</span>
									</div>
									<div class="row" >
											<span class=" pull-right">胜率：${yesPartiWechatInfo.forecastAccuracyOfTmplate}</span>
									</div>
									<div class="row" >
											<span class=" pull-right">参与：${yesPartiWechatInfo.countAllOfTmplate}次</span>
									</div>
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
							<div class="row" >
								<div class="col-xs-4 pull-right" style="padding-left: 0px;" onclick="goToActListOfUser('${noPartiWechatInfo.user_id}')">
									<img   class="img-circle" style="width:60px;height:60px;" src="${noPartiWechatInfo.headImgUrl}"  >
								</div>
								<div class="col-xs-8 " style="padding-left: 0px;">
									<div class="row" >
										<span class=" pull-right">${noPartiWechatInfo.nickName}</span>
									</div>
									<div class="row" >
											<span class=" pull-right">胜率：${noPartiWechatInfo.forecastAccuracyOfTmplate}</span>
									</div>
									<div class="row" >
											<span class=" pull-right">参与：${noPartiWechatInfo.countAllOfTmplate}次</span>
										</div>
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