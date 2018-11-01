<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link rel="stylesheet" type="text/css" href="css/pullToRefresh.css">
<link href="http://cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css" rel="stylesheet">
<link href="bootstrap3.3.5/css/app.css" rel="stylesheet">
<link rel="stylesheet" href="bootstrap3.3.5/css/myInfoStyle.css" />
<link rel="stylesheet" type="text/css" href="css/task.css?random=3.1">
<link rel="stylesheet" type="text/css" href="http://cdn.bootcss.com/font-awesome/4.2.0/css/font-awesome.min.css">
<script type="text/javascript"	src="js/iscroll.js"></script>
<script type="text/javascript"	src="js/pullToRefresh.js"></script>
<script src="http://libs.baidu.com/jquery/1.9.1/jquery.min.js"></script>
<script src="http://cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<title>轻松评</title>
<script type="text/javascript">
	function showStockMarket(){
// 		alert("展示股市内容！");
$('#tabs').children().removeClass('tab-active');
$('#tabs').children().eq(0).addClass('tab-active');
document.getElementById("typeId").value = "2";
		getAndPrepareContent(2);
	}
	
	function showFinanceMarket(){
// 		alert("展示财经内容！");
$('#tabs').children().removeClass('tab-active');
$('#tabs').children().eq(1).addClass('tab-active');
document.getElementById("typeId").value = "3";
		getAndPrepareContent(3);
		
	}
	
	function showHotEvents(){
// 		alert("展示热点内容！");
$('#tabs').children().removeClass('tab-active');
$('#tabs').children().eq(2).addClass('tab-active');
document.getElementById("typeId").value = "1";
		getAndPrepareContent(1);
	}
	
	function getAndPrepareContent(type){
		var userId = "${userId}";
		var url = "${base}/loadMore?userId=" +userId+ "&type=" + type+ "&page=0";
		var page = 0;
		$.ajax({
			type : "POST",
			url : url,
			datatyep : "json",
			success : function(data)
			{
			var divContent = document.getElementById("divContent");
			divContent.innerHTML = '';
			var jsonData = eval("("+data+")");
			for(var i=0; i<jsonData.length;i++)
			{
				var htmlStr = "";
				var iData = jsonData[i];
				
				//htmlStr += "<div class='container-fluid' style='background: white; margin-bottom:10px;' onclick='activityDetail('"+iData.activity_id+"')'>";
				var container = document.createElement("div");
				container.className = "container-fluid";
				container.style.cssText = "background: white; margin-bottom:10px;";
				container.id = i;
				//container.setAttribute("onclick", "activityDetail('"+iData.activity_id+"')");
				
				//htmlStr += "<div class='row' style='padding-bottom:5px;padding-top:5px;'>";
				var row1 = document.createElement("div");
				row1.className = "row";
				row1.style.cssText = "padding-bottom:5px;padding-top:5px;";
				
				//htmlStr += "<div class='col-xs-12'>";
				var col1 = document.createElement("div");
				col1.className = "col-xs-10";
				
				//htmlStr += "<img src='"+iData.headimgurl+"' class='img-circle' style='width: 30px; height: 30px;' />";
				var imgheader = document.createElement("img");
				imgheader.className = "img-circle";
				imgheader.style.cssText = "width: 30px; height: 30px;";
				//imgheader.setAttribute("src", "'"+iData.headimgurl+"'");
				imgheader.src = iData.headimgurl;
				
				//htmlStr += "<span style='font-size: 80%;'>"+iData.nickname+"</span>";
				var span1 = document.createElement("span");
				span1.style.cssText = "font-size: 80%;";
				span1.innerText = " "+iData.nickname+" ";
				
				//htmlStr += "<span style='font-size: 80%;'>"+iData.create_time+"</span>";
				var span2 = document.createElement("span");
				span2.style.cssText = "font-size: 80%;";
				span2.innerText = iData.create_time;
				
				//htmlStr += "</div>";
				col1.appendChild(imgheader);
				col1.appendChild(span1);
				col1.appendChild(span2);
				
				var col12;
				if(iData.isGz!=-1)
				{
					col12 = document.createElement("div");
					col12.className = "col-xs-1";
					col12.setAttribute("onclick", "gzOrNot('${userId}','"+iData.activity_id+"')");
					if(iData.isGz==1)
					{
						var vi1 = document.createElement("i");
						vi1.className = "fa fa-star fa-lg";
						vi1.style.cssText = "margin-left:-5px;color:#EE7600;";
						vi1.id="gz"+iData.activity_id;
						col12.appendChild(vi1);
					}
					else if(iData.isGz==0)
					{
						var vi2 = document.createElement("i");
						vi2.className = "fa fa-star fa-lg";
						vi2.style.cssText = "margin-left:-5px;color:gray;";
						vi2.id="gz"+iData.activity_id;
						col12.appendChild(vi2);
					}
				}
				//htmlStr += "</div>";
				row1.appendChild(col1);
				var colblank = document.createElement("div");
				colblank.className = "col-xs-1";
				row1.appendChild(colblank);
				if(iData.isGz!=-1)
				{
					row1.appendChild(col12);
				}
				container.appendChild(row1);
				
				//htmlStr += "<div class='row' style='padding-bottom:5px;'>";
				var srDiv = document.createElement("div");
				srDiv.setAttribute("onclick", "activityDetail('"+iData.activity_id+"')");
				
				var row2 = document.createElement("div");
				row2.className = "row";
				row2.style.cssText = "padding-bottom:5px;";
				
				//htmlStr += "<div class='col-xs-12'>";
				var col2 = document.createElement("div");
				col2.className = "col-xs-12";
				
				//htmlStr += "<span style='font-size: 100%;'><b>"+iData.activity_desc+"</b></span>";
				var span2 = document.createElement("span");
				span2.style.cssText = "font-size: 100%;";
				var b = document.createElement("b");
				b.innerText = iData.activity_desc;
				span2.appendChild(b);
				
				//htmlStr += "</div>";
				col2.appendChild(span2);
				
				//htmlStr += "</div>";
				row2.appendChild(col2);
				srDiv.appendChild(row2);
				
				//htmlStr += "<div class='row' style='padding-bottom:8px;'>";
				var row3 = document.createElement("div");
				row3.className = "row";
				row3.style.cssText = "padding-bottom:8px;";
				
				//htmlStr += "<div class='col-xs-12'>";
				var col3 = document.createElement("div");
				col3.className = "col-xs-12";
				
				//htmlStr += "<span style='font-size: 80%;'>"+iData.activity_stake+"</span>";
				var span3 = document.createElement("span");
				span3.style.cssText = "font-size: 80%;";
				span3.innerText = iData.activity_stake;
				
				col3.appendChild(span3);
				row3.appendChild(col3);
				srDiv.appendChild(row3);
				
				//htmlStr += "<div class='row' style='padding-bottom:5px;'>";
				var row4 = document.createElement("div");
				row4.className = "row";
				row4.style.cssText = "padding-bottom:5px;";
				
				//htmlStr += "<div class='col-xs-12'>";
				var col4 = document.createElement("div");
				col4.className = "col-xs-12";
				
				if(iData.parimg.length>0)
				{
					//htmlStr += "<span style='font-size: 80%; margin-right:6px;'>已有</span>";
					var span4 = document.createElement("span");
					span4.style.cssText = "font-size: 80%; margin-right:6px;";
					span4.innerText = "已有";
					col4.appendChild(span4);
					
					for(var j=0; j<iData.parimg.length; j++)
					{
						//htmlStr += "<img src='"+iData.parimg[j]+"' class='img-circle' style='width: 25px; height: 25px; margin-left:-6px;'/>";
						var imgtemp = document.createElement("img");
						imgtemp.className = "img-circle";
						imgtemp.style.cssText = "width: 25px; height: 25px; margin-left:-6px;";
						//imgtemp.setAttribute("src", "'"+iData.parimg[j]+"'");
						imgtemp.src = iData.parimg[j];
						col4.appendChild(imgtemp);
					}
					//htmlStr += "<span style='font-size: 80%;'>参与</span>";
					var span5 = document.createElement("span");
					span5.style.cssText = "font-size: 80%;";
					span5.innerText = "参与";
					col4.appendChild(span5);
				}
				else
				{
					//htmlStr += "<span style='font-size: 80%; margin-right:6px;'>无人参与</span>";
					var span6 = document.createElement("span");
					span6.style.cssText = "font-size: 80%; margin-right:6px;";
					span6.innerText = "无人参与";
					col4.appendChild(span6);
				}
				//htmlStr += "</div>";
				row4.appendChild(col4);
				//htmlStr += "</div>";
				srDiv.appendChild(row4);
				
				container.appendChild(srDiv);
				//htmlStr += "</div>";
				divContent.appendChild(container);
				//divContent.innerHTML = vvContent.innerHTML + htmlStr; 
			}
			wrapper.refresh();
			var iData = jsonData[0];
			if(iData.template_id == 2 && page == 0){
				document.getElementById("0").style.background = "#CCDDFF";
				document.getElementById("1").style.background = "#CCDDFF";
			}
			document.getElementById("pageId").value = page;
		}
		});
	}
