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
<link
	href="http://cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet" type="text/css" href="css/task.css?random=2.4">
<link rel="stylesheet" type="text/css"
	href="http://cdn.bootcss.com/font-awesome/4.2.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css"
	href="http://www.bootcss.com/p/buttons/css/buttons.css ">
<script type="text/javascript"
	src="http://sandbox.runjs.cn/uploads/rs/340/ustg8wvx/weui.js"></script>
<link rel="stylesheet" type="text/css"
	href="http://sandbox.runjs.cn/uploads/rs/340/ustg8wvx/weui.css">
<link href="bootstrap3.3.5/css/app.css" rel="stylesheet">
<script src="http://libs.baidu.com/jquery/1.9.1/jquery.min.js"></script>
<script src="http://cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<script type="text/javascript"	src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<!-- <script type="text/javascript" src="js/jsFroOnline.js"></script> -->
<title>朕以为</title>

</head>
<body class="item">
	<script type="text/javascript">
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
	
	var timeout;
	$(function(){
		$("#dropdownMenu").click(function(e) {}); 
		if("${openId}"=="")
		{
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
	// 必填，需要使用的JS接口列表，所有JS接口列表见附录2
	});

 
	
	
	
	
	
	 
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
			 var a ="${Participate.size()}";
			 var b="${Activitiy.particiLimititation-1}";	

			   if("${WechatUser.userId}"=="${openId}")
				{
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
		    //人数限制
 		     if(parseInt(a)>parseInt(b)){
 				 return;
 				 }  
		   //获取适时的参与者数量
			  $.ajax({
				  url : "${base}/getNumberOfPartner?activityId=${Activitiy.activityId}",
				  type : 'GET',
				  success : function(data){
					  var limit =  "${Activitiy.particiLimititation}";
					  if( (limit - data - 1) <= 0 ){
						  weui.alert("你来晚了,参与人数已满！快去发起自己的活动吧！");
						  return;
					  }else{
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
				  }
			  });
		}
		function clickYesButton() {
			
			var a ="${Participate.size()}";
			 var b="${Activitiy.particiLimititation-1}";
			 var resultStatus = "${Activitiy.resultStatus}";
			 if(resultStatus!=0){
				 return;
			 }				 
			if("${openId}"==""){
				weui.alert("微信服务器错误，请重新进入页面！");
			  	return ;
			}
			if("${WechatUser.userId}"=="${openId}"){
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
		    
		    if(parseInt(a)>parseInt(b)){
				// weui.alert("质疑人数已满！");
				 return;
				 }
		    //获取适时的参与者数量
				  $.ajax({
					  url : "${base}/getNumberOfPartner?activityId=${Activitiy.activityId}",
					  type : 'GET',
						async : true,
					  success : function(data){
						  var limit =  "${Activitiy.particiLimititation}";
						  if( (limit - data - 1) <= 0 ){
							  weui.alert("你来晚了,参与人数已满！快去发起自己的活动吧！");
							  return;
						  }else{
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
					  }
				  });
		}
		
		
		
		function insert(obj) {
			clearTimeout(timeout);
			if ("${openId}" == "") {
				weui.alert("微信服务器错误，请重新进入页面！");
				return;
			}
			var s = $("#exampleInputArea").val();
			var isReplyComment = localStorage.getItem('isReplyComments');
			if ('true' != isReplyComment) {
				var url = "${base}/insertAjaxcomments?activityId=${Activitiy.activityId}&openId=${openId}&comments="
						+ s;
				if (s == "") {
					return;
				}
				if ("${granted}" == "N") {
					window.location.href = '${base}/weixin/oauth?action=insertcommentwecat&activityId=${Activitiy.activityId}&paramstr=comment='
							+ s;
				} else {
					$.ajax({
								url : url,
								type : 'post',
								datatype : "json",
								success : function(data) {
									document.getElementById("exampleInputArea").value = "";
									var member = eval("(" + data + ")");
									var headerURL = member[0];
									var name = member[1];
									var coment = member[2];
									var time = member[3].substr(0, 19);

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
									obj.insertAdjacentHTML("afterEnd", _html);
									weui.Loading.success();
									$("#commentsArea").removeClass('acitve');
									$("#footer").css('display','');

								},
								error : function() {
									weui.alert("微信服务器错误，请重新进入页面！");
								}
							});
				}
			} else {
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
								document.getElementById("exampleInputArea").value = "";
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
								$("#commentsArea").removeClass('acitve');
								$("#footer").css('display','');

							},
							error : function() {
								weui.alert("微信服务器错误，请重新进入页面！");
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
							+ ' onclick="replyComments(this)">回复</a></div></div></div><div id='+comentId+'ReplyTag'+' class=""><ul></ul></div></div>';
					obj.insertAdjacentHTML("afterEnd", _html);
                    
                    weui.Loading.success();
                    weui.alert("赶紧点击右上角分享,邀请朋友来一起吐槽!");
				}
			});
			}
		
		function popup(){
			
			$("#footer").css('display','none');
			$("#commentsArea").addClass('acitve');
		$('#exampleInputArea').attr('placeholder', '发表评论');
		var t = setTimeout("document.getElementById('exampleInputArea').focus();",100);
			
			}
		
		
		
		
		function codefans(){
			var box=document.getElementById("hideBox");
			box.style.display="none";
		}
		//setTimeout("codefans()",3000);//3秒
		
		function callHideBox(yesOrNo){
			var box=document.getElementById("hideBox");
			box.innerHTML="<span class='arrow_span'>"+ yesOrNo +"</span>";
			box.style.display="block";
			
		}

		
		function displayPao(){
			var box=document.getElementById("resultHideBox");
			box.style.display="block";
		}
		
		function hideThis(){
			var box=document.getElementById("resultHideBox");
			box.style.display="none";
		}
		
		
		
	
	
	function internalNoButton()
	{
		if("${granted}"=="N")
		{
			window.location.href="${base}/weixin/oauth?action=clickNoButton&activityId=${Activitiy.activityId}";
		}
		else
		{			
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
									+ ' onclick="replyComments(this)">回复</a></div></div></div><div id='+comentId+'ReplyTag'+' class=""><ul></ul></div></div>';
							obj.insertAdjacentHTML("afterEnd", _html);
						
						var img = $("#bluList").html();
	        			 img = img +'<img class="img-circle pull-right" style="width:30px;height:30px;" src='+headerURL+'>';
	        			$("#bluList").html(img);
	        			//重写 wxready方法
						 var activityType = "${Activitiy.activityStake}";
						 var numberOfParticipate  = ${participateNicknameYes.size() + participateNicknameNO.size()};
						 	var numberOfYes = ${participateNicknameYes.size()};
						 	var numberOfNo = ${participateNicknameNO.size()} + 1;
	   					if(activityType.indexOf("朕要为此赌上")>-1 || activityType.indexOf("座城池")>-1){
	   						reWXready("奖惩：${Activitiy.activityStake}","${WechatUser.nickName} 预测：${Activitiy.activityDesc}",headerURL);
// 	   						reWXready("正方："+numberOfYes+"人 VS 反方："+numberOfNo+"人!","${WechatUser.nickName} 预测：${Activitiy.activityDesc}",headerURL);
	   					}else{
	   						reWXready("${WechatUser.nickName} 预测：${Activitiy.activityDesc}","挑战了：" + name+" VS ${WechatUser.nickName}",headerURL);
	   					}
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
		
		}
		else{
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
									+ ' onclick="replyComments(this)">回复</a></div></div></div><div id='+comentId+'ReplyTag'+' class=""><ul></ul></div></div>';
							obj.insertAdjacentHTML("afterEnd", _html);
	                     
						var img = $("#redList").html();
						 img = img + '<img class="img-circle" style="width:30px;height:30px;" src='+headerURL+'>';
						$("#redList").html(img);
						//重写 wxready方法
						 var activityType = "${Activitiy.activityStake}";
						 var numberOfParticipate  = ${participateNicknameYes.size() + participateNicknameNO.size()};
						 	var numberOfYes = ${participateNicknameYes.size()} + 1;
						 	var numberOfNo = ${participateNicknameNO.size()};
	   					if(activityType.indexOf("朕要为此赌上")>-1 || activityType.indexOf("座城池")>-1){
	   						reWXready("奖惩：${Activitiy.activityStake}","${WechatUser.nickName} 发起预测：${Activitiy.activityDesc}",headerURL);
// 	   						reWXready("正方："+numberOfYes+"人 VS 反方："+numberOfNo+"人!","${WechatUser.nickName} 发起预测：${Activitiy.activityDesc}",headerURL);
	   					}else{
	   						reWXready("${WechatUser.nickName} 发起预测：${Activitiy.activityDesc}","挑战了：" + name+" ${WechatUser.nickName} VS ...",headerURL);
	   					}
						//显示引导分享泡泡
						callHideBox("赶紧分享,邀请朋友支持你!");
					}
				}
			
			});
		}
	}
	</script>
		<script type="text/javascript">
		$(document).ready(function() {
			  //是否显示剩余席位,描述包含如下内容就不显示剩余席位
		    var activityType = "${Activitiy.activityStake}";
		   if(activityType.indexOf("朕要为此赌上")>-1 || activityType.indexOf("座城池")>-1){
			   document.getElementById("seatDiv").innerHTML=" ";		
			 //结果发布按钮是否出现
				var ownerId = "${WechatUser.userId}";
				var nowUserId = "${openId}";
				var resultStatus = "${Activitiy.resultStatus}";
				var yesPart = "${WechatUser.nickName} ";
				var noPart = "";
				var numberOfParticipate  = ${participateNicknameYes.size() + participateNicknameNO.size()};
			 	var numberOfYes = ${participateNicknameYes.size()};
			 	var numberOfNo = ${participateNicknameNO.size()};
				if(ownerId==nowUserId && resultStatus == 0){
					//owner进来且未发布结果
					document.getElementById("forOwer").style.display = "block";
					document.getElementById("forChalleger").style.display = "none";
					$("#blueBtn").removeClass("button-glow");
					$("#redBtn").removeClass("button-glow");
					//添加结果发布字体闪烁
						reWXready("奖惩：${Activitiy.activityStake}","${WechatUser.nickName} 预测：${Activitiy.activityDesc}","${WechatUser.headImgUrl}");
				}else if(ownerId!=nowUserId && resultStatus == 0){
					//其他人进来，未发布结果
					document.getElementById("forOwer").style.display = "none";
					document.getElementById("forChalleger").style.display = "block";
					reWXready("奖惩：${Activitiy.activityStake}","${WechatUser.nickName} 预测：${Activitiy.activityDesc}","${WechatUser.headImgUrl}");
				}else if( resultStatus!= 0){
					$("#win").removeClass("button-glow");
					$("#lose").removeClass("button-glow");
					if(ownerId==nowUserId){
						document.getElementById("forOwer").style.display = "block";
						document.getElementById("forChalleger").style.display = "none";
					}else{
						document.getElementById("forOwer").style.display = "none";
						document.getElementById("forChalleger").style.display = "block";
					}
					
					//显示结果
					
					if(resultStatus==2){
						//document.getElementById("resultOfAct").innerHTML="朕胜了";
						reWXready("奖惩：${Activitiy.activityStake}","${WechatUser.nickName} 发起预测：${Activitiy.activityDesc}",headerURL);
// 						reWXready("胜方："+numberOfYes+"人 VS 败方:"+numberOfNo+ " 人！", "${WechatUser.nickName}预测：${Activitiy.activityDesc}","${WechatUser.headImgUrl}");
						document.getElementById("redBtn").innerHTML='<span style="color:#f5725a"><b>胜</b></span>';
						document.getElementById("blueBtn").innerHTML='<span style="color:#42b5d8"><b>败</b></span>';
					}else{
						//document.getElementById("resultOfAct").innerHTML="朕认栽";
						reWXready("奖惩：${Activitiy.activityStake}","${WechatUser.nickName} 发起预测：${Activitiy.activityDesc}",headerURL);
// 						reWXready("败方："+numberOfYes+"人 VS 胜方:"+numberOfNo+ " ！", "${WechatUser.nickName}预测：${Activitiy.activityDesc}", "${WechatUser.headImgUrl}");
						document.getElementById("redBtn").innerHTML='<span style="color:#f5725a"><b>败</b></span>';
						document.getElementById("blueBtn").innerHTML='<span style="color:#42b5d8"><b>胜</b></span>';
					}
					document.getElementById("seatDiv").innerHTML="活动结束";				
					$("#blueBtn").removeClass("button-glow");
					$("#redBtn").removeClass("button-glow");
					
				}
		   }else{
			 //结果发布按钮是否出现
				var ownerId = "${WechatUser.userId}";
				var nowUserId = "${openId}";
				var resultStatus = "${Activitiy.resultStatus}";
				var yesPart = "${WechatUser.nickName} ";
				var noPart = "";
				<c:forEach var="obj" items="${participateNicknameYes}" begin="0" end="0"> 
					yesPart =yesPart+ "${obj} ";
			 	</c:forEach>
			 	if("${participateNicknameYes.size()}" >= 2){
			 		yesPart = yesPart + "...";
			 	}
				<c:forEach var="obj" items="${participateNicknameNO}"> 
					noPart =noPart+ "${obj} ";
			 	</c:forEach>
			 	var fromChall = "${fromChall}";
			 	if(noPart.length==0){
			 		noPart = "虚位以待... ";
			 		}
				if(ownerId==nowUserId && resultStatus == 0){
					//owner进来且未发布结果
					document.getElementById("forOwer").style.display = "block";
					document.getElementById("forChalleger").style.display = "none";
					$("#blueBtn").removeClass("button-glow");
					$("#redBtn").removeClass("button-glow");
					//添加结果发布字体闪烁
					if(fromChall == "y"){
						reWXready("奖惩：${Activitiy.activityStake}","${WechatUser.nickName} 发起预测：${Activitiy.activityDesc}","${WechatUser.headImgUrl}");
					}else{
						reWXready("${WechatUser.nickName} 发起预测：${Activitiy.activityDesc}","挑战了：" + yesPart+" VS "+noPart,"${WechatUser.headImgUrl}");	
					}
				}else if(ownerId!=nowUserId && resultStatus == 0){
					//其他人进来，未发布结果
					document.getElementById("forOwer").style.display = "none";
					document.getElementById("forChalleger").style.display = "block";
					reWXready("${WechatUser.nickName} 预测：${Activitiy.activityDesc}","挑战了：" + yesPart+" VS "+noPart,"${WechatUser.headImgUrl}");
				}else if( resultStatus!= 0){
					$("#win").removeClass("button-glow");
					$("#lose").removeClass("button-glow");
					if(ownerId==nowUserId){
						document.getElementById("forOwer").style.display = "block";
						document.getElementById("forChalleger").style.display = "none";
					}else{
						document.getElementById("forOwer").style.display = "none";
						document.getElementById("forChalleger").style.display = "block";
					}
					
					//显示结果
					
					if(resultStatus==2){
						//document.getElementById("resultOfAct").innerHTML="朕胜了";
						
						reWXready("胜者:${WechatUser.nickName} ... VS 败者:"+noPart + " ${Activitiy.activityStake}", "${WechatUser.nickName}预测成功，朕胜了","${WechatUser.headImgUrl}");
						document.getElementById("redBtn").innerHTML='<span style="color:#f5725a"><b>胜</b></span>';
						document.getElementById("blueBtn").innerHTML='<span style="color:#42b5d8"><b>败</b></span>';
					}else{
						//document.getElementById("resultOfAct").innerHTML="朕认栽";
						
						reWXready("败者:${WechatUser.nickName} ... VS 胜者:"+noPart + " ${Activitiy.activityStake}", "${WechatUser.nickName}预测失败，朕认栽", "${WechatUser.headImgUrl}");
						document.getElementById("redBtn").innerHTML='<span style="color:#f5725a"><b>败</b></span>';
						document.getElementById("blueBtn").innerHTML='<span style="color:#42b5d8"><b>胜</b></span>';
					}
					document.getElementById("seatDiv").innerHTML="活动结束";				
					$("#blueBtn").removeClass("button-glow");
					$("#redBtn").removeClass("button-glow");
					
				}
		   }
			
			
			
			//结果发布按钮 的 提示气泡是否出现
			var today = new Date();   
		   var year = today.getFullYear(); 
		   var month = ((today.getMonth()+1)>9)?(today.getMonth()+1):("0"+(today.getMonth()+1));   
		   var daystart = (today.getDate()>9)?(today.getDate()):("0"+today.getDate()) ;  
		   var hour = (today.getHours()>9)?(today.getHours()):("0"+today.getHours()); 
		   var minute = (today.getMinutes()>9)?(today.getMinutes()):("0"+today.getMinutes()) ;
		   var now = year + "-" + month + "-" + daystart + " " + hour +":"+ minute;
		   var limitFlag =  "${Activitiy.activityDeadline}";	
		
		   callHideBox("赶紧分享,邀请朋友支持你!")		
		   
		 
		});
		</script>
		
		<!-- 气泡相关 -->
		
		
		<div class="arrow_box button-glow" id="hideBox" style="display:block; top:15px;color:white" onclick="codefans()"><span class='arrow_span'>活动发起成功,邀请朋友参与!</span></div>
		 
		<!-- 气泡相关 -->
		<!-- 活动结果气泡相关 -->
		
		<div class="arrow_box button-glow" id="resultHideBox" style="display:none; top:15px;color:white" onclick="hideThis()">
		<span class="arrow_span">结果发布成功,分享告诉朋友!</span></div>
		<!-- 活动结果气泡相关 --> 
		<!-- 结果发布按钮 -->
		<script type="text/javascript">
		function selectChanged(actId,val){
			
			var resultStatus = "${Activitiy.resultStatus}";
			 if(resultStatus!=0){
				 return;
			 }	
			 var resultChoice="通知朋友们你败了？决定后要记得分享，让朋友们知道朕认栽了!";
			 if(val == 2){
				 var resultChoice = "通知朋友们你胜了？决定后要记得分享，让朋友们知道朕赢了!";
			 }
			weui.confirm(resultChoice,"提示",function(r)
			{
				if(r==true)
				{	
					var vl = val;
					$("#win").removeAttr("onclick");
					$("#lose").removeAttr("onclick");
					$("#redSide").removeAttr("onclick");
					$("#blueSide").removeAttr("onclick");
					 var activityType = "${Activitiy.activityStake}";
					 var numberOfParticipate  = ${participateNicknameYes.size() + participateNicknameNO.size()};
					 	var numberOfYes = ${participateNicknameYes.size()} + 1;
					 	var numberOfNo = ${participateNicknameNO.size()};
   				
					$.ajax({
						url : "${base}/saveUserSelected?actId="+actId+"&status="+vl,
						type : 'get',
						success : function(data){
							var yesPart = "";
							var noPart = "";
							<c:forEach var="obj" items="${participateNicknameNO}"> 
							noPart =noPart+ "${obj} ";
						 	</c:forEach>
								if(vl == 2){
									//document.getElementById("resultOfAct").innerHTML="朕胜了";
									//重写 wxready方法
									if(activityType.indexOf("朕要为此赌上")>-1 || activityType.indexOf("座城池")>-1){
				   						reWXready("正方："+numberOfYes+"人 VS 反方："+numberOfNo+"人!${Activitiy.activityStake}","${WechatUser.nickName}预测${Activitiy.activityDesc}","${WechatUser.headImgUrl}");
				   					}else{
				   						reWXready("胜者:${WechatUser.nickName} ... VS 败者:"+noPart + " ${Activitiy.activityStake}","${WechatUser.nickName}预测成功，朕胜了","${WechatUser.headImgUrl}");
				   					}
									//显示引导分享泡泡
									callHideBox("皇上目光如炬,分享告诉朋友!");
									document.getElementById("redBtn").innerHTML='<span style="color:#f5725a"><b>胜</b></span>';
									document.getElementById("blueBtn").innerHTML='<span style="color:#42b5d8"><b>败</b></span>';
								}else{
									//document.getElementById("resultOfAct").innerHTML="朕认栽";
									if(activityType.indexOf("朕要为此赌上")>-1 || activityType.indexOf("座城池")>-1){
				   						reWXready("正方："+numberOfYes+"人 VS 反方："+numberOfNo+"人!${Activitiy.activityStake}","${WechatUser.nickName}预测${Activitiy.activityDesc}","${WechatUser.headImgUrl}");
				   					}else{
				   						reWXready("败者:${WechatUser.nickName} ... VS 胜者:"+noPart + " ${Activitiy.activityStake}","${WechatUser.nickName}预测失败，朕认栽", "${WechatUser.headImgUrl}");
				   					}
									
									//显示引导分享泡泡
									callHideBox("皇上老眼昏花,分享告诉朋友!");
									document.getElementById("redBtn").innerHTML='<span style="color:#f5725a"><b>败</b></span>';
									document.getElementById("blueBtn").innerHTML='<span style="color:#42b5d8"><b>胜</b></span>';
									
								}
								document.getElementById("seatDiv").innerHTML="活动结束";
								$("#blueBtn").removeClass("button-glow");
								$("#redBtn").removeClass("button-glow");
								$("#win").removeClass("button-glow");
								$("#lose").removeClass("button-glow");
								
								//交易明细
								var jsonData = eval("("+data+")");
								if(jsonData.length>0)
								{
									var resltHtml = "";
									for(var oi=0; oi<jsonData.length; oi++)
									{
										
										var tempHtml = "<div class='col-xs-4' style='overflow:hidden;'>";
										
										tempHtml+="<img src='"+jsonData[oi].picture+"' class='img-circle' style='width: 30px; height: 30px;'>";
										
										if(jsonData[oi].winlose=="-1")
										{
											tempHtml+="<span style='color:green;'> 失去 "+jsonData[oi].points+"</span>";
										}
										else
										{
											tempHtml+="<span style='color:red;'> 获得 "+jsonData[oi].points+"</span>";
										}
										
										tempHtml+="</div>";
										resltHtml+=tempHtml;
									}
									//生成交易
									
									document.getElementById("resultConfirmDiv").style.display = "none";
									document.getElementById("dellDetailDiv").style.display = "block";
									document.getElementById("dellResultSpan").innerHTML="结果明细";
									
									document.getElementById("dellDetailDiv").innerHTML=resltHtml;
								}
							}	
						});
				}
			});
		}
		</script>
		
		
		<div class="header" style="background-color:white;padding:5px 0px 5px 0px;">
		<div class="row m-t m-r" style="margin-left:10px;">
			<div class="m-t col-xs-12 m-b m-t-sm">
						<span class="h6"><c:out
								value="${WechatUser.nickName}" /> </span> 
						<span id="level-display"  class="h6">
							
						</span>
						<span class="h6"> <fmt:formatDate
								value="${Activitiy.createTime}" pattern="yyyy-MM-dd HH:mm" />
						</span>
			</div>
		</div>
		</div>
	<!-- 结果发布按钮 -->
	
	
	<div class="container m-t" style="padding:0;" id="divId">
	<div class="container" style="background-color:white;padding:10px 10px 0px 10px;">
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
							<fmt:formatDate value="${Activitiy.activityDeadline}"
								pattern="yyyy-MM-dd HH:mm" /> 
						</span>
		</div>

	
		<div class="m-l-xs m-b m-t h5">				
					<i class="fa fa-bell-o fa-lg"></i>
						<span class="h5">结果公布：</span> <span id="resultOfAct" class="text-font ">
							<fmt:formatDate value="${Activitiy.publishDate}"
								pattern="yyyy-MM-dd HH:mm" /> 
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
		<div id="seatDiv" class="h6" align="center">还有${Activitiy.particiLimititation-numberOfPartner-1}席位</div>
		<hr class="m-t-xs m-b-xs">
		<a href="${base}/sysActParticipateList?activityId=${Activitiy.activityId}">
			<div  class="row  m-l m-r-xs">
				<span id="redList">
					<img class="img-circle" style="margin-left:-8px;width:30px;height:30px;" src="${WechatUser.headImgUrl}">
					<c:choose>
						<c:when test="${ParticipateYesList!=null && ParticipateYesList.size()>0}"> 
							<c:forEach var="thisParticipate" items="${ParticipateYesList}" varStatus="preIndex">
								<img class="img-circle" style="margin-left:-8px;width:30px;height:30px;" src="${thisParticipate}">
							</c:forEach>
						</c:when>
						<%-- <c:otherwise>
							<span class="h6 text-muted"></span>
						</c:otherwise> --%>
					</c:choose>
				</span>
				<span id="bluList">
					<c:choose>
						<c:when test="${ParticipateNoList!=null && ParticipateNoList.size()>0}"> 
							<c:forEach var="thisParticipate" items="${ParticipateNoList}" varStatus="preIndex">
								<img class="img-circle pull-right" style="margin-left:-8px;width:30px;height:30px;" src="${thisParticipate}">
							</c:forEach>
						</c:when>
						<%-- <c:otherwise>
							<span class="h6 text-muted"></span>
						</c:otherwise> --%>
					</c:choose>
				</span>
			</div>
		</a>
		
		</div>
