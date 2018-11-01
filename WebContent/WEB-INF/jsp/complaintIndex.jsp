<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!doctype html>
<html>
<head>
<title>投诉 </title>
<meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no" />

  <link rel="stylesheet" href="css/commom_complaint.css">
  <link rel="stylesheet" href="css/other_complaint.css">
  		<script src="https://code.jquery.com/jquery.js"></script>
		<script type="text/javascript" src="bootstrap3.3.5/jquery-1.8.3.min.js" charset="UTF-8"></script>
		<link rel="stylesheet" type="text/css" href="http://sandbox.runjs.cn/uploads/rs/340/ustg8wvx/weui.css">
		<script type="text/javascript" src="http://sandbox.runjs.cn/uploads/rs/340/ustg8wvx/weui.js"></script>
<script type="text/javascript">
function insertComplain(activityId,activityOwnerUserId,complaintOwnerUserId){
	var complaintContent = document.getElementById("rp_form_content").value;
	$.ajax({
		url : "${base}/insertComplaint",
		type : 'post',
		data: {activityId:activityId,activityOwnerUserId:activityOwnerUserId,complaintOwnerUserId:complaintOwnerUserId,complaintContent:complaintContent},
		success :function(data){
				if(data == 0){
// 					weui.alert("已发起过投诉，无须重复投诉！");
// 				}else{
					alert("投诉成功！");
					window.history.back(-1);
				}
			
			}
	});
	
};

</script>
</head>
<body style="background-color:#eee;">
 <div class="outSide">
  <div class="registQu registQu2">
    <ul class="dl_kuangQuyu" id="report_form">
    <input id="activityId" type="hidden" value="${obj.activityId}">
    <input id="activityOwnerUserId" type="hidden" value="${obj.activityOwnerUserId}">
    <input id="complaintOwnerUserId" type="hidden" value="${obj.complaintOwnerUserId}">
      <li class="firstLi yj">
        <div class="yiJiank"><textarea id="rp_form_content"  onblur=""  placeholder="输入举报理由，以及被举报人的微信号！"></textarea></div>
      </li>
    </ul>
    <div class="yellowBtn yanZhengbtn"><a href="javascript:void(0);"  ontouchstart="" onclick="insertComplain('${obj.activityId}','${obj.activityOwnerUserId}','${obj.complaintOwnerUserId}')">提交</a></div>
  </div>
</div>
</body>
</html>