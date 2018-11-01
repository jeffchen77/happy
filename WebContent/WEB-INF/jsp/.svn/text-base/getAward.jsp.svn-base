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
<link rel="stylesheet" href="bootstrap3.3.5/css/myInfoStyle.css" />
<link rel="stylesheet" href="css/task.css?random=1.4" />
<link rel="stylesheet"
	href="http://cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css"
	href="http://cdn.bootcss.com/font-awesome/4.2.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css"
	href="http://sandbox.runjs.cn/uploads/rs/340/ustg8wvx/weui.css">
<script type="text/javascript"
	src="http://sandbox.runjs.cn/uploads/rs/340/ustg8wvx/weui.js"></script>

<script src="http://libs.baidu.com/jquery/1.9.1/jquery.min.js"></script>
<script src="http://cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<title>签到领取任务</title>
<script type="text/javascript">
	$(document).ready(
			function() {
				var honest = "${user.integritylRank}";
				var htmlhonest = "";
				switch (honest) {
				case 1:
					htmlhonest = "诚信度:继续改进";
					break;
				case 2:
					htmlhonest = "诚信度:基本靠谱";
					break;
				case 3:
					htmlhonest = "诚信度:诚实守信";
					break;
				case 4:
					htmlhonest = "诚信度:君子楷模";
					break;
				default:
					htmlhonest = "诚信度:完美无瑕";
				}
				$("#level-honest").html(htmlhonest);
				//设置城池交易流水链接

				var userId = "${wechatUser.userId}";

				if (userId != null) {
					var url = "${base}/getTransPointsRecords?userId=" + userId
							+ "&pageNumber=1";
					document.getElementById("transPointsRecords").setAttribute(
							'href', url);
				}
			});
