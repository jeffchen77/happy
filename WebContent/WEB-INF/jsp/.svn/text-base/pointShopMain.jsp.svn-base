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
<link rel="stylesheet" href="css/task.css?random=1.2" />
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
<title>积分兑换商城</title>

</head>
<body class="m-b" style="background-color: #f5f5f5;">
	<div class="headerOuterWrapper">
      <div class="headerWrapper"> 
     <span style="padding-right: 0.2rem;padding-left: 0.2rem; font-size: 0.2rem;" class="col-md-3 pull-left">
     	可用城池：<span id="myPoints">${points}</span>
     </span>
     <span class="col-md-6 shopHeader" style="padding-left: 0.45rem;padding-right: 0.2rem;">
     	城池兑换商城
     </span>
     <a style="padding-right: 0.2rem;padding-left: 0.2rem;font-size: 0.2rem;" class="col-md-3 pull-right" href="${base}/billdetail?userId=${openId}">
     	兑换记录
     </a>
      
    </div>
     </div>
	
	<h4 class="sectionTitle">奖品兑换-
	<small class="text-danger">注意：兑换城池数从基本50城池之后算起</small></h4>
	<div class="homeProductsWrapper" style="padding-right: 0.2rem;padding-left: 0.95rem;">
        <c:forEach var="good" items="${goods}">
        	<div class="homeProductWrapper"><img src="${good['img_url']}" alt="">
         		 <div class="homeProductInfoWrapper"><span class="homeProductTitle">${good['point_price']}城池</span><a href="${base}/awardShopDetail?userId=${openId}&goodId=${good['id']}" class="homePurchaseButton">兑换</a></div>
        	</div>
        </c:forEach>
     </div>
	<script type="text/javascript">
		
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
	<script type="text/javascript">
	$.ajax({
		type : "POST",
		url : "${base}/mypoint/getpoint",
		data: {userId:'${openId}'},
		datatyep : "json",
		success : function(data)
		{
			var jsonData = eval("("+data+")");
			$('#myPoints')[0].innerHTML = jsonData;
		}
	});
	</script>
</body>
</html>