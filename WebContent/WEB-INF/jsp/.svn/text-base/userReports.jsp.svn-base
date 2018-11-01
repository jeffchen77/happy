<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link rel="stylesheet" type="text/css"
	href="http://cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">
<link rel="stylesheet" href="bootstrap3.3.5/css/myInfoStyle.css" />
<link rel="stylesheet" href="css/ranking.css" />
<link rel="stylesheet" href="css/task.css?random=1.4" />
<link rel="stylesheet" type="text/css"
	href="http://cdn.bootcss.com/font-awesome/4.2.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css"
	href="http://www.bootcss.com/p/buttons/css/buttons.css ">
<link rel="stylesheet" type="text/css"
	href="http://sandbox.runjs.cn/uploads/rs/340/ustg8wvx/weui.css">
<link rel="stylesheet" type="text/css" href="bootstrap3.3.5/css/app.css">
<script type="text/javascript"
	src="http://sandbox.runjs.cn/uploads/rs/340/ustg8wvx/weui.js"></script>
<script type="text/javascript"
	src="http://libs.baidu.com/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript"
	src="http://cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<title>用户排行榜</title>
</head>
<body>
	<div class="container" style="background-color: #f0f3f4;">
		<section id="ranking">
			<span id="ranking_title">我的排行： <c:choose>
					<c:when test="${obj.reportForUserId != null}">
						<c:forEach var="perAct" items="${obj.reportForUserId}"
							varStatus="preIndex">				
						${perAct.rownum}						
				</c:forEach>
					</c:when>
				</c:choose>
			</span>
			<section id="ranking_list">
				<c:choose>
					<c:when
						test="${obj.reportForAllUser != null && obj.reportForAllUser.size() > 0 }">
							<section class="box" style="background-color:white;height:15px;line-height:15px">
								<section class="col_1"></section>
								<section class="col_2"></section>
								<section class="col_3" style="font-size:12px;">准确率</section>
								<section class="col_4" style="font-size:12px;">城池数</section>
								<section class="col_5" style="font-size:12px;"></section>
							</section> 
						<c:forEach var="perAct" items="${obj.reportForAllUser}"
							varStatus="preIndex">
							<section class="box">
								<section class="col_1" title="${perAct.rownum}">${perAct.rownum}</section>
								<section class="col_2">
									<li style="margin-top:5px;margin-bottom:5px;font-size:0.8em">${perAct.nickname}</li>
									<li><img src="${perAct.headimgurl}" /></li>
								</section>
								<section class="col_3">${perAct.forecastAccuracy}</section>
								<section class="col_4">${perAct.allPoints-perAct.lockedPoints}/${perAct.allPoints}</section>
								<section class="col_5">
								<li style="margin-top:5px;margin-bottom:5px;font-size:0.8em" id="id${perAct.rownum}">${perAct.toTotal}</li>
								<c:if test="${perAct.isClickedToday=='1'}">
								<li><i class="fa fa-heart fa-lg" style="color:#FF6347;margin-top:3px;"></i></li>
								</c:if>
								<c:if test="${perAct.isClickedToday=='0'}">
								<li><i class="fa fa-heart fa-lg" style="color:gray;margin-top:3px;" onclick="clickZan(this, 'id${perAct.rownum}', '${perAct.userId}')"></i></li>
								</c:if>
								</section>
							</section>
						</c:forEach>
					</c:when>
				</c:choose>

			</section>
		</section>

		<%-- 
		<c:choose>
			<c:when test="${obj.reportForUserId != null}">
				<c:forEach var="perAct" items="${obj.reportForUserId}" varStatus="preIndex">
					<div class="row" >
						<div class="col-xs-2" >
						${perAct.rownum}
						</div>
						<div class="col-xs-2"  >
						<img src="${perAct.headimgurl}" class="img-circle" style="width: 30px; height: 30px;">
						</div>
						<div class="col-xs-2"  >
						${perAct.nickname}
						</div>
						<div class="col-xs-2"  >
						${perAct.forecastAccuracy}
						</div>
						<div class="col-xs-2" >
						${perAct.winCount}
						</div>
						<div class="col-xs-2" >
						${perAct.selfPic}
						</div>
					</div>
				</c:forEach>
			</c:when>
		</c:choose>
		<c:choose>
			<c:when test="${obj.reportForAllUser != null && obj.reportForAllUser.size() > 0 }">
				<c:forEach var="perAct" items="${obj.reportForAllUser}" varStatus="preIndex">
					<div class="row" >
						<div class="col-xs-2" >
						${perAct.rownum }
						</div>
						<div class="col-xs-2"  >
						<img src="${perAct.headimgurl}" class="img-circle" style="width: 30px; height: 30px;">
						</div>
						<div class="col-xs-2"  >
						${perAct.nickname}
						</div>
						<div class="col-xs-2"  >
						${perAct.forecastAccuracy}
						</div>
						<div class="col-xs-2" >
						${perAct.winCount}
						</div>
						<div class="col-xs-2" >
						${perAct.selfPic}
						</div>
					</div>
				</c:forEach>
			</c:when>
		</c:choose> --%>
	<div style="height: 60px;"></div>
	<footer>
		<div class="mune">
			<a href="${base}/weixin/baseoauth?action=challengIndex" style="text-decoration: none;">
	    	<i class="fa fa-paint-brush fa-2x"></i>
	        <p>发起</p>
	        </a>
	    </div>
		
		<div class="mune">
			<a href="${base}/weixin/baseoauth?action=findActivity" style="text-decoration: none;">
	    	<i class="fa fa-eye fa-2x"></i>
	        <p>发现</p>
	        </a>
	    </div>
		<div class="mune">
			<a href="#" data-toggle="modal" data-target="#myModal" style="text-decoration: none;">
	    	<i class="fa fa-envelope fa-2x"></i>
	        <p>红包</p>
	        </a>
	    </div> 
	    <div class="mune">
			<a href="${base}/weixin/baseoauth?action=myInfoIndex" style="text-decoration: none;">
	    	<i class="fa fa-user fa-2x"></i>
	        <p>设置</p>
	        </a>
	    </div>
	</footer>
	</div>
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
	             	  关注朕以为，拿RMB大红包！
	            </h4>
	         </div>
	         <div class="modal-body" style="padding:0.08rem;">
	          <div><img src="images/qrcode.jpg" style="width: 4.0rem;height: 4.0rem;"></div>
	         </div>
	      </div>
		</div>
	</div>
	<script type="text/javascript">
	function clickZan(obj, rowNumId, toUserId)
	{
		obj.style.color="#FF6347";
		var num = $("#"+rowNumId)[0].innerText;
		num = Number(num) + 1;
		$("#"+rowNumId)[0].innerText = num;
		obj.onclick = null;
		$.ajax({
			type : "POST",
			url : "${base}/surport/doSurport",
			data: {fromUserId:'${obj.userOpenId}', toUserId: toUserId},
			datatyep : "json",
			success : function(data) { 					
			}
		});
	}
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
	</script>
</body>
</html>