</script>
</head>
<body style="display:none">
<ul class="navHeader" id="tabs">
				<li class="navTab tab-active" style="width: 3.75rem;" onclick="showStockMarket()">
					<span>股市</span>
				</li>
				<li onclick="showFinanceMarket()" style="width: 3.75rem;" class="navTab">
					<span>财经</span>
				</li>
	<!-- 			<li  onclick="showHotEvents()" class="navTab">
					<span>热点</span>
				</li> -->
				
			</ul> 
			<div  style="margin-top: 1.1rem;">
		 <div>
			<%-- <c:choose>
				<c:when test="${unreadMes!=null && countOfUnread != 0 }">
					<div class="replyBanner" style="margin-bottom: 0.05rem;">
						<div  onclick="goToListOfUnread('${unreadMes.participateUserId}')">
							<div align="right" class="col-xs-2">
								<img class="img-circle" style="width:30px;height:30px;" src="${unreadMes.replyUserheadImgUrl}">
							</div>
							<div align="left" class="col-xs-8">
								<span>回复了你参与的活动！</span>
							</div>
							<div align="center" class="col-xs-2" style="padding-top: 5px;">
							<span class="fa-stack fa-lg" aria-hidden="true" style="line-height: 1.4em;">
					          <i class="fa fa-circle text-danger" style="font-size:1.4em"></i>
					          <i class="fa  fa-stack-1x">${countOfUnread}</i>
					        </span>
							</div>
						</div>
					</div>
				</c:when>
				<c:otherwise>
				<div ></div>
				</c:otherwise>
			</c:choose> --%>
