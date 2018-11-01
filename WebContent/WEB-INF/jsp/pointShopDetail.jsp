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
<title>城池兑换详情</title>

</head>
<body class="item">

		<section class="images">
			<div class="swiper-container">
				<div class="swiper-wrapper">
					<div class="swiper-slide">
						<img src="${goodurl}" />
					</div>
				</div>
				<!-- Add Pagination -->
				<div class="swiper-pagination"></div>
			</div>
		</section>

		<section class="header">
			<h2 class="title">现金红包${goodmoney}元</h2>
			<div class="price ">
				<div class="current-price">
					<span class="current-price"><small>￥</small>${goodmoney}.00</span>
				</div>
				<span class="express">${goodpoint}城池</span>
			</div>
			<div class="sales">已经领取: ${goodused} 剩余: ${goodhave}</div>
		</section>

		<section class="sku">
			<dl class="sku-group">
				<dt style="padding-top: 0.1rem;">兑换数量: </dt>
				<dd>
					<div class="quantity-wrapper">
						<a class="quantity-decrease" onclick="minus()">
							<em class="minus">-</em>
						</a>
						<input type="number" min="1" max="10" class="quantity" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" value="1" id="number"/>
						<a class="quantity-increase" id="quantityPlus" onclick="plus()">
							<em id="plus">+</em>
						</a>
					</div>
				</dd>
			</dl>
		</section>

		<section class="content">

			<div class="desc">
				<big class="text-danger">${goodname}</big>
				<p>
					${gooddesc}
				</p>
			</div>
		</section>

		<section class="layer">
			<div class="content">
				<div class="head">
					<a class="closeIcon"></a>
				</div>
				<div class="bd">
					<dl>
						<dt>消耗城池：</dt>
						<dd><span id="totalPoints">${goodpoint}</span></dd>
					</dl>
					<dl>
						<dt>兑换数量：</dt>
						<dd id="totalAmount">
							1
						</dd>
					</dl>
				</div>
				<div class="foot">
					<a id="submitBill">确定兑换</a>
				</div>
			</div>

		</section>

		<footer class="footer">
			<div class="button">
				<a class="buy">立即兑换</a>
			</div>
		</footer>
		<script type="text/javascript">
			(function(doc, win) {
				var docEl = doc.documentElement,
					resizeEvt = 'orientationchange' in window ? 'orientationchange' : 'resize',
					recalc = function() {
						var clientWidth = docEl.clientWidth;
						if(!clientWidth) return;
						docEl.style.fontSize = 100 * (clientWidth / 750) + 'px';
					};
				if(!doc.addEventListener) return;
				win.addEventListener(resizeEvt, recalc, false);
				doc.addEventListener('DOMContentLoaded', recalc, false);
			})(document, window);
			(function() {
				//sku
				$('.buy').click(function() {
					var currentNum = $('#number').val();
					var totalPoints = currentNum * ${goodpoint};
					$('#totalPoints')[0].innerHTML = totalPoints;
					$('#totalAmount')[0].innerHTML = currentNum;
					$('.layer').addClass('acitve');
				});
				
				$('.closeIcon').click(function() {
					$('.layer').removeClass('acitve');
				});
				
				//提交订单到服务器
				$('#submitBill').click(function() {
					var currentNum = $('#number').val();
					$.ajax({
						type : "POST",
						url : "${base}/mypoint/submitbill",
						data: {userId:'${openId}', num: currentNum, goodId: '${goodId}'},
						datatyep : "json",
						success : function(data)
						{
							var flag = eval("("+data+")");
							if(flag == 0)
							{
								weui.alert("系统错误，请稍后重试或者联系客服！");
							}
							else if(flag == -1)
							{
								weui.alert("您的城池数量不够，不能兑换此奖励。您可以发起或者参与活动来获取更多的城池！");
							}
							else if(flag == -2)
							{
								weui.alert("此奖励的剩余量不足，您可以选择其他奖励或者减少兑换的数量！");
							}
							else
							{
								window.location.href="${base}/billdetail?userId=${openId}";
							}
						}
					});
				});
				
			})();

			function minus() {
				var currentNum = $('#number').val();
				if(currentNum > 1) {
					$('#number').val(currentNum - 1);
				}
			}

			function plus() {
				var currentNum = $('#number').val();
				if(currentNum<10){
					$('#number').val(parseInt(currentNum) + 1);
				}
				
			}
		</script>
	</body>

</html>