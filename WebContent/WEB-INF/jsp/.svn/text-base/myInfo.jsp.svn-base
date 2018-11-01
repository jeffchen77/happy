<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>

	<head>
		<title>个人中心</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="viewport"
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
		<link rel="stylesheet" href="bootstrap3.3.5/css/myInfoStyle.css" />
		<link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css" />
		<link rel="stylesheet" type="text/css" href="http://cdn.bootcss.com/font-awesome/4.2.0/css/font-awesome.min.css">
		<script src="http://libs.baidu.com/jquery/1.9.1/jquery.min.js"></script>
<!-- 		<script type="text/javascript" src="bootstrap3.3.5/jquery-1.8.3.min.js" charset="UTF-8"></script> -->
<!-- 		<script src="js/jquery-1.9.1.js"></script> -->
    <script src="http://cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
		<script type="text/javascript">
			function updateEmail() {
				var Email = document.getElementById("newEmail").value;
				var userId = document.getElementById("userId").value;
				var newEmail = document.getElementById("newEmail").value;
				$.ajax({
					type: 'POST',
					url: "${base}/updateEmail",
					data: {
						userId: userId,
						Email: Email
					},
					datatype: "json",
					success: function(msg) {
						document.getElementById("email").innerHTML = newEmail;
						alert("修改成功！ ");
		            	 
					}
				});
			}
			
			function updateActPassword() {
				var newActPassword = document.getElementById("newActPassword").value;
				var userId = document.getElementById("userId").value;
				if(newActPassword.length <= 4){
					$.ajax({
						type: 'POST',
						url: "${base}/updateActPassWord",
						data: {
							userId: userId,
							secretcode: newActPassword
						},
						datatype: "json",
						success: function(msg) {
							document.getElementById("actPassword").innerHTML = newActPassword;
							$("#pageForActPassword ").toggle();
							alert("修改成功！ ");
						}
					});
				}else{
					alert("请输入4位以内密码！ ");
				}
			}

			function bandPhoneNum() {
				var newPhoneNum = document.getElementById("newPhoneNum").value;
				var userId = document.getElementById("userId").value;
				$.ajax({
					type: 'POST',
					url: "${base}/bandPhoneNum",
					data: {
						userId: userId,
						newPhoneNum: newPhoneNum
					},
					datatype: "json"
				});
			}

			function pageForPhone() {
				$("#pageForPhone").toggle();
			}
			function pageForEmail() {
				$("#pageForEmail ").toggle();
			}
			function pageForActPassword(){
				$("#pageForActPassword ").toggle();
			}
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
		</script>
		<script type="text/javascript">$(document).ready(function() {
			
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
				});
		</script>
		<script type="text/javascript">
			$(document).ready(function() {
				var userId = "${obj.wechatUser.userId}";
				if(userId!=null){
					var url1="${base}/myActivityIndex?userId="+userId+"&ownerOrParter=1";
					var url2="${base}/myActivityIndex?userId="+userId+"&ownerOrParter=2";
					var url3="${base}/myActivityIndex?userId="+userId+"&ownerOrParter=3";
					document.getElementById("sponsoredAct").setAttribute('href', url1);
					document.getElementById("participateAct").setAttribute('href', url2);
					document.getElementById("activityStore").setAttribute('href', url3);
				}
				//设置城池交易流水链接
				var userId = "${obj.wechatUser.userId}";
				if(userId!=null){
					var url="${base}/getTransPointsRecords?userId="+userId+"&pageNumber=1";
					document.getElementById("transPointsRecords").setAttribute('href', url);
				}
				
			});
		</script>
	</head>

	<body  class="m-b"  style="background-color: #f5f5f5;" >
	<div  class="m-b"  style="background-color: #5bc0de;">
				<div class="row" style="padding: 5px; margin-left:0px; margin-right:0px;">
					<div class="col-xs-3 " style="padding-left: 0px;">
						<img id="userImgUrl" class="img-circle" style="width:60px;height:60px;" src="${obj.wechatUser.headImgUrl}" onclick="checkNewUrl()">
					</div>
					<div class="col-xs-8" style="color:white;">
						<div class="row">
							<div class="col-xs-6" style=" ">
								<p class="h6">${obj.wechatUser.nickName}</p>	
								<input id="userId" type="hidden" value="${obj.wechatUser.userId}">							
							</div>
							<div class="col-xs-6" style="padding-left:0px">
								<p class="h6">胜率：${obj.user.forecastAccuracy}</p>
							</div>
						</div>
						<div class="row" >
							<div class="col-xs-6" style=" ">
								<a id="transPointsRecords"><p class="h6"  id="level-display">城池：${obj.userPoints.allPoints-obj.userPoints.lockedPoints}/${obj.userPoints.allPoints}</p></a>
							</div>
							<div class="col-xs-6" style="padding-left:0px">
								<p class="h6" id="level-honest"> </p>								
							</div>
						</div>
					</div>

				</div>
