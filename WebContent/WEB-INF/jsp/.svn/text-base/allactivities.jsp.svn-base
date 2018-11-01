<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<title>发起的活动</title>
<link href="http://cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="http://cdn.bootcss.com/font-awesome/4.2.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="http://www.bootcss.com/p/buttons/css/buttons.css ">
<script type="text/javascript" src="http://sandbox.runjs.cn/uploads/rs/340/ustg8wvx/weui.js"></script>
<link rel="stylesheet" type="text/css" href="http://sandbox.runjs.cn/uploads/rs/340/ustg8wvx/weui.css">
<link href="http://cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap-theme.min.css" rel="stylesheet">
	<link rel="stylesheet" href="bootstrap3.3.5/css/myInfoStyle.css" />
<link href="bootstrap3.3.5/css/app.css" rel="stylesheet">
<script src="http://libs.baidu.com/jquery/1.9.1/jquery.min.js"></script>
<script src="http://cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		var url = location.search; //获取url中"?"符后的字串 
var theRequest = new Object(); 
if (url.indexOf("?") != -1) { 
var str = url.substr(1); 
strs = str.split("&"); 
for(var i = 0; i < strs.length; i ++) { 
theRequest[strs[i].split("=")[0]]=unescape(strs[i].split("=")[1]); 
} 
if("1"==theRequest["ownerOrParter"]){
	//发起的活动
	$("#sponsoredActButton").removeClass("btn-default");
	$("#sponsoredActButton").addClass("btn-info");
	$("#sponsoredActSpan").css("color","white");
	$("#myParterChallenge").hide();	
	$("#myChallenge").show();
	$("#myCareChallenge").hide();
	document.title='发起的活动';
}
else if("2"==theRequest["ownerOrParter"]){
	//参与的活动
	$("#participateActButton").removeClass("btn-default");
	$("#participateActButton").addClass("btn-info");
	$("#participateActSpan").css("color","white");
	$("#myParterChallenge").show();	
	$("#myChallenge").hide();
	$("#myCareChallenge").hide();
	document.title='参与的活动';
}
else if("3"==theRequest["ownerOrParter"]){
	//已收藏活动
	$("#careActButton").removeClass("btn-default");
	$("#careActButton").addClass("btn-info");
	$("#careActSpan").css("color","white");
	$("#myCareChallenge").show();	
	$("#myParterChallenge").hide();	
	$("#myChallenge").hide();
	document.title='收藏的活动';
}
} 


	});
</script>
<script type="text/javascript">
	function showDiv(vid,dropdownMenu)
	{
		var menu = document.getElementById(dropdownMenu);
		var div = document.getElementById(vid);
		var ids = div.style.display;
		
		if(ids == "block")
		{
			div.style.display="none";
			$(event.target).removeClass("fa-chevron-circle-up");
			$(event.target).addClass("fa-chevron-circle-down");
		}
		else
		{
			div.style.display="block";			
			$(event.target).removeClass("fa-chevron-circle-down");
			$(event.target).addClass("fa-chevron-circle-up");
			$(menu).click(function(e) {});
		}		
	}
	
	function activityDetail(actId)
	{
		window.location.href="${base}/weixin/baseoauth?action=onlineGame&activityId="+actId;	
	}

	function selectChanged(actId,status,ownerActivity,val)
	{
// 		var mTarget = event.target;
		
// 		if("0"==mTarget.value)
// 		{	
// 			return;
// 		}
		weui.confirm("你确定结束活动并通知好友？活动参与者将会收到通知邮件！","提示",function(r)
		{
			if(r==true)
			{	
				var hstatus = document.getElementById(status);
				var vl = val;
				var divid = "resultShow"+actId;
				if(vl!=0)
				{
					hstatus.innerText="已完成";
					if(vl==1)
					{
						document.getElementById(divid).innerHTML="我认栽，通知好友";
						$("#"+divid).addClass("text-muted");
						document.getElementById(actId).setAttribute('data-toggle', '');
					}
					else if(vl==2)
					{
						document.getElementById(divid).innerHTML="朕赢了，通知好友";
						$("#"+divid).addClass("text-muted");
						document.getElementById(actId).setAttribute('data-toggle', '');
					}					
					$.ajax({
						url : "${base}/saveUserSelected?actId="+actId+"&status="+vl,
						type : 'get',
						success :
							function(data){}
						});
				}
			}
			else
			{
				mTarget.value="0";
			}
		});
	}
	
	
	function myChallenge(){
		var oldClass1=document.getElementById("sponsoredActButton").className;
		var oldClass2=document.getElementById("participateActButton").className;
		var oldClass3=document.getElementById("careActButton").className;
		if(oldClass1=="btn-default"){
					$("#sponsoredActButton").removeClass("btn-default");
					$("#sponsoredActButton").addClass("btn-info");
					$("#sponsoredActSpan").css("color","white");
					if(oldClass2=="btn-info"){
						$("#participateActButton").removeClass("pt-line btn-info");
					$("#participateActButton").addClass("btn-default");
					$("#participateActSpan").css("color","black");
					}
					if(oldClass3=="btn-info"){
						$("#careActButton").removeClass("btn-info");
					$("#careActButton").addClass("btn-default");
					$("#careActSpan").css("color","black");
					}
					$("#myParterChallenge").hide();	
					$("#myChallenge").show();
					$("#myCareChallenge").hide();
					document.title='发起的活动';
				}
		
		
	};
	
	function myParterChallenge(){
		var oldClass1=document.getElementById("sponsoredActButton").className;
		var oldClass2=document.getElementById("participateActButton").className;
		var oldClass3=document.getElementById("careActButton").className;
		if(oldClass2=="btn-default"){
					$("#participateActButton").removeClass("btn-default");
					$("#participateActButton").addClass("btn-info");
					$("#participateActSpan").css("color","white");
					if(oldClass1=="btn-info"){
						$("#sponsoredActButton").removeClass("btn-info");
					$("#sponsoredActButton").addClass("btn-default");
					$("#sponsoredActSpan").css("color","black");
					}
					if(oldClass3=="btn-info"){
						$("#careActButton").removeClass("btn-info");
					$("#careActButton").addClass("btn-default");
					$("#careActSpan").css("color","black");
					}
					
					$("#myParterChallenge").show();	
					$("#myChallenge").hide();
					$("#myCareChallenge").hide();
					document.title='参与的活动';
				}
		
		
	};
	
	function myCareChallenge(){
		var oldClass1=document.getElementById("sponsoredActButton").className;
		var oldClass2=document.getElementById("participateActButton").className;
		var oldClass3=document.getElementById("careActButton").className;
		if(oldClass3=="btn-default"){
					$("#careActButton").removeClass("btn-default");
					$("#careActButton").addClass("btn-info");
					$("#careActSpan").css("color","white");
					if(oldClass1=="btn-info"){
						$("#sponsoredActButton").removeClass("btn-info");
					$("#sponsoredActButton").addClass("btn-default");
					$("#sponsoredActSpan").css("color","black");
					}
					if(oldClass2=="btn-info")
					{
						$("#participateActButton").removeClass("pt-line btn-info");
						$("#participateActButton").addClass("btn-default");
						$("#participateActSpan").css("color","black");
					}
					$("#myCareChallenge").show();	
					$("#myParterChallenge").hide();	
					$("#myChallenge").hide();
					document.title='收藏的活动';
				}
		
		
	};
	
	function delTheAct(actId,creatTime){
		var hasParter = null;//0为无参与者，1为有参与者
		$.ajax({
			url : "${base}/activityOfParter?actId="+actId,
			type : 'get',
			success :function(data){
				hasParter = data;
				}
		});
		
		if(hasParter == 1){
			weui.confirm("本次活动已有朋友来参加了！你确定要删除？","提示",function(r){
				if(r==true){
					deleteOp(actId,creatTime)
				}	
			});
		}else{
			weui.confirm("你确定要删除本次活动？","提示",function(r){
				if(r==true){
					deleteOp(actId,creatTime)
				}	
						
			});
		}
		
	};
	
	
	//取消关注
	function cancelCare(actId,userId,activityDiv){
		$.ajax({
			url : "${base}/cancelCare?actId="+actId+"&userId="+userId,
			type : 'get',
			success :function(data){
				
				var parentNode = document.getElementById("myCareChallenge");
				var child = document.getElementById(activityDiv);
				if (parentNode != null)
				{
					parentNode.removeChild(child);
				}
					
			}
		});
		
	};
	//执行删除操作
	function deleteOp(actId,creatTime){
		$.ajax({
			url : "${base}/deleteTheActivity?actId="+actId+"&creatTime="+creatTime,
			type : 'get',
			success :function(data){
					if(data == 3){
						weui.alert("距离发起活动已超过三分钟，无法删除");
					}else{
						window.location.reload();	
					}
				}
		});
		
	};
	
	function insertComplain(activityId,activityOwnerUserId,complaintOwnerUserId){
		window.location.href="${base}/complaintIndex?activityId="+activityId+"&activityOwnerUserId="+activityOwnerUserId+"&complaintOwnerUserId="+complaintOwnerUserId;
	};
	function insertPress(activityId,activityOwnerUserId,complaintOwnerUserId){
		$.ajax({
			url : "${base}/insertPress",
			type : 'post',
			data: {activityId:activityId,activityOwnerUserId:activityOwnerUserId,complaintOwnerUserId:complaintOwnerUserId},
			datatype: "json",
			success :function(data){
				weui.alert("催促成功！楼主将会收到邮件和系统提醒！");
				}
		});
	}
	function insertPressOwner(activityId,activityOwnerUserId,complaintOwnerUserId,personCount){
		
		if(personCount==0)
		{
			weui.alert("没人参与活动。。。");
			return;
		}
		
		$.ajax({
			url : "${base}/insertPressOwner",
			type : 'post',
			data: {activityId:activityId,activityOwnerUserId:activityOwnerUserId,complaintOwnerUserId:complaintOwnerUserId},
			datatype: "json",
			success :function(data){
				weui.alert("催促成功！参与者将会收到邮件和系统提醒！");
				}
		});
	};
	function goToListOfUnread(userId){
		window.location.href = "${base}/toListOfUnread?userId=" + userId;
	}
	
 </script>
 <script type="text/javascript">
		$(document).ready(function() {
			var ownerOrParter = ${obj.ownerOrParter};
			switch (ownerOrParter) {
				case 1:
					myChallenge();					
					break;
				case 2:
					myParterChallenge();
					break;
				case 3:
					myCareChallenge();
					break;
				default:
					myChallenge();
				}
			
				});
				
		</script>