<!-- id="showOrNone" -->
<!-- //擂主所见 -->
<div class="container m-t" style="background-color:white;padding: 5px 0px 10px 0px;" id="forOwer">
		<div>
			<div class="col-xs-4">
				<hr />
			</div>
			<div class="col-xs-4"
				style="text-align: center; padding: 10px 0px 0px 0px;">
				<c:choose>
					<c:when test="${isDetailFlag=='N'}">
					<span class="h5 text-muted" id="dellResultSpan">发布结果</span>
					</c:when>
				    <c:when test="${isDetailFlag=='Y'}">
				    <span class="h5 text-muted" id="dellResultSpan">结果明细</span>
				    </c:when>
			    </c:choose>
			</div>
			<div class="col-xs-4">
				<hr />
			</div>
		</div>
		<c:choose>
		  <c:when test="${isDetailFlag=='N'}">
				<div id="resultConfirmDiv" style="display:block;">
					<div class="col-xs-6" style="text-align: center;">
						<button id="win" class="button button-glow button-pill" onclick="selectChanged('${Activitiy.activityId}',2)">朕赢了</button>
					</div>
					<div class="col-xs-6" style="text-align: center;">
						<button id="lose" class="button button-glow button-pill" onclick="selectChanged('${Activitiy.activityId}',1)">朕认栽</button>
					</div>
				</div>
		
				<div id="dellDetailDiv" style="display:none;text-align:center;">		
				</div>						
		 </c:when>
		 <c:when test="${isDetailFlag=='Y'}">
				<%-- <div style="text-align:center;">
					<c:forEach var="pInfo" items="${dellDetailInfo}">
					<p style="text-size:0.9rem;">
						<img src="${pInfo['picture']}" class="img-circle" style="width: 25px; height: 25px;">
						<c:choose>
		 					 <c:when test="${pInfo['winlose'] == 0}">
		 					 	<span style="color:red;"> 失去了 </span>${pInfo['points']} 城池
		 					 </c:when>
		 					 <c:when test="${pInfo['winlose'] == 1}">
		 					 	<span style="color:red;"> 获得了 </span>${pInfo['points']} 城池
		 					 </c:when>
		 				</c:choose>
					</p>
					</c:forEach>	
				</div> --%>	
				<c:forEach var="pInfo" items="${dellDetailInfo}">
					<div class="col-xs-4" style="overflow:hidden;">
					<img src="${pInfo['picture']}" class="img-circle" style="width: 30px; height: 30px;">
					<c:if test="${pInfo['winlose'] == 0}"><span style="color:green;"> 失去 ${pInfo['points']}</span></c:if>
					<c:if test="${pInfo['winlose'] == 1}"><span style="color:red; "> 获得 ${pInfo['points']}</span></c:if>
					</div>
				</c:forEach>					 
		 </c:when>			
		 </c:choose>
	</div>

