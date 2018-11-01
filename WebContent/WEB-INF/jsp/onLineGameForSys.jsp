<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
		<link rel="stylesheet" type="text/css" href="http://cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">

		<link rel="stylesheet" href="bootstrap3.3.5/css/myInfoStyle.css" />

		<link rel="stylesheet" type="text/css" href="css/task.css">
		<link rel="stylesheet" type="text/css" href="http://cdn.bootcss.com/font-awesome/4.2.0/css/font-awesome.min.css">
		<link rel="stylesheet" type="text/css" href="http://www.bootcss.com/p/buttons/css/buttons.css ">
		<link rel="stylesheet" type="text/css" href="http://sandbox.runjs.cn/uploads/rs/340/ustg8wvx/weui.css">
		<link rel="stylesheet" type="text/css" href="bootstrap3.3.5/css/app.css">
		<script type="text/javascript"	src="http://sandbox.runjs.cn/uploads/rs/340/ustg8wvx/weui.js"></script>
		<script type="text/javascript"	src="http://libs.baidu.com/jquery/1.9.1/jquery.min.js"></script>
		<script type="text/javascript"	src="http://cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
		<script type="text/javascript"	src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
		<title>朕以为</title>
		
		<script type="text/javascript">
		var timeout;
		$(document).ready(function() {
			localStorage.setItem('isReplyComments', 'false');
			//结果发布按钮是否出现
			var ownerId = "systemadmin";
			var nowUserId = "${openId}";
			var resultStatus = "${Activitiy.resultStatus}";
			var yesPart = "";
			var noPart = "";
			 <c:forEach var="obj" items="${participateNicknameYes}" begin="0" end="1"> 
				yesPart =yesPart+ "${obj} ";
		 	</c:forEach>
		 	if(yesPart.length >= 1){
		 		yesPart = yesPart + "...";
		 	}else{
		 		yesPart = "虚位以待... ";
		 	}
			<c:forEach var="obj" items="${participateNicknameNO}"> 
				noPart =noPart+ "${obj} ";
		 	</c:forEach>
		 	if(noPart.length==0){
		 		noPart = "虚位以待... ";
		 	}  
		 	//获取目前参与人员数
		
		 	var numberOfParticipate  = ${participateNicknameYes.size() + participateNicknameNO.size()};
		 	var numberOfYes = ${participateNicknameYes.size()};
		 	var numberOfNo = ${participateNicknameNO.size()};
		 	reWXready("奖惩：${Activitiy.activityStake}","预测：${Activitiy.activityDesc}","${WechatUser.headImgUrl}");
// 		 	reWXready("系统活动：${Activitiy.activityDesc}","已经有：" + numberOfParticipate+"位朋友参与到了本活动中！ " ,"${WechatUser.headImgUrl}");
		 	//显示交易记录
		 	if(resultStatus == 0){
		 		document.getElementById("forChalleger").style.display = "none";
		 	}else{
		 		document.getElementById("forChalleger").style.display = "block";
		 		
					$("#win").removeClass("button-glow");
					$("#lose").removeClass("button-glow");
										
					//显示结果
					if(resultStatus==2){
// 						reWXready("${Activitiy.activityStake}","预测：${Activitiy.activityDesc} ","${WechatUser.headImgUrl}");
						
						reWXready("胜者:"+yesPart+" VS 败者:"+noPart + " ${Activitiy.activityStake}","有：" + numberOfYes +"位朋友在本次活动中胜出！ ","${WechatUser.headImgUrl}");
						document.getElementById("redBtn").innerHTML='<span style="color:#f5725a"><b>胜</b></span>';
						document.getElementById("blueBtn").innerHTML='<span style="color:#42b5d8"><b>败</b></span>';
					}else{
// 						reWXready("${Activitiy.activityStake}","预测：${Activitiy.activityDesc} ","${WechatUser.headImgUrl}");
						
						reWXready("败者:"+yesPart+" VS 胜者:"+noPart + " ${Activitiy.activityStake}", "有：" + numberOfNo +"位朋友在本次活动中胜出！ ", "${WechatUser.headImgUrl}");
						document.getElementById("redBtn").innerHTML='<span style="color:#f5725a"><b>败</b></span>';
						document.getElementById("blueBtn").innerHTML='<span style="color:#42b5d8"><b>胜</b></span>';
					}
					document.getElementById("seatDiv").innerHTML="活动结束";				
					$("#blueBtn").removeClass("button-glow");
					$("#redBtn").removeClass("button-glow");
				
		 	}
		});
		</script>
	</head>
	<body>
	<script type="text/javascript">
			$(function(){ 
				if("${openId}"==""){ 
					window.location.href='http://${appServer}${base}/weixin/baseoauth?action=onlineGame&activityId=${Activitiy.activityId}';
				}
			});
			
			wx.config({
			    debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
			    appId: '${weixinParames.weixinparames.appId}', // 必填，公众号的唯一标识
			    timestamp:  '${weixinParames.weixinparames.timestamp}', // 必填，生成签名的时间戳 
			    nonceStr: '${weixinParames.weixinparames.nonceStr}', // 必填，生成签名的随机串
			    signature: '${weixinParames.weixinparames.signature}',// 必填，签名，见附录1 
				jsApiList : ['onMenuShareTimeline','onMenuShareAppMessage']
			});
		
		 
			
			
			function reWXready(contentx,titlex,imgUrlx){//参数：赞成反对，活动结果
				//全部的imgurl都统一为产品logo
				imgUrlx = "https://mmbiz.qlogo.cn/mmbiz/rLJwdLlcd3cRQEwo8rYXV7vJy8yOib9VzOZibd23ova9FKD8fZz1CwLuEzg0fRhtvpmgXdxLuIRJEG6PxPCrciclQ/0?wx_fmt=jpeg";
				 wx.ready(function () {
					 //讨论组分享↓↓↓↓↓↓↓↓↓
					 wx.onMenuShareAppMessage({  
					        title: titlex, // 分享标题  
					        desc: contentx, // 分享描述  
					        link: 'http://${appServer}${base}/weixin/baseoauth?action=onlineGame&activityId=${Activitiy.activityId}', // 分享链接  
					        imgUrl: imgUrlx, // 分享图标  
					        type: 'link', // 分享类型,music、video或link，不填默认为link  
					        dataUrl: '', // 如果type是music或video，则要提供数据链接，默认为空  
					       
					   }); 
		
					 if(titlex.length >= 20){
						 titlex = titlex.substring(0,20)+"...";
					 }
					 var showPart = titlex +"\n" + contentx;
					  
					//盆友圈↓↓↓↓↓↓↓
					 wx.onMenuShareTimeline({
						 
						 	title: showPart,
						    link: 'http://${appServer}${base}/weixin/baseoauth?action=onlineGame&activityId=${Activitiy.activityId}', // 分享链接
						    imgUrl:imgUrlx,
						});
					 wx.error(function(res){
				            // config信息验证失败会执行error函数，如签名过期导致验证失败，具体错误信息可以打开config的debug模式查看，也可以在返回的res参数中查看，对于SPA可以在这里更新签名。
				            weui.alert("微信服务器错误，请重新进入！");
				        });
					
				 });
				
			}
			
			function clickYesButton() {
				
				 var resultStatus = "${Activitiy.resultStatus}";
				 if(resultStatus!=0){
					 return;
				 }				  	
				if("${openId}"==""){
					weui.alert("微信服务器错误，请重新进入页面！");
				  	return ;
				}
				var dealline = "${Activitiy.activityDeadline}".substr(0,19);
			    var  deallinestr=dealline.toString();
			    deallinestr =  deallinestr.replace(/-/g,"/");
			    var deadTime = new Date(deallinestr).getTime();
				var currenTime = new Date().getTime();
			    if(parseInt(deadTime-currenTime)<parseInt(0)){
			    	weui.alert("你来晚了,活动截止时间已过！快去发起自己的活动吧！");
				   return ;  
			    } 
			    //获取适时的参与者数量
				  weui.confirm("确定支持？决定后别忘了点击右上角和朋友分享你的态度！记住了喔！","提示",function(r){
						if(r==true)
						{
							if("${pwdflag}"=="Y")
							{	
								var inputValue = prompt("请输入密码","");
								if(inputValue==null)
								{
									return;
								}
								else
								{
									if(inputValue=="")
									{
										weui.alert("密码不能为空！");
									}
									else
									{
										//判断输入的密码是否正确
										$.ajax({
											type : "POST",
											url : "${base}/verifyActPwd",
											data: {userId:"${Activitiy.userId}",actId:"${Activitiy.activityId}",secretcode:inputValue,parUsrId:"${openId}"},
											datatyep : "json",
											success : function(data)
											{
												var jsonData = eval("("+data+")");
												if(jsonData['rev']=="Y")
												{
													internalYesButton();
												}
												else if(jsonData['rev']=="L")
												{
													weui.alert("城池数量不足");
												}
												else if(jsonData['rev']=="N")
												{
													weui.alert("密码不正确");
												}
												else if(jsonData['rev']=="F")
												{
													weui.alert("服务器错误");
												}
											}
										});
									}
								}
							}
							else
							{
								internalYesButton();
							}
						}
					});
			}
			function clickNoButton(){
		 		var resultStatus = "${Activitiy.resultStatus}";
				 if(resultStatus!=0){
					 return;
				 }
	 			 if("${openId}"=="")
				{
				 weui.alert("微信服务器错误，请重新进入页面！");
				   return ;
				} 
				//时间限制
			    var dealline = "${Activitiy.activityDeadline}".substr(0,19);
			    var  deallinestr=dealline.toString();
			    deallinestr =  deallinestr.replace(/-/g,"/");
			    var deadTime = new Date(deallinestr).getTime();
				var currenTime = new Date().getTime();
			    
	 		      if(parseInt(deadTime-currenTime)<parseInt(0))
			    	  {
					   weui.alert("你来晚了,活动截止时间已过！快去发起自己的活动吧！");
					   return ;  
			    	  }   
			  
								weui.confirm("确定反对？决定后别忘了点击右上角和朋友分享你的态度！记住了喔","提示",function(r){
									if(r==true){
										if("${pwdflag}"=="Y")
										{	
											var inputValue = prompt("请输入密码","");
											if(inputValue==null)
											{
												return;
											}
											else
											{
												if(inputValue=="")
												{
													weui.alert("密码不能为空！");
												}
												else
												{
													//判断输入的密码是否正确
													$.ajax({
														type : "POST",
														url : "${base}/verifyActPwd",
														data: {userId:"${Activitiy.userId}",actId:"${Activitiy.activityId}",secretcode:inputValue,parUsrId:"${openId}"},
														datatyep : "json",
														success : function(data)
														{
															var jsonData = eval("("+data+")");
															if(jsonData['rev']=="Y")
															{
																internalNoButton();
															}
															else if(jsonData['rev']=="L")
															{
																weui.alert("城池数量不足");
															}
															else if(jsonData['rev']=="N")
															{
																weui.alert("密码不正确");
															}
															else if(jsonData['rev']=="F")
															{
																weui.alert("服务器错误");
															}
														}
													});
												}
											}
										}
										else
										{
											internalNoButton();
										}
									}	
											
								});
			}
			function internalNoButton()
			{
				if("${granted}"=="N")
				{
					window.location.href="${base}/weixin/oauth?action=clickNoButton&activityId=${Activitiy.activityId}";
				}
				else
				{	
					var numberOfParticipate  = ${participateNicknameYes.size() + participateNicknameNO.size() + 1 };
				 	var numberOfYes = ${participateNicknameYes.size()};
				 	var numberOfNo = ${participateNicknameNO.size()};
					document.getElementById("blueSide").setAttribute('onclick', '');
					$.ajax({
						url : "${base}/clickAgainst?activityId=${Activitiy.activityId}&openId=${openId}",
						type : 'POST',
						async : true,
						dataType : 'json',
						success : function(data) {
							
							if(data=="NOT!"){
								 weui.alert("你已经参与了该活动!");
							 	return;
							}else{
								
								var member = data;
			                     var headerURL=member[0];
			                     var name=member[1];
			                     var coment=member[2];
			                     var time=member[3].substr(0,19);
			                	 var obj = document.getElementById("dicuss");  	                	 
			                	 var _html='<div class="mod-project-support_item clearfix item J_tpl"><div class="mod-project-support_item__user"><img  width="100%" class="lazy-load" style="display: inline;" src='
			                       	 +headerURL+'></div><div class="mod-project-support_item__detail"><div style="width: 5rem;float: left;"><div name="${openId}" class="project-support_item__detail__user">'+
			                       	 name+'</div><div class="project-support_item__detail__time">'+
			                       	 time+'</div></div><div name="zanFlag" style="height: 0.7rem;" onclick="clickZan(this)"><i class="fa fa-thumbs-o-up"></i><span style="margin-left: 0.1rem;">0</span></div><div class="project-support_item__detail__content">'+
			        					coment+'</div></div></div>';
			                     obj.insertAdjacentHTML("afterEnd",_html);
								
								var img = $("#bluList").html();
			        			 img = '<img class="img-circle pull-right" style="width:30px;height:30px;" src='+headerURL+'>' + img;
			        			$("#bluList").html(img);
			        			//重写 wxready方法
			        			reWXready("${Activitiy.activityStake}",name+"反对：${Activitiy.activityDesc} ","${WechatUser.headImgUrl}");
						
// 								reWXready("系统活动：${Activitiy.activityDesc}","已经有：" + numberOfParticipate+"位朋友参与到了本活动中！ ",headerURL);
								//显示引导分享泡泡
								callHideBox("赶紧分享,邀请朋友支持你!");
							}

						}
					});
				}
			}
			
			function internalYesButton()
			{
				if("${granted}"=="N"){
					window.location.href="${base}/weixin/oauth?action=clickYesButton&activityId=${Activitiy.activityId}";
				
				} else{
					var numberOfParticipate  = ${participateNicknameYes.size() + participateNicknameNO.size() + 1 };
					var numberOfYes = ${participateNicknameYes.size()};
				 	var numberOfNo = ${participateNicknameNO.size()};
					document.getElementById("redSide").setAttribute('onclick', '');
					$.ajax({
						url : "${base}/clickSupport?activityId=${Activitiy.activityId}&openId=${openId}",
						type : 'post',
						async : true,
						datatype: "json",
						success : function(data) { 
							if(eval("("+data+")")=="NOT!"){
								 weui.alert("你已经参与了该活动!");
								 return;
							}else{
								var member = eval("("+data+")");
			                     var headerURL=member[0];
			                     var name=member[1];
			                     var coment=member[2];
			                     var time=member[3].substr(0,19);
			                	 var obj = document.getElementById("dicuss");  	                	 
			                	 var _html='<div class="mod-project-support_item clearfix item J_tpl"><div class="mod-project-support_item__user"><img  width="100%" class="lazy-load" style="display: inline;" src='
			                       	 +headerURL+'></div><div class="mod-project-support_item__detail"><div style="width: 5rem;float: left;"><div name="${openId}" class="project-support_item__detail__user">'+
			                       	 name+'</div><div class="project-support_item__detail__time">'+
			                       	 time+'</div></div><div name="zanFlag" style="height: 0.7rem;" onclick="clickZan(this)"><i class="fa fa-thumbs-o-up"></i><span style="margin-left: 0.1rem;">0</span></div><div class="project-support_item__detail__content">'+
			        					coment+'</div></div></div>';
			                     obj.insertAdjacentHTML("afterEnd",_html);
			                     
								var img = $("#redList").html();
								 img = '<img class="img-circle" style="width:30px;height:30px;" src='+headerURL+'>' + img ;
								$("#redList").html(img);
								//重写 wxready方法
								reWXready("${Activitiy.activityStake}",name+"支持：${Activitiy.activityDesc} ",headerURL);
								//显示引导分享泡泡
								callHideBox("赶紧分享,邀请朋友支持你!");
							}
						}
					
					});
				}
			}
			
			function changeAttention(evt){
				if("${openId}"=="")
				{
				weui.alert("微信服务器错误，请重新进入页面！");
				   return ;
				} 
				  if("${WechatUser.userId}"=="${openId}")
					{
					   return ;  
					}

				$.ajax({
					url : "${base}/careAbout?activityId=${Activitiy.activityId}&userId=${openId}&flag="+evt.id,
					type : 'get',
					async : true,
					datatype: "json",
					success : function(data) { 					
						if("gz"==evt.id)
						{
							if(eval("("+data+")")=="NOT")
							{
							 weui.alert("欢迎使用朕以为，请先注个册嘛！");
							 return;
							}
						}
						if(eval("("+data+")")=="no")
						{
							 return;
						}
						
						if("bb"==evt.id)
						{
							var bbPeople=document.getElementById("bbcount");
							
							if($(bbPeople).html()=="")
							{
								$(bbPeople).html(1);
							}
							else
							{
								
								$(bbPeople).html(parseInt($(bbPeople).html())+1);
							}
						}
						if("rb"==evt.id)
						{
							var rbPeople=document.getElementById("rbcount");
							if($(rbPeople).html()=="")
							{
								$(rbPeople).html(1);
							}
							else
							{
								
								$(rbPeople).html(parseInt($(rbPeople).html())+1);
							}
						}
						if("nn"==evt.id)
						{
							var nnPeople=document.getElementById("nncount");
							if($(nnPeople).html()=="")
							{
								$(nnPeople).html(1);
							}
							else
							{
								
								$(nnPeople).html(parseInt($(nnPeople).html())+1);
							}						
						}
						
						var member = eval("("+data+")");
	                    var headerURL=member[0];
	                    var name=member[1];
	                    var coment=member[2];
	                    var time=member[3].substr(0,19);
	               	 var obj = document.getElementById("dicuss");  	                	 
	               	var _html='<div class="mod-project-support_item clearfix item J_tpl"><div class="mod-project-support_item__user"><img  width="100%" class="lazy-load" style="display: inline;" src='
	                  	 +headerURL+'></div><div class="mod-project-support_item__detail"><div style="width: 5rem;float: left;"><div name="${openId}" class="project-support_item__detail__user">'+
	                  	 name+'</div><div class="project-support_item__detail__time">'+
	                  	 time+'</div></div><div name="zanFlag" style="height: 0.7rem;" onclick="clickZan(this)"><i class="fa fa-thumbs-o-up"></i><span style="margin-left: 0.1rem;">0</span></div><div class="project-support_item__detail__content">'+
	   					coment+'</div></div></div>';
	                    obj.insertAdjacentHTML("afterEnd",_html);
	                    
	                    weui.Loading.success();
					}
				});
				}
			
			function insert(obj) {
				clearTimeout(timeout);
	 			if("${openId}"=="")
				{
				 weui.alert("微信服务器错误，请重新进入页面！");
				   return ;
				} 	  
				 
				 var isReplyComment = localStorage.getItem('isReplyComments');
				 if('true' != isReplyComment){
					 var s = $("#exampleInputComment").val();
					 var url="${base}/insertAjaxcomments?activityId=${Activitiy.activityId}&openId=${openId}&comments="+s;
					 if(s=="")
					{
						 return;
					}
					 if("${granted}"=="N")
						{
							window.location.href='${base}/weixin/oauth?action=insertcommentwecat&activityId=${Activitiy.activityId}&paramstr=comment='+s;
						}
						else
						{
						   $.ajax({ 
				                url : url,
				                type:'post', 
				                datatype: "json",
				                success : function(data){
				                	document.getElementById("exampleInputComment").value="";
				                	 var member = eval("("+data+")");
				                     var headerURL=member[0];
				                     var name=member[1];
				                     var coment=member[2];
				                     var time=member[3].substr(0,19);
				                     var comentId = member[4];
				                	 var obj = document.getElementById("dicuss");  	                	 
				                	 var _html = '<div class="mod-project-support_item clearfix item J_tpl"><div class="mod-project-support_item__user"><img  width="100%" class="img-circle" style="display: inline;" src='
											+ headerURL
											+ '></div><div class="mod-project-support_item__detail"><div id='+comentId+'><div name="${openId}" class="project-support_item__detail__user">'
											+ name
											+ '</div><div class="project-support_item__detail__time">'
											+ time
											+ '</div></div><div class="project-support_item__detail__content"><p>'
											+ coment
											+ '</p><div class="pull-right"><div name="zanFlag" class="" onclick="clickZan(this)" style="float: left; margin-right: 0.3rem;"><i class="fa fa-thumbs-o-up"></i><span style="margin-left: 0.1rem;">0</span></div><a style="color:#337ab7" id='
											+ comentId
											+ 'Reply'
											+ ' onclick="replyComments(this)" name="${openId}">回复</a></div></div></div><div id='+comentId+'ReplyTag'+' class=""><ul></ul></div></div>';
									
				                     obj.insertAdjacentHTML("afterEnd",_html);
				                     weui.Loading.success();
				                	                 
				                },
				                error : function(){
				                	weui.alert("微信服务器错误，请重新进入页面！");
				                }
						   });
						}
				 }else{

					 
					 var s = $("#inputcommentforuser").val();
					 var replyCommentBtnId = localStorage.getItem('replyCommentBtnId');
				var insertTagId = replyCommentBtnId + 'Tag';
				var commentId = replyCommentBtnId.substr(0,
						replyCommentBtnId.length - 5);
				var touserId = localStorage.getItem('toUserId');
				var url = "${base}/insertAjaxReplycomments?activityId=${Activitiy.activityId}&commentId="
						+ commentId + "&openId=${openId}&touserId=" + touserId
						+ "&comments=" + s;
				if (s == "") {
					return;
				}
				$.ajax({
							url : url,
							type : 'post',
							datatype : "json",
							success : function(data) {
								document.getElementById("inputcommentforuser").value = "";
								var member = eval("(" + data + ")");
								var replyName = member[0];
								var replyUserId = member[1];
								var touserName = member[2];
								var touserUserId = member[3];
								var coment = member[4];
								if ('tag' == $('#' + insertTagId).attr('class')) {
									if (replyUserId != touserUserId
											&& touserUserId != '') {
										var _html = '<li onclick="replyComments(this)"><span><a style="color:#337ab7" name="'+replyUserId+'">'
												+ replyName
												+ '</a>回复<a  style="color:#337ab7">'
												+ touserName
												+ '</a>:</span><span>'
												+ coment
												+ '</span></li>';
									} else {
										var _html = '<li onclick="replyComments(this)"><span><a style="color:#337ab7" name="'+replyUserId+'">'
												+ replyName
												+ '</a>:</span><span>'
												+ coment
												+ '</span></li>';
									}

									$('#' + insertTagId + '>ul').append(_html);
								} else {
									var _html = '<li onclick="replyComments(this)"><span><a style="color:#337ab7" name="'+replyUserId+'">'
											+ replyName
											+ '</a>:</span><span>'
											+ coment + '</span></li>';
									$('#' + insertTagId).addClass('tag');
									$('#' + insertTagId + '>ul').append(_html);

								}
								weui.Loading.success();
								localStorage.removeItem('isReplyComments');
								localStorage.removeItem('replyCommentBtnId');
								localStorage.removeItem('toUserId');
								document.getElementById("commentForAct").style.display = "";
								document.getElementById("commentForUser").style.display = "none";
								document.getElementById("footMune").style.display = "";
								

							},
							error : function() {
								weui.alert("微信服务器错误，请重新进入页面！");
							}
						});
				 }
				 
			}
			
		</script>
		<div class="header" style="background-color:white;padding:0px 0px 0px 0px;">
		<a href="#" data-toggle="modal" data-target="#myModal" style="text-decoration: none;">
			<img src="images/1.jpg" id="pk" style="height:1.7rem;width:100%;">
			</a>
		</div>
		<div class="container" style="background-color:white;padding:5px 0px 0px 0px;">
			<div style="border-radius: 2px 2px 2px 2px;background-color:#f0f3f4;margin-left:10px;margin-right:10px;" class="row">
				<div class="m-l-xs m-b-xs m-t h5">				
					<i class="fa fa-bullhorn fa-lg"></i>
					<span class="h5">活动预测：</span> <span class="text-font ">
						<c:out value="${Activitiy.activityDesc}" />
					</span>
				</div>
				<div class="m-l-xs m-b-xs m-t h5">				
					<i class="fa fa-gift fa-lg"></i>
					<span class="h5">活动奖惩：</span> <span class="text-font ">
						<c:out value="${Activitiy.activityStake}" />
					</span>
				</div>			
				<div class="m-l-xs m-b-xs m-t h5">				
					<i class="fa fa-clock-o fa-lg"></i>
					<span class="h5">参与截止：</span> <span class="text-font ">
						<fmt:formatDate value="${Activitiy.activityDeadline}" pattern="yyyy-MM-dd HH:mm" /> 
					</span>
				</div>
				<div class="m-l-xs m-b m-t h5">				
					<i class="fa fa-bell-o fa-lg"></i>
					<span class="h5">结果公布：</span> <span id="resultOfAct" class="text-font ">
						<fmt:formatDate value="${Activitiy.publishDate}" pattern="yyyy-MM-dd HH:mm" /> 
					</span>
				</div>
				
				<c:if test="${Activitiy.tendency !=null && Activitiy.tendency !=''}">
					<div class="m-l-xs m-b-xs m-t h5">				
								<span class="h5">事件发生概率：</span>
								 <span class="text-font ">
									<c:out value="${Activitiy.tendency}" />
								</span>
								<span class="h5">(根据大数据获得)</span>
					</div>	
				</c:if>
			</div>
		</div>
		<div class="container" style="background-color:white;padding-bottom:5px;">
			<hr class="m-t-xs m-b-xs">
			<div>
				<div id="redSide" class="col-xs-4 m-t-xs" align="center" onclick="clickYesButton()">
					<button id="redBtn" class="button button-glow  button-circle button-giant">
					<span class="fa fa-thumbs-up fa-lg" style="color:#f5725a"></span>
					</button>
				</div>
				<div id="midLogo" class="col-xs-4" align="center"><img src="images/pk.gif" id="pk" style="height:65px;width:50px;">
				</div>
				<div id="blueSide" class="col-xs-4 m-t-xs" align="center" onclick="clickNoButton()">
					<button id="blueBtn" class="button button-glow button-circle button-giant">
					<span class="fa fa-thumbs-down fa-lg" style="color:#42b5d8"></span>
					</button>
				</div>
			</div>
			<div id="seatDiv" class="h6" align="center"> </div>
			<hr class="m-t-xs m-b-xs">
			<a href="${base}/sysActParticipateList?activityId=${Activitiy.activityId}">
