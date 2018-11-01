<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<link href="http://cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="css/task.css?random=2.9">
	<link rel="stylesheet" type="text/css" href="http://cdn.bootcss.com/font-awesome/4.2.0/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="http://www.bootcss.com/p/buttons/css/buttons.css ">
	<link rel="stylesheet" type="text/css" href="http://sandbox.runjs.cn/uploads/rs/340/ustg8wvx/weui.css">
	<link href="bootstrap3.3.5/css/app.css" rel="stylesheet">
	<script type="text/javascript" src="http://sandbox.runjs.cn/uploads/rs/340/ustg8wvx/weui.js"></script>
	<script src="http://libs.baidu.com/jquery/1.9.1/jquery.min.js"></script>
	<script src="http://cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
	<script type="text/javascript"	src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
	<title>朕以为</title>
	<style type="text/css">
.img-pk{-webkit-animation: scaleout 2s infinite ease-in-out;animation: scaleout 2s infinite ease-in-out;}
@-webkit-keyframes scaleout {
    0% { -webkit-transform: scale(1.0) }
    100% {
        -webkit-transform: scale(1.2);
        opacity: 0;
    }
}
@keyframes scaleout {
    0% {
        transform: scale(1.0);
        -webkit-transform: scale(1.0);
    } 100% {
          transform: scale(1.2);
          -webkit-transform: scale(1.2);
          opacity: 0;
      }
}
</style>
</head>