<!-- //非擂主所见 -->
		<div class="container m-t" style="background-color:white;padding: 5px 0px 10px 0px;" id="forChalleger">
		<c:if test="${isDetailFlag=='Y'}">
			<div style="margin-top:5px;margin-button:5px;">
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
		<div>
			<div class="col-xs-4">
				<hr />
			</div>
			<div class="col-xs-4"
				style="text-align: center; padding: 10px 0px 0px 0px;">
				<span class="h5 text-muted">吐槽一下</span>
			</div>
			<div class="col-xs-4">
				<hr />
			</div>
		</div>

		<div>
			<div class="col-xs-4" style="text-align: center;">
				<span id="bb" class="h6" onclick="changeAttention(this)">好好玩</span>
					<span style="font-size: 80%;vertical-align:bottom;" id="bbcount" >0</span>
				
			</div>
			<div class="col-xs-4" style="text-align: center;">
				<span id="nn" class="h6" onclick="changeAttention(this)">好无聊</span>
					<span style="font-size: 80%;vertical-align:bottom;" id="nncount">0</span>
			</div>
			<div class="col-xs-4" style="text-align: center;">
				<span id="rb" class="h6" onclick="changeAttention(this)">弱爆了</span>
					<span style="font-size: 80%;vertical-align:bottom;" id="rbcount">0</span>
				
			</div>
			
		</div>
	</div>
	
		<div
			class="mod-project-card mod-project-supporter mod-project-support ajax-loading" style="margin-top:10px;">
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
							<div name="${ai['UserId']}" class="project-support_item__detail__user">${ai['Name']}</div>
							<div class="project-support_item__detail__user">准确率：${ai['ForecastAccuracy']}</div>
							<div class="project-support_item__detail__user">城池数：${ai['AllPoints']}</div>
							<div class="project-support_item__detail__time"> ${ai['CreateTime'].substring(0, 19)}</div>
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
								<a style="color: #337ab7" id="${ai['CommentId']}Reply" name="${ai['UserId']}" 
									onclick="replyFirstComments(this)">回复</a>
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

	</div>
	<nav class="navbar navbar-default navbar-fixed-bottom" style="padding: 0px"
		role="navigation">
		<div class="container">

			<div class="row" style="display: block;" id="footer">

				<div class="col-xs-6 " style="margin-top: 11px;" onclick='popup()'>
					<button type="button"  class="button button-pill" >：发表评论</button>
