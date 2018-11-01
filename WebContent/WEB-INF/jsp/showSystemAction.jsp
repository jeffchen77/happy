<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link
	href="http://cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet" type="text/css" href="http://sandbox.runjs.cn/uploads/rs/340/ustg8wvx/weui.css">
<link rel="stylesheet" type="text/css" href="http://www.bootcss.com/p/bootstrap-datetimepicker/bootstrap-datetimepicker/css/datetimepicker.css">
<script type="text/javascript" src="http://sandbox.runjs.cn/uploads/rs/340/ustg8wvx/weui.js"></script>
<script src="http://libs.baidu.com/jquery/1.9.1/jquery.min.js"></script>
<script src="http://cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<script src="http://www.bootcss.com/p/bootstrap-datetimepicker/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
<title>系统活动列表</title>
<script type="text/javascript">
	function btnClick(actid, win, trname) {
		
		weui.confirm("","请输入理由",function(r)
		{
			if(r==true)
			{
				var dialogComment=$.trim($('#dialog_comment').val());
				var weui_confirm = $(".weui_dialog_confirm");
				if(dialogComment==null || dialogComment=="")
				{
					weui_confirm.find(".weui_dialog_bd").html("<span style='color:red'>理由不能为空哦！！！</span>");
					weui_confirm.show();
					return;
				}
				weui_confirm.find(".weui_dialog_bd").empty();
				document.getElementById("dialog_comment").value = "";
				
		 		$.ajax({
					url : "${base}/doWinOrLoseAction",
					type : 'POST',
					async : true,
					data: {actId: actid, winflag: win, msg:dialogComment},
					dataType : 'json',
					success : function(data) {
						if ("1" == data) {
							var mainbody = document.getElementById('mainbody');
							var child = document.getElementById(trname);
							mainbody.removeChild(child);
						}
					}
				}); 
			}
		});
	}
	
	function showDialog()
	{
		var mydialog = $("#mydialog");
		mydialog.show();
	}
	
	function cancer()
	{
		var mydialog = $("#mydialog");
		mydialog.hide();
	}
	
	function showCanserDialog()
	{
		//得到过期的活动
		$.ajax({
			url : "${base}/getOverdueActivity",
			type : 'get',
			success :
					function(data)
					{
				        var iHtml = "";
						var arrList = eval("("+data+")");
						if(arrList.length < 1)
						{
							iHtml +="<tr><td colspan='5' style='text-align:center;'>"
							iHtml += "<span style='color:red;'>没有过期的活动</span>";
							iHtml += "</td></tr>"
							document.getElementById("cancerBody").innerHTML=iHtml;
						}
						else
						{
							for(var i=0; i<arrList.length; i++)
							{
								var act = arrList[i];
								iHtml += "<tr id='ctr"+i+"'>";
								iHtml += "<td style='width:40%;'>";
								iHtml += act.acttitle;
								iHtml += "</td>";
								iHtml += "<td style='width:10%;'>";
								iHtml += act.actpoints;
								iHtml += "</td>";
								iHtml += "<td style='width:20%;'>";
								iHtml += act.actpublishtime;
								iHtml += "</td>";
								iHtml += "<td style='width:10%; color:red;'>";
								iHtml += act.duedays;
								iHtml += "</td>";
								iHtml += "<td style='width:20%;'>";
								iHtml += "<button type='button' class='btn btn-default btn-xs' onclick=\"mCloseActivity(\'ctr"+i+"\',\'"+act.actid+"\')\">结束活动</button>";
								iHtml += "</td>";
								iHtml += "</tr>";
							}
							document.getElementById("cancerBody").innerHTML=iHtml;
						}
						var mydialog = $("#canserDialog");
						mydialog.show();
					}
			 });
	}
	
	function mCloseActivity(ctrid, actid)
	{
		$.ajax({
			url : "${base}/stopOverdueActivity",
			type : 'post',
			data: {actid:actid},
			datatype: "json",
			success :function(data){
				if ("1" == data) {
					var mainbody = document.getElementById('cancerBody');
					var child = document.getElementById(ctrid);
					mainbody.removeChild(child);
				}
				}
		});
	}
	
	function canserClose()
	{
		var mydialog = $("#canserDialog");
		mydialog.hide();
	}
	
	
	
	// 	显示当前时间的函数

        function getTime()
        {
            var now = new Date();
            document.getElementById('actdeadline').value = now.getFullYear()
                                             + "-" + (now.getMonth() + 1)
                                             + "-" + (now.getDate()+3)
                                             + " " + now.getHours()
                                             + ":" + now.getMinutes()
                                             + ":" + now.getSeconds();
        document.getElementById('publishTime').value = now.getFullYear()
                                             + "-" + (now.getMonth() + 1)
                                             + "-" + (now.getDate()+5)
                                             + " " + "00:00:00";
                                             
        }
	
	function formSubmit()
	{
		var mydialog = $("#mydialog");
		var actDesc = $("#actdesc").val();
		var actpunish = $("#actpunish").val();
		var actdeadline = $("#actdeadline").val();
		var partNum = $("#partNum").val();
		var publishTime = $("#publishTime").val();
		var stackNum = $("#stackNum").val();
		var yuanWenUrl = $("#yuanWenUrl").val();
		var wailianTitle = $("#wailianTitle").val();
		var wailianUrl = $("#wailianUrl").val();
		var activitytype=$("#activitytype").val();
		if(actDesc=="" || actpunish=="" || actdeadline=="" || partNum=="" || publishTime=="" || stackNum=="")
		{
			alert("请填完必填选项");
			return;
		}
		if(!partNum.match('^[0-9]*$'))
		{
			alert("参与人数请输入数字");
			return;
		}
		if(!stackNum.match('^[0-9]*$'))
		{
			alert("城池数量请输入数字");
			return;
		}
		if(activitytype=="请选择"){
		alert("请选择活动类型");
		return;
		}
		mydialog.hide();
		weui.Loading.show("处理中");
		$.ajax({
			url : "${base}/insertSysAct",
			type : 'POST',
			async : true,
			data: {actDesc: actDesc, actpunish: actpunish, actdeadline:actdeadline, partNum:partNum,publishTime:publishTime,stackNum:stackNum,yuanWenUrl:yuanWenUrl,wailianTitle:wailianTitle,wailianUrl:wailianUrl,activitytype:activitytype},
			dataType : 'json',
			success : function(data) {
				weui.Loading.hide();
				$("#actdesc")[0].value=null;
				$("#actpunish")[0].value=null;
				$("#actdeadline")[0].value=null;
				$("#partNum")[0].value=null;
				$("#publishTime")[0].value=null;
				$("#stackNum")[0].value=null;
				$("#yuanWenUrl")[0].value=null;
				$("#wailianTitle")[0].value=null;
				$("#wailianUrl")[0].value=null;
				$("activitytype")[0].value="请选择";
			}
		}); 
	}