</div>


	
 	<input id="pageId" name="page" type="text" value="0" hidden="hidden"/>
	<input id="typeId" name="type" type="text" value="${typeId}" hidden="hidden"/> 	
<div id="wrapper">
	<div id="divContent">
	<c:if test="${actsOfWeekAndDay.size()>0}">
		<c:forEach var="act" items="${actsOfWeekAndDay}">
			<div class="container-fluid" style="background: #CCDDFF; margin-bottom:10px;">
				<div class="row" style="padding-bottom:5px;padding-top:5px;">
					<div class="col-xs-10">
						<img src="${act['headimgurl']}" class="img-circle" style="width: 30px; height: 30px;" />
						<span style="font-size: 80%;">${act['nickname']}</span>
						<span style="font-size: 80%;">${act['create_time']}</span>
					</div>
					<div class="col-xs-1"></div>
					<c:if test="${act['isGz']!=-1}">
						<div class="col-xs-1" onclick="gzOrNot('${userId}','${act['activity_id']}')">
							<c:if test="${act['isGz']==1}">
								<i class="fa fa-star fa-lg" style="margin-left:-5px; color:#EE7600;" id="gz${act['activity_id']}"></i>
							</c:if>
							<c:if test="${act['isGz']==0}">
								<i class="fa fa-star fa-lg" style="margin-left:-5px; color:gray;" id="gz${act['activity_id']}"></i>
							</c:if>
						</div>
					</c:if>
				</div>
				<div onclick="activityDetail('${act['activity_id']}')">
				<div class="row" style="padding-bottom:5px;">
					<div class="col-xs-12">
						<c:choose>
							<c:when test="${act['title_back_news'] !=null && act['title_back_news'] != '' }">
								<span style="font-size: 100%;"><b>${act['title_back_news']}</b></span>
							</c:when>
							<c:otherwise>
								<span style="font-size: 100%;"><b>${act['activity_desc']}</b></span>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				
				<div class="row" style="padding-bottom:8px;">
					<div class="col-xs-12">
						<span style="font-size: 80%;">${act['activity_stake']}</span>
					</div>
				</div>
				
				<div class="row" style="padding-bottom:5px;">
					<div class="col-xs-12">
						<c:if test="${act['parimg'].size()>0}">
							<span style="font-size: 80%; margin-right:6px;">已有</span>
							<c:forEach var="usrimg" items="${act['parimg']}">
								<img src="${usrimg}" class="img-circle" style="width: 25px; height: 25px; margin-left:-6px;"/>
							</c:forEach>
							<span style="font-size: 80%;">参与</span>
						</c:if>
						<c:if test="${act['parimg'].size()<=0}">
							<span style="font-size: 80%; margin-right:6px;">无人参与</span>
						</c:if>
					</div>
				</div>
				</div>
			</div>
		</c:forEach>
		</c:if>
	<c:if test="${acts.size()>0}">
		<input id="nextId" type="text" value="" hidden="hidden"/>
		<c:forEach var="act" items="${acts}" >
			<div class="container-fluid" style="background: white; margin-bottom:10px;">
				<div class="row" style="padding-bottom:5px;padding-top:5px;">
					<div class="col-xs-10">
						<img src="${act['headimgurl']}" class="img-circle" style="width: 30px; height: 30px;" />
						<span style="font-size: 80%;">${act['nickname']}</span>
						<span style="font-size: 80%;">${act['create_time']}</span>
					</div>
					<div class="col-xs-1"></div>
					<c:if test="${act['isGz']!=-1}">
						<div class="col-xs-1" onclick="gzOrNot('${userId}','${act['activity_id']}')">
							<c:if test="${act['isGz']==1}">
								<i class="fa fa-star fa-lg" style="margin-left:-5px; color:#EE7600;" id="gz${act['activity_id']}"></i>
							</c:if>
							<c:if test="${act['isGz']==0}">
								<i class="fa fa-star fa-lg" style="margin-left:-5px; color:gray;" id="gz${act['activity_id']}"></i>
							</c:if>
						</div>
					</c:if>
				</div>
				<div onclick="activityDetail('${act['activity_id']}')">
				<div class="row" style="padding-bottom:5px;">
					<div class="col-xs-12">
						<c:choose>
							<c:when test="${act['title_back_news'] !=null && act['title_back_news'] != '' }">
								<span style="font-size: 100%;"><b>${act['title_back_news']}</b></span>
							</c:when>
							<c:otherwise>
								<span style="font-size: 100%;"><b>${act['activity_desc']}</b></span>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				
				<div class="row" style="padding-bottom:8px;">
					<div class="col-xs-12">
						<span style="font-size: 80%;">${act['activity_stake']}</span>
					</div>
				</div>
				
				<div class="row" style="padding-bottom:5px;">
					<div class="col-xs-12">
						<c:if test="${act['parimg'].size()>0}">
							<span style="font-size: 80%; margin-right:6px;">已有</span>
							<c:forEach var="usrimg" items="${act['parimg']}">
								<img src="${usrimg}" class="img-circle" style="width: 25px; height: 25px; margin-left:-6px;"/>
							</c:forEach>
							<span style="font-size: 80%;">参与</span>
						</c:if>
						<c:if test="${act['parimg'].size()<=0}">
							<span style="font-size: 80%; margin-right:6px;">无人参与</span>
						</c:if>
					</div>
				</div>
				</div>
			</div>
		</c:forEach>
		</c:if>
	</div>

