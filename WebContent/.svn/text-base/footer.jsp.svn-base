<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="utf-8">
<title>footer</title>
<script type="text/javascript"
	src="http://sandbox.runjs.cn/uploads/rs/340/ustg8wvx/weui.js"></script>
<link rel="stylesheet" type="text/css"
	href="http://sandbox.runjs.cn/uploads/rs/340/ustg8wvx/weui.css">
<script src="https://code.jquery.com/jquery.js"></script>
<script>
function changeAttention(){
	var xmlhttp;    
	if (window.XMLHttpRequest)
	  {// code for IE7+, Firefox, Chrome, Opera, Safari
	  xmlhttp=new XMLHttpRequest();
	  }
	else
	  {// code for IE6, IE5
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	  }
	xmlhttp.open("GET","/happy/validCareAbout",true);
	xmlhttp.send();
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {	
		    alert(xmlhttp.responseText);
		  	var carePeople=document.getElementById("care");
			if(xmlhttp.responseText){
				carePeople.innerHTML=parseInt(carePeople.innerHTML)+1;
			}
			
		}
	   }
	
	}	
	function changeAttention1(){
		$.ajax({
		//	url : "/happy/validCareAbout?activityId=${Activitiy.activityId}&userId=${openId}",
			url : "/happy/careAbout?activityId=fsfasfasff&userId=wdcflydehuixiaowankk",
			type : 'get',
			async : true,
			datatype: "json",
			success : function(data) { 
			
				if(eval("("+data+")")=="no")
					{
					 weui.alert("你已关注!");
					 return;
					}
				var carePeople=document.getElementById("care");
				carePeople.innerHTML=parseInt(carePeople.innerHTML)+1;
			}
		});
		}
</script>

</head>
<body>
	<footer>
				<div class="div_left_right" align="center" onclick="changeAttention1()">
					<div class="icon"></div>
					<div>
						<label>关注</label>
						<label class="total_count" id="care">0</label>
					</div>
				</div>
				<div class="div_center" align="center">
					<div class="btn">我要支持</div>
				</div>
				<div class="div_left_right" align="center">
					<div class="icon"></div>
					<div>
						<label>分享</label>
						<label class="total_count">111</label>
					</div>
				</div>
			</footer>
</body>
<script>
$.ajax({
	//	url : "/happy/validCareAbout?activityId=${Activitiy.activityId}&userId=${openId}",
		url : "/happy/getOnlookers?activityId=fsfasfasff",
		type : 'get',
		async : true,
		datatype: "json",
		success : function(data) { 
			var carePeople=document.getElementById("care");
			carePeople.innerHTML=eval("("+data+")");
		}
	});
</script>
</html>