/* 	$(function(){
		$("#publishTime").datetimepicker({format: 'yyyy-mm-dd hh:ii:ss', forceParse: true});
		$("#actdeadline").datetimepicker({format: 'yyyy-mm-dd hh:ii:ss', forceParse: true});
	}); */
	
	function sendComments(actid) {
		var commentsDialog = $("#commentsDialog");
		$("#hiddenAct")[0].value = actid;
		commentsDialog.show();
	}
	
	function cancerComments()
	{
		var commentsDialog = $("#commentsDialog");
		commentsDialog.hide();
	}
	
	function formSubmitComments()
	{
		var dialogComment=$.trim($('#sys_comment').val());
		if(dialogComment==null || dialogComment=="")
		{
			alert("系统评论消息不能为空!");
			return;
		}
		var act = $("#hiddenAct").val();
		$.ajax({
			url : "${base}/insertAjaxcomments?activityId="+act+"&openId=systemadmin&comments="+encodeURIComponent(dialogComment),
			type : 'POST',
			async : true,
			dataType : 'json',
			success : function(data) {
				cancerComments();
			}
		}); 
	}
</script>
</head>
<body onload="getTime()">
	<div class="container">
		<c:if test="${acts.size()>0}">
			<div class="row-fluid" style="margin-top:30px;">
				<div class="span12">
					<ul class="nav nav-tabs">
						<li class="active">
							<a href="#">活动列表</a>
						</li>
						<li>
							<a href="#" onclick="showCanserDialog()">过期活动</a>
						</li>
						<li>
							<a href="#" onclick="showDialog()">发起活动</a>
						</li>
					</ul>
				</div>
			</div>
			<table class="table table-bordered table-striped">
				<caption style="text-align: center; margin-top: 10px;">
					<b>系统活动列表</b>
				</caption>
				<thead>
					<tr>
						<th>活动描述</th>
						<th>活动奖惩</th>
						<th>城池数量</th>
						<th>活动类型</th>
						<th>创建时间</th>
						<th>发布时间</th>
						<th>结果发布</th>
					</tr>
				</thead>
				<tbody id="mainbody">
					<c:forEach var="act" varStatus="preIndex" items="${acts}">
						<tr id="tr${preIndex.index}">
							<td>${act.activityDesc}</td>
							<td>${act.activityStake}</td>
							<td>${act.stakePoints}</td>
							<c:if test="${act.templateId=='2'}"> <td>股票</td></c:if>
						    <c:if test="${act.templateId=='1'}"> <td>热点</td></c:if>
						     <c:if test="${act.templateId=='3'}"> <td>财经</td></c:if>