</head>
<body>

<div class="container" style="background-color:#f0f3f4;">
			
  	<div  class="CarePageTopBtn" style="background-color: transparent;z-index:1;">
			<a class="btn-default" id="sponsoredActButton" style="text-decoration:none;" onclick="myChallenge()">
				<span id="sponsoredActSpan" class="h5" style="color:black">发起的活动 </span>
			</a>
			<a class="btn-default" id="participateActButton" style="text-decoration:none;" href="#2a" data-toggle="tab" onclick="myParterChallenge()">
				<span id="participateActSpan" class="h5" style="color:black">参与的活动</span>
			</a>
						<a class="btn-default" id="careActButton" style="text-decoration:none;" href="#3a" data-toggle="tab" onclick="myCareChallenge()">
				<span id="careActSpan" class="h5" style="color:black">收藏的活动</span>
			</a>
	</div>  

			<c:choose>
				<c:when test="${obj.unreadMes!=null && obj.countOfUnread != 0}">
					<div style="margin-top: 50px;padding-bottom: 50px;">
						<div onclick="goToListOfUnread('${obj.unreadMes.participateUserId}')">
							<div align="right" class="col-xs-2" style="">
								<img class="img-circle" style="width:40px;height:40px;" src="${obj.unreadMes.replyUserheadImgUrl}">
							</div>
							<div align="left" class="col-xs-8" style="padding-top: 8px;">
								<span>回复了你参与的活动！</span>
							</div>
							<div align="center" class="col-xs-2" style="padding-top: 5px;color:#e30505">
							<span class="fa-stack fa-lg" aria-hidden="true" style="line-height: 1.4em;">
					          <i class="fa fa-circle" style="font-size:1.4em"></i>
					          <i class="fa  fa-stack-1x fa-inverse">${obj.countOfUnread}</i>
					        </span>

							</div>
						</div>
					</div>
				</c:when>
				<c:otherwise>
				<div style="margin-top: 50px;"></div>
				</c:otherwise>
			</c:choose>

