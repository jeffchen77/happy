<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!doctype html>
<html>
<head>
<title>朕以为</title>
	 <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no" />

    <link href="http://cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css" rel="stylesheet">
    <!-- <link href="bootstrap3.3.5/css/bootstrap-theme.min.css" rel="stylesheet"> -->
    <link href="bootstrap3.3.5/css/app.css" rel="stylesheet">
    <link type="text/css" href="http://cdn.bootcss.com/jqueryui/1.11.0/jquery-ui.min.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="http://www.bootcss.com/p/buttons/css/buttons.css ">
    <!--  -->
    <script src="http://libs.baidu.com/jquery/1.9.1/jquery.min.js"></script>
   <script src="js/mobiscroll.core-2.6.2.js" type="text/javascript"></script>
	<script src="js/mobiscroll.core-2.6.2-zh.js" type="text/javascript"></script>
	<link href="css/mobiscroll.core-2.6.2.css" rel="stylesheet" type="text/css" />
	<script src="js/mobiscroll.datetime-2.6.2.js" type="text/javascript"></script>
	<script src="js/mobiscroll.select-2.6.2.js" type="text/javascript"></script>
    <script src="js/mobiscroll.android-ics-2.6.2.js" type="text/javascript"></script>
	<link href="css/mobiscroll.android-ics-2.6.2.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="css/task.css" />
    <link rel="stylesheet" href="bootstrap3.3.5/css/myInfoStyle.css" />
	<link rel="stylesheet" type="text/css" href="http://cdn.bootcss.com/font-awesome/4.2.0/css/font-awesome.min.css">
	
    <script src="http://cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>  
    <script type="text/javascript"	src="http://sandbox.runjs.cn/uploads/rs/340/ustg8wvx/weui.js"></script>
<link rel="stylesheet" type="text/css"	href="http://sandbox.runjs.cn/uploads/rs/340/ustg8wvx/weui.css">
<script type="text/javascript"	src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <!--  -->

	<link rel="stylesheet" href="css/jquery.range.css">
	<script src="js/jquery.range.js"></script>
	
	<!-- for switch -->
 <!-- 	<link href="switch/bootstrap-switch.css" rel="stylesheet">
	<script src="switch/highlight.js"></script>
    <script src="switch/bootstrap-switch.js"></script>
    <script src="switch/main.js"></script>   -->
	<!-- for switch -->
	<script>
	$(function(){
		$('.single-slider').jRange({
			from: 1,
			to: 10,
			step: 1,
			scale: [1,10],
			format: '%s',
			width:180,
			showLabels: true,
			showScale: true
		});
	});
	$(function(){ $("#dropdownMenu").click(function(e) {}); }); 
	$(function(){ $("#challengeMenu").click(function(e) {}); }); 
	</script>
    <!--  -->
