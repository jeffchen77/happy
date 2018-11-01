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
	
<link rel="stylesheet" href="css/task.css?random=2.4" />

<link rel="stylesheet" type="text/css"
	href="http://cdn.bootcss.com/font-awesome/4.2.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css"
	href="http://www.bootcss.com/p/buttons/css/buttons.css ">
<link rel="stylesheet" type="text/css"
	href="http://sandbox.runjs.cn/uploads/rs/340/ustg8wvx/weui.css">
<script type="text/javascript"
	src="http://sandbox.runjs.cn/uploads/rs/340/ustg8wvx/weui.js"></script>
<script type="text/javascript"
	src="http://libs.baidu.com/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript"
	src="http://cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">
	var timeout;
	var maxHeight = 0;
	var maxCount = 3;
	$(function() {
		$('#MostRedBox').css('overflow', 'hidden');
		if ($('#MostRedBox').find('.box').size() <= maxCount) {
			maxCount = $('#MostRedBox').find('.box').size();
			$('#moreRecord').css('display', 'none');
		}

		for (var index = 0; index < maxCount; index++) {
			maxHeight = maxHeight
					+ $('#MostRedBox').find('.box').eq(index).outerHeight(true)
					+ 11;
		}
		$('#MostRedBox').css('height', maxHeight + 'px');
		var flag=${obj.listOfUnread != null && obj.listOfUnread.size() > 0 };
		if(flag){
			$('#latestReadBox').parent().css('display','none');	
			$('#unReadBox').parent().css('display','');
		}
		
		else{
			$('#latestReadBox').parent().css('display','');	
			$('#unReadBox').parent().css('display','none');
		}

	});
	function goToOnLineGame(activityId) {
		window.location.href = "${base}/weixin/baseoauth?action=onlineGame&activityId="
				+ activityId;
	}

	function toListOfNBuser(userId) {
		window.location.href = "${base}/listOfNBuser?userId=" + userId;
	}
	function collapsedBox(obj) {
		$('#MostRedBox').find('.box').find('.tag').css('display', 'none');
		$('#punlunFooter').css('display', 'none');
		$(".footerHome").css('display','');
		$(obj).parents('.box').eq('0').siblings().find('.box-body').css('display', 'none');
		var boxId = obj.id.substr(0, obj.id.length - 3);
		if ('none' == $('#' + boxId).find('.box-body').css('display')) {
			$('#' + boxId).attr('className', 'box');
			$('#' + boxId).find('.box-body').css('display', 'block');
			$(obj).find('span').css('display', 'none');
		} else {
			$('#' + boxId).attr('className', 'box collapsed-box');
			$('#' + boxId).find('.box-body').css('display', 'none');
		}

	}
	function replyComments(obj) {
		/* var box = obj.getBoundingClientRect();
		doc = obj.ownerDocument;
		body = doc.body;
		html = doc.documentElement;
		clientTop = html.clientTop || body.clientTop || 0;
		var topHeight = box.top
				+ (self.pageYOffset || html.scrollTop || body.scrollTop)
				- clientTop;

		//var topHeight = obj.getBoundingClientRect().top;
		var inputHeight = $(obj).outerHeight(true) + topHeight + 10;
		/* $('#comments').css('display', '');
		$('#comments').css('position', 'absolute');
		$('#comments').css('top', inputHeight+'px'); */
		
		var toUserName = $(obj).find('a').eq(0).text();
		var toUserId = $(obj).find('a').eq(0).attr('name');
		localStorage.setItem('toUserId', toUserId);
		localStorage.setItem('commentId', $(obj).attr('name'));
		localStorage.setItem('activityId', $(obj).parent().attr('name'));
		$("#commentsArea").addClass('acitve');
		$('#exampleInputArea').attr('placeholder', '回复' + toUserName + '：');
		var t = setTimeout("document.getElementById('exampleInputArea').focus();",100);
		$(".footerHome").css('display','none');
	}