<div id="myChallenge">
<c:choose>
<c:when test="${obj.dataAllAct!=null && obj.dataAllAct.size()>0}"> 	
<c:forEach var="perAct" items="${obj.dataAllAct}" varStatus="preIndex">
	<c:if test="${preIndex.index==obj.dataAllAct.size()-1}">
		<input id="hiddenflag1" type="text" value="${perAct.header_time}" hidden="hidden"/>
	</c:if>
	<!-- 活动 -->
	<div class="container" style="background-color:white;padding:8px;margin-bottom:10px;">
		<div class="row" style="z-index:0">
				<div class="col-sm-7">
					<span class="thumb-sm pull-left"> <img
						src="${perAct.header_img}" class="img-circle" style="width: 30px; height: 30px;">
					</span>
						<div>
							<span style="font-size: 80%;">${perAct.header_name}</span>
							<span style="font-size: 80%;">${perAct.header_time}</span>
							<span id="status${preIndex.index}" class="h6 text-muted" style="float:right;">${perAct.header_status}</span>
						</div>
				</div>
		</div>
		<div onclick="activityDetail('${perAct.act_id}')">
		<div class="m-l m-b-xs m-t-xs">				
					<i class="h6 text-muted fa fa-bullhorn fa-lg"></i>
						<span class="h6 text-muted">事件预测：</span>
						<span class="h6 text-font">${perAct.act_title}</span>					
		</div>
		<div class="m-l m-b-xs m-t-xs">				
					<i class="h6 text-muted fa fa-gift fa-lg"></i>
							<span class="h6 text-muted">事件奖惩：</span>
							<span class="h6 text-font">${perAct.act_content}</span>
		</div>
		</div>
		<!-- div收起和展开  -->
		<%-- <div id="div${preIndex.index}" style="display:none;"> --%>
		<div id="div${preIndex.index}">				
			
			<%-- <div class="m-l m-b-xs m-t-xs">				
					<i class="h6 text-muted fa fa-clock-o fa-lg"></i>
							<span class="h6 text-muted">参与截止：</span> 
							<span class="h6 text-font">${perAct.act_time}</span>
			</div> --%>
			
			<div class="row" >
			<div class="col-xs-6" style="text-align: left;overflow-y:auto;overflow-x:hidden;height:35px;">
				<div class=" m-l-lg m-b-xs m-t-xs">				
								<c:choose>
									<c:when test="${perAct.act_parter_yes.size()>0}">	
									<span class="h6 text-muted">					
										<c:forEach var="actParter" items="${perAct.act_parter_yes}" varStatus="status">
											<c:choose>
												<c:when test="${status.index==0}">
													<img src="${actParter}" class="img-circle thumb-lg" style="width: 30px; height: 30px;">
												</c:when>
												<c:otherwise>
													<img src="${actParter}" class="img-circle thumb-lg" style="width: 30px; height: 30px; margin-left:-8px;">
												</c:otherwise>
											</c:choose>
										</c:forEach>
										</span>
									</c:when>
									<c:otherwise>
										<span class="h6 text-muted">没有人支持</span>
									</c:otherwise>
								</c:choose>
						
					<span class="h6 text-muted"><i class="fa fa-thumbs-o-up fa-lg"></i></span>
				</div>
			</div>
			
			<div class="col-xs-6" style="text-align: right;overflow-y:auto;overflow-x:hidden;height:35px;">
				<div class=" m-r-lg m-b-xs m-t-xs">				
								<c:choose>
									<c:when test="${perAct.act_parter_no.size()>0}">	
									<span class="h6 text-muted">					
										<c:forEach var="actParter" items="${perAct.act_parter_no}" varStatus="status">
											<c:choose>
												<c:when test="${status.index==0}">
													<img src="${actParter}" class="img-circle thumb-lg" style="width: 30px; height: 30px;">
												</c:when>
												<c:otherwise>
													<img src="${actParter}" class="img-circle thumb-lg" style="width: 30px; height: 30px; margin-left:-8px;">
												</c:otherwise>
											</c:choose>
										</c:forEach>
										</span>
									</c:when>
									<c:otherwise>
										<span class="h6 text-muted">没有人反对</span>
									</c:otherwise>
								</c:choose>
						
					<span class="h6 text-muted"><i class="fa fa-thumbs-o-down fa-lg"></i></span>
				</div>
			</div>
			
			</div>
				
		<div class="row" >
		<div class="col-xs-5" style="text-align: left;">
			<c:if test="${perAct.delAble==1}">
					<button class="button button-plain button-border button-circle button-small" style="color:#58666e;" data-toggle="button" onclick="delTheAct('${perAct.act_id}','${perAct.header_time}')">撤回</button>
			</c:if>
 			<button class="button button-plain button-border button-circle button-small" style="color:#58666e;" data-toggle="button" onclick="insertComplain('${perAct.act_id}','${perAct.header_userId}','${obj.theUserId}')">投诉</button>
			<c:if test="${perAct.header_status=='已完成'}">
			<button class="button button-plain button-border button-circle button-small" style="color:#58666e;" id="ownerActivity${preIndex.index}"   data-toggle="button"  onclick="insertPressOwner('${perAct.act_id}','${perAct.header_userId}','${obj.theUserId}','${perAct.act_parter.size()}')">催促</button>
			</c:if>
		</div>
		<div class="pull-right" style="margin-right:20px">
			<c:choose> 
				<c:when test="${perAct.act_result==3}">
						<div class="btn-group btn-group-sm pull-right" >
						  	<span aria-haspopup="true" aria-expanded="false" style="margin-top:-5px; ">
 								<span class="text-muted">活动因故取消</span><!-- <span class="caret"></span> -->
						  	</span>
						 </div>
				</c:when>
				<c:when test="${perAct.header_status=='已完成'}">
					<div class="btn-group">
					  <div class="btn-group btn-group-sm pull-right">
					  	<span aria-haspopup="true" aria-expanded="false" style="margin-top:-5px;">
						  	<c:choose>	
							  	<c:when test="${perAct.act_result==1}">
	 							<span class="text-muted">我认栽，通知好友</span>
	 							</c:when>
	 							<c:when test="${perAct.act_result==2 }">
	 							<span class="text-muted">朕赢了，通知好友</span>
	 							</c:when>
 							</c:choose>	
 						</span>
 						<!-- <span class="caret"></span> -->
 					 </div>
					</div>
				</c:when>
				<c:otherwise>
					<div class="btn-group btn-group-sm pull-right" >
						  	<span aria-haspopup="true" aria-expanded="false" style="margin-top:-5px; ">
 								<span class="text-muted">等待结果发布</span><!-- <span class="caret"></span> -->
						  	</span>
						 </div>
				</c:otherwise>
			</c:choose>				
			
<!-- 			</div>	  -->
		</div>	
		</div>
		</div>
		
		<%-- <div style="text-align: center;">				
				<span class="avatar fa fa-chevron-circle-down fa-lg" onclick="showDiv('div${preIndex.index}','${perAct.act_id}')" style="color: #b8b8b8;"></span>
		</div> --%>
											
	</div>	
	</c:forEach>
<div id="divLoadMore1">
</div>
<div style="text-align: center; height: 40px; line-height: 40px; font-size: 12px; color: #888; font-family: Arial, Microsoft YaHei; background-color: white;" onclick="loadMoreActivity(this, 1, '${obj.theUserId}')">
		<div id="loadText1">点击加载更多</div>
</div>
</c:when>
<c:otherwise>
	<div class="container" style="background-color:white; padding-bottom:30px;">
	<div class="h5 text-muted" style="padding-top:50px;text-align:center;">
		<span>亲，你还没发起活动哦</span>		
	</div>
	</div>
</c:otherwise>
</c:choose> 
</div>

