<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!doctype html>
<html>
<head>
<title>test</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<script type="text/javascript"  src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js "></script>
<script type="text/javascript"  src="bootstrap3.3.5/jquery-1.8.3.min.js "></script>
</head>
<body>
	<script type="text/javascript">	
	</script>
	<button id="chooseImage" class="btn btn_primary">chooseImage</button>
	<button id="getLocation" class="btn btn_primary">getLocation</button>
	<button id="addcontact" class="btn btn_primary">关注</button>
	<button id="sharetimeline" class="btn btn_primary">分享朋友圈</button>
	<span>${WechatUser.openId}</span>
	<span>${activityId}</span>
	<script type="text/javascript">
	
	</script>
</body>
</html>