/* 	function atfocus() {

		$('#exampleInputComment').focus();
	}
	function outfocus() {
		timeout = setTimeout(function() {
			if ('Yes' == localStorage.getItem('isDisplayReply')) {
				localStorage.removeItem('isDisplayReply');
			} else {
				//$('#comments').css('display', 'none');
			}

		}, 200);

	} */
	function insert(obj) {
		clearTimeout(timeout);
		if ("${obj.openId}" == "") {
			weui.alert("微信服务器错误，请重新进入页面！");
			return;
		}
		var s = $("#exampleInputArea").val();

		var touserId = localStorage.getItem('toUserId');
		var commentId = localStorage.getItem('commentId');
		var activityId = localStorage.getItem('activityId');
		var url = "${base}/insertAjaxReplycomments?activityId=" + activityId
				+ "&commentId=" + commentId + "&openId=${obj.openId}&touserId="
				+ touserId + "&comments=" + s;
		if (s == "") {
			return;
		}
		$("#commentsArea").removeClass('acitve');
		$(".footerHome").css('display','');
		$.ajax({
			url : url,
			type : 'post',
			datatype : "json",
			success : function(data) {
				
				localStorage.removeItem('toUserId');
				localStorage.removeItem('commentId');
				localStorage.removeItem('activityId');
				weui.Loading.success();

			},
			error : function() {
				weui.alert("微信服务器错误，请重新进入页面！");
			}
		});

	}
	function displayMore() {
		for (var index = maxCount; index < $('#MostRedBox').find('.box').size(); index++) {
			maxHeight = maxHeight
					+ $('#MostRedBox').find('.box').eq(index).outerHeight(true)
					+ 11;
		}
		$('#MostRedBox').css('height', maxHeight + 'px');
		maxCount = $('#MostRedBox').find('.box').size();
		$('#moreRecord').css('display', 'none');
	}
	function detailReply(obj) {
		
		$(obj).parent().parent().siblings().find('.tag').css('display', 'none');
		$(obj).parents(".box").eq('0').siblings().find('.tag').css('display',
				'none');
		$('#unReadBox').find('.box').find('.box-body').css('display', 'none');
		var displaySwitch = $(obj).parent().next().css('display');
		if ('none' == displaySwitch) {
			$(obj).parent().next().css('display', '');
			$('#punlunFooter').css('display', '');
			$(".footerHome").css('display','none');
			/* var box = obj.getBoundingClientRect();
			doc = obj.ownerDocument;
			body = doc.body;
			html = doc.documentElement;
			clientTop = html.clientTop || body.clientTop || 0;
			var topHeight = box.top
					+ (self.pageYOffset || html.scrollTop || body.scrollTop)
					- clientTop;

			//var topHeight = obj.getBoundingClientRect().top;
			var inputHeight = $(obj).parent().next().outerHeight(true)
					+ topHeight + 11; */
			/* $('#comments').css('display', '');
			$('#comments').css('position', 'absolute');
			$('#comments').css('top', inputHeight+'px'); */
			
			var toUserName = $(obj).parent().prev().find('a').eq(0).text();
			var toUserId = $(obj).parent().prev().find('a').attr('name');
			localStorage.setItem('toUserId', toUserId);
			localStorage.setItem('commentId', $(obj).parents('li').eq('0')
					.attr('name'));
			localStorage.setItem('activityId', $(obj).parents('.box').eq('0')
					.attr('name'));
			$('#punlunFooter').children().eq(0).text('回复'+ toUserName + '：');
		} else {
			$(obj).parent().next().css('display', 'none');
			$('#punlunFooter').css('display', 'none');
			$(".footerHome").css('display','');
		}

		maxHeight = 0;
		for (var index = 0; index < maxCount; index++) {
			maxHeight = maxHeight
					+ $('#MostRedBox').find('.box').eq(index).outerHeight(true)
					+ 11;
		}
		$('#MostRedBox').css('height', maxHeight + 'px');
	}
</script>
<title>未读信息列表</title>
</head>
<body style="background-color: rgba(0, 0, 0, .075);" class="item">
	<div class="box">
		<div class="box-header with-border">
			<h4 class="box-title label label-info">未读评论</h4>

		</div>
		<div id="unReadBox" class="box-body">
			<c:choose>

				<c:when
					test="${obj.listOfUnread != null && obj.listOfUnread.size() > 0 }">
					<c:forEach var="perAct" items="${obj.listOfUnread}"
						varStatus="preIndex">
						<div id="${perAct.activityId}" class="box collapsed-box">
							<div class="box-header with-border">
								<h4 class="box-title"
									onclick="goToOnLineGame('${perAct.activityId}')">${perAct['activityRemark']}  ${perAct['activityDesc']}</h4>
								<div class="box-tools">
									<small id="${perAct.activityId}Msg" class="label"
													style="background-color: #ccc;" 
										onclick="collapsedBox(this)"> <i class="fa fa-comment"></i>
										<span>${perAct['countOfact']}</span>
									</small>
								</div>
							</div>

							<div class="box-body" style="padding: 0; display: none;">
								<ul class="messageList" name="${perAct.activityId}">
									<c:forEach var="listMessage"
										items="${perAct['unreadReplyCommentList']}">
										<li name="${listMessage['commentId']}"
											onclick="replyComments(this)">
											<!-- start message -->
											<div class="pull-left">
												<img class="img-circle" style="width: 20px; height: 20px;"
													src="${listMessage['imgOfreply']}">
											</div> <c:choose>
												<c:when
													test="${listMessage['replyUserId']==listMessage['touserId']||listMessage['touserId']==''}">
													<h5 style="margin: 0;">
														<a name="${listMessage['replyUserId']}">${listMessage['nickOfreply']}</a>:

													</h5>
												</c:when>
												<c:when
													test="${listMessage['replyUserId']!=listMessage['touserId']&&listMessage['touserId']!=''}">
													<h5 style="margin: 0;">
														<a name="${listMessage['replyUserId']}">${listMessage['nickOfreply']}</a>回复<a
															name="${listMessage['touserId']}">${listMessage['nickOftoUser']}</a>:

													</h5>
												</c:when>
											</c:choose>

											<p
												style="padding: 0 0 0 25px; color: rgba(0, 0, 0, 0.5); margin: 0 0 3px;">
												<small><i class="fa fa-clock-o"></i>
													${listMessage['createTime'].substring(0, 19)}</small>
											</p>
											<p style="padding: 0 0 0 25px;font-size:0.3rem;">${listMessage['replyComments']}</p>

										</li>
										<!-- end message -->
									</c:forEach>
								</ul>
							</div>

							<!-- /.box-body -->

						</div>

					</c:forEach>
				</c:when>
			</c:choose>


		</div>

	</div>
