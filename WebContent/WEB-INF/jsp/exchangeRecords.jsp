<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>

<html>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
		<link rel="stylesheet" href="css/task.css?random=1.2" />
		<link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css" />
		<link rel="stylesheet" type="text/css" href="http://cdn.bootcss.com/font-awesome/4.2.0/css/font-awesome.min.css">
		<link rel="stylesheet" type="text/css" href="http://sandbox.runjs.cn/uploads/rs/340/ustg8wvx/weui.css">
		<script type="text/javascript" src="http://sandbox.runjs.cn/uploads/rs/340/ustg8wvx/weui.js"></script>

		<script src="http://libs.baidu.com/jquery/1.9.1/jquery.min.js"></script>
		<script src="http://cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
		<title>兑换记录</title>

	</head>

	<body class="m-b" style="background-color: #f5f5f5;">
		<div class="recordBanner">
			<span style="padding-right: 0.2rem;padding-left: 0.2rem; font-size: 0.2rem;" class="col-md-3 pull-left">
     	兑换详情
     </span>
		</div>
		<c:forEach var="bd" items="${listbd}">
		<div class="costRecords-box">

			<div class="costRecords-box-content">
				<span class="costRecords-box-title">${bd.good.goodName}
					<span class="pull-right">￥${bd.good.price * bd.goodNum}</span>
				</span>
				<c:if test="${bd.billStatus==0}"> 
					<span class="costRecords-box-text text-danger">申请已提交，等待发放</span>
				</c:if>
				<c:if test="${bd.billStatus==1}"> 
					<span class="costRecords-box-text text-danger">奖品已发放，请查收</span>
				</c:if>
				<span class="costRecords-box-text">订单号：${bd.billNum}</span>
				<span class="costRecords-box-text">兑换数量：${bd.goodNum}</span>
				<span class="costRecords-box-text">${bd.fomatTime}</span>

			</div>
		</div>
		</c:forEach>
		<c:if test="${listbd.size()<=0}">
		<div class="costRecords-box">
     	<img style="width:100%;" src="images/wujilu.jpg" />
     	</div>
		</c:if>
		<script type="text/javascript">
			(function(doc, win) {
				var docEl = doc.documentElement,
					resizeEvt = 'orientationchange' in window ? 'orientationchange' :
					'resize',
					recalc = function() {
						var clientWidth = docEl.clientWidth;
						if(!clientWidth)
							return;
						docEl.style.fontSize = 100 * (clientWidth / 750) + 'px';
					};
				if(!doc.addEventListener)
					return;
				win.addEventListener(resizeEvt, recalc, false);
				doc.addEventListener('DOMContentLoaded', recalc, false);
			})(document, window);
		</script>
	</body>

</html>