<body class="item">
	<script type="text/javascript">
	function reWXready(contentx,titlex,imgUrlx){//参数：赞成反对，活动结果
		//全部的imgurl都统一为产品logo
		var imgOfBackNews = "${Activitiy.imgBackBews}";
		if(imgOfBackNews == null || imgOfBackNews == ""){
			imgUrlx = "https://mmbiz.qlogo.cn/mmbiz/rLJwdLlcd3cRQEwo8rYXV7vJy8yOib9VzOZibd23ova9FKD8fZz1CwLuEzg0fRhtvpmgXdxLuIRJEG6PxPCrciclQ/0?wx_fmt=jpeg";
		}else{
			imgUrlx = imgOfBackNews;
		}
		//titlex = "(有红包)"+ titlex;
	wx.ready(function () {
			 //讨论组分享↓↓↓↓↓↓↓↓↓
				var titleOfBackNews = "${Activitiy.titleBackNews}";
				var titleForS = null;
				var contentForS = null;
				if(titleOfBackNews == null || titleOfBackNews == ""){
					titleForS =  "${currentUser.nickName}想听你"+titlex;
					contentForS = contentx;
				}else{
					titleForS = titleOfBackNews;
					contentForS = "${currentUser.nickName}想听你"+titlex;
				}
			wx.onMenuShareAppMessage({  
			title: titleForS, // 分享标题  
			desc: contentForS, // 分享描述  
			link: 'http://${appServer}${base}/weixin/baseoauth?action=onlineGame&activityId=${Activitiy.activityId}', // 分享链接  
			imgUrl: imgUrlx, // 分享图标  
			type: 'link', // 分享类型,music、video或link，不填默认为link  
			dataUrl: '', // 如果type是music或video，则要提供数据链接，默认为空  
			}); 
			
			
			//盆友圈↓↓↓↓↓↓↓
			var showPart = null;
			if(titleOfBackNews == null || titleOfBackNews == ""){
				if(titlex.length >= 13){
					titlex = titlex.substring(0,13)+"...";
				}
				showPart = "${currentUser.nickName}想听你意见:" + titlex +"\n" + contentx;
			}else{
				titlex = "${currentUser.nickName}想听你意见:" + titleOfBackNews;
				showPart = titlex;
			}
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
						  	//打开dialog的时候，把radios的值设置为1
						    //var radios = document.getElementsByName("optionsRadiosinline");
						    //radios[0].checked = true;
						    document.getElementById("radio_input").style.visibility="visible";
						    $('#optionsRadios1').next().text('反对');
						    $('#optionsRadios2').next().text('强烈反对');
						    $('#optionsRadios3').next().text('反对到底');
							weui.confirm("踩踩踩分享朋友圈，呼朋唤友一起踩！","和朋友一起嬉笑怒骂，这很快乐！",function(r){
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
															window.location.href="${base}/weixin/baseoauth?action=getAwardIndex";
															return;
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
		</script>
		<script type="text/javascript">
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
							 //打开dialog的时候，把radios的值设置为1
							  //var radios = document.getElementsByName("optionsRadiosinline");
							  //radios[0].checked = true;
							  document.getElementById("radio_input").style.visibility="visible";
							  $('#optionsRadios1').next().text('支持');
							    $('#optionsRadios2').next().text('强烈支持');
							    $('#optionsRadios3').next().text('支持到底');
							  weui.confirm("顶顶顶分享朋友圈，呼朋唤友一起顶！","和朋友一起嬉笑怒骂，这很快乐！",function(r){
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
																window.location.href="${base}/weixin/baseoauth?action=getAwardIndex";
																return;
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
			var s =$.trim($("#exampleInputArea").val());
			var isReplyComment = localStorage.getItem('isReplyComments');
			if ('true' != isReplyComment) {
				var url = "${base}/insertAjaxcomments?activityId=${Activitiy.activityId}&openId=${openId}&comments="
						+ encodeURIComponent(s);
				if (s == "") {
					return;
				}
				$("#commentsArea").removeClass('acitve');
				$("#footer").css('display','');
				if ("${granted}" == "N") {
					window.location.href = '${base}/weixin/oauth?action=insertcommentwecat&activityId=${Activitiy.activityId}&paramstr=comment='
							+ encodeURIComponent(s);
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
						+ "&comments=" + encodeURIComponent(s);
				if (s == "") {
					return;
				}
				$("#commentsArea").removeClass('acitve');
				$("#footer").css('display','');
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
								

							},
							error : function() {
								weui.alert("微信服务器错误，请重新进入页面！");
							}
						});

			}

		}
		</script>
<script type="text/javascript">
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
		setTimeout("codefans()",3000);//3秒
		
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
		
		
	</script>	
	<script type="text/javascript">
	
	function internalNoButton()
	{
		var dialogComment=$.trim($('#dialog_comment').val());
		var radios = document.getElementsByName("optionsRadiosinline");
		var doubleNum = "";
		for(var i=0; i<radios.length; i++)
		{
			if(radios[i].checked)
			{
				doubleNum = radios[i].value;
			}
		}
		if("${granted}"=="N")
		{
			window.location.href="${base}/weixin/oauth?action=clickNoButton&activityId=${Activitiy.activityId}&paramstr=comment="+encodeURIComponent(dialogComment)+"&num="+doubleNum;
			return;
		}
		else
		{			
			document.getElementById("blueSide").setAttribute('onclick', '');
			$.ajax({
				url : "${base}/clickAgainst?activityId=${Activitiy.activityId}&openId=${openId}&comment="+encodeURIComponent(dialogComment)+"&num="+doubleNum,
				type : 'POST',
				async : true,
				dataType : 'json',
				success : function(data) {
					
					if(data=="NOT!"){
						 weui.alert("你已经参与了该活动!");
					 	return;
					}
					else if(data=="MAX!")
					{
						weui.alert("你的城池不够，不能参与此活动，先去获得城池吧!");
						window.location.href="${base}/weixin/baseoauth?action=getAwardIndex";
						return;
					}
					else{
						
						var member = data;
	                     var headerURL=member[0];
	                     var name=member[1];
	                     var coment=member[2];
	                     var time=member[3].substr(0,19);
	                     var comentId = member[4];
	                     var gzflag = member[5];
	                     
	                     if(gzflag=="UNGZ")
	                    	 {
	                    	 showMask();
	                    	 }
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
						var num = doubleNum;
	        			 img = img +'<div style="position:relative;width:30px;height:30px;" class="pull-right"><img class="img-circle pull-right" style="width:30px;height:30px;" src='+headerURL+'><p class="label text-warning" style="position: absolute;left: 15px;top: 20px;">X'+num+'</p></div>';
	        			$("#bluList").html(img);
	        			//重写 wxready方法
						 var activityType = "${Activitiy.activityStake}";
/* 						 var numberOfParticipate  = ${participateNicknameYes.size() + participateNicknameNO.size()};
						 	var numberOfYes = ${participateNicknameYes.size()};
						 	var numberOfNo = ${participateNicknameNO.size()} + 1; */
	   					if(activityType.indexOf("朕要为此赌上")>-1 || activityType.indexOf("座城池")>-1){
	   						reWXready("奖惩：${Activitiy.activityStake}","意见：${Activitiy.activityDesc}",headerURL);
	   						//reWXready("奖惩：${Activitiy.activityStake}","${WechatUser.nickName}预测：${Activitiy.activityDesc}",headerURL);
// 	   						reWXready("正方："+numberOfYes+"人 VS 反方："+numberOfNo+"人!","${WechatUser.nickName}预测：${Activitiy.activityDesc}",headerURL);
	   					}else{
	   						reWXready("预测：${Activitiy.activityDesc}","挑战了：" + name+" VS ${WechatUser.nickName}",headerURL);
	   						//reWXready("${WechatUser.nickName}预测：${Activitiy.activityDesc}","挑战了：" + name+" VS ${WechatUser.nickName}",headerURL);
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
		var dialogComment=$.trim($('#dialog_comment').val());
		var radios = document.getElementsByName("optionsRadiosinline");
		var doubleNum = "";
		for(var i=0; i<radios.length; i++)
		{
			if(radios[i].checked)
			{
				doubleNum = radios[i].value;
			}
		}
		if("${granted}"=="N"){
			window.location.href="${base}/weixin/oauth?action=clickYesButton&activityId=${Activitiy.activityId}&paramstr=comment="+encodeURIComponent(dialogComment)+"&num="+doubleNum;
		  return;
		}
		else{
			document.getElementById("redSide").setAttribute('onclick', '');
			$.ajax({
				url : "${base}/clickSupport?activityId=${Activitiy.activityId}&openId=${openId}&comment="+encodeURIComponent(dialogComment)+"&num="+doubleNum,
				type : 'post',
				async : true,
				datatype: "json",
				success : function(data) { 
					if(eval("("+data+")")=="NOT!"){
						 weui.alert("你已经参与了该活动!");
						 return;
					}else if(eval("("+data+")")=="MAX!")
					{
						weui.alert("你的城池不够，不能参与此活动，先去获得城池吧!");
						window.location.href="${base}/weixin/baseoauth?action=getAwardIndex";
						return;
					}
					else{
						var member = eval("("+data+")");
	                     var headerURL=member[0];
	                     var name=member[1];
	                     var coment=member[2];
	                     var time=member[3].substr(0,19);
	                     var comentId = member[4];
	                     var gzflag = member[5];
	                     
	                     if(gzflag=="UNGZ")
	                    	 {
	                    	 showMask();
	                    	 }
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
						var num = doubleNum;
// 						 img = img + '<img class="img-circle" style="width:30px;height:30px;" src='+headerURL+'>';
						 img = img +'<div style="position:relative;width:30px;height:30px;" class="pull-left"><img class="img-circle" style="width:30px;height:30px;" src='+headerURL+'><p class="label text-warning" style="position: absolute;left: 15px;top: 20px;">X'+num+'</p></div>';
		        			
						 $("#redList").html(img);
						//重写 wxready方法
						 var activityType = "${Activitiy.activityStake}";
/* 						 var numberOfParticipate  = ${participateNicknameYes.size() + participateNicknameNO.size()};
						 	var numberOfYes = ${participateNicknameYes.size()} + 1;
						 	var numberOfNo = ${participateNicknameNO.size()}; */
	   					if(activityType.indexOf("朕要为此赌上")>-1 || activityType.indexOf("座城池")>-1){
	   						reWXready("奖惩：${Activitiy.activityStake}","意见：${Activitiy.activityDesc}",headerURL);
	   						//reWXready("奖惩：${Activitiy.activityStake}","${WechatUser.nickName}发起预测：${Activitiy.activityDesc}",headerURL);
// 	   						reWXready("正方："+numberOfYes+"人 VS 反方："+numberOfNo+"人!","${WechatUser.nickName}发起预测：${Activitiy.activityDesc}",headerURL);
	   					}else{
	   						reWXready("预测：${Activitiy.activityDesc}","挑战了：" + name+" ${WechatUser.nickName} VS ...",headerURL);
	   					//	reWXready("${WechatUser.nickName}发起预测：${Activitiy.activityDesc}","挑战了：" + name+" ${WechatUser.nickName} VS ...",headerURL);
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
/* 				var numberOfParticipate  = ${participateNicknameYes.size() + participateNicknameNO.size()};
			 	var numberOfYes = ${participateNicknameYes.size()};
			 	var numberOfNo = ${participateNicknameNO.size()}; */
				if(ownerId==nowUserId && resultStatus == 0){
					//owner进来且未发布结果
					document.getElementById("forOwer").style.display = "block";
					document.getElementById("forChalleger").style.display = "none";
					$("#blueBtn").removeClass("button-glow");
					$("#redBtn").removeClass("button-glow");
					//添加结果发布字体闪烁
						reWXready("奖惩：${Activitiy.activityStake}","意见：${Activitiy.activityDesc}","${WechatUser.headImgUrl}");
						//reWXready("奖惩：${Activitiy.activityStake}","${WechatUser.nickName}预测：${Activitiy.activityDesc}","${WechatUser.headImgUrl}");
				}else if(ownerId!=nowUserId && resultStatus == 0){
					//其他人进来，未发布结果
					document.getElementById("forOwer").style.display = "none";
					document.getElementById("forChalleger").style.display = "none";
					reWXready("奖惩：${Activitiy.activityStake}","意见：${Activitiy.activityDesc}","${WechatUser.headImgUrl}");
					//reWXready("奖惩：${Activitiy.activityStake}","${WechatUser.nickName}预测：${Activitiy.activityDesc}","${WechatUser.headImgUrl}");
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
			      var headerURL = "nothing";
					if(resultStatus==2){
						//document.getElementById("resultOfAct").innerHTML="朕胜了";
						reWXready("奖惩：${Activitiy.activityStake}","意见：${Activitiy.activityDesc}",headerURL);
						//reWXready("奖惩：${Activitiy.activityStake}","${WechatUser.nickName}发起预测：${Activitiy.activityDesc}",headerURL);
// 						reWXready("胜方："+numberOfYes+"人 VS 败方:"+numberOfNo+ " 人！", "${WechatUser.nickName}预测：${Activitiy.activityDesc}","${WechatUser.headImgUrl}");
						document.getElementById("redBtn").innerHTML='<span style="color:#f5725a"><b>胜</b></span>';
						document.getElementById("blueBtn").innerHTML='<span style="color:#42b5d8"><b>败</b></span>';
					}else{
						//document.getElementById("resultOfAct").innerHTML="朕认栽";
						reWXready("奖惩：${Activitiy.activityStake}","${WechatUser.nickName}发起预测：${Activitiy.activityDesc}",headerURL);
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
						//reWXready("奖惩：${Activitiy.activityStake}","${WechatUser.nickName}发起预测：${Activitiy.activityDesc}","${WechatUser.headImgUrl}");
						reWXready("奖惩：${Activitiy.activityStake}","意见：${Activitiy.activityDesc}","${WechatUser.headImgUrl}");
					}else{
						reWXready("预测：${Activitiy.activityDesc}","挑战了：" + yesPart+" VS "+noPart,"${WechatUser.headImgUrl}");	
						//reWXready("${WechatUser.nickName}发起预测：${Activitiy.activityDesc}","挑战了：" + yesPart+" VS "+noPart,"${WechatUser.headImgUrl}");
					}
				}else if(ownerId!=nowUserId && resultStatus == 0){
					//其他人进来，未发布结果
					document.getElementById("forOwer").style.display = "none";
					document.getElementById("forChalleger").style.display = "block";
					//reWXready("${WechatUser.nickName}预测：${Activitiy.activityDesc}","挑战了：" + yesPart+" VS "+noPart,"${WechatUser.headImgUrl}");
					reWXready("预测：${Activitiy.activityDesc}","挑战了：" + yesPart+" VS "+noPart,"${WechatUser.headImgUrl}");
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
		   //判断是否是系统活动或者用户发起活动
		   var sysOrUser = "${Activitiy.acitvityType}";
		   //header显示
		   if(sysOrUser ==  "2"){
			    document.getElementById("headerForUser").style.display = "none";
				document.getElementById("headerForSys").style.display = "block";
		   }else{
			    document.getElementById("headerForSys").style.display = "none";
				document.getElementById("headerForUser").style.display = "block";
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
		   
		   var gz_flag = "${user.gz_flag}";
		   if(gz_flag == 1){
			   document.getElementById("guanzhu").style.display = "none";
				document.getElementById("redPakage").style.display = "block";
		   }else{
			   document.getElementById("guanzhu").style.display = "block";
				document.getElementById("redPakage").style.display = "none";
		   }
		   
		 
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
			//打开dialog的时候，把radios的值设置为1
			//var radios = document.getElementsByName("optionsRadiosinline");
			//radios[0].checked = true;
			document.getElementById("radio_input").style.visibility="hidden";
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
/* 					 var numberOfParticipate  = ${participateNicknameYes.size() + participateNicknameNO.size()};
					 var numberOfYes = ${participateNicknameYes.size()} + 1;
					 var numberOfNo = ${participateNicknameNO.size()}; */
					 var dialogComment=$.trim($('#dialog_comment').val());
   				
					$.ajax({
						url : "${base}/saveUserSelected?actId="+actId+"&status="+vl+"&dialogComment="+dialogComment,
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
										reWXready("奖惩：${Activitiy.activityStake}","意见：${Activitiy.activityDesc}","${WechatUser.headImgUrl}");
// 				   						reWXready("正方："+numberOfYes+"人 VS 反方："+numberOfNo+"人!${Activitiy.activityStake}","${WechatUser.nickName}预测${Activitiy.activityDesc}","${WechatUser.headImgUrl}");
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
										reWXready("奖惩：${Activitiy.activityStake}","意见：${Activitiy.activityDesc}","${WechatUser.headImgUrl}");
// 				   						reWXready("正方："+numberOfYes+"人 VS 反方："+numberOfNo+"人!${Activitiy.activityStake}","${WechatUser.nickName}预测${Activitiy.activityDesc}","${WechatUser.headImgUrl}");
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
								var moreFlag = "";
								var pgmstack = "";
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
										
										moreFlag = jsonData[oi].moreFlag;
										pgmstack = jsonData[oi].pgmstack;
									}
									//生成交易
									
									document.getElementById("resultConfirmDiv").style.display = "none";
									document.getElementById("dellDetailDiv").style.display = "block";
									document.getElementById("dellResultSpan").innerHTML="结果明细";
									
									document.getElementById("dellDetailDiv").innerHTML=resltHtml;
									
									if(moreFlag=="1")
									{
										weui.alert('恭喜你，你额外获得了'+pgmstack+'城池！');
									}
								}
							}	
						});
				}
			});
		}
		</script>
		
		
		<div class="header" style="background-color:white;padding:0px 0px 0px 0px;">
			<div id="headerForUser" class="row m-t m-r" style="margin-left:10px;">
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
			
			<style>
.container {
    position: relative;
}

.center {
    position: absolute;
    left: 0;
    top: 50%;
    width: 100%;
    text-align: center;
    font-size: 18px;
}

img { 
    width: 100%;
    height: auto;
}
</style>

			<div class="container" id="headerForSys">
				<c:if test="${forecastAcc != null && forecastAcc != ''}">
					<span class="h4" style="position:absolute;left:1.5rem;top:0.5rem;">
					小朕子机器人预测：${forecastAcc}
					</span>
				</c:if>
				<a href="#" data-toggle="modal" data-target="#myModal" style="text-decoration: none;">
				<img src="images/1.jpg" id="pk" style="height:1.7rem;width:100%;">				
				<div class="center"></div>
				</a>
			</div>
		</div>
	<!-- 结果发布按钮 -->
		
	
	<div class="container m-t" style="padding:0;margin: 0;" id="divId">
	<div class="container" style="background-color:white;padding:10px 10px 0px 10px;">
	<c:choose>
				<c:when test="${Activitiy.imgBackBews != null && Activitiy.imgBackBews != ''}">
					<div class="newsBanner" >
						<a href="${Activitiy.originalUrl}">
							<div class="col-xs-2" style="padding-left: 0.2rem;">
								<img class="img-circle" style="width:0.75rem;height:0.75rem;" src="${Activitiy.imgBackBews}">
							</div>
							<div class="col-xs-10" style="margin-top: 0.1rem;line-height: 0.4rem;padding-right:0.01rem;padding-left:0rem">
								<c:choose>
									<c:when test="${Activitiy.titleBackNews != null && Activitiy.titleBackNews != ''}">
										 <c:if test="${fn:length(Activitiy.titleBackNews) > 32}">
											<span>
											${Activitiy.titleBackNews.substring(0, 12)}...
											</span>
										</c:if> 
										<c:if test="${fn:length(Activitiy.titleBackNews) <= 32}">
											<span>
											${Activitiy.titleBackNews}
											</span>
										</c:if>
									</c:when>
									<c:otherwise>
										<span>背景新闻</span>
									</c:otherwise>
								</c:choose>
							</div>
						</a>
					</div>
				</c:when>
				
			</c:choose>
	<div style="border-radius: 2px 2px 2px 2px;background-color:#f0f3f4;margin-left:0px;margin-right:0px;" class="row">
		
		<div class="m-l-xs m-b-xs m-t h5">				
					<i class="fa fa-bullhorn fa-lg"></i>
						<span class="h5">活动预测：</span> <span class="text-font" style="font-size:13px;">
						<c:if test="${Activitiy.originalUrl==null || Activitiy.originalUrl==''}">
							<c:out value="${Activitiy.activityDesc}" />
						</c:if>
						<c:if test="${Activitiy.originalUrl!=null && Activitiy.originalUrl!=''}">
							<a href="${Activitiy.originalUrl}" class="text-font" style="font-size:13px;"><c:out value="${Activitiy.activityDesc}" />
<!-- 							<span style="font-size:0.22rem;margin-left:2px;color:white;background-color:#6B5959;">原文</span> -->
							</a>
						</c:if>
						</span>
		</div>
		<div class="m-l-xs m-b-xs m-t h5">				
					<i class="fa fa-gift fa-lg"></i>
						<span class="h5">活动奖惩：</span> <span class="text-font" style="font-size:13px;">
							<c:out value="${Activitiy.activityStake}" />
						</span>
		</div>			

		
		<div class="m-l-xs m-b-xs m-t h5">				
					<i class="fa fa-clock-o fa-lg"></i>
						<span class="h5">参与截止：</span> <span class="text-font" style="font-size:13px;">
							<fmt:formatDate value="${Activitiy.activityDeadline}"
								pattern="yyyy-MM-dd HH:mm" /> 
						</span>
		</div>

	
		<div class="m-l-xs m-b m-t h5">				
					<i class="fa fa-bell-o fa-lg"></i>
						<span class="h5">结果公布：</span> <span id="resultOfAct" class="text-font" style="font-size:13px;">
							<fmt:formatDate value="${Activitiy.publishDate}"
								pattern="yyyy-MM-dd HH:mm" /> 
						</span>
			</div>
		
		<c:if test="${Activitiy.tendency !=null && Activitiy.tendency !=''}">
			<div class="m-l-xs m-b-xs m-t h5">	
			<i class="fa fa-cube fa-lg"></i>			
						<span class="h5">天人相参：</span>
						  <span class="text-font ">
						 <c:set var="tend" value="${fn:replace(Activitiy.tendency,'%','') }"></c:set>
							 <c:if test="${tend <= 40 }">
								 	<c:out value="一切有为法，该事不会发生" />
								</c:if>
								<c:if test="${tend > 40 && tend < 60}">
								 	<c:out value="系统无法预测该事件是否会发生" />
								</c:if>
								<c:if test="${tend >= 60 }">
								 	<c:out value="一切有为法，该事定会发生" />
								</c:if>
						 
						</span>
						<span class="h5"></span>
			</div>
		</c:if>

</div>
		</div>
	<div class="container" style="background-color:white;padding-bottom:5px;">
		<hr class="m-t-xs m-b-xs">
			<div>
				<div id="redSide" class="col-xs-4 m-t-xs" align="center" onclick="clickYesButton()">
					<button id="redBtn" class="button button-circle button-giant">
					<span class="fa fa-thumbs-up fa-lg" style="color:#f5725a"></span>
					</button>
				</div>
				<div id="midLogo" class="col-xs-4" align="center" style="background-size: 65px 65px;
    background-repeat: no-repeat;
    background-image: url(images/pk_icon2.png);background-position-x: 50%;">
    <a href="${base}/formOfPartsInAct?actId=${Activitiy.activityId}&percent=0" ><img class="img-pk" src="images/pk_icon2.png" id="pk" style="height:65px;width:65px;"></a>
    
				</div>
				<div id="blueSide" class="col-xs-4 m-t-xs" align="center" onclick="clickNoButton()">
					<button id="blueBtn" class="button button-circle button-giant">
					<span class="fa fa-thumbs-down fa-lg" style="color:#42b5d8"></span>
					</button>
				</div>
			</div>
			<div id="seatDiv" class="h6" align="center">还有${Activitiy.particiLimititation-numberOfPartner-1}席位</div>
		<hr class="m-t-xs m-b-xs">
	</div>
<!-- 			<button class="button button-glow  button-circle button-giant"> -->
<%-- 		<div class="row">
			<div class="col-xs-5"></div>
				<div class="col-xs-2">
					<a href="${base}/formOfPartsInAct?actId=${Activitiy.activityId}&percent=0" align="center">
							<i class="fa fa-lightbulb-o fa-2x button-glow" style="font-size:1.8em"></i>
					</a>
				</div>
			<div class="col-xs-5"></div>
		</div> --%>
<!-- 			</button> -->
			
		<div class="container" style="background-color:white;">
		<a href="${base}/formOfPartsInAct?actId=${Activitiy.activityId}&percent=0">
			<div class="row m-l-xs m-r-xs" style="margin-bottom:2px;">
				<div id="redList" style="width:40%;float:left;" class="col-xs-4">
					<c:choose>
						<c:when test="${WechatUser.userId == 'systemadmin'}">
						</c:when>
						<c:otherwise>
							<img class="img-circle" style="margin-left:-8px;width:30px;height:30px;" src="${WechatUser.headImgUrl}">
						</c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test="${ParticipateYesList!=null && ParticipateYesList.size()>0}"> 
							<c:forEach var="thisParticipate" items="${ParticipateYesList}" varStatus="preIndex">
							<div style="position:relative;width:30px;height:30px;" class="pull-left">
								<img class="img-circle" style="margin-left:-8px;width:30px;height:30px;" src="${thisParticipate.headimgurl}">
								<c:if test="${thisParticipate.double_num != 1}">
								 <p class="label text-warning" style="position: absolute;left: 15px;top: 20px;">X${thisParticipate.double_num}</p>
								 </c:if>
								 </div>
							</c:forEach>
						</c:when>
					</c:choose>
				</div>
				<div id="bluList" style="width:40%;float:right;" class="col-xs-4">
					<c:choose>
						<c:when test="${ParticipateNoList!=null && ParticipateNoList.size()>0}"> 
							<c:forEach var="thisParticipate" items="${ParticipateNoList}" varStatus="preIndex">
							<div style="position:relative;width:30px;height:30px;" class="pull-right">
							<img class="img-circle pull-right" style="margin-left:-8px;width:30px;height:30px;" src="${thisParticipate.headimgurl}">
							<c:if test="${thisParticipate.double_num != 1}">
							<p class="label text-warning" style="position: absolute;left: 15px;top: 20px;">X${thisParticipate.double_num}</p>
							</c:if>						
			  
			</div>
								
							</c:forEach>
						</c:when>
						<%-- <c:otherwise>
							<span class="h6 text-muted"></span>
						</c:otherwise> --%>
					</c:choose>
				</div>
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
			
			<div>
					<c:forEach var="pInfo" items="${dellDetailInfo}">
						<div class="col-xs-4" style="overflow:hidden;">
						<img src="${pInfo['picture']}" class="img-circle" style="width: 30px; height: 30px;">
						<c:if test="${pInfo['winlose'] == 0}"><span style="color:green;"> 失去 ${pInfo['points']}</span></c:if>
						<c:if test="${pInfo['winlose'] == 1}"><span style="color:red; "> 获得 ${pInfo['points']}</span></c:if>
						</div>
					</c:forEach>	

			</div>
		</c:if>
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
							<c:if test="${ai['UserId']!='systemadmin'}">
							<div class="project-support_item__detail__user col-xs-6" style="padding:0px;font-size:0.9em">准确率：${ai['ForecastAccuracy']}</div>
							<div class="project-support_item__detail__user col-xs-6" style="padding:0px;font-size:0.9em">城池数：${ai['AllPoints']-ai['lockedPoints']}/${ai['AllPoints']}</div>
							</c:if>
							
						</div>
						<div class="project-support_item__detail__content">
							<p>${ai['Comments']}</p>
							<div class="project-support_item__detail__time col-xs-8" style="padding:0px;"> ${ai['CreateTime'].substring(0, 19)}</div>
							<div class="pull-right">
								<div name="zanFlag" class="${ai['ZanClass']}"
									onclick="clickZan(this)"
									style="float: left; margin-right: 0.3rem;">
									<i class="fa fa-thumbs-o-up"></i><span
										style="margin-left: 0.1rem;">${ai['Zan']}</span>
								</div>
								<a style="color: #337ab7" id="${ai['CommentId']}Reply" name="${ai['UserId']}" 
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

	</div>
	<nav class="navbar navbar-default navbar-fixed-bottom" style="padding: 0px;height:40px"
		role="navigation">
		<div class="container">

			<div class="row" style="display: block;" id="footer">

				<div class="col-xs-6 " style="margin-top: 8px;" onclick='popup()'>
					<button type="button"  class="button button-pill" style="height:35px;font-size:0.9em;padding: 0 50px 0 20px;">:发射评论</button>
<!-- 					<img style="width: 30px; height: 30px;" src="images/discuss.jpg"> -->
				</div>

	 			<div class="col-xs-2" id="guanzhu" style="text-align: center; margin-top: 8px;">	 			
					<a href="${base}/weixin/baseoauth?action=findActivity" style="text-decoration: none;">
						<i class="fa fa-eye fa-2x" style="font-size:1.8em"></i>
						<p style="font-size:0.8em">发现</p>
					</a>
				</div> 
				<div class="col-xs-2" id="redPakage" style="text-align: center; margin-top: 8px;">
					<a href="#"  style="text-decoration: none;">
						<i class="fa fa-envelope fa-2x" style="font-size:1.8em"></i>
						<p style="font-size:0.8em">红包</p>
					</a>
				</div> 
				
				
				<div class="col-xs-2" style="text-align: center; margin-top: 8px;">
					<a href="${base}/weixin/baseoauth?action=onekeycopy&activityId=${Activitiy.activityId}" style="text-decoration: none;">
				    	<i class="fa fa-files-o fa-2x" style="font-size:1.8em"></i>
				        <p style="font-size:0.8em">复制</p>
				     </a>
<!-- 					<button type="button" style="font-size:12px;margin-top:-4px;" class="button button-pill" -->
<%-- 						onclick="javascrtpt:window.location.href='${base}/weixin/baseoauth?action=challengIndex'">发起活动</button> --%>

				</div>
				<div class="col-xs-2" style="text-align: center; margin-top:8px;  padding:0px;">
					<a onclick="showShare()">						
						<i class="fa fa-share fa-2x" style="font-size:1.8em"></i>
						<p style="font-size:0.8em">分享</p>
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
	<section id="shareArea" style="background: rgba(0, 0, 0, 0.51);" class="layer">
		<img src="images/shareToFriend2.png" style="width:100%">
		
		<div style="margin-left:2.1rem;margin-top:0.5rem;width:100%">
		<img onclick="shareCancle()" src="images/shareCancle.png" style="width: 3rem;height: 1.5rem;">
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
	             	  关注朕以为<br/>
	             	  拿RMB大红包！
	            </h4>
	         </div>     
	         <div class="modal-body" style="padding:0.08rem;">
	          <div><img src="images/qrcode.jpg" style="width: 4.0rem;height: 4.0rem;"></div>
	         </div>
	      </div>
		</div>
	</div>
	<!--用户提示  -->
	<div id="cover" class="cover" onclick="hiddenMask()" style="border-radius:1em 1em 1em 1em;padding-top:5px;color:white;">
		<div id="coverTitle" class="row" style="margin:10px;font-size: 1.4em;">
		用户提示：
		</div>
		<div id="coverBody" class="row" style="margin-right: 15px;margin-left: 15px;font-size: 1.1em;">
		请点下方菜单识别二维码关注公众号，关注成功可以及时获取朋友的意见和评论！
		</div>
		<div id="coverFooter" class="row" style="margin:10px;text-align: right; ">  
		    <button onclick="hiddenMask()" class="button button-large button-plain button-borderless" style="background-color: #1383A5;font-size:1.3em">
			确定
			</button>
		</div>
	</div>
	<!--BEGIN dialog1-->
<div class="weui_dialog_confirm" id="dialog1" style="display: none;">
    <div class="weui_mask"></div>
    <div class="weui_dialog">
        <div class="weui_dialog_hd"><strong class="weui_dialog_title">提示</strong></div>
        <div class="weui_dialog_input" style="padding-top: 10px;"><textarea id="dialog_comment" rows="3" class="form-control" placeholder="理由了？妙语连珠，幽默搞笑还是随便说说都无所谓，只要够真就行！一句就成！"></textarea></div>
        <div class="weui_dialog_bd" style="margin-top:5px;">确定支持？决定后别忘了点击右上角和朋友分享你的态度！记住了喔</div>
        <div class="weui_dialog_input" style="text-align:center;" id="radio_input">
	        <label class="checkbox-inline" style="padding-left:0px;">
				<input type="radio" name="optionsRadiosinline" id="optionsRadios1" value="1" onclick="radioChange(this)" checked> <span>1倍</span>
			</label>
			<label class="checkbox-inline" style="padding-left:0px;">
				<input type="radio" name="optionsRadiosinline" id="optionsRadios2" value="2" onclick="radioChange(this)"> <span>2倍</span>
			</label>
		 	<label class="checkbox-inline" style="padding-left:0px;">
				<input type="radio" name="optionsRadiosinline" id="optionsRadios3" value="3" onclick="radioChange(this)"> <span>3倍</span>
			</label>
        </div>
        <div class="weui_dialog_ft" style="margin-top:5px;">
            <a href="javascript:;" class="weui_btn_dialog default">取消</a>
            <a href="javascript:;" class="weui_btn_dialog primary">确定</a>
        </div>
    </div>
</div>
<!--END dialog1-->
</body>
<script type="text/javascript">
function hideBox(){
	var fromChall = "${fromChall}";
	if(fromChall != "y"){
		var box=document.getElementById("hideBox");
		box.style.display="none";
	}
};
function radioChange(obj){
	var i=parseInt($(obj).val());
	switch (i){
		case 1:
		weui.Loading.msg('不加倍',1000, "weui_info_toast", "weui_icon_safe_warn");
		$('.weui_toast').css('z-index','10000');
			break;
			case 2:
		weui.Loading.msg('加倍X2',1000, "weui_info_toast", "weui_icon_safe_warn");
		$('.weui_toast').css('z-index','10000');
			break;
			case 3:
		weui.Loading.msg('加倍X3',1000, "weui_info_toast", "weui_icon_safe_warn");
		$('.weui_toast').css('z-index','10000');
			break;
		
	}
	
}
/* $.ajax({
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
	}); */
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
function shareCancle(){
	$("#shareArea").removeClass('acitve');	
}
document.addEventListener('touchmove', function(event) {
    //判断条件,条件成立才阻止背景页面滚动,其他情况不会再影响到页面滚动
    if($("#shareArea").hasClass("acitve")){
        event.preventDefault();
    }
    if($("#commentsArea").hasClass("acitve")){
        event.preventDefault();
    }
});
function showShare(){
	$("#shareArea").addClass('acitve');	
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

function hiddenMask(){	
	$("#cover").hide();
	var userId = "${openId}";
	 $.ajax({
		type: 'POST',
		url: "${base}/guanZhu",
		data: {
			userId: userId
		},
		datatype: "json",
		success: function(data) {
			//nothing to do
		}
	});
	}
$(function(){
	var gzFlag = "${gzFlag}";
	if(gzFlag =="0")
	{
		$.ajax({
			type : "POST",
			url : "${base}/getSysTip",
			data:{ tipId:"10"},
			datatype : "json",
			success : function(data)
			{
				var jsonData = eval("("+data+")");
				
				var title=document.getElementById("coverTitle");
				title.innerHTML=jsonData['title'];
				var body=document.getElementById("coverBody");
				body.innerHTML=jsonData['body'];
				$("#cover").show();
			}
		});	
	}
	});
function showMask(){	
	$.ajax({
		type : "POST",
		url : "${base}/getSysTip",
		data:{ tipId:"10"},
		datatype : "json",
		success : function(data)
		{
			var jsonData = eval("("+data+")");
			
			var title=document.getElementById("coverTitle");
			title.innerHTML=jsonData['title'];
			var body=document.getElementById("coverBody");
			body.innerHTML=jsonData['body'];
			$("#cover").show();
		}
	});	
	}
window.onload=hideBox();
</script>
</html>