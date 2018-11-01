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
<title>我的预测能力</title>

<script>
	var win = ${obj.win};
	var lose = ${obj.lose};
	var data = [
		{
			label: "TEST1",
			value: win,
			color:"#F38630"
		},
		{
			value : lose,
			color : "#69D2E7"
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
			alert( segment.label + ": " + segment.value);
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
	
</script>
</head>
<body>
	<div class="container" style="background-color:white;padding:10px 5px 0px 5px;">
		<div id="legend" class="row">
			<div class="col-xs-6" style="background-color:#69D2E7;">
				<span >败
				</span>
			</div>
			<div class="col-xs-6 " style="background-color:#F38630;">
				<span  class="pull-right" >胜
				</span>
			</div>
		</div>
		<br>
		<div style=" text-align:center;">
			<canvas id="myChart" style="width:200px;height:200px;" >
			</canvas>
		</div>
	</div>	
</body>
</html>