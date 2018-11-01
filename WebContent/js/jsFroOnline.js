
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
			var s = $("#exampleInputComment").val();
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
					$
							.ajax({
								url : url,
								type : 'post',
								datatype : "json",
								success : function(data) {
									document
											.getElementById("exampleInputComment").value = "";
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
											+ ' onclick="replyComments(this)">回复</a></div></div></div><div id='+comentId+'ReplyTag'+' class=""><ul></ul></div></div>';
									obj.insertAdjacentHTML("afterEnd", _html);
									weui.Loading.success();

								},
								error : function() {
									weui.alert("微信服务器错误，请重新进入页面！");
								}
							});
				}
			} else {
				var replyCommentBtnId = localStorage
						.getItem('replyCommentBtnId');
				var insertTagId = replyCommentBtnId + 'Tag';
				var commentId = replyCommentBtnId.substr(0,
						replyCommentBtnId.length - 5);
				var touserId = localStorage.getItem('toUserId');
				var url = "${base}/insertAjaxReplycomments?commentId="
						+ commentId + "&openId=${openId}&touserId=" + touserId
						+ "&comments=" + s;
				if (s == "") {
					return;
				}
				$
						.ajax({
							url : url,
							type : 'post',
							datatype : "json",
							success : function(data) {
								document.getElementById("exampleInputComment").value = "";
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
								document.getElementById("footer").style.display = "";
								document.getElementById("comments").style.display = "none";

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
			
			if(document.getElementById("footer").style.display=="none")
				{
				document.getElementById("footer").style.display="";
				document.getElementById("comments").style.display="none";
				}
			else
				{
				document.getElementById("footer").style.display="none";
				document.getElementById("comments").style.display="";
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
						var commentType = $('#exampleInputComment').attr(
								'placeholder');
						if ('请输入评论' != commentType) {
							document.getElementById("footer").style.display = "";
							document.getElementById("comments").style.display = "none";
							localStorage.removeItem('isReplyComments');
							localStorage.removeItem('replyCommentBtnId');
							localStorage.removeItem('toUserId');
							$('#exampleInputComment').attr('placeholder',
									'请输入评论');
						}
					}, 200);
		
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
		
		
		