<div id="myParterChallenge" style="display: none">
<c:choose>
	<c:when test="${obj.dataParter!=null && obj.dataParter.size()>0}"> 	
		<c:forEach var="perAct" items="${obj.dataParter}" varStatus="preIndex">
		
		<c:if test="${preIndex.index==obj.dataParter.size()-1}">
			<input id="hiddenflag2" type="text" value="${perAct.header_time}" hidden="hidden"/>
		</c:if>
		
		<!-- 活动 -->
		<div class="container" style="background-color:white; padding:8px;margin-bottom:10px;">
			<div class="row" style="z-index:0">
					<div class="col-sm-7">
						<span class="thumb-sm pull-left"> <img
							src="${perAct.header_img}" class="img-circle" style="width: 30px; height: 30px;">
						</span>
						
							<div>
								<span style="font-size: 80%;">${perAct.header_name}</span>
								<span style="font-size: 80%;">${perAct.header_time}</span>
								<span id="status${preIndex.index}" class="h6 text-muted" style="float:right;">${perAct.header_status}</span>
							</div>
			</div>
			</div>
			<div onclick="activityDetail('${perAct.act_id}')">
			<div class="m-l m-b-xs m-t-xs">				
					<i class="h6 text-muted fa fa-bullhorn fa-lg"></i>
							<span class="h6 text-muted">事件预测：</span>
							<span class="h6 text-font">${perAct.act_title}</span>
			</div>
			<div class="m-l m-b-xs m-t-xs">				
					<i class="h6 text-muted fa fa-gift fa-lg"></i>
								<span class="h6 text-muted"> 事件奖惩：</span>
								<span class="h6 text-font">${perAct.act_content}</span>
			</div>
			</div>
			<!-- div收起和展开  -->
			<%-- <div id="divx${preIndex.index}" style="display:none;"> --%>
			<div id="divx${preIndex.index}">
				
				
				<%-- <div class="m-l m-b-xs m-t-xs">				
					<i class="h6 text-muted fa fa-clock-o fa-lg"></i>
								<span class="h6 text-muted">参与截止：</span> 
								<span class="h6 text-font">${perAct.act_time}</span>
				</div> --%>
				
				<div class="row" >
			<div class="col-xs-6" style="text-align: left;overflow-y:auto;overflow-x:hidden;height:35px;">
				<div class=" m-l-lg m-b-xs m-t-xs">				
								<c:choose>
									<c:when test="${perAct.act_parter_yes.size()>0}">	
									<span class="h6 text-muted">					
										<c:forEach var="actParter" items="${perAct.act_parter_yes}" varStatus="status">
											<c:choose>
												<c:when test="${status.index==0}">
													<img src="${actParter}" class="img-circle thumb-lg" style="width: 30px; height: 30px;">
												</c:when>
												<c:otherwise>
													<img src="${actParter}" class="img-circle thumb-lg" style="width: 30px; height: 30px; margin-left:-8px;">
												</c:otherwise>
											</c:choose>
										</c:forEach>
										</span>
									</c:when>
									<c:otherwise>
										<span class="h6 text-muted">没有人支持</span>
									</c:otherwise>
								</c:choose>
						
					<span class="h6 text-muted"><i class="fa fa-thumbs-o-up fa-lg"></i></span>
				</div>
			</div>
			
			<div class="col-xs-6" style="text-align: right;overflow-y:auto;overflow-x:hidden;height:35px;">
				<div class=" m-r-lg m-b-xs m-t-xs">				
								<c:choose>
									<c:when test="${perAct.act_parter_no.size()>0}">	
									<span class="h6 text-muted">					
										<c:forEach var="actParter" items="${perAct.act_parter_no}" varStatus="status">
											<c:choose>
												<c:when test="${status.index==0}">
													<img src="${actParter}" class="img-circle thumb-lg" style="width: 30px; height: 30px;">
												</c:when>
												<c:otherwise>
													<img src="${actParter}" class="img-circle thumb-lg" style="width: 30px; height: 30px; margin-left:-8px;">
												</c:otherwise>
											</c:choose>
										</c:forEach>
										</span>
									</c:when>
									<c:otherwise>
										<span class="h6 text-muted">没有人反对</span>
									</c:otherwise>
								</c:choose>
						
					<span class="h6 text-muted"><i class="fa fa-thumbs-o-down fa-lg"></i></span>
				</div>
			</div>
			
			</div>
				
			<div class="row">
			<div class="col-xs-5" style="text-align: left;">
				<button class="button button-plain button-border button-circle button-small" style="color:#58666e;" data-toggle="button" onclick="insertComplain('${perAct.act_id}','${perAct.header_userId}','${obj.theUserId}')">投诉</button>
					<c:if test="${perAct.header_status=='已完成'}">
					<button class="button button-plain button-border button-circle button-small" style="color:#58666e;"  data-toggle="button"  onclick="insertPress('${perAct.act_id}','${perAct.header_userId}','${obj.theUserId}')">催促</button>
	 				</c:if>
			</div>
			<div class="pull-right" style="margin-right:20px">
			<c:choose> 
				<c:when test="${perAct.act_result==3}">
						<div class="btn-group btn-group-sm pull-right" >
						  	<span aria-haspopup="true" aria-expanded="false" style="margin-top:-5px; ">
 								<span class="text-muted">活动因故取消</span><!-- <span class="caret"></span> -->
						  	</span>
						 </div>
				</c:when>
				<c:when test="${perAct.header_status=='已完成'}">
					<div class="btn-group">
					  <div class="btn-group btn-group-sm pull-right">
					  	<span aria-haspopup="true" aria-expanded="false" style="margin-top:-5px;">
						  	<c:choose>	
							  	<c:when test="${perAct.act_result==1}">
	 							<span class="text-muted">我认栽，通知好友</span>
	 							</c:when>
	 							<c:when test="${perAct.act_result==2 }">
	 							<span class="text-muted">朕赢了，通知好友</span>
	 							</c:when>
 							</c:choose>	
 						</span>
 						<!-- <span class="caret"></span> -->
 					 </div>
					</div>
				</c:when>
				<c:otherwise>
					<div class="btn-group btn-group-sm pull-right" >
						  	<span aria-haspopup="true" aria-expanded="false" style="margin-top:-5px; ">
 								<span class="text-muted">等待结果发布</span><!-- <span class="caret"></span> -->
						  	</span>
						 </div>
				</c:otherwise>
			</c:choose>			 
			</div>	
			</div>
		</div>
			
			<%-- <div style="text-align: center;">					
					<span class="avatar fa fa-chevron-circle-down fa-lg" onclick="showDiv('divx${preIndex.index}')" style="color: #b8b8b8;"></span>
			</div> --%>
			
		
											
		</div>	
		</c:forEach>
	<div id="divLoadMore2">
	</div>
	<div style="text-align: center; height: 40px; line-height: 40px; font-size: 12px; color: #888; font-family: Arial, Microsoft YaHei; background-color: white;" onclick="loadMoreActivity(this, 2, '${obj.theUserId}')">
		<div id="loadText2">点击加载更多</div>
	</div>	
	</c:when>
	<c:otherwise>
		<div class="container" style="background-color:white; padding-bottom:30px;">
		<div class="h5 text-muted" style="padding-top:50px;text-align:center;">
		<span>亲，你还没参与活动哦</span>	
		</div>
		</div>
	</c:otherwise>
</c:choose> 
</div>

