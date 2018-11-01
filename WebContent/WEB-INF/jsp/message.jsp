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
<link href="bootstrap3.3.5/css/bootstrap.min.css" rel="stylesheet">
<link href="bootstrap3.3.5/css/bootstrap.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="css/qscui.css">
<link rel="stylesheet" type="text/css" href="css/upgrade.css">
<link rel="stylesheet" type="text/css" href="css/font-awesome.min.css">
<script type="text/javascript"
	src="http://sandbox.runjs.cn/uploads/rs/340/ustg8wvx/weui.js"></script>
<link rel="stylesheet" type="text/css"
	href="http://sandbox.runjs.cn/uploads/rs/340/ustg8wvx/weui.css">
	<link rel="stylesheet" href="bootstrap3.3.5/css/myInfoStyle.css" />
<link href="bootstrap3.3.5/css/bootstrap-theme.min.css" rel="stylesheet">
<script src="bootstrap3.3.5/js/jquery.min.js"></script>
	<script src="https://code.jquery.com/jquery.js"></script>
<script src="bootstrap3.3.5/js/bootstrap.min.js"></script>
<script src="js/jquery-1.9.1.js"></script>
<script type="text/javascript"
	src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js "></script>
	
<script type="text/javascript">

function getMessage(obj) {
	var status =  obj;
	
	$.ajax({
		type: 'POST',
		url: "${base}/getMessage",
		data: {
			status: status,
		},
		
		datatype: "json",
		success: function(msg) {
		
		}
		
	});
}



</script>
	
<script type="text/javascript">


		function readCheck(obj) {
			var iconId=obj.id+"Icon";
			var oldClass = document.getElementById(iconId).className;
			if (oldClass == "glyphicon glyphicon-question-sign text-danger") {
				$("#"+iconId).removeClass("glyphicon glyphicon-question-sign text-danger");
				$("#"+iconId).addClass("glyphicon glyphicon-info-sign text-success");
			}
		}
		function checkPanelDisplay(obj) {
			var buttonId=obj.id;
			var spanId=buttonId+"Span";
			var oldClass = document.getElementById(buttonId).className;
			if(buttonId=="unreadMsgButton"){
				if(oldClass=="btn-default"){
					$("#"+buttonId).removeClass("btn-default");
					$("#"+buttonId).addClass("btn-info");
					$("#"+spanId).css("color","white");
					$("#readMsgButton").removeClass("btn-info");
					$("#readMsgButton").addClass("btn-default");
					$("#readMsgButtonSpan").css("color","black");
					$("#unreadMsg").show();
					$("#readMsg").hide();
				}
				
			}
			else if(buttonId=="readMsgButton"){
				if(oldClass=="pt-line btn-default"){
					$("#"+buttonId).removeClass("btn-default");
					$("#"+buttonId).addClass("btn-info");
					$("#"+spanId).css("color","white");
					$("#unreadMsgButton").removeClass("btn-info");
					$("#unreadMsgButton").addClass("btn-default");
					$("#unreadMsgButtonSpan").css("color","black");
					$("#readMsg").show();
					$("#unreadMsg").hide();
				}
			}
			
		}

	
	</script>	
<title>朕以为</title>
<body>
<div class="container-fluid">
		<div class="DetaPageTopBtn ">
			<a class="btn-info" id="unreadMsgButton" style="text-decoration:none;" onclick="checkPanelDisplay(this)">
				<span id="unreadMsgButtonSpan" class="h5" style="color:white">未读消息 </span>
			</a>
			<a class="pt-line btn-default" id="readMsgButton" style="text-decoration:none;" href="#2a" data-toggle="tab" onclick="checkPanelDisplay(this)">
				<span id="readMsgButtonSpan" class="h5" style="color:black">已读消息</span>
			</a>
		</div>

		<div class="panel-group mod-project-card mod-project-supporter" style="margin-top: 50px;" id="unreadMsg">
			<c:forEach var="ai" items="${ComentsInfoNotRead}">
			<div class="panel panel-info">
				<div id=${ai['divId']} style="padding: 0;" class="panel-heading" data-toggle="collapse" data-parent="#unreadMsg" href=${ai['href']}  onclick="readCheck(this)">
					<div class="panel-title">
						<div class="input-group">
							<span id=${ai['spanId']}  class="glyphicon glyphicon-question-sign text-danger">${ai['title']} </span>
						</div>
					</div>
				</div>
				<div id=${ai['id']}  class="panel-collapse collapse">
					<div class="mod-project-support_item clearfix item J_tpl" style="height: auto">

					<div  class="mod-project-support_item__user" >
						<img class="lazy-load" src="${ai['head']}"
							style="display: inline;">
					</div>
					<div class="mod-project-support_item__detail">
						
						<div class="project-support_item__detail__content"><h6>${ai['body']}</h6></div>
						<div class="project-support_item__detail__time">
							${ai['sendTime']}</div>	
					</div>
	
				</div>
				</div>
			</div>
			</c:forEach>
		</div>
		<div class="panel-group mod-project-card mod-project-supporter" style="margin-top: 50px;display: none;" id="readMsg">
		
		<c:forEach var="ai" items="${ComentsInfoHadRead}">
			<div class="panel panel-info">
				<div id=${ai['divId']} style="padding: 0;" class="panel-heading" data-toggle="collapse" data-parent="#readMsg" href=${ai['href']}  onclick="readCheck(this)">
					<div class="panel-title">
						<div class="input-group">
							<span id=${ai['spanId']}  class="glyphicon glyphicon-info-sign text-success">${ai['title']}</span>
						</div>
					</div>
				</div>
				<div id=${ai['id']}  class="panel-collapse collapse">
					<div class="mod-project-support_item clearfix item J_tpl" style="height: auto">

					<div  class="mod-project-support_item__user" >
						<img class="lazy-load" src="${ai['head']}"
							style="display: inline;">
					</div>
					<div class="mod-project-support_item__detail">
						
						<div class="project-support_item__detail__content"><h6>${ai['body']}</h6></div>
						<div class="project-support_item__detail__time">
							${ai['sendTime']}</div>	
					</div>
	
				</div>
				</div>
			</div>
			</c:forEach>
		
			

		</div>

	</div>
	<div style="height: 60px;"></div>
	<footer>
	
	<div class="mune">
    	<a href="${base}/weixin/baseoauth?action=challengIndex" style="text-decoration: none;">
    	<i class="fa fa-paint-brush fa-2x"></i>
        <p>发起</p>
        </a>
    </div>
	
	<div class="mune">
		<a href="${base}/getMessage?userId=${theUserId}" style="text-decoration: none;">
    	<i class="fa fa-comment fa-2x" style="color: #5bc0de;"></i>
        <p style="color: #5bc0de;">消息</p>
        </a>
    </div>
	<div class="mune">
		<a href="#" data-toggle="modal" data-target="#myModal" style="text-decoration: none;">
    	<i class="fa fa-qrcode fa-2x"></i>
        <p>关注</p>
        </a>
    </div> 
    <div class="mune">
		<a href="${base}/weixin/baseoauth?action=myInfoIndex" style="text-decoration: none;">
    	<i class="fa fa-user fa-2x"></i>
        <p>我</p>
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
})(document, window);

</script>
</body>
</html>