</script>
</head>
<body class="m-b item" style="background-color: #f5f5f5;">
	<div class="m-b" style="background-color: #5bc0de;">
		<div class="row"
			style="padding: 5px; margin-left: 0px; margin-right: 0px;">
			<div class="col-xs-3" style="padding-left: 0px;">
				<img class="img-circle" style="width: 60px; height: 60px;"
					src="${wechatUser.headImgUrl}" onclick="checkNewUrl()">
			</div>
			<div class="col-xs-8" style="color: white; padding: 0px">
				<div class="row">
					<div class="col-xs-6">
						<p class="h6">${wechatUser.nickName}</p>
					</div>
					<div class="col-xs-6">
						<p class="h6">胜率：${dsbRate}</p>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<a id="transPointsRecords"><p class="h6" id="level-display">城池数：${userPoints.allPoints-userPoints.lockedPoints}/${userPoints.allPoints}</p></a>
					</div>
					<div class="col-xs-6">
						<p class="h6" id="level-honest"></p>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div style="margin-top: 0.2rem;">
		<span class="title bg-title" href="#">领取奖励</span>
	</div>
	<div>
		<c:forEach var="ai" items="${awardMap}">
			<div class="info-box" id=${ai['divId']}>

				<div class="info-box-content" id=${ai['pgmId']}>
					<span class="info-box-title">${ai['pgmTitle']}</span> <span
						class="info-box-text">${ai['pgmDesc']}</span> <input type="hidden"
						value="${ai['pgmPoints']}">
				</div>
				<span class="info-box-icon bg-aqua pull-right" name="${ai['isGet']}"
					onclick="getAward(this)">领取</span>
				<!-- /.info-box-content -->

			</div>
		</c:forEach>
	</div>
	<div>
		<a style="color: #5bc0de;" class="btn btn-default btn-block">更多活动</a>
	</div>
	<div style="margin-top: 0.2rem;">
		<span class="title bg-title" href="#">热门兑换</span>
	</div>
	<div>
		<c:forEach var="good" items="${hotgoods}">
			<div class="info-box">

				<div class="info-box-content">
					<span class="info-box-title">${good['good_name']}</span> <span
						class="info-box-text">${good['good_desc']}</span>
				</div>
				<span class="info-box-icon bg-point pull-right" onclick="openGood(${good['id']})">兑换</span>
				<!-- /.info-box-content -->

			</div>
		</c:forEach>
	</div>
	<div>
		<a style="color: #E66767;" class="btn btn-default btn-block" href="${base}/awardShop?userId=${wechatUser.userId}">更多兑换</a>
	</div>
	<div style="height: 60px;"></div>
	<footer>
		<div class="mune">
		<a href="${base}/getUserReport?userId=${wechatUser.userId}" style="text-decoration: none;">
    	<i class="fa fa-trophy fa-2x"></i>
        <p>榜单</p>
        </a>
    </div>
    
	<div class="mune">
		<a href="${base}/weixin/baseoauth?action=findActivity" style="text-decoration: none;">
    	<i class="fa fa-eye fa-2x"></i>
        <p>发现</p>
        </a>
    </div>
    
	<div class="mune">
		<a href="${base}/myActivityIndex?userId=${wechatUser.userId}&ownerOrParter=1" style="text-decoration: none;">
    	<i class="fa fa-bars fa-2x"></i>
        <p>我的</p>
        </a>
    </div>
    <div class="mune">
		<a href="${base}/weixin/baseoauth?action=myInfoIndex" style="text-decoration: none;">
    	<i class="fa fa-user fa-2x"></i>
        <p>设置</p>
        </a>
    </div>
	</footer>
	<!-- 模态框（Modal） -->
 	  <div class="modal fade" id="myModal" role="dialog" 
	   aria-labelledby="myModalLabel" aria-hidden="true">
	   <div class="modal-dialog" style="margin: 20%;width:4.2rem; height:4.2rem;">
	      <div class="modal-content">
	         <div class="modal-header" style="padding: 0.1rem;">
	            <button type="button" class="close" 
	               data-dismiss="modal" aria-hidden="true">
	                  &times;
	            </button>
	            <h4 class="modal-title" id="myModalLabel">
	             	  关注朕以为
	            </h4>
	         </div>
	         <div class="modal-body" style="padding:0.08rem;">
	          <div><img src="images/qrcode.jpg" style="width: 4.0rem;height: 4.0rem;"></div>
	         </div>
	      </div>
		</div>
	</div>
	<script type="text/javascript">
		$(document).ready(function() {
			$('[name="hasGet"]').removeClass('bg-aqua');
			$('[name="hasGet"]').addClass('bg-disable');
			$('[name="hasGet"]').removeAttr('onclick');
			$('[name="hasGet"]').text('已领取');
		});
		(function(doc, win) {
			var docEl = doc.documentElement, resizeEvt = 'orientationchange' in window ? 'orientationchange'
					: 'resize', recalc = function() {
				var clientWidth = docEl.clientWidth;
				if (!clientWidth)
					return;
				docEl.style.fontSize = 100 * (clientWidth / 750) + 'px';
			};
			if (!doc.addEventListener)
				return;
			win.addEventListener(resizeEvt, recalc, false);
			doc.addEventListener('DOMContentLoaded', recalc, false);
		})(document, window);

		function getAward(obj) {
			//调用action
			var pgmPoints = $(obj).prev().children().eq('2').val();
			var pgmId = $(obj).prev().attr('id');
			if(pgmId == "PGMNEW"){
				window.location.href="${base}/weixin/baseoauth?action=challengIndex";
				return;
			}
			var userId = "${wechatUser.userId}";
			$.ajax({
				type : 'POST',
				url : "${base}/getAward",
				data : {
					userId : userId,
					pgmPoints : pgmPoints,
					pgmId : pgmId
				},
				success : function(msg) {
					//获取返回值，放到页面上。
					$(obj).text('已领取');
					$(obj).removeClass('bg-aqua');
					$(obj).addClass('bg-disable');
					$(obj).removeAttr('onclick');
					var pointsRecords = Number("${userPoints.allPoints}")
							+ Number($(obj).prev().children().eq('2').val());
					$('#transPointsRecords>p').text('城池数量：' + pointsRecords);
					weui.alert("获得城池" + $(obj).prev().children().eq('2').val()
							+ "座！");
					if('PGMDAY'== pgmId)
					{
						window.location.href="${base}/weixin/baseoauth?action=findActivity";
					}
				}

			});
		}
		
		function openGood(goodid) {
			window.location.href="${base}/awardShopDetail?userId=${wechatUser.userId}&goodId="+goodid;
		}
	</script>
</body>
</html>