<!-- 我收藏的活动 -->
<div id="myCareChallenge" style="display: none">
<c:choose>
	<c:when test="${obj.careParter!=null && obj.careParter.size()>0}"> 	
		<c:forEach var="perAct" items="${obj.careParter}" varStatus="preIndex">
		
		<c:if test="${preIndex.index==obj.careParter.size()-1}">
			<input id="hiddenflag3" type="text" value="${perAct.header_time}" hidden="hidden"/>
		</c:if>
		
		<!-- 活动 -->
		<div class="container"  id="activity${preIndex.index}" style="background-color:white; padding:8px;margin-bottom:10px;">
			<div class="row" style="z-index:0">
					<div class="col-sm-7">
						<span class="thumb-sm pull-left"> <img
							src="${perAct.header_img}" class="img-circle" style="width: 30px; height: 30px;">
						</span>
						
							<div>
								<span style="font-size: 80%;">${perAct.header_name}</span>
								<%-- <c:choose>
									<c:when test="${perAct.header_level==1}">
										 <span style="font-size: 80%;">-新人-</span>
									</c:when>
									<c:when test="${perAct.header_level==2}">
										 <span style="font-size: 80%;">-师兄-</span>
									</c:when>
									<c:when test="${perAct.header_level==3}">
										 <span style="font-size: 80%;">-少侠-</span>
									</c:when>
									<c:when test="${perAct.header_level==4}">
										 <span style="font-size: 80%;">-大侠-</span>
									</c:when>
									<c:when test="${perAct.header_level==5}">
										 <span style="font-size: 80%;">-掌门-</span>
									</c:when>
							   </c:choose> --%>
								<span style="font-size: 80%;">${perAct.header_time}</span>
								<span id="status${preIndex.index}" class="h6 text-muted" style="float:right;">${perAct.header_status}</span>
							</div>
			</div>
			</div>
			<div onclick="activityDetail('${perAct.act_id}')">
			<div class="m-l m-b-xs m-t-xs">				
					<i class="h6 text-muted fa fa-bullhorn fa-lg"></i>
							<span class="h6 text-muted">事件预测：</span>
							<span class="h6 text-font">${perAct.act_title}</span>
			</div>
			<div class="m-l m-b-xs m-t-xs">				
					<i class="h6 text-muted fa fa-gift fa-lg"></i>
								<span class="h6 text-muted">事件奖惩：</span>
								<span class="h6 text-font">${perAct.act_content}</span>
				</div>
			</div>
			<!-- div收起和展开  -->
			<%-- <div id="divy${preIndex.index}" style="display:none;"> --%>
			<div id="divy${preIndex.index}">
				
				
				<%-- <div class="m-l m-b-xs m-t-xs">				
					<i class="h6 text-muted fa fa-clock-o fa-lg"></i>
								<span class="h6 text-muted">参与截止：</span> 
								<span class="h6 text-font">${perAct.act_time}</span>
				</div> --%>
				
				<div class="row" >
			<div class="col-xs-6" style="text-align: left;overflow-y:auto;overflow-x:hidden;height:35px;">
				<div class=" m-l-lg m-b-xs m-t-xs">				
								<c:choose>
									<c:when test="${perAct.act_parter_yes.size()>0}">	
									<span class="h6 text-muted">					
										<c:forEach var="actParter" items="${perAct.act_parter_yes}" varStatus="status">
											<c:choose>
												<c:when test="${status.index==0}">
													<img src="${actParter}" class="img-circle thumb-lg" style="width: 30px; height: 30px;">
												</c:when>
												<c:otherwise>
													<img src="${actParter}" class="img-circle thumb-lg" style="width: 30px; height: 30px; margin-left:-8px;">
												</c:otherwise>
											</c:choose>
										</c:forEach>
										</span>
									</c:when>
									<c:otherwise>
										<span class="h6 text-muted">没有人支持</span>
									</c:otherwise>
								</c:choose>
						
					<span class="h6 text-muted"><i class="fa fa-thumbs-o-up fa-lg"></i></span>
				</div>
			</div>
			
			<div class="col-xs-6" style="text-align: right;overflow-y:auto;overflow-x:hidden;height:35px;">
				<div class=" m-r-lg m-b-xs m-t-xs">				
								<c:choose>
									<c:when test="${perAct.act_parter_no.size()>0}">	
									<span class="h6 text-muted">					
										<c:forEach var="actParter" items="${perAct.act_parter_no}" varStatus="status">
											<c:choose>
												<c:when test="${status.index==0}">
													<img src="${actParter}" class="img-circle thumb-lg" style="width: 30px; height: 30px;">
												</c:when>
												<c:otherwise>
													<img src="${actParter}" class="img-circle thumb-lg" style="width: 30px; height: 30px; margin-left:-8px;">
												</c:otherwise>
											</c:choose>
										</c:forEach>
										</span>
									</c:when>
									<c:otherwise>
										<span class="h6 text-muted">没有人反对</span>
									</c:otherwise>
								</c:choose>
						
					<span class="h6 text-muted"><i class="fa fa-thumbs-o-down fa-lg"></i></span>
				</div>
			</div>
			
			</div>
			<div class="row">	
				<div class="col-xs-5" style="text-align: left;">
					<button class="button button-plain button-border button-circle button-small" style="color:#58666e;" data-toggle="button" onclick="cancelCare('${perAct.act_id}','${obj.theUserId}','activity${preIndex.index}')">取消</button>
				</div>
				<%-- <div class="col-xs-7 h6 text-muted m-t-xs">
					<span class="h6 text-muted">结果发布：</span>
						<c:choose> 
							<c:when test="${perAct.act_result==-1}">
								<select style="width:100px;" disabled="disabled">
									<option value="-1" selected>已取消</option>
								</select>
							</c:when>
							<c:otherwise>
								<select style="width:100px;" disabled="disabled" >
									<option value="0" <c:if test="${perAct.act_result==0}">selected</c:if>></option>
									<option value="1" <c:if test="${perAct.act_result==1}">selected</c:if>>我认栽，通知好友</option>
									<option value="2" <c:if test="${perAct.act_result==2}">selected</c:if>>朕赢了，通知好友</option>
								</select>
							</c:otherwise>
						</c:choose>			 
					</div>	 --%>
					<div class="pull-right" style="margin-right:20px">
			<%-- <span class="h6 text-muted">结果发布：</span>
						<select style="width:100px;"  disabled="disabled">
							<option value="0" <c:if test="${perAct.act_result==0}">selected</c:if>></option>
							<option value="1" <c:if test="${perAct.act_result==1}">selected</c:if>>我认栽，通知好友</option>
							<option value="2" <c:if test="${perAct.act_result==2}">selected</c:if>>朕赢了，通知好友</option>
							<option value="3" <c:if test="${perAct.act_result==3}">selected</c:if>>活动因故取消</option>
						</select>	 --%>
			<c:choose> 
				<c:when test="${perAct.act_result==3}">
						<div class="btn-group btn-group-sm pull-right" >
						  	<span aria-haspopup="true" aria-expanded="false" style="margin-top:-5px; ">
 								<span class="text-muted">活动因故取消</span><!-- <span class="caret"></span> -->
						  	</span>
						 </div>
				</c:when>
				<c:when test="${perAct.header_status=='已完成'}">
					<div class="btn-group">
					  <div class="btn-group btn-group-sm pull-right">
					  	<span aria-haspopup="true" aria-expanded="false" style="margin-top:-5px;">
						  	<c:choose>	
							  	<c:when test="${perAct.act_result==1}">
	 							<span class="text-muted">我认栽，通知好友</span>
	 							</c:when>
	 							<c:when test="${perAct.act_result==2 }">
	 							<span class="text-muted">朕赢了，通知好友</span>
	 							</c:when>
 							</c:choose>	
 						</span>
 						<!-- <span class="caret"></span> -->
 					 </div>
					</div>
				</c:when>
				<c:otherwise>
					<div class="btn-group btn-group-sm pull-right" >
						  	<span aria-haspopup="true" aria-expanded="false" style="margin-top:-5px; ">
 								<span class="text-muted">等待结果发布</span><!-- <span class="caret"></span> -->
						  	</span>
						 </div>
				</c:otherwise>
			</c:choose>			 
			</div>
			</div>	
				
				
			</div>	
				
				
	
			
			<%-- <div style="text-align: center;">					
					<span class="avatar fa fa-chevron-circle-down fa-lg" onclick="showDiv('divy${preIndex.index}')" style="color: #b8b8b8;"></span>
			</div> --%>
				
		</div>	
		</c:forEach>
	<div id="divLoadMore3">
	</div>
	<div style="text-align: center; height: 40px; line-height: 40px; font-size: 12px; color: #888; font-family: Arial, Microsoft YaHei; background-color: white;" onclick="loadMoreActivity(this, 3, '${obj.theUserId}')">
		<div id="loadText3">点击加载更多</div>
	</div>
	</c:when>
	<c:otherwise>
		<div class="container" style="background-color:white; padding-bottom:30px;">
		<div class="h5 text-muted" style="padding-top:50px;text-align:center;">
		<span>亲，你还没收藏活动哦</span>	
		</div>
		</div>
	</c:otherwise>