<!-- 				<a href="#">	 -->
				<div  class="m-l m-r-xs" style="padding:0px 0px 10px 0px;">
					<span id="redList">
						<c:choose>
							<c:when test="${ParticipateYesList!=null && ParticipateYesList.size()>0}"> 
								<c:forEach var="thisParticipate" items="${ParticipateYesList}" begin="0" end="2" varStatus="preIndex">
									<img class="img-circle" style="margin-left:-8px;width:30px;height:30px;" src="${thisParticipate}">
								</c:forEach>
							</c:when>
						</c:choose>
						<c:choose>
							<c:when test="${ParticipateYesList!=null && ParticipateYesList.size()>3}"> 
								<i class="fa fa-ellipsis-h fa-lg" style="margin-left:0px;width:30px;height:30px;"></i>
							</c:when>
						</c:choose>
					</span>
					<span id="bluList">
						<c:choose>
							<c:when test="${ParticipateNoList!=null && ParticipateNoList.size()>0}">
								<c:forEach var="thisParticipate" items="${ParticipateNoList}" end="2" varStatus="preIndex">
									<img class="img-circle pull-right" style="margin-left:-8px;width:30px;height:30px;" src="${thisParticipate}">
								</c:forEach>
							</c:when>
						</c:choose>
						<c:choose>
							<c:when test="${ParticipateNoList!=null && ParticipateNoList.size()>3}">
								<i class="fa fa-ellipsis-h fa-lg pull-right" style="margin:8px 10px 0px 0px;"></i>
							</c:when>
						</c:choose>
					</span>
				</div>
			 </a> 
		</div>
		<div class="container m-t-xs" style="background-color:white;padding: 5px 0px 0px 0px;" id="forChalleger">
			<c:if test="${isDetailFlag=='Y'}">
				<div style="margin-top:5px;margin-bottom:5px;">
					<div class="col-xs-4">
						<hr />
					</div>
					<div class="col-xs-4"
						style="text-align: center; padding: 10px 0px 0px 0px;">
						<span class="h5 text-muted">结果明细</span>
					</div>
					<div class="col-xs-4">
						<hr />
					</div>
				</div>
				
				<div class="row">
						<c:forEach var="pInfo" items="${dellDetailInfo}">
							<div class="col-xs-4" style="overflow:hidden;">
							<img src="${pInfo['picture']}" class="img-circle" style="width: 30px; height: 30px;">
							<c:if test="${pInfo['winlose'] == 0}"><span style="color:green;"> 失去 ${pInfo['points']}</span></c:if>
							<c:if test="${pInfo['winlose'] == 1}"><span style="color:red; "> 获得 ${pInfo['points']}</span></c:if>
							</div>
						</c:forEach>	
	
				</div>
			</c:if>
			<hr class="m-t-xs m-b-xs">
		</div>

		<div style=" background-color:white;padding:5px 0px 5px 0px;" id="commentForAct">		
		  <div class="col-lg-6">
		    <div class="input-group">
		      <div class="input-group-btn">
		        <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		        <span class="caret"></span></button>
		        <ul class="dropdown-menu">
		          	<li id="bb" onclick="changeAttention(this)"style="text-align:center">好好玩</li>
				   	<li role="separator" class="divider"></li>
				    <li id="nn" onclick="changeAttention(this)" style="text-align:center">好无聊</li>
				    <li role="separator" class="divider"></li>
				    <li id="rb" onclick="changeAttention(this)" style="text-align:center">弱爆了</li>	
		        </ul>
		      </div><!-- /btn-group -->
		      <input type="text" class="form-control" id="exampleInputComment" placeholder="请输入评论" data-emojiable="true">
		      <span class="input-group-btn">
		        <button class="btn btn-default" type="button" id="pinglun" onclick='insert(this)' >发表</button>
		      </span>
		    </div><!-- /input-group -->
		  </div><!-- /.col-lg-6 -->
		</div>
		
		
		<div class="mod-project-card mod-project-supporter mod-project-support ajax-loading" style="margin-top:10px;">
			<div class="row m-t" style="margin:0px;" id="dicuss">
				<div class="col-xs-4" >
				<div class="div" style="border-radius:0em 5em 5em 0em;background-color:#42b5d8;height:20px;margin-left:-15px;"> 
				<span style="font-size: 80%;color:white;padding-left:15px;" >最新评论</span>
				</div>
				</div>
				
			</div>

			<c:forEach var="ai" items="${ComentsInfo}">


				<div class="mod-project-support_item clearfix item J_tpl">

					<div class="mod-project-support_item__user">
						<img class="img-circle" src="${ai['HeadURL']}" width="100%"
							style="display: inline;">
					</div>

					<div class="mod-project-support_item__detail">
						<div id="${ai['CommentId']}">
							<div name="${ai['UserId']}"
								class="project-support_item__detail__user">${ai['Name']}</div>
							<div class="project-support_item__detail__user">准确率：${ai['ForecastAccuracy']}</div>
							<div class="project-support_item__detail__user">城池数：${ai['AllPoints']}</div>
							<div class="project-support_item__detail__time">
								${ai['CreateTime'].substring(0, 19)}</div>
						</div>
						<div class="project-support_item__detail__content">
							<p>${ai['Comments']}</p>
							<div class="pull-right">
								<div name="zanFlag" class="${ai['ZanClass']}"
									onclick="clickZan(this)"
									style="float: left; margin-right: 0.3rem;">
									<i class="fa fa-thumbs-o-up"></i><span
										style="margin-left: 0.1rem;">${ai['Zan']}</span>
								</div>
								<a style="color: #337ab7" id="${ai['CommentId']}Reply"
									onclick="replyComments(this)">回复</a>
							</div>
						</div>

					</div>

					<div id="${ai['CommentId']}ReplyTag" class="${ai['ReplyTagCss']}">
						<ul>
							<c:forEach var="bi" items="${ai['ReplyCommentList']}">
								<c:choose>
									<c:when
										test="${bi['replyUserId']==bi['replyTouserId']||bi['replyTouserId']==''}">
										<li onclick="replyComments(this)"><span><a
												style="color: #337ab7" name="${bi['replyUserId']}">${bi['replyUserName']}</a>:</span><span>${bi['replyComments']}</span></li>
									</c:when>
									<c:when
										test="${bi['replyUserId']!=bi['replyTouserId']&&bi['replyTouserId']!=''}">
										<li onclick="replyComments(this)"><span><a
												style="color: #337ab7" name="${bi['replyUserId']}">${bi['replyUserName']}</a>回复<a
												style="color: #337ab7" name="${bi['replyTouserId']}">${bi['replyTouserName']}</a>:</span><span>${bi['replyComments']}</span></li>
									</c:when>
								</c:choose>

							</c:forEach>
						</ul>

					</div>

				</div>
			</c:forEach>
			<div style="height: 41px"></div>
		</div>

		<footer>
		<div style=" background-color:white;padding:5px 0px 5px 0px; display:none;" id="commentForUser">		
		  <div class="col-lg-6">
		    <div class="input-group">
		      <div class="input-group-btn">
		        <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		        <span class="caret"></span></button>
		        <ul class="dropdown-menu">
		          	<li id="bb" onclick="changeAttention(this)"style="text-align:center">好好玩</li>
				   	<li role="separator" class="divider"></li>
				    <li id="nn" onclick="changeAttention(this)" style="text-align:center">好无聊</li>
				    <li role="separator" class="divider"></li>
				    <li id="rb" onclick="changeAttention(this)" style="text-align:center">弱爆了</li>	
		        </ul>
		      </div><!-- /btn-group -->
		      <input type="text" class="form-control" id="inputcommentforuser"  onfocus='atfocus()' onblur='outfocus()' placeholder="请输入评论" data-emojiable="true" >
		      <span class="input-group-btn">
		        <button class="btn btn-default" type="button" id="pinglun" onclick='insert(this)'>发表</button>
		      </span>
		    </div><!-- /input-group -->
		  </div><!-- /.col-lg-6 -->
		</div>
		<div id="footMune">
			<div class="mune">
				<a href="${base}/weixin/baseoauth?action=challengIndex" style="text-decoration: none;">
		    	<i class="fa fa-share fa-2x"></i>
		        <p>发起</p>
		        </a>
		    </div>
			
			<div class="mune">
				<a href="${base}/weixin/oauth?action=onekeycopy&activityId=${Activitiy.activityId}" style="text-decoration: none;">
		    	<i class="fa fa-files-o fa-2x"></i>
		        <p>克隆</p>
		        </a>
		    </div>
			<div class="mune">
				<a  href="#" data-toggle="modal" data-target="#myModal" style="text-decoration: none;">
		    	<i class="fa fa-qrcode fa-2x"></i>
		        <p>关注</p>
		        </a>
		    </div> 
		    <div class="mune">
				<a href="${base}/weixin/baseoauth?action=myInfoIndex" style="text-decoration: none;">
		    	<i class="fa fa-user fa-2x" style="color: #5bc0de;"></i>
		        <p  >我</p>
		        </a>
		    </div>
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
	</body>