<!-- 					<img style="width: 30px; height: 30px;" src="images/discuss.jpg"> -->
				</div>

	 			<div class="col-xs-2" id="guanzhu" style="text-align: center; margin-top: 11px;">
					<a href="#" data-toggle="modal" data-target="#myModal" style="text-decoration: none;">
						<i class="fa fa-qrcode fa-2x"></i>
						<p> 关注 </p>
					</a>
				</div> 
				
				
				<div class="col-xs-2" style="text-align: center; margin-top: 11px;">
					<a href="${base}/weixin/baseoauth?action=challengIndex" style="text-decoration: none;">
				    	<i class="fa fa-share fa-2x"></i>
				        <p>发起</p>
				     </a>
<!-- 					<button type="button" style="font-size:12px;margin-top:-4px;" class="button button-pill" -->
<%-- 						onclick="javascrtpt:window.location.href='${base}/weixin/baseoauth?action=challengIndex'">发起活动</button> --%>

				</div>
				<div class="col-xs-2" style="text-align: center; margin-top:11px;  padding:0px;">
					<a href="${base}/weixin/baseoauth?action=myInfoIndex&activityId=${Activitiy.activityId}">						
						<i class="fa fa-user fa-2x"></i>
						<p>我</p>
					</a>
				</div>
			</div>
			</div>
		<section id="commentsArea" style="background: rgba(0, 0, 0, 0.51);" class="layer">
		<div class="content" style="background: #eee">
			<div class="form-group">
				<div style="padding:0 10px 0 10px"><span class="pull-left form-control-static" onclick='closeBack()'>取消</span>
				<span class="pull-right form-control-static" onclick='insert(this)'>发送</span>
				</div>
					<textarea onfocus="test()" id="exampleInputArea" style="background: #ddd" rows="4" cols="50" class="form-control" placeholder="回复评论">