</c:choose> 
</div>

<div style="height: 60px;"></div>
<footer>
	<div class="mune">
		<a href="${base}/weixin/baseoauth?action=FrontOfChallengIndex" style="text-decoration: none;">
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
<!-- 	<div class="mune">
		<a href="#" data-toggle="modal" data-target="#myModal" style="text-decoration: none;">
    	<i class="fa fa-envelope fa-2x"></i>
        <p>红包</p>
        </a>
    </div> -->
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
	
</body>
<script>
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
<script type="text/javascript">
function loadMoreActivity(obj, flag, userId)
{
	var loadText=document.getElementById("loadText"+flag);
	loadText.innerText = '加载中，请稍等。。。';
	var hiddenflag=document.getElementById("hiddenflag"+flag).value;

	$.ajax({
		type : "POST",
		url : "${base}/loadMoreActivity",
		data: {flag:flag, next:hiddenflag, userId:userId},
		datatyep : "json",
		success : function(data)
		{
			var divContent = document.getElementById("divLoadMore"+flag);
			var jsonData = eval("("+data+")");
			var arrList = jsonData.dataAllAct;
			var sf = "";
			for(var i=0; i<arrList.length;i++)
			{
				var actMap = arrList[i];
				if(i == arrList.length-1)
				{
					document.getElementById("hiddenflag"+flag).value = actMap.header_time;
				}
				if(flag == 1)
				{
					sf += populateMyChange(actMap, i);
				}
				else if(flag == 2)
				{
					sf += populateMyParterChange(actMap, i);
				}
				else if(flag == 3)
				{
					sf += populateMyCareChange(actMap, i);
				}
			}
			divContent.innerHTML = divContent.innerHTML + sf;
			loadText.innerText = '点击加载更多'; 
		}
	}); 
}

function populateMyChange(actMap, i)
{
	var sf = "";
	sf += "<div class='container' style='background-color:white;padding:8px;margin-bottom:10px;'>";
	sf += "<div class='row' style='z-index:0'>";
	sf += "<div class='col-sm-7'>";
	sf += "<span class='thumb-sm pull-left'>";
	sf += "<img src='" + actMap.header_img+ "' class='img-circle' style='width: 30px; height: 30px;'>";
	sf += "</span>";
	sf += "<div>";
	sf += "<span style='font-size: 80%;'>" + actMap.header_name+ "</span>";
	sf += "<span style='font-size: 80%;'>" + actMap.header_time+ "</span>";
	sf += "<span id='status"+ actMap.header_time+ i + "' class='h6 text-muted' style='float:right;'>" + actMap.header_status+ "</span>";
	sf += "</div>";
	sf += "</div>";
	sf += "</div>";
	sf += "<div onclick='activityDetail('" + actMap.act_id+ "')'>";
	sf += "<div class='m-l m-b-xs m-t-xs'>";				
	sf += "<i class='h6 text-muted fa fa-bullhorn fa-lg'></i>";
	sf += "<span class='h6 text-muted'>事件预测：</span>";
	sf += "<span class='h6 text-font'>" + actMap.act_title+ "</span>";					
	sf += "</div>";
	sf += "<div class='m-l m-b-xs m-t-xs'>";				
	sf += "<i class='h6 text-muted fa fa-gift fa-lg'></i>";
	sf += "<span class='h6 text-muted'>事件奖惩：</span>";
	sf += "<span class='h6 text-font'>" + actMap.act_content+ "</span>";
	sf += "</div>";
	sf += "</div>";
	sf += "<div id='div"+ actMap.header_time + i + "'>";				
	sf += "<div class='row'>";
	sf += "<div class='col-xs-6' style='text-align: left;overflow-y:auto;overflow-x:hidden;height:35px;'>";
	sf += "<div class=' m-l-lg m-b-xs m-t-xs'>";					
	if(actMap.act_parter_yes.length > 0)
	{
	sf += "<span class='h6 text-muted'>";					
	for(var j=0; j<actMap.act_parter_yes.length; j++)
	{
	if(j==0)
	{
	sf += "<img src='"+ actMap.act_parter_yes[j] + "' class='img-circle thumb-lg' style='width: 30px; height: 30px;'>";
	}
	else
	{
	sf += "<img src='"+ actMap.act_parter_yes[j] + "' class='img-circle thumb-lg' style='width: 30px; height: 30px; margin-left:-8px;'>";
	}
	}
	sf += "</span>";
	}
	else
	{
	sf += "<span class='h6 text-muted'>没有人支持</span>";
	}
	sf += "<span class='h6 text-muted'>";
	sf += "<i class='fa fa-thumbs-o-up fa-lg'></i>";
	sf += "</span>";
	sf += "</div>";
	sf += "</div>";
	sf += "<div class='col-xs-6' style='text-align: right;overflow-y:auto;overflow-x:hidden;height:35px;'>";
	sf += "<div class=' m-r-lg m-b-xs m-t-xs'>";				
	if(actMap.act_parter_no.length > 0)
	{
	sf += "<span class='h6 text-muted'>";					
	for(var m=0; m<actMap.act_parter_no.length; m++)
	{
	if(m == 0)
	{
	sf += "<img src='"+actMap.act_parter_no[m]+ "' class='img-circle thumb-lg' style='width: 30px; height: 30px;'>";
	}
	else
	{
	sf += "<img src='"+actMap.act_parter_no[m]+ "' class='img-circle thumb-lg' style='width: 30px; height: 30px; margin-left:-8px;'>";
	}
	}
	sf += "</span>";
	}
	else
	{
	sf += "<span class='h6 text-muted'>没有人反对</span>";
	}						
	sf += "<span class='h6 text-muted'>";
	sf += "<i class='fa fa-thumbs-o-down fa-lg'></i>";
	sf += "</span>";
	sf += "</div>";
	sf += "</div>";
	sf += "</div>";				
	sf += "<div class='row' >";
	sf += "<div class='col-xs-5' style='text-align: left;'>";
	if(actMap.delAble==1)
	{
	sf += "<button class='button button-plain button-border button-circle button-small' style='color:#58666e;' data-toggle='button' onclick='delTheAct('" + actMap.act_id+ "','" + actMap.header_time+ "')'>撤回</button>";
	}
	sf += "<button class='button button-plain button-border button-circle button-small' style='color:#58666e;' data-toggle='button' onclick='insertComplain('" + actMap.act_id+ "','" + actMap.header_userId+ "','" + actMap.header_userId + "')'>投诉</button>";
	if(actMap.header_status=='已完成')
	{
	sf += "<button class='button button-plain button-border button-circle button-small' style='color:#58666e;' id='ownerActivity"+ actMap.header_time+ i + "'   data-toggle='button'  onclick='insertPressOwner('" + actMap.act_id+ "','" + actMap.header_userId+ "','"+ actMap.header_userId+ "','" + actMap.act_parter.length+ "')'>催促</button>";
	}
	sf += "</div>";
	sf += "<div class='pull-right' style='margin-right:20px'>";
	if(actMap.act_result==3)
	{
	sf += "<div class='btn-group btn-group-sm pull-right' >";
	sf += "<span aria-haspopup='true' aria-expanded='false' style='margin-top:-5px; '>";
	sf += "<span class='text-muted'>活动因故取消</span>";
	sf += "</span>";
	sf += "</div>";
	}
	else if(actMap.header_status=='已完成')
	{
	sf += "<div class='btn-group'>";
	sf += "<div class='btn-group btn-group-sm pull-right'>";
	sf += "<span aria-haspopup='true' aria-expanded='false' style='margin-top:-5px;'>";
	if(actMap.act_result==1)
	{
	sf += "<span class='text-muted'>我认栽，通知好友</span>";
	}
	if(actMap.act_result==2)
	{
	sf += "<span class='text-muted'>朕赢了，通知好友</span>";
	}	
	sf += "</span>";

	sf += "</div>";
	sf += "</div>";
	}
	else
	{

	sf += "<div class='btn-group btn-group-sm pull-right' >";
	sf += "<span aria-haspopup='true' aria-expanded='false' style='margin-top:-5px; '>";
	sf += "<span class='text-muted'>等待结果发布</span>";
	sf += "</span>";
	sf += "</div>";
	}							
	sf += "</div>";	
	sf += "</div>";
	sf += "</div>";
	sf += "</div>";	
	return sf;
}