<div class="box">
		<div class="box-header with-border">
			<h4 class="box-title label label-info">最近评论</h4>

		</div>
		<div id="latestReadBox" class="box-body">
			<c:choose>

				<c:when
					test="${obj.listOfReaded != null && obj.listOfReaded.size() > 0 }">
					<c:forEach var="perAct" items="${obj.listOfReaded}"
						varStatus="preIndex">
						<div id="${perAct.activityId}Lst" class="box collapsed-box">
							<div class="box-header with-border">
								<h4 class="box-title"
									onclick="goToOnLineGame('${perAct.activityId}')">${perAct['activityRemark']}  ${perAct['activityDesc']}</h4>
								<div class="box-tools">
									<small id="${perAct.activityId}LstMsg" class="label"
													style="background-color: #ccc;" 
										onclick="collapsedBox(this)"> <i class="fa fa-comment"></i>
									</small>
								</div>
							</div>

							<div class="box-body" style="padding: 0; display: none;">
								<ul class="messageList" name="${perAct.activityId}">
									<c:forEach var="listMessage"
										items="${perAct['readedReplyCommentList']}">
										<c:choose>
											<c:when test="${listMessage['replyComments'] != null && listMessage['replyComments'] !='' && listMessage['replyComments'] !='undefined'}">
										<li name="${listMessage['commentId']}"
											onclick="replyComments(this)">
											<!-- start message -->
											<div class="pull-left">
												<img class="img-circle" style="width: 20px; height: 20px;"
													src="${listMessage['imgOfreply']}">
											</div> 
											<c:choose>
												<c:when
													test="${listMessage['replyUserId']==listMessage['touserId']||listMessage['touserId']==''}">
													<h5 style="margin: 0;">
														<a name="${listMessage['replyUserId']}">${listMessage['nickOfreply']}</a>:

													</h5>
												</c:when>
												<c:when
													test="${listMessage['replyUserId']!=listMessage['touserId']&&listMessage['touserId']!=''}">
													<h5 style="margin: 0;">
														<a name="${listMessage['replyUserId']}">${listMessage['nickOfreply']}</a>回复<a
															name="${listMessage['touserId']}">${listMessage['nickOftoUser']}</a>:

													</h5>
												</c:when>
											</c:choose>

											<p
												style="padding: 0 0 0 25px; color: rgba(0, 0, 0, 0.5); margin: 0 0 3px;">
												<small><i class="fa fa-clock-o"></i>
													${listMessage['createTime'].substring(0, 19)}</small>
											</p>
											<p style="padding: 0 0 0 25px;font-size:0.3rem;">${listMessage['replyComments']}</p>

										</li>
										</c:when>
										</c:choose>
										<!-- end message -->
									</c:forEach>
								</ul>
							</div>

							<!-- /.box-body -->

						</div>

					</c:forEach>
				</c:when>
			</c:choose>


		</div>

	</div>
	
	<div class="box" style="margin-top: 0.3rem;">
		<div class="box-header with-border">
			<h4 class="box-title label label-info">最热评论</h4>

		</div>
		<div id="MostRedBox" class="box-body">
			<c:choose>
				<c:when
					test="${obj.nBestComment != null && obj.nBestComment.size() > 0 }">
					<c:forEach var="activityMap" items="${obj.nBestComment}">
						<div name="${activityMap.activityId}" class="box">
							<div class="box-header">
								<h4 class="box-title"
									onclick="goToOnLineGame('${activityMap.activityId}')">${activityMap['activityRemark']}  ${activityMap['activityDesc']}</h4>

							</div>

							<div class="box-body" style="padding: 0;">
								<ul class="messageList">
									<c:forEach var="listMessageRed"
										items="${activityMap['commentListOfTheActID']}">
										<li name="${listMessageRed['commentId']}">
											<!-- start message -->
											<div class="pull-left">
												<img class="img-circle" style="width: 20px; height: 20px;"
													src="${listMessageRed['headImagOfNBest']}">
											</div>
											<h5 style="margin: 0 0 5px 0;">
												<a name="${listMessageRed['userIdOfNBest']}">${listMessageRed['nickOfNBest']}</a>:
												<small class="pull-right" style="padding-top: 2.1px;"><i
													class="fa fa-clock-o"></i>
													${listMessageRed['createTimecommentsOfNBest'].substring(0, 19)}</small>
											</h5>

											<p style="padding: 0 0 0 25px;">

												${listMessageRed['commentsOfNBest']} <small
													onclick="detailReply(this)" class="pull-right label"
													style="background-color: #ccc;"><i
													class="fa fa-comment"></i>${listMessageRed['countOFcom']}</small>
											</p>
											<div id="${listMessageRed['commentId']}ReplyTag"
												style="margin-bottom: 10px; display: none;" class="tag">
												<ul name="${activityMap.activityId}">
													<c:forEach var="bi"
														items="${listMessageRed['allRepOfThisCommentId']}">
														<c:choose>
															<c:when
																test="${bi['fromUserId']==bi['toUserId']||bi['toUserId']==''}">
																<li name="${listMessageRed['commentId']}"
																	onclick="replyComments(this)"><span><a
																		style="color: #337ab7" name="${bi['fromUserId']}">${bi['nickOffromUser']}</a>:</span><span>${bi['commentsReply']}</span></li>
															</c:when>
															<c:when
																test="${bi['fromUserId']!=bi['toUserId']&&bi['toUserId']!=''}">
																<li name="${listMessageRed['commentId']}"
																	onclick="replyComments(this)"><span><a
																		style="color: #337ab7" name="${bi['fromUserId']}">${bi['nickOffromUser']}</a>回复<a
																		style="color: #337ab7" name="${bi['toUserId']}">${bi['nickOftoUser']}</a>:</span><span>${bi['commentsReply']}</span></li>
															</c:when>
														</c:choose>

													</c:forEach>
												</ul>

											</div>
										</li>
										<!-- end message -->
									</c:forEach>
								</ul>
							</div>

							<!-- /.box-body -->

						</div>
					</c:forEach>

				</c:when>
			</c:choose>


		</div>

	</div>
	<div id="moreRecord" class="btn btn-sm btn-default btn-block"
		onclick="displayMore()">点击查看更多</div>
	<section id="commentsArea" style="background: rgba(0, 0, 0, 0.51);" class="layer">
		<div class="content" style="background: #eee">
			<div class="form-group">
				<div style="padding:0 10px 0 10px"><span class="pull-left form-control-static" onclick='closeBack()'>取消</span>
				<span class="pull-right form-control-static" onclick='insert(this)'>发送</span>
				</div>
					<textarea autofocus id="exampleInputArea" style="background: #ddd" rows="4" cols="50" class="form-control" placeholder="回复评论">