<script type="text/javascript">
function clickZan(obj) {
	//调用action
	var commentId = $(obj).prev().attr('id');
	var commentUserId=$(obj).prev().children().eq('0').attr('name');
	var userId = "${openId}";
	var newZan=null;
	if(commentUserId==userId){
		weui.alert('不能点赞自己哦！');
	}
	else{
		if('text-danger'!=$(obj).attr('class')){
			newZan=true;
			$.ajax({
				type : 'POST',
				url : "${base}/clickZan",
				data : {
					userId : userId,
					commentId : commentId,
					newZan:newZan
				},
				success : function(msg) {
					//获取返回值，放到页面上。
					var zanCount = Number($(obj).children().eq('1').text())
							+ 1;
					$(obj).children().eq('1').text(zanCount);
					$(obj).addClass('text-danger');
				}

			});
		}
		else{
			newZan=false;
			$.ajax({
				type : 'POST',
				url : "${base}/clickZan",
				data : {
					userId : userId,
					commentId : commentId,
					newZan:newZan
				},
				success : function(msg) {
					//获取返回值，放到页面上。
					var zanCount = Number($(obj).children().eq('1').text())
					- 1;
			$(obj).children().eq('1').text(zanCount);
			$(obj).removeClass('text-danger');
				}

			});
		}
	}
	
	
	
}	