function populateMyParterChange(actMap, i)
{
	var sf = "";
	sf += "<div class='container' style='background-color:white;padding:8px;margin-bottom:10px;'>";
	sf += "<div class='row' style='z-index:0'>";
	sf += "<div class='col-sm-7'>";
	sf += "<span class='thumb-sm pull-left'>";
	sf += "<img src='" + actMap.header_img+ "' class='img-circle' style='width: 30px; height: 30px;'>";
	sf += "</span>";
	sf += "<div>";
	sf += "<span style='font-size: 80%;'>" + actMap.header_name+ "</span>";
	sf += "<span style='font-size: 80%;'>" + actMap.header_time+ "</span>";
	sf += "<span id='status"+ actMap.header_time+ i + "' class='h6 text-muted' style='float:right;'>" + actMap.header_status+ "</span>";
	sf += "</div>";
	sf += "</div>";
	sf += "</div>";
	sf += "<div onclick='activityDetail('" + actMap.act_id+ "')'>";
	sf += "<div class='m-l m-b-xs m-t-xs'>";				
	sf += "<i class='h6 text-muted fa fa-bullhorn fa-lg'></i>";
	sf += "<span class='h6 text-muted'>事件预测：</span>";
	sf += "<span class='h6 text-font'>" + actMap.act_title+ "</span>";					
	sf += "</div>";
	sf += "<div class='m-l m-b-xs m-t-xs'>";				
	sf += "<i class='h6 text-muted fa fa-gift fa-lg'></i>";
	sf += "<span class='h6 text-muted'>事件奖惩：</span>";
	sf += "<span class='h6 text-font'>" + actMap.act_content+ "</span>";
	sf += "</div>";
	sf += "</div>";
	sf += "<div id='div"+ actMap.header_time + i + "'>";				
	sf += "<div class='row'>";
	sf += "<div class='col-xs-6' style='text-align: left;overflow-y:auto;overflow-x:hidden;height:35px;'>";
	sf += "<div class=' m-l-lg m-b-xs m-t-xs'>";					
	if(actMap.act_parter_yes.length > 0)
	{
	sf += "<span class='h6 text-muted'>";					
	for(var j=0; j<actMap.act_parter_yes.length; j++)
	{
	if(j==0)
	{
	sf += "<img src='"+ actMap.act_parter_yes[j] + "' class='img-circle thumb-lg' style='width: 30px; height: 30px;'>";
	}
	else
	{
	sf += "<img src='"+ actMap.act_parter_yes[j] + "' class='img-circle thumb-lg' style='width: 30px; height: 30px; margin-left:-8px;'>";
	}
	}
	sf += "</span>";
	}
	else
	{
	sf += "<span class='h6 text-muted'>没有人支持</span>";
	}
	sf += "<span class='h6 text-muted'>";
	sf += "<i class='fa fa-thumbs-o-up fa-lg'></i>";
	sf += "</span>";
	sf += "</div>";
	sf += "</div>";
	sf += "<div class='col-xs-6' style='text-align: right;overflow-y:auto;overflow-x:hidden;height:35px;'>";
	sf += "<div class=' m-r-lg m-b-xs m-t-xs'>";				
	if(actMap.act_parter_no.length > 0)
	{
	sf += "<span class='h6 text-muted'>";					
	for(var m=0; m<actMap.act_parter_no.length; m++)
	{
	if(m == 0)
	{
	sf += "<img src='"+actMap.act_parter_no[m]+ "' class='img-circle thumb-lg' style='width: 30px; height: 30px;'>";
	}
	else
	{
	sf += "<img src='"+actMap.act_parter_no[m]+ "' class='img-circle thumb-lg' style='width: 30px; height: 30px; margin-left:-8px;'>";
	}
	}
	sf += "</span>";
	}
	else
	{
	sf += "<span class='h6 text-muted'>没有人反对</span>";
	}						
	sf += "<span class='h6 text-muted'>";
	sf += "<i class='fa fa-thumbs-o-down fa-lg'></i>";
	sf += "</span>";
	sf += "</div>";
	sf += "</div>";
	sf += "</div>";				
	sf += "<div class='row' >";
	sf += "<div class='col-xs-5' style='text-align: left;'>";
	sf += "<button class='button button-plain button-border button-circle button-small' style='color:#58666e;' data-toggle='button' onclick='insertComplain('" + actMap.act_id+ "','" + actMap.header_userId+ "','" + actMap.header_userId + "')'>投诉</button>";
	if(actMap.header_status=='已完成')
	{
	sf += "<button class='button button-plain button-border button-circle button-small' style='color:#58666e;' data-toggle='button'  onclick='insertPress('" + actMap.act_id+ "','" + actMap.header_userId+ "','"+ actMap.header_userId + "')'>催促</button>";
	}
	sf += "</div>";
	sf += "<div class='pull-right' style='margin-right:20px'>";
	if(actMap.act_result==3)
	{
	sf += "<div class='btn-group btn-group-sm pull-right' >";
	sf += "<span aria-haspopup='true' aria-expanded='false' style='margin-top:-5px; '>";
	sf += "<span class='text-muted'>活动因故取消</span>";
	sf += "</span>";
	sf += "</div>";
	}
	else if(actMap.header_status=='已完成')
	{
	sf += "<div class='btn-group'>";
	sf += "<div class='btn-group btn-group-sm pull-right'>";
	sf += "<span aria-haspopup='true' aria-expanded='false' style='margin-top:-5px;'>";
	if(actMap.act_result==1)
	{
	sf += "<span class='text-muted'>我认栽，通知好友</span>";
	}
	if(actMap.act_result==2)
	{
	sf += "<span class='text-muted'>朕赢了，通知好友</span>";
	}	
	sf += "</span>";

	sf += "</div>";
	sf += "</div>";
	}
	else
	{

	sf += "<div class='btn-group btn-group-sm pull-right' >";
	sf += "<span aria-haspopup='true' aria-expanded='false' style='margin-top:-5px; '>";
	sf += "<span class='text-muted'>等待结果发布</span>";
	sf += "</span>";
	sf += "</div>";
	}							
	sf += "</div>";	
	sf += "</div>";
	sf += "</div>";
	sf += "</div>";	
	return sf;
}

