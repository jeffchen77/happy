<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
    <title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link href="http://cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css" rel="stylesheet">
    <!-- <link href="bootstrap3.3.5/css/bootstrap-theme.min.css" rel="stylesheet"> -->
    <link href="bootstrap3.3.5/css/app.css" rel="stylesheet">
    <link type="text/css" href="http://cdn.bootcss.com/jqueryui/1.11.0/jquery-ui.min.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="http://www.bootcss.com/p/buttons/css/buttons.css ">

    <link rel="stylesheet" href="bootstrap3.3.5/css/myInfoStyle.css" />
	<link rel="stylesheet" type="text/css" href="http://cdn.bootcss.com/font-awesome/4.2.0/css/font-awesome.min.css">
	
    <script src="http://cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>  
    <script type="text/javascript"	src="http://sandbox.runjs.cn/uploads/rs/340/ustg8wvx/weui.js"></script>
<link rel="stylesheet" type="text/css"	href="http://sandbox.runjs.cn/uploads/rs/340/ustg8wvx/weui.css">
<script type="text/javascript"	src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script> 
<script type="text/javascript"	src="http://libs.baidu.com/jquery/1.9.1/jquery.min.js"></script>
   <style>
   .cover {
position:fixed; top: 10.5em; right:3.2em; bottom:10.3em;filter: alpha(opacity=60); background-color: #777;
z-index: 1002; left: 3.2em; display:none;
opacity:1.0; -moz-opacity:1.0;
}
   
   </style>
</head>

<body>
<div class="head">test page</div>
<div class="container">
<div class="row">
<a href="#" class="button button-block button-rounded button-large">创建公众号菜单</a>
</div>
<div class="row">
<a href="http://www.76idea.com/happydev/weixin/baseoauth?action=getAwardIndex" class="button button-block button-rounded button-large">获取奖励</a>
</div>
<div class="row">
<a href="http://www.76idea.com/happydev/findactivity" class="button button-block button-rounded button-large">发现活动</a>
</div>
<div class="row">
<input accept="audio/*" type="file">
<input accept="video/*" type="file">
<input accept="image/*" type="file">
</div>
<div class="row">

   <a href="http://www.76idea.com/happy/testmsg?userId=oxw8iwTNSBnMFnSJ2kz4RPo7V9Bk" >发送结果信息测试${msgret}</a><br />
</div>
<div class="row">

   <a href="javascript:;" onclick="showMask()" >点我显示遮罩层</a><br />
</div>

</div>
<div id="cover" class="cover" onclick="hiddenMask()" style="color:white;">
		<div class="row" style="margin:10px">
		用户提示：
		</div>
		<div class="row" style="margin-right: 15px;margin-left: 15px;">
		上发斯蒂芬斯蒂芬斯蒂芬斯蒂芬是的发送到发送到发送到f法定分三大
		艾弗森地方阿达发送到发送到发送到f阿斯顿发送到发sd
		大法师发送到a
		</div>
</div>
		
		<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" role="dialog" 
   aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog" style="margin: 50px">
      <div class="modal-content">
         <div class="modal-header" style="padding: 5px;">
            <button type="button" class="close" 
               data-dismiss="modal" aria-hidden="true">
                  &times;
            </button>
            <h4 class="h5 modal-title" id="myModalLabel">
             	  关注朕以为
            </h4>
         </div>
         <div class="modal-body" style="padding: 5px;">
          <div style="padding:0px 20px;"><img src="images/qrcode.jpg"></div>
         </div>
      </div><!-- /.modal-content -->
</div><!-- /.modal -->
		
</div>

<footer>
	
	<div class="mune">
    	<a href="${base}/weixin/baseoauth?action=challengIndex" style="text-decoration: none;">
    	<i class="fa fa-paint-brush fa-2x"></i>
        <p>发起</p>
        </a>
    </div>
	
	<div class="mune">
		<a href="#" style="text-decoration: none;">
    	<i class="fa fa-comment fa-2x" style="color: #5bc0de;"></i>
        <p style="color: #5bc0de;">消息</p>
        </a>
    </div>
	<div class="mune">
		<a href="#" data-toggle="modal" data-target="#myModal" style="text-decoration: none;">
    	<i class="fa fa-qrcode fa-2x"></i>
        <p>关注</p>
        </a>
    </div> 
    <div class="mune">
		<a href="${base}/weixin/baseoauth?action=myInfoIndex" style="text-decoration: none;">
    	<i class="fa fa-user fa-2x"></i>
        <p>我</p>
        </a>
    </div>
</footer>
</body>
<script >
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


function showMask(){
	$('body').css("overflow","hidden");
	$("#cover").show();
	}
 function hiddenMask(){
	$('body').css("overflow","visible");
	$("#cover").hide();
	}
$(function(){$('body').css("overflow","hidden");
	$("#cover").show();});

</script>
</html>