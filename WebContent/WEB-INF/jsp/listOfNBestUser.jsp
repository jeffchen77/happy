<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<title>他的活动</title>
<link
	href="http://cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet" type="text/css"
	href="http://cdn.bootcss.com/font-awesome/4.2.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css"
	href="http://www.bootcss.com/p/buttons/css/buttons.css ">
<script type="text/javascript"
	src="http://sandbox.runjs.cn/uploads/rs/340/ustg8wvx/weui.js"></script>
<link rel="stylesheet" type="text/css"
	href="http://sandbox.runjs.cn/uploads/rs/340/ustg8wvx/weui.css">
<link
	href="http://cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap-theme.min.css"
	rel="stylesheet">
<link rel="stylesheet" href="bootstrap3.3.5/css/myInfoStyle.css" />
<link href="bootstrap3.3.5/css/app.css" rel="stylesheet">
<script src="http://libs.baidu.com/jquery/1.9.1/jquery.min.js"></script>
<script src="http://cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

<script type="text/javascript">

	function activityDetail(actId) {
		window.location.href = "${base}/weixin/baseoauth?action=onlineGame&activityId="
				+ actId;
	}


</script>
</head>
<body>

	<div class="container" style="background-color: #f0f3f4;">

		<div id="myChallenge">
			<c:choose>
				<c:when test="${obj.dataAllAct!=null && obj.dataAllAct.size()>0}">
					<c:forEach var="perAct" items="${obj.dataAllAct}"
						varStatus="preIndex">
						<c:if test="${preIndex.index==obj.dataAllAct.size()-1}">
							<input id="hiddenflag1" type="text" value="${perAct.header_time}"
								hidden="hidden" />
						</c:if>
						<!-- 活动 -->
						<div class="container"
							style="background-color: white; padding: 8px; margin-bottom: 10px;">
							<div class="row" style="z-index: 0">
								<div class="col-sm-7">
									<span class="thumb-sm pull-left"> <img
										src="${perAct.header_img}" class="img-circle"
										style="width: 30px; height: 30px;">
									</span>
									<div>
										<span style="font-size: 80%;">${perAct.header_name}</span> <span
											style="font-size: 80%;">${perAct.header_time}</span> <span
											id="status${preIndex.index}" class="h6 text-muted"
											style="float: right;">${perAct.header_status}</span>
									</div>
								</div>
							</div>
							<div onclick="activityDetail('${perAct.act_id}')">
								<div class="m-l m-b-xs m-t-xs">
									<i class="h6 text-muted fa fa-bullhorn fa-lg"></i> <span
										class="h6 text-muted">事件预测：</span> <span class="h6 text-font">${perAct.act_title}</span>
								</div>
								<div class="m-l m-b-xs m-t-xs">
									<i class="h6 text-muted fa fa-gift fa-lg"></i> <span
										class="h6 text-muted">事件奖惩：</span> <span class="h6 text-font">${perAct.act_content}</span>
								</div>
							</div>
							<div id="div${preIndex.index}">
								<div class="row">
									<div class="col-xs-6"
										style="text-align: left; overflow-y: auto; overflow-x: hidden; height: 35px;">
										<div class=" m-l-lg m-b-xs m-t-xs">
											<c:choose>
												<c:when test="${perAct.act_parter_yes.size()>0}">
													<span class="h6 text-muted"> <c:forEach
															var="actParter" items="${perAct.act_parter_yes}"
															varStatus="status">
															<c:choose>
																<c:when test="${status.index==0}">
																	<img src="${actParter}" class="img-circle thumb-lg"
																		style="width: 30px; height: 30px;">
																</c:when>
																<c:otherwise>
																	<img src="${actParter}" class="img-circle thumb-lg"
																		style="width: 30px; height: 30px; margin-left: -8px;">
																</c:otherwise>
															</c:choose>
														</c:forEach>
													</span>
												</c:when>
												<c:otherwise>
													<span class="h6 text-muted">没有人支持</span>
												</c:otherwise>
											</c:choose>

											<span class="h6 text-muted"><i
												class="fa fa-thumbs-o-up fa-lg"></i></span>
										</div>
									</div>

									<div class="col-xs-6"
										style="text-align: right; overflow-y: auto; overflow-x: hidden; height: 35px;">
										<div class=" m-r-lg m-b-xs m-t-xs">
											<c:choose>
												<c:when test="${perAct.act_parter_no.size()>0}">
													<span class="h6 text-muted"> <c:forEach
															var="actParter" items="${perAct.act_parter_no}"
															varStatus="status">
															<c:choose>
																<c:when test="${status.index==0}">
																	<img src="${actParter}" class="img-circle thumb-lg"
																		style="width: 30px; height: 30px;">
																</c:when>
																<c:otherwise>
																	<img src="${actParter}" class="img-circle thumb-lg"
																		style="width: 30px; height: 30px; margin-left: -8px;">
																</c:otherwise>
															</c:choose>
														</c:forEach>
													</span>
												</c:when>
												<c:otherwise>
													<span class="h6 text-muted">没有人反对</span>
												</c:otherwise>
											</c:choose>

											<span class="h6 text-muted"><i
												class="fa fa-thumbs-o-down fa-lg"></i></span>
										</div>
									</div>

								</div>
							</div>
						</div>
					</c:forEach>
					<div id="divLoadMore1"></div>
					<div
						style="text-align: center; height: 40px; line-height: 40px; font-size: 12px; color: #888; font-family: Arial, Microsoft YaHei; background-color: white;"
						onclick="loadMoreActivity(this, 1, '${obj.theUserId}')">
						<div id="loadText1">点击加载更多</div>
					</div>
				</c:when>
				<c:otherwise>
					<div class="container"
						style="background-color: white; padding-bottom: 30px;">
						<div class="h5 text-muted"
							style="padding-top: 50px; text-align: center;"></div>
					</div>
				</c:otherwise>
			</c:choose>
		</div>


		<div style="height: 60px;"></div>
		<footer>
			<div class="mune">
				<a href="${base}/weixin/baseoauth?action=FrontOfChallengIndex"
					style="text-decoration: none;"> <i class="fa fa-paint-brush fa-2x"></i>
					<p>发起</p>
				</a>
			</div>

			<div class="mune">
				<a href="${base}/getMessage?userId=${obj.theUserId}"
					style="text-decoration: none;"> <i class="fa fa-comment fa-2x"></i>
					<p>消息</p>
				</a>
			</div>
			<div class="mune">
				<a href="#" data-toggle="modal" data-target="#myModal"
					style="text-decoration: none;"> <i class="fa fa-qrcode fa-2x"></i>
					<p>关注</p>
				</a>
			</div>
			<div class="mune">
				<a
					href="${base}/weixin/baseoauth?action=myInfoIndex&activityId=${obj.activityId}"
					style="text-decoration: none;"> <i class="fa fa-user fa-2x"></i>
					<p>我</p>
				</a>
			</div>
		</footer>
	</div>
	<!-- 模态框（Modal） -->
	<div class="modal fade" id="myModal" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog"
			style="margin: 20%; width: 4.2rem; height: 4.2rem;">
			<div class="modal-content">
				<div class="modal-header" style="padding: 0.1rem;">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">关注朕以为</h4>
				</div>
				<div class="modal-body" style="padding: 0.08rem;">
					<div>
						<img src="images/qrcode.jpg"
							style="width: 4.0rem; height: 4.0rem;">
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
<script>
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


</html>