<!--  -->
	
	<!--Includes-->

    <style type="text/css">
        body {
            padding: 0;
            margin: 0;
            font-family: arial, verdana, sans-serif;
            font-size: 12px;
            background: #f0f3f4;
        }
        input, select {
            width: 65%;
            padding: 5px;
            margin: 5px 0;
            border: 1px solid #aaa;
            box-sizing: border-box;
            border-radius: 5px;
            -moz-box-sizing: border-box;
            -webkit-box-sizing: border-box;
            -webkit-border-radius: 5px;
        }
        .header {
            border: 1px solid #333;
            background: #111;
            color: white;
            font-weight: bold;
            text-shadow: 0 -1px 1px black;
            background-image: linear-gradient(#3C3C3C,#111);
            background-image: -webkit-gradient(linear,left top,left bottom,from(#3C3C3C),to(#111));
            background-image: -moz-linear-gradient(#3C3C3C,#111);
        }
        .header h1 {
            text-align: center;
            font-size: 16px;
            margin: .6em 0;
            padding: 0;
            text-overflow: ellipsis;
            overflow: hidden;
            white-space: nowrap;
        }
        .content {
            padding: 15px;
            background: #fff;
        }
        .car {
            position: relative;
            height: 100%;
        }
        .car img {
            height: 28px;
            display: block;
            margin: 0 auto;
        }
        .car .img-cont {
            width: 80px;
            height: 28px;
            text-align: center;
            float: left;
            position: relative;
            top: 50%;
            margin-top: -14px;
        }
        .car span {
            float: left;
        }
    </style>




    <script type="text/javascript">
		    function clickStake(value){
		    	var context="";
				switch(value){
				case -1:
					context="无奖惩！";
					break;					
				case 1:
					context="输方每人发8.8元红包到参与人微信群中！";
					break;
				case 2:
					context="输方AA请参与方一起吃大餐(一周内)！";
					break;
				default:
					context="";
				}
				document.getElementById("activityStake").value=context;
		    }
        function clickChall(value){
		    	var context="";
				switch(value){
				case 1:
					context="明天沪市收盘翻红！";
					break;
				case 2:
					context="今晚9点的比赛，会有红牌出现！";
					break;
				case 3:
					context="2016NBA总决赛，勇士4：3骑士赢下总冠军！";
					break;
				default:
					context="";
				}
				document.getElementById("activityDesc").value=context;
		    }
    
    
        $(function () {
            var curr = new Date().getFullYear();
            var opt = {

            }
            
            var today = new Date(); 
            var tomorrow = new Date((today/1000+86400*1)*1000);
            var thedayaftertomorrow = new Date((today/1000+86400*2)*1000);
            
 		    
 		  
            var daystart = (tomorrow.getDate())>9 ? (tomorrow.getDate()) : ("0"+(tomorrow.getDate())); 
  		  var monthstart = (tomorrow.getMonth() + 1)>9 ? (tomorrow.getMonth() + 1) : ("0"+(tomorrow.getMonth() + 1));   
 		   var yearstart = tomorrow.getFullYear();  
 		   
 		  var dayend = (thedayaftertomorrow.getDate()>9) ? (thedayaftertomorrow.getDate()):("0"+(thedayaftertomorrow.getDate())); 
 		   var monthend = (thedayaftertomorrow.getMonth() + 1)>9 ? (thedayaftertomorrow.getMonth() + 1) : ("0"+(thedayaftertomorrow.getMonth() + 1));   
  		   var yearend = thedayaftertomorrow.getFullYear();  
  		   
 		   
 		   
 		   var minuties = today.getMinutes();
 		   var hours = today.getHours();
 		   var day = today.getDate();
 		   var month = (today.getMonth() + 1)>9 ? (today.getMonth() + 1) : ("0"+(today.getMonth() + 1));   
 		   var year = today.getFullYear();   
 		  
 		   var mytime = "12:00"; 
 		   var datestart = yearstart + "-" + monthstart + "-" + daystart + " " + mytime;  
 		   var dateend = yearend + "-" + monthend + "-" + dayend + " " + mytime; 

            opt.date = {preset : 'date'};
			opt.datetime = { preset : 'datetime', minDate: new Date(year,month-1,day,hours,minuties), maxDate: new Date(2120,12,31,0,0), stepMinute: 1  };
			opt.time = {preset : 'time'};
			opt.tree_list = {preset : 'list', labels: ['Region', 'Country', 'City']};
			opt.image_text = {preset : 'list', labels: ['Cars']};
			opt.select = {preset : 'select'};
			
	     
	

//             $("#demo_default").show();
            $('#test_default').val(datestart).scroller('destroy').scroller($.extend(opt['datetime'], { theme: 'android-ics light', mode: 'scroller', display: 'bottom', lang: 'zh' }));
            $('#test_publish').val(dateend).scroller('destroy').scroller($.extend(opt['datetime'], { theme: 'android-ics light', mode: 'scroller', display: 'bottom', lang: 'zh' }));
//         	$('#demo').trigger('change');
            /* 联动 */
              var browser={
		    		versions:function(){
					           var u = navigator.userAgent, app = navigator.appVersion;
					           return {//移动终端浏览器版本信息
					                trident: u.indexOf('Trident') > -1, //IE内核
					                presto: u.indexOf('Presto') > -1, //opera内核
					                webKit: u.indexOf('AppleWebKit') > -1, //苹果、谷歌内核
					                gecko: u.indexOf('Gecko') > -1 && u.indexOf('KHTML') == -1, //火狐内核
					                mobile: !!u.match(/AppleWebKit.*Mobile.*/)||!!u.match(/AppleWebKit/), //是否为移动终端
					                ios: !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/), //ios终端
					                android: u.indexOf('Android') > -1 || u.indexOf('Linux') > -1, //android终端或者uc浏览器
					                iPhone: u.indexOf('iPhone') > -1 || u.indexOf('Mac') > -1, //是否为iPhone或者QQHD浏览器
					                iPad: u.indexOf('iPad') > -1, //是否iPad
					                webApp: u.indexOf('Safari') == -1 //是否web应该程序，没有头部与底部
					            };
			         		}(),
			         language:(navigator.browserLanguage || navigator.language).toLowerCase()
			}
            
         
            	$('#test_default').change(function(){
            		   if(!browser.versions.iPhone){
		    				var mynow = formatTomorrow();
		             	  	$('#test_publish').val(mynow);
            		   }
                });
            
            
            
            
            $('#test_publish').change(function(){
            	var test_default = $('#test_default').val();
            	var test_publish = $('#test_publish').val();
         	  	if(test_default > test_publish){
         	  		weui.alert("结果发布应在参与截止时间之后！")
         	  	if(!browser.versions.iPhone){
                	var mynow = formatTomorrow();
             	  $('#test_publish').val(mynow);
         	  	}
         	  	}
            });
        });
    </script>

<!--  -->
 <script type="text/javascript">
 function formatTomorrow(){
	 var test_default = $('#test_default').val();
	 var datetemp = new Date(test_default);
 	var datestrpublish = new Date((datetemp/1000+86400*1)*1000);
 	
     	var myyear = datestrpublish.getFullYear(); 
 	   var mymonth = ((datestrpublish.getMonth()+1)>9) ? (datestrpublish.getMonth()+1) : ("0"+(datestrpublish.getMonth()+1));   
 	   var myday = (datestrpublish.getDate()>9) ? (datestrpublish.getDate()) : ("0"+datestrpublish.getDate()) ;  
 	   var myhour = (datestrpublish.getHours()>9) ? (datestrpublish.getHours()) : ("0"+datestrpublish.getHours()); 
 	   var myminute = (datestrpublish.getMinutes()>9) ? (datestrpublish.getMinutes()) : ("0"+datestrpublish.getMinutes()) ;
	   var mynow = myyear + "-" + mymonth + "-" + myday + " " + myhour +":"+ myminute;  
	   return mynow;
 }

function bandPhoneNum(){
	 var newPhoneNum = document.getElementById("newPhoneNum").value;
	 var userId = document.getElementById("userId").value;
	 $.ajax({
		  type: 'POST',
		  url: "${base}/bandPhoneNum",
		  data: {userId:userId,newPhoneNum:newPhoneNum},
		  datatype: "json"
		});
};

function checkNewUrl(){
	var userId = document.getElementById("userId").value;
	 $.ajax({
		type: 'POST',
		url: "${base}/updateImagUrl",
		data: {
			userId: userId
		},
		datatype: "json",
		success: function(data) {
			if(data == 0){
				//未关注,弹出关注二维码
				$("#myModal").modal("show");
			}else{
				//已关注
				document.getElementById("userImgUrl").src = data;
			}
		}
	});  
}

function checkRequired(){
	 var userId = document.getElementById("userId").value;
	 var activityDesc = document.getElementById("activityDesc").value;
	var particiLimititation = document.getElementById("particiLimititation").value;
/* 	var activityStake = document.getElementById("numOfCity").value; */
	var activityStake = 0;
	var radio = document.getElementsByName("numOfCity");  
	var stakePoints = 0;
	 for (i=0; i<radio.length; i++) {  
	     if (radio[i].checked) {  
	    	 stakePoints = radio[i].value;
	    	 activityStake =  "朕要为此赌上"+stakePoints+"座城池";
	     }  
	 } 
	var endTime =document.getElementById("test_default").value;
	var publishTime = document.getElementById("test_publish").value;
	/* 	var stakePoints = 0;
	if($('input[id="VRChecked"]').prop("checked")){
		stakePoints = document.getElementById("stakePoints").value;
		activityStake = "朕要为此赌上"+stakePoints+"座城池";
	} */
	
	  var today = new Date();   
	   var year = today.getFullYear(); 
	   var month = ((today.getMonth()+1)>9)?(today.getMonth()+1):("0"+(today.getMonth()+1));   
	   var daystart = (today.getDate()>9)?(today.getDate()):("0"+today.getDate()) ;  
	   var hour = (today.getHours()>9)?(today.getHours()):("0"+today.getHours()); 
	   var minute = (today.getMinutes()>9)?(today.getMinutes()):("0"+today.getMinutes()) ;
	   var now = year + "-" + month + "-" + daystart + " " + hour +":"+ minute;
	   var limitFlag = document.getElementById("limitFlag").value;	   
		//校验城池
	   var useablePoints = "${obj.userPoints.allPoints}" - "${obj.userPoints.lockedPoints}";

		var inputPoints = stakePoints;
		if($('input[id="VRChecked"]').prop("checked") && useablePoints < inputPoints){
			weui.alert("您的可用城池不足以支付您的赌注！");
			radio[0].checked = true ;
// 			document.getElementById("stakePoints").value = 0;
			window.location.href="${base}/weixin/baseoauth?action=getAwardIndex";
		}else{
			if(endTime > publishTime){
				weui.alert("结果发布应在参与截止时间之后！");
			}else{
				if(limitFlag == 1){
					weui.alert("您有发起的活动未能正常结束，请先去活动管理页面处理！等待解禁（详情见活动规则）！");
				}else{
					weui.confirm("您确定发起活动？如果本次活动超过三个人参加，您的账户将获得系统奖励2座城池！赶紧点击右上角分享吧！","提示",function(r){
						if(r == true){
							document.getElementById("startAct").setAttribute('onclick', '');
							$.ajax({
								  type: 'POST',
								  url: "${base}/checkHasPhone",
								  data: {userId:userId},
								  datatype: "json",
								  success :function(data){
										if(data == 0){
											
											document.getElementById("startAct").setAttribute('onclick', 'checkRequired()');
											$("#pageForPhone").addClass('acitve');
										}else{
											//检查信息是否填写完整
											
											if(activityDesc== "" || particiLimititation=="" || activityStake=="" || endTime==""||publishTime==""){
												weui.alert("请完整填写活动信息！");
												document.getElementById("startAct").setAttribute('onclick', 'checkRequired()');
											}else{
												//保存
												$("#challengeTheme").submit();
											}	
										}
									}
								});
						}
					});
				}
			}
		}
}

function getIsSecratCodeChecked(){
	var userId = document.getElementById("userId").value;
	var secretcode = document.getElementById("sceratCode").value;
	if($('input[id="secratCodeChecked"]').prop("checked")){
		//选中加密
		if(secretcode != null && secretcode != ""){
			//已有密码
			weui.alert("您的活动密码是："+secretcode+",告诉您想邀请的朋友，让他们参与到活动中来吧！如果想修改密码，请到个人中心去修常用活动密码。");
		}else{
			//密码为空
			var newSecretcode = prompt("您还没有设置密码！请设置一个4位常用活动密码，以后就不用再设定了哟！","");
			if( newSecretcode == null || newSecretcode == ""){
				weui.alert("您没有输入密码，本次活动未加密！");
				document.getElementById("switch-state").checked = false;
			}else if(newSecretcode.length > 4){
				weui.alert("密码不能大于4位！");
				document.getElementById("switch-state").checked = false;
			}else{
				document.getElementById("sceratCode").value = newSecretcode;
				//保存密码到数据库
				$.ajax({
					type : "POST",
					url : "${base}/updateActPassWord",
					data: {userId:userId,secretcode:newSecretcode},
					datatyep : "json",
					success : function(data){
					}
				});
			}
		}
	}else{
		//未选中，不加密
	}
}
 function getVRChecked(){
	if($('input[id="VRChecked"]').prop("checked")){
		//选中赌城池
		document.getElementById("virtualDiv").style.display = "none";
		document.getElementById("realDiv").style.display = "block";
		document.getElementById("realSample").style.display = "block";
		document.getElementById("numOfparticiLimititation").style.display = "block";
		document.getElementById("particiLimititation").value = 20;
		
	}else{
		//未选中  赌实物
		document.getElementById("virtualDiv").style.display = "block";
		document.getElementById("realSample").style.display = "none";
		document.getElementById("realDiv").style.display = "none";
		document.getElementById("numOfparticiLimititation").style.display = "none";
// 		document.getElementById("stakePoints").value = 1;
	}
} 
/* function checkStakePoint(){
	var useablePoints = "${obj.userPoints.allPoints}" - "${obj.userPoints.lockedPoints}";
	var inputPoints = document.getElementById("stakePoints").value;
	if(inputPoints <=0 || inputPoints > 20){
		weui.alert("赌注需大于0小于20座城池！");
		document.getElementById("stakePoints").value = 5;
		return;
	}
	var reg = new RegExp("^[0-9]*$");
	if(!reg.test(inputPoints)){  
	        weui.alert("请输入数字!");  
	}else{
		if(useablePoints < inputPoints){
			weui.alert("您的可用城池不足！");
			document.getElementById("stakePoints").value = 1;
			window.location.href="${base}/weixin/baseoauth?action=getAwardIndex";
		}
	}
} */
/* 
function minusOne(){
	var stakePoints = document.getElementById("stakePoints").value;
	if((stakePoints - 1) >= 0){
		document.getElementById("stakePoints").value = (stakePoints - 1);
	}
}

function plusOne(){
	var useablePoints = Number("${obj.userPoints.allPoints}") - Number("${obj.userPoints.lockedPoints}");
	var stakePoints = document.getElementById("stakePoints").value;
	if((Number(stakePoints) + 1) <= useablePoints){
		document.getElementById("stakePoints").value = Number(stakePoints) + 1;
	}
} */
</script>
<script type="text/javascript">
	$(document).ready(function(){

		var honest = "${obj.user.integritylRank}";
		var htmlhonest = "";
		switch(honest){
		case 1:
			htmlhonest="诚信度:继续改进";
			break;
		case 2:
			htmlhonest="诚信度:基本靠谱";
			break;
		case 3:
			htmlhonest="诚信度:诚实守信";
			break;
		case 4:
			htmlhonest="诚信度:君子楷模";
			break;
		default:
			htmlhonest="诚信度:完美无瑕";
		}
		$("#level-honest").html(htmlhonest);
		//设置城池交易流水链接
		
		var userId = "${obj.wechatUser.userId}";
		
		if(userId!=null){
			var url="${base}/getTransPointsRecords?userId="+userId+"&pageNumber=1";
			document.getElementById("transPointsRecords").setAttribute('href', url);
		}
	});
</script> 
</head>

<body class="item">

 <div class="m-b" style="background-color:#5bc0de;">
				<div class="row" style="padding: 5px; margin-left:0px; margin-right:0px;">
					<div class="col-xs-3" style="padding-left: 0px;">
						<img class="img-circle" style="width:60px;height:60px;" src="${obj.wechatUser.headImgUrl}" onclick="checkNewUrl()">
					</div>
					<div class="col-xs-8" style="color:white;">
						<div class="row">
							<div class="col-xs-6" style="padding: 8px;">
								<p class="h6">${obj.wechatUser.nickName}</p>								
							</div>
							<div class="col-xs-6" style="padding: 8px;">
								<p class="h6">胜率：${obj.dsbRate}</p>
							</div>
						</div>
						 <div class="row" >
							<div class="col-xs-6" style="padding: 8px;">
								<a id="transPointsRecords"><p class="h6"  id="level-display">城池：${obj.userPoints.allPoints-obj.userPoints.lockedPoints}/${obj.userPoints.allPoints}</p></a>
							</div>
							<div class="col-xs-6" style="padding:8px;">
								<p class="h6" id="level-honest"> </p>								
							</div>
						</div>
					</div>

				</div>
	</div>

  
  <div class="container"> 

<form  action="${base}/ChallengeTheme" id="challengeTheme" method="post"> 
  <input id="userId" name="userId" type="hidden" value="${obj.wechatUser.userId}">
   <input id="limitFlag" name="limitFlag" type="hidden" value="${obj.user.limitFlag}">
    <input id="templateId" name="templateId" type="hidden" value="${obj.templateId}">
    	<div class="form-group m-b">
    		<div class="panel-info">
			   <div class="panel-heading">
			       <h4 class="panel-title">
			        	 活动预测 
						
					      <input id="secratCodeChecked" name="secratCodeChecked" type="checkbox" style="width: 10%;" onclick="getIsSecratCodeChecked()">加密
					     <input id="sceratCode" name="sceratCode" type="hidden" value="${obj.user.actPassword}">
						<!-- Single button -->
					  <div class="btn-group btn-group-sm pull-right">
						  <span id="challengeMenu" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="margin-top:-5px; background-color:#d9edf7;">
 							示例<i class="fa fa-gift fa-lg"></i>
						  </span>

						  <ul class="dropdown-menu dropdown-menu-left" aria-labelledby="challengeMenu" style="border-radius:0.5em 0.5em 0.5em 0.5em;min-width:100px;">
						   
						    <li onclick="clickChall(1)" style="text-align:center">股票预测</li>
						    <li role="separator" class="divider"></li>
						    <li onclick="clickChall(2)" style="text-align:center">亚冠预测</li>
						    <li role="separator" class="divider"></li>
						    <li onclick="clickChall(3)" style="text-align:center">世预赛</li>						    
						  </ul>
						</div> 
			      </h4>
			   </div>
			  
			   <div class="panel-body" style="padding: 0;">
			     <textarea id="activityDesc" name="activityDesc" type="text" class="form-control" style="height:56px;"
						  		 placeholder="例如:周星星下部电影票房超20亿！" maxlength="140" required="required"></textarea>
			   </div>
			</div>
    	</div>
 <div class="form-group  m-b">
	 <div class="panel-info">
	   <div class="panel-heading">
       <h3 class="panel-title">
	         活动奖惩
					
					<input id="VRChecked" name="VRChecked" type="checkbox" style="width: 10%;" onclick="getVRChecked()">赌实物
					  <div id="realSample" class="btn-group btn-group-sm pull-right" style="display:none;">
						  <span id="dropdownMenu" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="margin-top:-5px; background-color:#d9edf7;">
 							示例<i class="fa fa-gift fa-lg"></i>
						  </span>

						  <ul class="dropdown-menu dropdown-menu-left" aria-labelledby="dropdownMenu" style="border-radius:0.5em 0.5em 0.5em 0.5em;min-width:100px;">
						   
						   	<li onclick="clickStake(-1)"style="text-align:center">无奖惩</li>
						   	<li role="separator" class="divider"></li>
						    <li onclick="clickStake(1)" style="text-align:center">红包雨</li>
						    <li role="separator" class="divider"></li>
						    <li onclick="clickStake(2)" style="text-align:center">吃大餐</li>						    
						  </ul>
						</div> 
	      </h3> 
	      
	   </div>
<!--  	   <div id="virtualDiv" class="panel-body button-group" style="padding: 0;width:100%;display:none">
	   		<p  id="virtualActivityStake" class="form-control" style="height:55px;" maxlength="70" required="required">
	   			朕要为此赌上
		   			<i class="fa fa-minus fa-lg m-r-xs" onclick="minusOne()">
		   				</i><input id="stakePoints" name="stakePoints" value="5" style="width:30px;"onblur="checkStakePoint()"></input>
		   			<i class="fa fa-plus fa-lg m-l-xs" onclick="plusOne()"></i>
				座城池！
			</p>
	   		
	   </div>  -->
	 
	 <div id="virtualDiv" class="panel-body button-group " style="padding: 0;width:100%;"> 
<!-- 		 <label class="pull-left" for="limitnum"> </label> -->
			<label><input name="numOfCity" type="radio" value="5" checked="checked"/> 5座 </label> 
			<label><input name="numOfCity" type="radio" value="10" />10座 </label> 
			<label><input name="numOfCity" type="radio" value="15" />15座 </label> 
			<label><input name="numOfCity" type="radio" value="20" />20座 </label> 
		</div> 
	 
	 
	   <div id="realDiv" class="panel-body button-group" style="padding: 0;width:100%;display:none;" >
	    <span id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="margin-top:-5px; background-color:#d9edf7;">
	     <textarea id="activityStake" name="activityStake" type="text" class="form-control" style="height:55px;"
				  		 placeholder="例如:输方每人发8.8元红包到参与人微信群中！" maxlength="70" required="required"></textarea>
				  		 </span>
		<ul class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdownMenu1" style="border-radius:0.5em 0.5em 0.5em 0.5em;min-width:100px;margin-top:-60px;" style="display:none;">
						   
						   	<li onclick="clickStake(-1)"style="text-align:center">无奖惩</li>
						   	<li role="separator" class="divider"></li>
						    <li onclick="clickStake(1)" style="text-align:center">红包雨</li>
						    <li role="separator" class="divider"></li>
						    <li onclick="clickStake(2)" style="text-align:center">吃大餐</li>					    
						  </ul>
				  		 
	   </div>
	</div>  
</div>  

	

	<div id="numOfparticiLimititation" class="form-group  m-b row h5" style="border-radius: 2px 2px 0px 0px;background-color:white;padding-left:10px;padding-top:11px;margin-left:2px;margin-right:2px">
	   <label class="pull-left" for="limitnum">参与人数：</label>
	     <div id="limitnum" class="pull-left" style="height:20px;margin-top:10px; padding-left:10px;">
	      	<input type="hidden" class="single-slider" value="10" id="particiLimititation" name="particiLimititation"/>
		</div>	
	</div>
	
	
		<div id="demo_default" class="row h5" style="border-radius: 2px 2px 0px 0px;background-color:white;padding-left:10px;margin-left:2px;margin-right:2px">
            <label for="test_default">参与截止：</label>
            <input type="text" name="test_default" id="test_default" />
        </div>
        <div id="demo_publish" class="row h5" style="background-color:white;padding-left:10px;margin-left:2px;margin-right:2px">
            <label for="test_publish">结果发布：</label>
            <input type="text" name="test_publish" id="test_publish" />
        </div>
			<input id="startAct" type="button" class="btn btn-info btn-block" onclick="checkRequired()" value="发起活动"></input>
     </form>  
     <div style="height: 60px;"></div>
</div>
 <section id="pageForPhone" style="background: rgba(0, 0, 0, 0.51);" class="layer">
		<div class="content" style="background: #eee">
			<div class="box">
				<div class="box-header">
			<h4 class="box-title text-danger">欢迎使用朕以为，请先注个册嘛！</h4>

		</div>
				<div class="box-body">
					<div  style="margin-top: 0.1rem;background-color:white;padding:10px;">
						<div class="row">
							<div class="col-xs-6 col-xs-offset-1">
								
								<input id="newPhoneNum" style="padding-left: 35.5px; width:100%;" type="text" placeholder="请输入手机号" value=""  />
								<span class="glyphicon glyphicon-phone form-control-feedback" style="left: 0.2rem;"></span>
							</div>
							<div class="col-xs-4" >
			                      <button class="btn btn-sm btn-info" style="margin-top: 0.1rem;" type="button" onclick="checkNum()">发送验证码</button>
		                    </div>
						</div>
						<div class="row">
							<div class="col-xs-6 col-xs-offset-1">
								<input id="check4Num" type="text"  style="padding-left: 35.5px; width:100%;" placeholder="请输入手机验证码" value="" />
								<input id="check4NumFact" class="form-control input-sm lt-dsb" value="" type="hidden" />
							</div>
							<div class="col-xs-4" >
									<button class="btn btn-sm btn-warning"  style="margin-top: 0.1rem;" onclick="check4Num()" type="button">校验验证码</button>
							</div>
							
						</div>

					
				</div> 
	
				</div>
			</div>
				</div>

	</section>
	<footer>	
    <div class="mune">
		<a href="${base}/weixin/baseoauth?action=findActivity" style="text-decoration: none;">
    	<i class="fa fa-eye fa-2x"></i>
        <p>发现</p>
        </a>
    </div>
    
    <div class="mune">
		<a href="${base}/myActivityIndex?userId=${obj.wechatUser.userId}&ownerOrParter=1" style="text-decoration: none;">
    	<i class="fa fa-bars fa-2x"></i>
        <p>我的</p>
        </a>
    </div>
    
	<div class="mune">
			<a href="${base}/getUserReport?userId=${obj.theUserId}" style="text-decoration: none;">
	    	<i class="fa fa-trophy fa-2x"></i>
	        <p>榜单</p>
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
    function checkNum() {  
   	 var newPhoneNum = document.getElementById("newPhoneNum").value; 
        var re = /^1\d{10}$/;
        if (newPhoneNum != null) {  
            if (re.test(newPhoneNum)) {
           	 //调用action
           	 var phoneNum = newPhoneNum;
				 var userId = document.getElementById("userId").value;
           	 $.ajax({
					  type: 'POST',
					  url: "${base}/getPhoneNum",
					  data: {userId:userId,phoneNum:phoneNum},
					  success: function(msg){
						  //获取返回值，放到页面上。
						  
						  	document.getElementById("check4NumFact").value = msg;
						  	weui.alert( "验证码已发送！ " );
					   }
					});
            }else{
            	weui.alert("请输入正确手机号码！ ");
           	 document.getElementById("newPhoneNum").value = " ";
            }  
        }  
    } 
     </script> 
     <script type="text/javascript">
     function check4Num() {  
    	 var check4Num = document.getElementById("check4Num").value;
    	 var check4NumFact = "0000";
         if (check4Num != null) {  
            	 var check4NumFact = document.getElementById("check4NumFact").value;
            	 if(check4Num==check4NumFact){
            		 bandPhoneNum();
            		weui.Loading.msg("注册成功！", 1000, "weui_success_toast", "weui_icon_toast");
     	$("#pageForPhone").removeClass('acitve');
            		 $("#phoneNum").innerHTML = $("#newPhoneNum").value;
            		 $("#check4Num").value =" ";
            	 }else{
            		 weui.alert("您输入的验证码错误！");
            	 }
         }  
     }
  

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
     
     
     wx.config({
 	    debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
 	    appId: '${obj.weixinparames.appId}', // 必填，公众号的唯一标识
 	    timestamp:  '${obj.weixinparames.timestamp}', // 必填，生成签名的时间戳 
 	    nonceStr: '${obj.weixinparames.nonceStr}', // 必填，生成签名的随机串
 	    signature: '${obj.weixinparames.signature}',// 必填，签名，见附录1 
 		jsApiList : ['onMenuShareTimeline','onMenuShareAppMessage']
 	// 必填，需要使用的JS接口列表，所有JS接口列表见附录2
 	});

 		 wx.ready(function () {
 			 //活动发起分享↓↓↓↓↓↓↓↓↓
 			 var titlex="朕以为";
 			 var contentx="发起你的活动预测，例如：周星星下部电影票房超20亿！";
 			 var imgUrlx="https://mmbiz.qlogo.cn/mmbiz/rLJwdLlcd3dO38VxcZx5rnME8EfkmiaYNSUdQAnLK33icKlpCB0IVZIWHZ4s00OmniaB2QXZJc1Y2ZJPI6OvCubDw/0?wx_fmt=jpeg";
 			 wx.onMenuShareAppMessage({  
 			        title: titlex, // 分享标题  
 			        desc: contentx, // 分享描述  
 			        link: 'http://${appServer}${base}/weixin/baseoauth?action=challengIndex', // 分享链接  
 			        imgUrl: imgUrlx, // 分享图标  
 			        type: 'link', // 分享类型,music、video或link，不填默认为link  
 			        dataUrl: '', // 如果type是music或video，则要提供数据链接，默认为空  
 			       
 			   }); 

 			 
 			  
 			//盆友圈↓↓↓↓↓↓↓
 			 wx.onMenuShareTimeline({
 				 
 				 	title: titlex+": "+contentx,
 				    link: 'http://${appServer}${base}/weixin/baseoauth?action=challengIndex', // 分享链接
 				    imgUrl:imgUrlx,
 				});
 			 wx.error(function(res){
 		            // config信息验证失败会执行error函数，如签名过期导致验证失败，具体错误信息可以打开config的debug模式查看，也可以在返回的res参数中查看，对于SPA可以在这里更新签名。
 		            weui.alert("微信服务器错误，请重新进入！");
 		        });
 			
 		 });
 		 
 		 //一键复制的功能在这里
 	
 		$(function(){
 			var defualtAct = '${obj.defaultAct}';
 		 if(defualtAct!='')
 		 {
 			$("#activityDesc").val('${obj.defaultAct.activityDesc}');
 			if('${obj.defaultAct.stakePoints>0}')
 			{
 				//如果是赌城池
 				$("#VRChecked").attr("checked", true);
 				document.getElementById("virtualDiv").style.display = "block";
 				document.getElementById("realDiv").style.display = "none";
 				document.getElementById("realSample").style.display = "none";
 				document.getElementById("stakePoints").value = '${obj.defaultAct.stakePoints}';
 			}
 			
 			 var datetemp = new Date('${obj.defaultAct.activityDeadline}');
 		 	var datestrpublish = new Date('${obj.defaultAct.publishDate}');
 		 	
 		     	var pyear = datestrpublish.getFullYear(); 
 		 	   var pmonth = ((datestrpublish.getMonth()+1)>9) ? (datestrpublish.getMonth()+1) : ("0"+(datestrpublish.getMonth()+1));   
 		 	   var pday = (datestrpublish.getDate()>9) ? (datestrpublish.getDate()) : ("0"+datestrpublish.getDate()) ;  
 		 	   var phour = (datestrpublish.getHours()>9) ? (datestrpublish.getHours()) : ("0"+datestrpublish.getHours()); 
 		 	   var pminute = (datestrpublish.getMinutes()>9) ? (datestrpublish.getMinutes()) : ("0"+datestrpublish.getMinutes()) ;
 			   var pubdate = pyear + "-" + pmonth + "-" + pday + " " + phour +":"+ pminute;  

 			  var dyear = datetemp.getFullYear(); 
		 	   var dmonth = ((datetemp.getMonth()+1)>9) ? (datetemp.getMonth()+1) : ("0"+(datetemp.getMonth()+1));   
		 	   var dday = (datetemp.getDate()>9) ? (datetemp.getDate()) : ("0"+datetemp.getDate()) ;  
		 	   var dhour = (datetemp.getHours()>9) ? (datetemp.getHours()) : ("0"+datetemp.getHours()); 
		 	   var dminute = (datetemp.getMinutes()>9) ? (datetemp.getMinutes()) : ("0"+datetemp.getMinutes()) ;
			   var deaddate = dyear + "-" + dmonth + "-" + dday + " " + dhour +":"+ dminute;  
			   
			   var opt = {

	            }
			   var today = new Date();
			   var minuties = today.getMinutes();
	 		   var hours = today.getHours();
	 		   var day = today.getDate();
	 		   var month = (today.getMonth() + 1)>9 ? (today.getMonth() + 1) : ("0"+(today.getMonth() + 1));   
	 		   var year = today.getFullYear(); 
	 		   
			   opt.date = {preset : 'date'};
				opt.datetime = { preset : 'datetime', minDate: new Date(year,month-1,day,hours,minuties), maxDate: new Date(2120,12,31,0,0), stepMinute: 1  };
				opt.time = {preset : 'time'};
				opt.tree_list = {preset : 'list', labels: ['Region', 'Country', 'City']};
				opt.image_text = {preset : 'list', labels: ['Cars']};
				opt.select = {preset : 'select'};
			   
 			$('#test_default').val(deaddate).scroller('destroy').scroller($.extend(opt['datetime'], { theme: 'android-ics light', mode: 'scroller', display: 'bottom', lang: 'zh' }));
 			$('#test_publish').val(pubdate).scroller('destroy').scroller($.extend(opt['datetime'], { theme: 'android-ics light', mode: 'scroller', display: 'bottom', lang: 'zh' }));
 		 }
 		}
 		);
 		
     </script> 
     

</body>
</html>