</div>	
			</div>
			


<footer style="z-index:2;">
	<div class="mune">
		<a href="${base}/weixin/baseoauth?action=toListOfUnread" style="text-decoration: none;">
    	<i class="fa fa-bullhorn fa-2x"></i>
        <p>讨论</p>
        </a>
    </div>
	
	<div class="mune">
		<a href="${base}/myActivityIndex?userId=${userId}&ownerOrParter=1" style="text-decoration: none;">
    	<i class="fa fa-bars fa-2x"></i>
        <p>我的</p>
        </a>
    </div>
        <div class="mune">
			<a href="${base}/getUserReport?userId=${userId}" style="text-decoration: none;">
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

</script>
</body>

<script>
refresher.init({
	id:"wrapper",                                                         
	pullUpAction:LoadMore 																			
	});																																							
function LoadMore() {
	var page = parseInt(document.getElementById("pageId").value) + 1;
	var type = document.getElementById("typeId").value;
	$.ajax({
		type : "POST",
		url : "${base}/loadMore",
		data: {page:page,userId:'${userId}',type:type},
		datatyep : "json",
		success : function(data)
		{
			var divContent = document.getElementById("divContent");
			var jsonData = eval("("+data+")");
			for(var i=0; i<jsonData.length;i++)
			{
				var htmlStr = "";
				var iData = jsonData[i];
				
				//htmlStr += "<div class='container-fluid' style='background: white; margin-bottom:10px;' onclick='activityDetail('"+iData.activity_id+"')'>";
				var container = document.createElement("div");
				container.className = "container-fluid";
				container.style.cssText = "background: white; margin-bottom:10px;";
			
				//container.setAttribute("onclick", "activityDetail('"+iData.activity_id+"')");
				
				//htmlStr += "<div class='row' style='padding-bottom:5px;padding-top:5px;'>";
				var row1 = document.createElement("div");
				row1.className = "row";
				row1.style.cssText = "padding-bottom:5px;padding-top:5px;";
				
				//htmlStr += "<div class='col-xs-12'>";
				var col1 = document.createElement("div");
				col1.className = "col-xs-10";
				
				//htmlStr += "<img src='"+iData.headimgurl+"' class='img-circle' style='width: 30px; height: 30px;' />";
				var imgheader = document.createElement("img");
				imgheader.className = "img-circle";
				imgheader.style.cssText = "width: 30px; height: 30px;";
				//imgheader.setAttribute("src", "'"+iData.headimgurl+"'");
				imgheader.src = iData.headimgurl;
				
				//htmlStr += "<span style='font-size: 80%;'>"+iData.nickname+"</span>";
				var span1 = document.createElement("span");
				span1.style.cssText = "font-size: 80%;";
				span1.innerText = " "+iData.nickname+" ";
				
				//htmlStr += "<span style='font-size: 80%;'>"+iData.create_time+"</span>";
				var span2 = document.createElement("span");
				span2.style.cssText = "font-size: 80%;";
				span2.innerText = iData.create_time;
				
				//htmlStr += "</div>";
				col1.appendChild(imgheader);
				col1.appendChild(span1);
				col1.appendChild(span2);
				
				var col12;
				if(iData.isGz!=-1)
				{
					col12 = document.createElement("div");
					col12.className = "col-xs-1";
					col12.setAttribute("onclick", "gzOrNot('${userId}','"+iData.activity_id+"')");
					if(iData.isGz==1)
					{
						var vi1 = document.createElement("i");
						vi1.className = "fa fa-star fa-lg";
						vi1.style.cssText = "margin-left:-5px;color:#EE7600;";
						vi1.id="gz"+iData.activity_id;
						col12.appendChild(vi1);
					}
					else if(iData.isGz==0)
					{
						var vi2 = document.createElement("i");
						vi2.className = "fa fa-star fa-lg";
						vi2.style.cssText = "margin-left:-5px;color:gray;";
						vi2.id="gz"+iData.activity_id;
						col12.appendChild(vi2);
					}
				}
				//htmlStr += "</div>";
				row1.appendChild(col1);
				var colblank = document.createElement("div");
				colblank.className = "col-xs-1";
				row1.appendChild(colblank);
				if(iData.isGz!=-1)
				{
					row1.appendChild(col12);
				}
				container.appendChild(row1);
				
				//htmlStr += "<div class='row' style='padding-bottom:5px;'>";
				var srDiv = document.createElement("div");
				srDiv.setAttribute("onclick", "activityDetail('"+iData.activity_id+"')");
				
				var row2 = document.createElement("div");
				row2.className = "row";
				row2.style.cssText = "padding-bottom:5px;";
				
				//htmlStr += "<div class='col-xs-12'>";
				var col2 = document.createElement("div");
				col2.className = "col-xs-12";
				
				//htmlStr += "<span style='font-size: 100%;'><b>"+iData.activity_desc+"</b></span>";
				var span2 = document.createElement("span");
				span2.style.cssText = "font-size: 100%;";
				var b = document.createElement("b");
				b.innerText = iData.activity_desc;
				span2.appendChild(b);
				
				//htmlStr += "</div>";
				col2.appendChild(span2);
				
				//htmlStr += "</div>";
				row2.appendChild(col2);
				srDiv.appendChild(row2);
				
				//htmlStr += "<div class='row' style='padding-bottom:8px;'>";
				var row3 = document.createElement("div");
				row3.className = "row";
				row3.style.cssText = "padding-bottom:8px;";
				
				//htmlStr += "<div class='col-xs-12'>";
				var col3 = document.createElement("div");
				col3.className = "col-xs-12";
				
				//htmlStr += "<span style='font-size: 80%;'>"+iData.activity_stake+"</span>";
				var span3 = document.createElement("span");
				span3.style.cssText = "font-size: 80%;";
				span3.innerText = iData.activity_stake;
				
				col3.appendChild(span3);
				row3.appendChild(col3);
				srDiv.appendChild(row3);
				
				//htmlStr += "<div class='row' style='padding-bottom:5px;'>";
				var row4 = document.createElement("div");
				row4.className = "row";
				row4.style.cssText = "padding-bottom:5px;";
				
				//htmlStr += "<div class='col-xs-12'>";
				var col4 = document.createElement("div");
				col4.className = "col-xs-12";
				
				if(iData.parimg.length>0)
				{
					//htmlStr += "<span style='font-size: 80%; margin-right:6px;'>已有</span>";
					var span4 = document.createElement("span");
					span4.style.cssText = "font-size: 80%; margin-right:6px;";
					span4.innerText = "已有";
					col4.appendChild(span4);
					
					for(var j=0; j<iData.parimg.length; j++)
					{
						//htmlStr += "<img src='"+iData.parimg[j]+"' class='img-circle' style='width: 25px; height: 25px; margin-left:-6px;'/>";
						var imgtemp = document.createElement("img");
						imgtemp.className = "img-circle";
						imgtemp.style.cssText = "width: 25px; height: 25px; margin-left:-6px;";
						//imgtemp.setAttribute("src", "'"+iData.parimg[j]+"'");
						imgtemp.src = iData.parimg[j];
						col4.appendChild(imgtemp);
					}
					//htmlStr += "<span style='font-size: 80%;'>参与</span>";
					var span5 = document.createElement("span");
					span5.style.cssText = "font-size: 80%;";
					span5.innerText = "参与";
					col4.appendChild(span5);
				}
				else
				{
					//htmlStr += "<span style='font-size: 80%; margin-right:6px;'>无人参与</span>";
					var span6 = document.createElement("span");
					span6.style.cssText = "font-size: 80%; margin-right:6px;";
					span6.innerText = "无人参与";
					col4.appendChild(span6);
				}
				//htmlStr += "</div>";
				row4.appendChild(col4);
				//htmlStr += "</div>";
				srDiv.appendChild(row4);
				
				container.appendChild(srDiv);
				//htmlStr += "</div>";
				divContent.appendChild(container);
				//divContent.innerHTML = vvContent.innerHTML + htmlStr; 

			}
			wrapper.refresh();
			document.getElementById("pageId").value = parseInt(page) + 1;
		}
	});
}
function activityDetail(actId)
{
	window.location.href="${base}/weixin/baseoauth?action=onlineGame&activityId="+actId;
// 	document.getElementById("pageId").value = "${nextid}";
}

function gzOrNot(usrId, actId)
{
	var colorName = document.getElementById("gz" + actId).style.color;
	var flag = 0;
	if(colorName.indexOf("gray")==-1)
	{
		flag = 0;
		$("#gz" + actId).css("color","#EE7600");
		$("#gz" + actId).css("color","gray");
	}
	else
	{
		flag = 1;
		$("#gz" + actId).css("color","gray");
		$("#gz" + actId).css("color","#EE7600");
	}

	$.ajax({
		type : "POST",
		url : "${base}/care/careOrNot",
		data: {userId:usrId, actId: actId, flag: flag},
		datatyep : "json",
		success : function(data) { 					
		}
	});
}

function goToListOfUnread(userId){
	window.location.href = "${base}/toListOfUnread?userId=" + userId;
}
window.onload = function(){
	$('body').css('display','');	
}; 
</script>
</html>