<!-- 						      <c:if test="${act.templateId==null}"> <td>热点</td></c:if> -->
<!-- 						      <c:if test="${act.templateId==' '}"> <td>热点</td></c:if> -->
						       <c:if test="${act.templateId!='3' and act.templateId!='2' and act.templateId!='1'}"> <td>热点</td></c:if>
							
							<td>${act.createTime}</td>
							<td>${act.publishDate}</td>
							<td><button type="button" class="btn btn-default btn-xs" onclick="btnClick('${act.activityId}', 2, 'tr${preIndex.index}')">
									支持胜</button>
								<button type="button" class="btn btn-default btn-xs" onclick="btnClick('${act.activityId}', 1, 'tr${preIndex.index}')">
									反对胜</button>
								<button type="button" class="btn btn-default btn-xs" onclick="sendComments('${act.activityId}')">
									发评论</button></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>
		<c:if test="${acts.size()<=0}">
			no record
		</c:if>
	</div>
	<div class="weui_dialog_confirm" id="dialog1" style="display: none;">
	    <div class="weui_mask"></div>
	    <div class="weui_dialog">
	        <div class="weui_dialog_hd"><strong class="weui_dialog_title">提示</strong></div>
	        <div class="weui_dialog_input" style="padding-top: 10px;"><textarea id="dialog_comment" rows="3" class="form-control" placeholder="请输入该活动胜或者败的理由，然后会在消息模块中体现!"></textarea></div>
	        <div class="weui_dialog_bd">确定支持？决定后别忘了点击右上角和朋友分享你的态度！记住了喔</div>
	        <div class="weui_dialog_ft">
	            <a href="javascript:;" class="weui_btn_dialog default">取消</a>
	            <a href="javascript:;" class="weui_btn_dialog primary">确定</a>
	        </div>
	    </div>
	</div>
	
	<div id="mydialog" style="display: none;">
		<div class="weui_mask"></div> 
		<div class="weui_dialog">			
	        <div class="weui_dialog_hd"><strong class="weui_dialog_title">发起活动表单</strong></div>
	        <div class="weui_dialog_bd">
		        <form class="form-inline" role="form">		   
				  
				  <div class="form-group" style="width:100%;margin-bottom:5px;">
				    <div class="input-group" style="width:100%;">
				      <div class="input-group-addon">活动描述<span style="color:red;">*</span></div>
				      <textarea class="form-control" id="actdesc" rows="2" placeholder="请输入活动描述"></textarea>
				    </div>
				  </div>
				  
				  <div class="form-group" style="width:100%;margin-bottom:5px;">
				    <div class="input-group" style="width:100%;">
				      <div class="input-group-addon">活动奖惩<span style="color:red;">*</span></div>
				      <textarea class="form-control" id="actpunish" rows="2">朕赌上5座城池.</textarea>
				    </div>
				  </div>
				  
				  <div class="form-group" style="width:100%;margin-bottom:5px;">
				    <div class="input-group" style="width:100%;">
				      <div class="input-group-addon">截止日期<span style="color:red;">*</span></div>
				      <input type="text" class="form-control" id="actdeadline" value="2016-12-12 00:00:00"/>
				    </div>
				  </div>
				  
				  <div class="form-group" style="width:100%;margin-bottom:5px;">
				    <div class="input-group" style="width:100%;">
				      <div class="input-group-addon">参与人数<span style="color:red;">*</span></div>
				      <input type="text" class="form-control" id="partNum" placeholder="20"/>
				    </div>
				  </div>
				  
				  <div class="form-group" style="width:100%;margin-bottom:5px;">
				    <div class="input-group" style="width:100%;">
				      <div class="input-group-addon">发布日期<span style="color:red;">*</span></div>
				      <input type="text" class="form-control" id="publishTime" value="2016-12-12 00:00:00"/>
				    </div>
				  </div>
				  
				  <div class="form-group" style="width:100%;margin-bottom:5px;">
				    <div class="input-group" style="width:100%;">
				      <div class="input-group-addon">城池数量<span style="color:red;">*</span></div>
				      <input type="text" class="form-control" id="stackNum" placeholder="5"/>
				    </div>
				  </div>
				  
				  <div class="form-group" style="width:100%;margin-bottom:5px;">
				    <div class="input-group" style="width:100%;">
				      <div class="input-group-addon">原文地址<span style="color:gray;">*</span></div>
				      <input type="text" class="form-control" id="yuanWenUrl" placeholder="http://www.baidu.com"/>
				    </div>
				  </div>
				  
				  <div class="form-group" style="width:100%;margin-bottom:5px;">
				    <div class="input-group" style="width:100%;">
				      <div class="input-group-addon">外联标题<span style="color:gray;">*</span></div>
				      <input type="text" class="form-control" id="wailianTitle" placeholder="苹果7发布会"/>
				    </div>
				  </div>
				  
				  <div class="form-group" style="width:100%;margin-bottom:5px;">
				    <div class="input-group" style="width:100%;">
				      <div class="input-group-addon">外联图片<span style="color:gray;">*</span></div>
				      <input type="text" class="form-control" id="wailianUrl" placeholder="http://www.baidu.com"/>
				    </div>
				  </div>
				   <div class="form-group" style="width:100%;margin-bottom:5px;">
				    <div class="input-group" style="width:100%;">
				      <div class="input-group-addon">活动类型<span style="color:gray;">*</span></div>
				      <select  class="form-control" id="activitytype" placeholder="请选择" > 
				      <option value="请选择">请选择</option> 
				        <option value="股票">股票</option> 
				       <option value="财经">财经</option>
				        <option value="热点">热点</option>
				        </select>				    
				    </div>
				  </div> 	  				  
				</form>
	        </div>
	        <div class="weui_dialog_ft">
	            <!-- <a href="javascript:;" class="weui_btn_dialog default" onclick="cancer()">取消</a>
	            <a href="javascript:;" class="weui_btn_dialog primary" onclick="formSubmit()">确定</a> -->
	            <a href="javascript:;" class="weui_btn_dialog default" style="float:left;width:50%;align:center;" onclick="cancer()">取消</a>
	            <a href="javascript:;" class="weui_btn_dialog primary" style="float:right;width:50%;align:center;" onclick="formSubmit()">确定</a>
	        </div>
	 	</div>
	 </div>
	 
	<div class="weui_loading_toast"style="display: none;z-index:10000">
	<div class="weui_mask"></div>
		<div class="weui_toast">
			<div class="weui_loading">
				<div class="weui_loading_leaf weui_loading_leaf_0"></div>
				<div class="weui_loading_leaf weui_loading_leaf_1"></div>
				<div class="weui_loading_leaf weui_loading_leaf_2"></div>
				<div class="weui_loading_leaf weui_loading_leaf_3"></div>
				<div class="weui_loading_leaf weui_loading_leaf_4"></div>
				<div class="weui_loading_leaf weui_loading_leaf_5"></div>
				<div class="weui_loading_leaf weui_loading_leaf_6"></div>
				<div class="weui_loading_leaf weui_loading_leaf_7"></div>
				<div class="weui_loading_leaf weui_loading_leaf_8"></div>
				<div class="weui_loading_leaf weui_loading_leaf_9"></div>
				<div class="weui_loading_leaf weui_loading_leaf_10"></div>
				<div class="weui_loading_leaf weui_loading_leaf_11"></div>
			</div>
		<p class="weui_toast_content"></p>
		</div>
	</div>
	 
	 <div id="commentsDialog" style="display: none;">
	    <div class="weui_mask"></div>
	    <div class="weui_dialog">
	        <div class="weui_dialog_hd"><strong class="weui_dialog_title">系统评论</strong></div>
	        <div class="weui_dialog_input" style="padding-top: 10px;"><textarea id="sys_comment" rows="3" class="form-control" placeholder="请输入系统消息！"></textarea></div>
	        <div class="weui_dialog_bd"><input type="hidden" id="hiddenAct"/></div>
	        <div class="weui_dialog_ft">
	            <a href="javascript:;" class="weui_btn_dialog default" style="float:left;width:50%;align:center;" onclick="cancerComments()">取消</a>
	            <a href="javascript:;" class="weui_btn_dialog primary" style="float:right;width:50%;align:center;" onclick="formSubmitComments()">确定</a>
	        </div>
	    </div>
	</div>
	
	
	<div id="canserDialog" style="display: none;">
		<div class="weui_mask"></div> 
		<div class="weui_dialog" style="height: 80%;width:60%; overflow-y:scroll;">			
	        <div class="weui_dialog_hd"><strong class="weui_dialog_title">过期活动列表</strong></div>
	        <div class="weui_dialog_bd">
		      	<table class="table table-bordered table-striped">
				<thead>
					<tr>
						<th>活动描述</th>
						<th>城池数量</th>
						<th>创建时间</th>
						<th>过期天数</th>
						<th></th>
					</tr>
				</thead>
				<tbody id="cancerBody">
					
				</tbody>
			</table>
	        </div>
	        <div class="weui_dialog_ft">
	            <a href="javascript:;" class="weui_btn_dialog primary" style="align:center;" onclick="canserClose()">关闭</a>
	        </div>
	 	</div>
	 </div>
</body>
</html>