</textarea>
			</div>
		</div>

	</section>
	</nav>
	
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
function hideBox(){
	var fromChall = "${fromChall}";
	if(fromChall != "y"){
		var box=document.getElementById("hideBox");
		box.style.display="none";
	}
};


$.ajax({
		url : "${base}/getOnlookers?activityId=${Activitiy.activityId}",
		type : 'get',
		async : true,
		datatype: "json",
		success : function(data) { 
			 var member = eval("("+data+")");
			var carePeople=document.getElementById("care");
			$(carePeople).html(eval("("+member[0]+")"));
			
			if(member[1]>0)
			{
			var bbPeople=document.getElementById("bbcount");
			$(bbPeople).html(eval("("+member[1]+")"));
			}
		
			if(member[2]>0)
			{
			var rbPeople=document.getElementById("rbcount");
			$(rbPeople).html(eval("("+member[2]+")"));
			}
			if(member[3]>0)
			{
			var nnPeople=document.getElementById("nncount");
			$(nnPeople).html(eval("("+member[3]+")"));
			}
			
		}
	});
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
	$("#footer").css('display','none');
	$("#commentsArea").addClass('acitve');
	
	if ($(obj).find('a').size() != 0) {
		var toUserName = $(obj).find('a').eq(0).text();
		var toUserId = $(obj).find('a').eq(0).attr('name');
		localStorage.setItem('isReplyComments', 'true');
		var replyCommentTagId = $(obj).parent().parent().attr('id');
		localStorage.setItem('replyCommentBtnId', replyCommentTagId.substr(
				0, replyCommentTagId.length - 3));
		localStorage.setItem('toUserId', toUserId);
		$('#exampleInputArea').attr('placeholder', '回复' + toUserName + '：');
		
		
	} else {
		var toUserId = $(obj).attr('name');
		localStorage.setItem('isReplyComments', 'true');
		localStorage.setItem('toUserId', toUserId);
		localStorage.setItem('replyCommentBtnId', obj.id);
		$('#exampleInputArea').attr('placeholder', '评论');
	}
	var t = setTimeout("document.getElementById('exampleInputArea').focus();",100);

}
function replyFirstComments(obj){
	$("#footer").css('display','none');
	$("#commentsArea").addClass('acitve');
	document.getElementById("exampleInputArea").focus();
	localStorage.setItem('replyCommentBtnId', obj.id);
		var toUserName = $(obj).find('a').eq(0).text();
		var toUserId = $(obj).attr('name');
		localStorage.setItem('toUserId', toUserId);
		localStorage.setItem('isReplyComments', 'true');
		$('#exampleInputArea').attr('placeholder',
				'回复' + toUserName + '：');
		var t = setTimeout("document.getElementById('exampleInputArea').focus();",100);
}
function closeBack(){
	$("#commentsArea").removeClass('acitve');
	$("#footer").css('display','');
	localStorage.removeItem('isReplyComments');
	localStorage.removeItem('replyCommentBtnId');
	localStorage.removeItem('toUserId');
	
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

window.onload=hideBox();
</script>
</html>