</div>
		<div class="nav mt-0">
			<ul>
				<li >
					<a id="sponsoredAct" style="text-decoration: none;">
					<span class="fa fa-flag-o fa-lg" style="color: #b8b8b8;"></span>
					<span style="font-size: 85%;color:#838383;">发起的活动</span>
					</a>
				</li>
				<li class="pt-line">
					<a id="participateAct" style="text-decoration: none;">
					<span class="fa fa-tasks fa-lg" style="color: #b8b8b8;"></span>
					<span style="font-size: 85%;color:#838383;">参与的活动</span>
					</a>
				</li>
				<li   class="pt-line">
					<a id="activityStore" style="text-decoration: none;">
					<span class="fa fa-star-o fa-lg" style="color: #b8b8b8;"></span>
					<span style="font-size: 85%;color:#838383;">收藏的活动</span>
					</a>
				</li>
				
			</ul>
		</div>

		<section class="mt-1">
			<div class="ps-lt">
				<div class="lt-dsb">
					<p>手机号：<span id="phoneNum">${obj.user.phoneNumber}</span></p>
					<i class="edit-button" onclick="pageForPhone()"></i>
				</div>
				<div id="pageForPhone" style="display: none;">
					<div class="cl-bb input-group col-xs-8" style="margin-top: 0.1rem;">

						<input id="newPhoneNum" style="padding-left: 35.5px;" class="form-control input-sm lt-dsb has-feedback" type="text" placeholder="请输入手机号" value=""  />

						<span class="glyphicon glyphicon-phone form-control-feedback" style="left: 0.1rem;"></span>
						<span class=" input-group-btn">
                      <button class="btn btn-sm btn-info" type="button" style="margin-bottom: 0.55rem" onclick="checkNum()">发送验证码</button>
                    </span>
					</div>
					<div class=" cl-bb input-group">
						<div class="row" style="margin-top: 0.1rem;">
							<div class="col-xs-7">
								<input id="check4Num" class="form-control input-sm lt-dsb" type="text" placeholder="请输入手机验证码" value="" />
								<input id="check4NumFact" class="form-control input-sm lt-dsb" value="" type="hidden" />
							</div>
							<div class="col-xs-4" style="margin-top: 0.1rem;">
								<i class="modifybutton" onclick="check4Num()">校验验证码</i>
							</div>
						</div>

					</div>
					<hr style="width:80%">
				</div>

				<div class="lt-dsb" style="border-top: none;">
					<p>邮箱地址：<span id="email">${obj.user.emailAddress}</span></p>
					<i class="edit-button" onclick="pageForEmail()"></i>
				</div>
				<div id="pageForEmail" class="row" style="display: none; margin-top: 0.1rem;">
					<div class=" col-xs-6">
						<input id="newEmail" type="email" style="padding-left: 35.5px; padding-right: 0;" class="form-control input-sm lt-dsb has-feedback" type="text" placeholder="xxx@163.com"/>
						<span style="left: 0.2rem;" class="glyphicon glyphicon-envelope form-control-feedback "></span>
					</div>
					<div class=" col-xs-4 " style="margin-top: 0.1rem;">
						<i class="modifybutton " onclick="checkEmail()">绑定邮箱</i>
					</div>
				</div>
				
				<div class="lt-dsb" style="border-top: none;">
					<p>活动密码：<span id="actPassword">${obj.user.actPassword}</span></p>
					<i class="edit-button" onclick="pageForActPassword()"></i>
				</div>
				<div id="pageForActPassword" class="row" style="display: none; margin-top: 0.1rem;">
					<div class=" col-xs-6">
						<input id="newActPassword"  style="padding-left: 35.5px; padding-right: 0;" class="form-control input-sm lt-dsb has-feedback" type="text" placeholder=" "/>
						<span style="left: 0.2rem;" class="glyphicon glyphicon-envelope form-control-feedback "></span>
					</div>
					<div class=" col-xs-4 " style="margin-top: 0.1rem;">
						<i class="modifybutton " onclick="updateActPassword()">修改密码</i>
					</div>
				</div>
			</div>
		</section>

		<section class="mt-1 ">
			<div class="ps-lt ">
				<div class="lt-dsb ">
					<a href="${base}/getUserReport?userId=${obj.wechatUser.userId}" style="text-decoration:none;" >
					<p>排行榜</p>
					<i class="arr-right "></i>
					</a>
				</div>
			</div>
		</section>

		<section class="mt-1 ">
			<div class="ps-lt ">
				<div class="lt-dsb ">
				<a href="${base}/toHelp" style="text-decoration:none;" >
					<p>系统帮助</p>
					<i class="arr-right "></i>
					</a>
					
				</div>
			</div>
		</section>
       <div style="height: 60px"></div>
	
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
	<div class="mune">
		<a  href="#" data-toggle="modal" data-target="#myModal" style="text-decoration: none;">
    	<i class="fa fa-envelope fa-2x"></i>
        <p>红包</p>
        </a>
    </div> 
    
    <div class="mune">
		<a href="${base}/myActivityIndex?userId=${obj.wechatUser.userId}&ownerOrParter=1" style="text-decoration: none;">
    	<i class="fa fa-bars fa-2x"></i>
        <p>我的</p>
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
						     alert( "验证码已发送！ " );
					   }
					});
             }else{
            	 alert("请输入正确手机号码！ ");
            	 document.getElementById("newPhoneNum").value = " ";
             }  
         }  
     } 
     </script>
     <script type="text/javascript">
     function check4Num() {  
    	 var check4Num = document.getElementById("check4Num").value;
    	 var check4NumFact = "0000";
         //检查是否是非数字值  
//          if (isNaN(check4Num)) {  
//         	 document.getElementById("check4Num").value = " ";  
//          }  
         if (check4Num != null) {  
            	 var check4NumFact = document.getElementById("check4NumFact").value;
            	 if(check4Num==check4NumFact && check4NumFact != ""){
            		 bandPhoneNum();
            		 alert("验证码校验成功！ ");
            		 document.getElementById("#phoneNum").innerHTML = $("#newPhoneNum").value;
            		 $("#pageForPhone").toggle();
            		 $("#check4Num").value =" ";
            	 }else{
            		 alert("您输入的验证码错误！ ");
            	 }
         }  
     } 
     </script>
     <script type="text/javascript">
     function checkEmail() {  
    	 var newEmail = document.getElementById("newEmail").value;
         var reg = /^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$/
         if (newEmail != null) {  
             if (reg.test(newEmail)) {
            	 updateEmail();
            	 $("#pageForEmail ").toggle();
             }else{
            	 alert("请检查您的邮箱地址！ ");
            	 obj.value = " ";
             }  
         }  
     } 
     if("${obj.activityId}" == "" || "${obj.activityId}" == "null")
    	 {
     	$("#backAct").attr("href","#");
     	$("#backAct").css("background-color","#b8b8b8");
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
</body>
</html>