function replyComments(obj) {
	document.getElementById("commentForAct").style.display = "none";
	document.getElementById("commentForUser").style.display = "";
	document.getElementById("footMune").style.display = "none";
	
	$('#inputcommentforuser').focus();

	if ($(obj).find('a').size() != 0) {
		var toUserName = $(obj).find('a').eq(0).text();
		var toUserId = $(obj).find('a').eq(0).attr('name');
		localStorage.setItem('isReplyComments', 'true');
		var replyCommentTagId = $(obj).parent().parent().attr('id');
		localStorage.setItem('replyCommentBtnId', replyCommentTagId.substr(
				0, replyCommentTagId.length - 3));
		localStorage.setItem('toUserId', toUserId);
		$('#inputcommentforuser').attr('placeholder',
				'回复' + toUserName + '：');
	} else {
		var toUserId = $(obj).attr('name');
		localStorage.setItem('isReplyComments', 'true');
		localStorage.setItem('toUserId', '');
		localStorage.setItem('replyCommentBtnId', obj.id);
		$('#inputcommentforuser').attr('placeholder',
				'回复' + '楼主' + '：');
	}

}
function atfocus(){
	 
	
	if (document.body&& document.body.scrollHeight)
	{
		document.body.scrollTop=document.body.scrollHeight; 
	}
	if (document.documentElement && document.documentElement.scrollHeight)
	{
		document.documentElement.scrollTop=document.documentElement.scrollHeight;
	}
}
function outfocus(){
	timeout = setTimeout(
			function() {
				document.body.scrollTop = 0;
				var commentType = $('#inputcommentforuser').attr(
						'placeholder');
				if ('请输入评论' != commentType) {
					document.getElementById("commentForAct").style.display = "";
					document.getElementById("commentForUser").style.display = "none";
					document.getElementById("footMune").style.display = "";
					localStorage.removeItem('isReplyComments');
					localStorage.removeItem('replyCommentBtnId');
					localStorage.removeItem('toUserId');
					$('#inputcommentforuser').attr('placeholder',
							'请输入评论');
				}
			}, 200);


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
</script>
</html>