function populateMyCareChange(actMap, i)
{
	var sf = "";
	sf += "<div class='container' style='background-color:white;padding:8px;margin-bottom:10px;'>";
	sf += "<div class='row' style='z-index:0'>";
	sf += "<div class='col-sm-7'>";
	sf += "<span class='thumb-sm pull-left'>";
	sf += "<img src='" + actMap.header_img+ "' class='img-circle' style='width: 30px; height: 30px;'>";
	sf += "</span>";
	sf += "<div>";
	sf += "<span style='font-size: 80%;'>" + actMap.header_name+ "</span>";
	sf += "<span style='font-size: 80%;'>" + actMap.header_time+ "</span>";
	sf += "<span id='status"+ actMap.header_time+ i + "' class='h6 text-muted' style='float:right;'>" + actMap.header_status+ "</span>";
	sf += "</div>";
	sf += "</div>";
	sf += "</div>";
	sf += "<div onclick='activityDetail('" + actMap.act_id+ "')'>";
	sf += "<div class='m-l m-b-xs m-t-xs'>";				
	sf += "<i class='h6 text-muted fa fa-bullhorn fa-lg'></i>";
	sf += "<span class='h6 text-muted'>事件预测：</span>";
	sf += "<span class='h6 text-font'>" + actMap.act_title+ "</span>";					
	sf += "</div>";
	sf += "<div class='m-l m-b-xs m-t-xs'>";				
	sf += "<i class='h6 text-muted fa fa-gift fa-lg'></i>";
	sf += "<span class='h6 text-muted'>事件奖惩：</span>";
	sf += "<span class='h6 text-font'>" + actMap.act_content+ "</span>";
	sf += "</div>";
	sf += "</div>";
	sf += "<div id='div"+ actMap.header_time + i + "'>";				
	sf += "<div class='row'>";
	sf += "<div class='col-xs-6' style='text-align: left;overflow-y:auto;overflow-x:hidden;height:35px;'>";
	sf += "<div class=' m-l-lg m-b-xs m-t-xs'>";					
	if(actMap.act_parter_yes.length > 0)
	{
	sf += "<span class='h6 text-muted'>";					
	for(var j=0; j<actMap.act_parter_yes.length; j++)
	{
	if(j==0)
	{
	sf += "<img src='"+ actMap.act_parter_yes[j] + "' class='img-circle thumb-lg' style='width: 30px; height: 30px;'>";
	}
	else
	{
	sf += "<img src='"+ actMap.act_parter_yes[j] + "' class='img-circle thumb-lg' style='width: 30px; height: 30px; margin-left:-8px;'>";
	}
	}
	sf += "</span>";
	}
	else
	{
	sf += "<span class='h6 text-muted'>没有人支持</span>";
	}
	sf += "<span class='h6 text-muted'>";
	sf += "<i class='fa fa-thumbs-o-up fa-lg'></i>";
	sf += "</span>";
	sf += "</div>";
	sf += "</div>";
	sf += "<div class='col-xs-6' style='text-align: right;overflow-y:auto;overflow-x:hidden;height:35px;'>";
	sf += "<div class=' m-r-lg m-b-xs m-t-xs'>";				
	if(actMap.act_parter_no.length > 0)
	{
	sf += "<span class='h6 text-muted'>";					
	for(var m=0; m<actMap.act_parter_no.length; m++)
	{
	if(m == 0)
	{
	sf += "<img src='"+actMap.act_parter_no[m]+ "' class='img-circle thumb-lg' style='width: 30px; height: 30px;'>";
	}
	else
	{
	sf += "<img src='"+actMap.act_parter_no[m]+ "' class='img-circle thumb-lg' style='width: 30px; height: 30px; margin-left:-8px;'>";
	}
	}
	sf += "</span>";
	}
	else
	{
	sf += "<span class='h6 text-muted'>没有人反对</span>";
	}						
	sf += "<span class='h6 text-muted'>";
	sf += "<i class='fa fa-thumbs-o-down fa-lg'></i>";
	sf += "</span>";
	sf += "</div>";
	sf += "</div>";
	sf += "</div>";				
	sf += "<div class='row' >";
	sf += "<div class='col-xs-5' style='text-align: left;'>";
	sf += "<button class='button button-plain button-border button-circle button-small' style='color:#58666e;' data-toggle='button' onclick='cancelCare('" + actMap.act_id+ "','" + actMap.header_userId+ "','activity" + actMap.header_time + i + "')'>取消</button>";
	sf += "</div>";
	sf += "<div class='pull-right' style='margin-right:20px'>";
	if(actMap.act_result==3)
	{
	sf += "<div class='btn-group btn-group-sm pull-right' >";
	sf += "<span aria-haspopup='true' aria-expanded='false' style='margin-top:-5px; '>";
	sf += "<span class='text-muted'>活动因故取消</span>";
	sf += "</span>";
	sf += "</div>";
	}
	else if(actMap.header_status=='已完成')
	{
	sf += "<div class='btn-group'>";
	sf += "<div class='btn-group btn-group-sm pull-right'>";
	sf += "<span aria-haspopup='true' aria-expanded='false' style='margin-top:-5px;'>";
	if(actMap.act_result==1)
	{
	sf += "<span class='text-muted'>我认栽，通知好友</span>";
	}
	if(actMap.act_result==2)
	{
	sf += "<span class='text-muted'>朕赢了，通知好友</span>";
	}
	sf += "</span>";

	sf += "</div>";
	sf += "</div>";
	}
	else
	{

	sf += "<div class='btn-group btn-group-sm pull-right' >";
	sf += "<span aria-haspopup='true' aria-expanded='false' style='margin-top:-5px; '>";
	sf += "<span class='text-muted'>等待结果发布</span>";
	sf += "</span>";
	sf += "</div>";
	}							
	sf += "</div>";	
	sf += "</div>";
	sf += "</div>";
	sf += "</div>";	
	return sf;
}
</script>
</html>