</textarea>
			</div>
		</div>

	</section>
	<div style="height: 60px;"></div>
<div class="footerHome">
	<div class="footerMune">
		<a href="${base}/weixin/baseoauth?action=FrontOfChallengIndex" style="text-decoration: none;">
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
	<div id="punlunFooter" style="height: auto;padding: 10px 15px;display:none" class="footerPingLun">
	<span  class="punlun-Btn button-pill" onclick="displayCommentsArea(this)" >回复评论：</span>
	</div>
	
</body>
<script>
function displayCommentsArea(obj){
	$("#commentsArea").addClass('acitve');
	$('#exampleInputArea').attr('placeholder',$(obj).text());
	var t = setTimeout("document.getElementById('exampleInputArea').focus();",100);
	$(".footerHome").css('display','none');
	localStorage.setItem('isDetailPinLun','Yes');
}
function closeBack(){
	$("#commentsArea").removeClass('acitve');
	
	if('Yes'==localStorage.getItem('isDetailPinLun')){
		$(".footerHome").css('display','none');
		$('#punlunFooter').css('display', '');
		localStorage.removeItem('isDetailPinLun');
	}
	else{
		$(".footerHome").css('display','');
		$('#punlunFooter').css('display', 'none');
	}
	
}
document.addEventListener('touchmove', function(event) {
    //判断条件,条件成立才阻止背景页面滚动,其他情况不会再影响到页面滚动
    if($("#commentsArea").hasClass("acitve")){
        event.preventDefault();
    }
});
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
})(document, window);
</script>
</html>