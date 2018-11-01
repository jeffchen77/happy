package com.happy.action;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.nutz.json.JsonFormat;
import org.nutz.mvc.View;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.By;
import org.nutz.mvc.annotation.Encoding;
import org.nutz.mvc.annotation.Filters;
import org.nutz.mvc.annotation.Param;
import org.nutz.mvc.view.JspView;
import org.nutz.mvc.view.UTF8JsonView;
import org.nutz.mvc.view.ViewWrapper;

import com.happy.filter.LogFilter;
import com.happy.model.Activity;
import com.happy.model.ActivityComments;
import com.happy.model.ClickZan;
import com.happy.model.CommentsReply;
import com.happy.model.Participate;
import com.happy.model.SysMessage;
import com.happy.model.UnreadMessage;
import com.happy.model.User;
import com.happy.model.UserPoints;
import com.happy.model.WechatUser;
import com.happy.service.GameServices;
import com.happy.service.URLService;
import com.happy.service.UnreadMesService;
import com.happy.service.UserActivityServices;
import com.happy.service.UserInfoService;
import com.happy.service.UserPointsService;
import com.happy.utils.CommonUtil;
import com.happy.utils.CustomMsgUtil;
import com.happy.utils.Sign;
import com.happy.weixin.app.App;
import com.happy.weixin.tokenweb.TokenWeb;
import com.happy.weixin.tokenweb.TokenWebService;
import com.happy.weixin.wechatuser.WeChatUserService;

@Encoding(input = "UTF-8", output = "UTF-8")
@Filters(value = { @By(type = LogFilter.class) })
public class OnLineAction {

	private static Logger log = LogManager.getLogger(OnLineAction.class);
	protected UserInfoService userInfoService = new UserInfoService();
	protected Activity activitiy = null;
	protected SysMessage mes = null;

	protected WechatUser wechatUser = null;

	protected Participate participate = null;
	protected ActivityComments activitycomments = null;
	protected CommentsReply commentsReply = null;

	protected GameServices gameServices = new GameServices();
	protected UserActivityServices userActivityServices = new UserActivityServices();
	protected UserPointsService userPointsService = new UserPointsService();
	protected UnreadMesService unreadMesService = new UnreadMesService();

	@At("/onlineGame")
	public View onlineGame(@Param("code") String code,
			@Param("scope") String scope,
			@Param("activityId") String activityId,
			@Param("fromChall") String fromChall, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String openId = "";
		String granted = "";

		WechatUser wechatUser = null;
		User user = null;

		try {
			TokenWeb tokenweb = TokenWebService.getNewTokenWebObject(
					App.APP_ID, App.APP_SECRET, code);
			openId = tokenweb.getOpenId();
			granted = "N";
			wechatUser = gameServices.getInfoFromWechatUser(openId);
			if (wechatUser != null) {
				granted = "Y";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		boolean f = game(request, response, activityId, openId);
		if (f == false) {
			String redirectUrl = "http://" + App.APP_SERVER + "/"
					+ App.APP_NAME + "/weixin/baseoauth?action=challengIndex";
			response.sendRedirect(redirectUrl);
			return null;
		}
		try {
			user = userInfoService.getUserByUserId(openId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (user != null) {
			request.setAttribute("phoneFlag", user.getPhoneNumber());
			request.setAttribute("upperLV",
					Integer.parseInt(user.getMoralRank()));
			request.setAttribute("gzFlag", user.getGzFlag());
			request.setAttribute("currentUser", user);

		}

		// 更新未读信息状态，把所有未读信息变为已读
		unreadMesService.updateUnreadMes(activityId, openId);

		List<Participate> listParticipate = gameServices
				.findParticipateByActid(activityId);
		int numberOfPartner = listParticipate.size();

		request.setAttribute("openId", openId);
		request.setAttribute("granted", granted);
		request.setAttribute("fromChall", fromChall);
		request.setAttribute("numberOfPartner", numberOfPartner);
		//显示系统胜负率
		request.setAttribute("forecastAcc", userInfoService.sysForecastAcc());
		
		String activity_type = null;
		activitiy = new Activity();
		activitiy = gameServices.getInfoFromActivity(activityId);
		activity_type = activitiy.getAcitvityType();
		return new ViewWrapper(new JspView("jsp.onLineGames"), "ok!");

		// openId="oxw8iwQ_DPNKHlfM6MRUp7n2sFcI";
		// request.setAttribute("openId", openId);
		// game(request,response,activityId,openId);
		// request.setAttribute("granted", "Y");
		// request.setAttribute("fromChall", "");
		// request.setAttribute("numberOfPartner", 2);
		// request.setAttribute("pwdflag", "Y");
		//
		// return new ViewWrapper(new JspView("jsp.onLineGame"),"ok!");

	}

	// 获取目前参与人数
	@At("/getNumberOfPartner")
	public void getNumberOfPartner(@Param("activityId") String activityId,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		List<Participate> listParticipate = gameServices
				.findParticipateByActid(activityId);
		String numberOfPartne = Integer.toString(listParticipate.size());
		response.getWriter().write(numberOfPartne);
	}

	public boolean game(HttpServletRequest request,
			HttpServletResponse response,
			@Param("activityId") String activityId,
			@Param("openId") String openId) {
		List<Map> participateNo = null;
		List<Map> participateYes = null;
		List<String> participateNicknameNO = null;
		List<String> participateNicknameYes = null;
		List<Map> comentsinfo = new ArrayList<Map>();
		List<Map> dellDetailInfo = new ArrayList<Map>();
		String pwdflag = null;
		String isDetailFlag = "N";

		Map<String, Object> data = new HashMap<String, Object>();
		try {
			String url = URLService.getFullUrl(request);
			Map<String, String> weixinparames = Sign.getSignParams(url,
					App.APP_ID, App.APP_SECRET);
			weixinparames.put("appId", App.APP_ID);
			data.put("weixinparames", weixinparames);
		} catch (Exception e) {
			e.printStackTrace();
		}
		// activityId= "CToxw8iwQ_DPNKHlfM6MRUp7n2sFcI20160511131708";

		try {
			activitiy = new Activity();
			wechatUser = new WechatUser();

			activitiy = gameServices.getInfoFromActivity(activityId);
			if (activitiy == null) {
				return false;
			}
			// 下面这段代码是用于加载交易明细的，如果是城池
			if (activitiy.getStakePoints() > 0
					&& (activitiy.getResultStatus() == 1 || activitiy
							.getResultStatus() == 2)) {
				isDetailFlag = "Y";
				dellDetailInfo = gameServices.getDellDetailInfo(activityId);
			}
			wechatUser = gameServices.getInfoFromWechatUser(activitiy
					.getUserId());
			participateNo = gameServices.getActivityByIdNoImgAndDou(activityId);

			participateYes = gameServices.getParticipateByYesImgAndDou(activityId);
			comentsinfo = gameServices.getCommentsInfoAndZan(
					gameServices.getCommentsInfo(activityId), openId);
			participateNicknameNO = gameServices.getNicknameByIdNo(activityId);
			participateNicknameYes = gameServices
					.getNicknameByIdYes(activityId);

			// 判断这个活动是否加密
			pwdflag = gameServices.isNeedPassword(activityId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		request.setAttribute("appServer", App.APP_SERVER);
		request.setAttribute("weixinParames", data);
		request.setAttribute("Activitiy", activitiy);
		request.setAttribute("WechatUser", wechatUser);
		request.setAttribute("ParticipateYesList", participateYes);
		request.setAttribute("ParticipateYes", participateYes.size());
		request.setAttribute("ParticipateNoList", participateNo);
		request.setAttribute("ComentsInfo", comentsinfo);
		request.setAttribute("participateNicknameNO", participateNicknameNO);
		request.setAttribute("participateNicknameYes", participateNicknameYes);
		request.setAttribute("pwdflag", pwdflag);
		request.setAttribute("isDetailFlag", isDetailFlag);
		request.setAttribute("dellDetailInfo", dellDetailInfo);
		return true;
	}

	@At("/clickAgainst")
	public View clickAgainst(@Param("activityId") String activityId,
			@Param("openId") String openId ,HttpServletRequest request, HttpServletResponse response) {

		String comment = request.getParameter("comment");//@Param("comment") String comment
		int num = Integer.parseInt(request.getParameter("num"));
		int found = 0;
		List<String> data = new ArrayList<String>();
		participate = new Participate();
		activitiy = new Activity();
		wechatUser = new WechatUser();
		mes = new SysMessage();
		try {
			found = gameServices.findParticipate(openId, activityId);

		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		if (found == -1) {
			return new ViewWrapper(new UTF8JsonView(new JsonFormat()), "NOT!");
		}

		participate.setActivityId(activityId);
		participate.setUserId(openId);
		participate.setDoubleNum(num);
		participate.setParticiType("N");
		int msgret=0;
		try {
			wechatUser = gameServices.getInfoFromWechatUser(openId);
			activitiy = gameServices.getInfoFromActivity(activityId);
			int availablePoint = gameServices.getAvailablePoints(openId);
			if(activitiy!=null && activitiy.getStakePoints()>0 && availablePoint-activitiy.getStakePoints()<0)
			{
				return new ViewWrapper(new UTF8JsonView(new JsonFormat()), "MAX!");
			}
			gameServices.saveParticipate(participate);
			activitiy.setActivityId(activityId);
			activitiy.setActivityStatus(1);
			gameServices.updateActivityStatus(activitiy);
			
			Date date = new Date();
			mes.setActivityId(activityId);
			mes.setBody(activitiy.getActivityRemark()
					+ wechatUser.getNickName() + "反对:");
			mes.setFromUserId(openId);
			mes.setToUserId(activitiy.getUserId());
			mes.setStatus(0);
			mes.setSendTime(date);
			mes.setTitle(activitiy.getActivityDesc());
//			userInfoService.sendSysMessage(mes); 暂时取消发系统消息
			//评论模块
			String agaisntComments = null;
			if(comment == null || "".equalsIgnoreCase(comment.trim())){
				agaisntComments = CommonUtil.getAgainstComments();
			}else{
				agaisntComments = comment;
			}
			
			//插入评论
			data = insertComments(wechatUser.getUserId(), activityId, agaisntComments);
			//组装超链接标签
			agaisntComments = "<a href='http://"+App.APP_SERVER+"/"+App.APP_NAME+"/weixin/baseoauth?action=onlineGame&activityId="+activityId+"'>"+agaisntComments+"</a>";
			
			//发送公众号客服信息
			msgret=CustomMsgUtil.sendCustomMsg(activitiy.getUserId(), mes.getBody()+agaisntComments);
			if(msgret>=0){
			// 发送给当前参与者的信息
				msgret=CustomMsgUtil.sendCustomMsg(openId, activitiy.getActivityRemark()
					+ "你反对:"+agaisntComments);

			// 发送公众号客服给其他的参与者
			sendParterCustomMsg(activityId, wechatUser.getNickName(), 0, openId, agaisntComments);
			}
			// 锁定user points
			if (activitiy.getStakePoints() > 0) {
				lockUserPointBasedOnActId(openId, activityId, num);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		List<String> commentIdList = null;
		try {
			commentIdList = gameServices.getCurrentInsertCommentId(activityId,
					wechatUser.getUserId());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if (commentIdList != null) {
			data.add(commentIdList.get(0));
		}
		if(msgret==-2){
			data.add("UNGZ");
		}
		data.add(num+"");	
		return new ViewWrapper(new UTF8JsonView(new JsonFormat()), data);

	}

	@At("/clickSupport")
	public View clickSupport(@Param("activityId") String activityId,
			@Param("openId") String openId,HttpServletRequest request, HttpServletResponse response) {
		String comment = request.getParameter("comment");//@Param("comment") String comment
		int num = Integer.parseInt(request.getParameter("num"));
		int found = 0;
		List<String> data = new ArrayList<String>();
		participate = new Participate();
		activitiy = new Activity();
		wechatUser = new WechatUser();
		mes = new SysMessage();
		try {
			found = gameServices.findParticipate(openId, activityId);

		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		if (found == -1) {
			return new ViewWrapper(new UTF8JsonView(new JsonFormat()), "NOT!");
		}

		participate.setActivityId(activityId);
		participate.setUserId(openId);
		participate.setParticiType("Y");
		participate.setDoubleNum(num);

		int msgret =0;
		try {
			wechatUser = gameServices.getInfoFromWechatUser(openId);
			activitiy = gameServices.getInfoFromActivity(activityId);
			int availablePoint = gameServices.getAvailablePoints(openId);
			if(activitiy!=null && activitiy.getStakePoints()>0 &&availablePoint-activitiy.getStakePoints()<0)
			{
				return new ViewWrapper(new UTF8JsonView(new JsonFormat()), "MAX!");
			}
			gameServices.saveParticipate(participate);
			activitiy.setActivityId(activityId);
			activitiy.setActivityStatus(1);
			gameServices.updateActivityStatus(activitiy);
			
			Date date = new Date();
			mes.setActivityId(activityId);
			mes.setBody(activitiy.getActivityRemark()
					+ wechatUser.getNickName() + "支持:");
			mes.setFromUserId(openId);
			mes.setToUserId(activitiy.getUserId());
			mes.setStatus(0);
			mes.setSendTime(date);
			mes.setTitle(activitiy.getActivityDesc());
//			userInfoService.sendSysMessage(mes);暂时取消发系统消息
			String supportComments = null;
			if(comment == null || "".equalsIgnoreCase(comment.trim())){
				supportComments = CommonUtil.getSupportComments();
			}else{
				supportComments = comment;
			}
//			String supportComments = "<a href='http://"+App.APP_SERVER+"/"+App.APP_NAME+"/weixin/baseoauth?action=onlineGame&activityId="+activityId+"'>online游戏</a>";
			data = insertComments(wechatUser.getUserId(), activityId, supportComments);
			
			//组装超链接标签
			supportComments = "<a href='http://"+App.APP_SERVER+"/"+App.APP_NAME+"/weixin/baseoauth?action=onlineGame&activityId="+activityId+"'>"+supportComments+"</a>";
			
			// 发送给活动发起者的信息
			msgret = CustomMsgUtil.sendCustomMsg(activitiy.getUserId(), mes.getBody()+supportComments);
			if(msgret>=0){
			// 发送给当前参与者的信息
			CustomMsgUtil.sendCustomMsg(openId, activitiy.getActivityRemark()
					+ "你支持:"+supportComments);
			// 发送给其他的参与者
			sendParterCustomMsg(activityId, wechatUser.getNickName(), 1, openId, supportComments);
			}
			// 锁定user points
			if (activitiy.getStakePoints() > 0) {
				lockUserPointBasedOnActId(openId, activityId, num);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		List<String> commentIdList = null;
		try {
			commentIdList = gameServices.getCurrentInsertCommentId(activityId,
					wechatUser.getUserId());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if (commentIdList != null) {
			data.add(commentIdList.get(0));
		}
		log.debug("gz msg ret:"+msgret);
		if(msgret==-2){
			data.add("UNGZ");
		}
		data.add(num+"");
		return new ViewWrapper(new UTF8JsonView(new JsonFormat()), data);

	}

	// 针对活动本身进行回复
	@At("/insertAjaxcomments")
	public View insertAjaxcomments(@Param("activityId") String activityId,
			@Param("openId") String openId,HttpServletRequest request, HttpServletResponse response) {

		String comments = request.getParameter("comments");//@Param("comment") String comment
		List<String> data = new ArrayList<String>();
		Timestamp currentTime = new Timestamp(System.currentTimeMillis());
		activitycomments = new ActivityComments();
		activitycomments.setActivityId(activityId);
		activitycomments.setUserId(openId);
		activitycomments.setComments(comments);
		activitycomments.setCreateTime(currentTime);

		try {

			wechatUser = gameServices.getInfoFromWechatUser(openId);
			gameServices.insertComments(activitycomments);
			//获取最新commentsId
			int commentsId = gameServices.getNewestCommentsId(openId, currentTime, activityId);
			int remarkId = 0;
			// 发送系统消息
			this.activitiy = gameServices.getInfoFromActivity(activityId);
//			SysMessage smes = new SysMessage();			
//			Date date = new Date();
//			smes.setActivityId(activityId);
//			smes.setBody(activitiy.getActivityRemark()+wechatUser.getNickName() + "：" + comments);
//			smes.setFromUserId(wechatUser.getUserId());
//			smes.setToUserId(activitiy.getUserId());
//			smes.setStatus(0);
//			smes.setSendTime(date);
//			smes.setTitle(activitiy.getActivityDesc());
//			userInfoService.sendSysMessage(smes); 暂时取消发系统消息

			// 针对活动发起者发送未读信息
			UnreadMessage unreadMes = new UnreadMessage();
			unreadMes.setActivityId(activityId);
			unreadMes.setParticipateUserId(activitiy.getUserId());
			unreadMes.setCreateTime(currentTime);
			unreadMes.setUnread(1);
			unreadMes.setReplyUserId(openId);
			unreadMes.setCommentId(commentsId);
			unreadMes.setRemarkId(remarkId);//0表示新的 对活动直接发出的评论
			// 针对活动发起者插入未读信息
			unreadMesService.insertUnreadMes(unreadMes);

			// 发送客服消息
			// 发送公众号客服给其他的参与者
			comments = "<a href='http://"+App.APP_SERVER+"/"+App.APP_NAME+"/weixin/baseoauth?action=onlineGame&activityId="+activityId+"'>"+comments+"</a>";
			sendParterCustomMsg(activityId, wechatUser.getNickName(), -1, wechatUser.getOpenId(), comments);	
			// 发送客服消息给活动发起者
			if (!wechatUser.getUserId().equalsIgnoreCase(activitiy.getUserId())) {
				CustomMsgUtil.sendCustomMsg(activitiy.getUserId(), activitiy.getActivityRemark()+wechatUser.getNickName() + "：" + comments);
			}
			// 发送给其他的参与者？
			sendParterCustomComment(activityId, wechatUser.getNickName(), 0,
					wechatUser.getUserId(), comments,commentsId,remarkId);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		data.add(wechatUser.getHeadImgUrl());
		data.add(wechatUser.getNickName());
		data.add(comments);
		data.add(currentTime.toString());
		List<String> commentIdList = null;
		try {
			commentIdList = gameServices.getCurrentInsertCommentId(activityId,
					openId);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if (commentIdList != null) {
			data.add(commentIdList.get(0));
		}
		return new ViewWrapper(new UTF8JsonView(new JsonFormat()), data);
	}

	public List<String> insertComments(String userId, String activityId,
			String comments) {

		List<String> data = new ArrayList<String>();
		Timestamp currentTime = new Timestamp(System.currentTimeMillis());
		activitycomments = new ActivityComments();
		activitycomments.setActivityId(activityId);
		activitycomments.setUserId(userId);
		activitycomments.setComments(comments);
		activitycomments.setCreateTime(currentTime);
		try {
			wechatUser = gameServices.getInfoFromWechatUser(userId);
			gameServices.insertComments(activitycomments);
			int commentId = gameServices.getNewestCommentsId(userId, currentTime, activityId);
			int remarkId = 0;
			Activity mAct = gameServices.getInfoFromActivity(activityId);
			// 插入未读信息表unreadMesService
			UnreadMessage unreadMes = new UnreadMessage();
			unreadMes.setActivityId(activityId);
			unreadMes.setParticipateUserId(mAct.getUserId());
			unreadMes.setCreateTime(currentTime);
			unreadMes.setUnread(1);
			unreadMes.setReplyUserId(wechatUser.getUserId());
			unreadMes.setCommentId(commentId);
			unreadMes.setRemarkId(remarkId);
			unreadMesService.insertUnreadMes(unreadMes);

			
			// 发送给其他的参与者
			sendParterCustomComment(activityId, wechatUser.getNickName(), 0,
					wechatUser.getUserId(), comments,commentId,remarkId);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		data.add(wechatUser.getHeadImgUrl());
		data.add(wechatUser.getNickName());
		data.add(comments);
		data.add(currentTime.toString());
		return data;

	}

	@At("/insertcommentwecat")
	public View insertcommentwecat(@Param("code") String code,
			@Param("scope") String scope,
			@Param("activityId") String activityId, HttpServletRequest request,
			HttpServletResponse response) {

		/*	String comment = request.getParameter("comment");//@Param("comment") String comment
		Timestamp currentTime = new Timestamp(System.currentTimeMillis());
		WechatUser wechatUser = null;
		try {
			wechatUser = WeChatUserService.getWeixinUser(code);
			// 发送系统消息
			SysMessage smes = new SysMessage();
			Activity mAct = gameServices.getInfoFromActivity(activityId);
			Date date = new Date();
			smes.setActivityId(activityId);
			smes.setBody(wechatUser.getNickName() + "：“" + comment + "”");
			smes.setFromUserId(wechatUser.getUserId());
			smes.setToUserId(mAct.getUserId());
			smes.setStatus(0);
			smes.setSendTime(date);
			smes.setTitle(mAct.getActivityDesc());
//			userInfoService.sendSysMessage(smes); 暂时取消发系统消息
			// 发送客服消息
			// 发送客服消息给活动发起者
			CustomMsgUtil.sendCustomMsg(mAct.getUserId(), smes.getBody());

		} catch (Exception e) {
			e.printStackTrace();
		}

		
		List<String> data = new ArrayList<String>();
		data = insertComments(wechatUser.getUserId(), activityId, comment);
				
		game(request, response, activityId, wechatUser.getOpenId());
		request.setAttribute("openId", wechatUser.getOpenId());
		request.setAttribute("granted", "Y");
		return new ViewWrapper(new JspView("jsp.onLineGame"), "ok");
		*/
		//fei rewrite the section code
		String comment = request.getParameter("comment");//@Param("comment") String comment
		
		WechatUser wechatUser = null;
		try {
			wechatUser = WeChatUserService.getWeixinUser(code);		
			// 发送客服消息给活动发起者
			SysMessage smes = new SysMessage();
			this.activitiy = gameServices.getInfoFromActivity(activityId);
			smes.setActivityId(activityId);
			smes.setBody(activitiy.getActivityRemark()+wechatUser.getNickName() + "：" + comment);
			if (!wechatUser.getUserId().equalsIgnoreCase(activitiy.getUserId())) {
				CustomMsgUtil.sendCustomMsg(activitiy.getUserId(), smes.getBody());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		List<String> data = new ArrayList<String>();
		data = insertComments(wechatUser.getUserId(), activityId, comment);
		
		// 发送公众号客服给其他的参与者
		sendParterCustomMsg(activityId, wechatUser.getNickName(), -1, wechatUser.getOpenId(), comment);				
		
		game(request, response, activityId, wechatUser.getOpenId());
		request.setAttribute("openId", wechatUser.getOpenId());
		request.setAttribute("granted", "Y");
		return new ViewWrapper(new JspView("jsp.onLineGame"), "ok");
			
	}

	@At("/clickNoButton")
	public View clickNoButton(@Param("code") String code,
			@Param("scope") String scope,
			@Param("activityId") String activityId, HttpServletRequest request,
			HttpServletResponse response) {

			String comment = request.getParameter("comment");//@Param("comment") String comment
			int num = Integer.parseInt(request.getParameter("num"));
		WechatUser wechatUser = null;
		try {
			wechatUser = WeChatUserService.getWeixinUser(code);

		} catch (Exception e) {
			e.printStackTrace();
		}

		Timestamp currentTime = new Timestamp(System.currentTimeMillis());
		saveNo(wechatUser.getUserId(), activityId, num);
		try {
			// 发送系统消息
			SysMessage smes = new SysMessage();
			Activity mAct = gameServices.getInfoFromActivity(activityId);
			Date date = new Date();
			smes.setActivityId(activityId);
			smes.setBody(mAct.getActivityRemark() + wechatUser.getNickName()
					+ "反对:");
			smes.setFromUserId(wechatUser.getUserId());
			smes.setToUserId(mAct.getUserId());
			smes.setStatus(0);
			smes.setSendTime(date);
			smes.setTitle(mAct.getActivityDesc());
//			userInfoService.sendSysMessage(smes); 暂时取消发系统消息

			// 插入未读信息表unreadMesService
			/*UnreadMessage unreadMes = new UnreadMessage();
			unreadMes.setActivityId(activityId);
			unreadMes.setParticipateUserId(mAct.getUserId());
			unreadMes.setCreateTime(currentTime);
			unreadMes.setUnread(1);
			unreadMes.setReplyUserId(wechatUser.getUserId());
			unreadMesService.insertUnreadMes(unreadMes);*/

			// 发送客服消息
			// 插入comments信息
			String agaisntComments = null;
			if(comment == null || "".equalsIgnoreCase(comment.trim())){
				agaisntComments = CommonUtil.getAgainstComments();
			}else{
				agaisntComments = comment;
			}
			insertComments(wechatUser.getUserId(), activityId, agaisntComments);
			// 发送客服消息给活动发起者
			CustomMsgUtil.sendCustomMsg(mAct.getUserId(), smes.getBody()+agaisntComments);
			// 发送客服消息给当前活动参与者
			CustomMsgUtil.sendCustomMsg(wechatUser.getUserId(),
					mAct.getActivityRemark() + "你反对:"+agaisntComments);
			// 发送给其他的参与者//已经集成到insertComments方法中
			sendParterCustomMsg(activityId, wechatUser.getNickName(), 0,
					wechatUser.getUserId(), agaisntComments);
			
			// 锁定user points
			if (mAct.getStakePoints() > 0) {
				lockUserPointBasedOnActId(wechatUser.getUserId(), activityId, num);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		game(request, response, activityId, wechatUser.getOpenId());
		request.setAttribute("openId", wechatUser.getOpenId());
		request.setAttribute("granted", "Y");
		return new ViewWrapper(new JspView("jsp.onLineGame"), "ok");

	}

	public void saveNo(String userId, String activityId, int num) {

		activitiy = new Activity();
		participate = new Participate();

		participate.setActivityId(activityId);
		participate.setUserId(userId);
		participate.setDoubleNum(num);
		participate.setParticiType("N");
		activitiy.setActivityId(activityId);
		activitiy.setActivityStatus(1);
		try {

			gameServices.saveParticipate(participate);
			gameServices.updateActivityStatus(activitiy);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return;

	}

	@At("/clickYesButton")
	public View clickYesButton(@Param("code") String code,
			@Param("scope") String scope,
			@Param("activityId") String activityId, HttpServletRequest request,
			HttpServletResponse response) {

			String comment = request.getParameter("comment");//@Param("comment") String comment
			int num = Integer.parseInt(request.getParameter("num"));
		WechatUser wechatUser = null;
		try {
			wechatUser = WeChatUserService.getWeixinUser(code);

		} catch (Exception e) {
			e.printStackTrace();
		}
		if(wechatUser!=null&&wechatUser.getUserId()!=null)
		{
		saveYes(wechatUser.getUserId(), activityId, num);

		try {
			// 发送系统消息
			SysMessage smes = new SysMessage();
			Activity mAct = gameServices.getInfoFromActivity(activityId);
			Date date = new Date();
			smes.setActivityId(activityId);
			smes.setBody(mAct.getActivityRemark() + wechatUser.getNickName()
					+ "支持:");
			smes.setFromUserId(wechatUser.getUserId());
			smes.setToUserId(mAct.getUserId());
			smes.setStatus(0);
			smes.setSendTime(date);
			smes.setTitle(mAct.getActivityDesc());
//			userInfoService.sendSysMessage(smes); 暂时取消发系统消息

			Timestamp currentTime = new Timestamp(System.currentTimeMillis());
			// 插入未读信息表unreadMesService
			/*UnreadMessage unreadMes = new UnreadMessage();
			unreadMes.setActivityId(activityId);
			unreadMes.setParticipateUserId(mAct.getUserId());
			unreadMes.setCreateTime(currentTime);
			unreadMes.setUnread(1);
			unreadMes.setReplyUserId(wechatUser.getUserId());
			unreadMesService.insertUnreadMes(unreadMes);*/

			// 发送客服消息
			// 插入comments信息
			String supportComments = null;
			if(comment == null || "".equalsIgnoreCase(comment.trim())){
					supportComments = CommonUtil.getSupportComments();
			}else{
					supportComments = comment;
			}
			
//			String supportComments = "<a href='https://www.baidu.com'>这个游戏</a>";
			insertComments(wechatUser.getUserId(), activityId, supportComments);
			// 发送客服消息给活动发起者
			CustomMsgUtil.sendCustomMsg(mAct.getUserId(), smes.getBody()+supportComments);
			// 发送客服消息给当前活动参与者
			CustomMsgUtil.sendCustomMsg(wechatUser.getUserId(),
					mAct.getActivityRemark() + "你支持:"+supportComments);
			// 发送给其他的参与者
			sendParterCustomMsg(activityId, wechatUser.getNickName(), 1,
					wechatUser.getUserId(), supportComments);

			// 锁定user points
			if (mAct.getStakePoints() > 0) {
				lockUserPointBasedOnActId(wechatUser.getUserId(), activityId, num);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		game(request, response, activityId, wechatUser.getOpenId());
		request.setAttribute("openId", wechatUser.getOpenId());
		request.setAttribute("granted", "Y");
		}
		return new ViewWrapper(new JspView("jsp.onLineGame"), "ok");

	}

	public void saveYes(String userId, String activityId, int num) {

		activitiy = new Activity();
		participate = new Participate();

		participate.setActivityId(activityId);
		participate.setUserId(userId);
		participate.setParticiType("Y");
		participate.setDoubleNum(num);
		activitiy.setActivityId(activityId);
		activitiy.setActivityStatus(1);

		try {

			gameServices.saveParticipate(participate);
			gameServices.updateActivityStatus(activitiy);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return;

	}

	private void sendParterCustomMsg(String actId, String nickName, int yOrn,
			String currentOpenId, String comment) {
		List<String> revList = gameServices
				.getAllParticipateBasedOnActId(actId);
		if (revList != null && revList.size() > 0) {
			for (int i = 0; i < revList.size(); i++) {
				if (!currentOpenId.equalsIgnoreCase(revList.get(i))) {
					if (yOrn == 1) {
						CustomMsgUtil.sendCustomMsg(revList.get(i),
								activitiy.getActivityRemark() + nickName
										+ "支持:"+comment);
					} else if (yOrn == 0)  {
						CustomMsgUtil.sendCustomMsg(revList.get(i),
								activitiy.getActivityRemark() + nickName
										+ "反对:"+comment);
					} else {
						CustomMsgUtil.sendCustomMsg(revList.get(i),
								activitiy.getActivityRemark() + nickName
										+ "："+comment);
					}
				}
			}
		}

	}

	// 对其他参与者发送信息！
	private void sendParterCustomComment(String actId, String nickName,
			int yOrn, String currentOpenId, String comment,int commentId,int remarkId) throws Exception {
		List<String> revList = gameServices
				.getAllParticipateBasedOnActId(actId);
		Activity activitiy = gameServices.getInfoFromActivity(actId);
		Timestamp currentTime = new Timestamp(System.currentTimeMillis());
		if (revList != null && revList.size() > 0) {
			for (int i = 0; i < revList.size(); i++) {
				if (!currentOpenId.equalsIgnoreCase(revList.get(i))) {
					//fei comment this code line,repeat send at here.
//					CustomMsgUtil.sendCustomMsg(revList.get(i), nickName + "：“"
//							+ comment + "”");
					// 针对参与活动用户，发送未读信息。
					UnreadMessage unreadMes = new UnreadMessage();
					unreadMes.setActivityId(actId);
					unreadMes.setParticipateUserId(revList.get(i));
					unreadMes.setCreateTime(currentTime);
					unreadMes.setUnread(1);
					unreadMes.setReplyUserId(currentOpenId);
					unreadMes.setCommentId(commentId);
					unreadMes.setRemarkId(remarkId);
					unreadMesService.insertUnreadMes(unreadMes);
				}
			}
		}

	}

	@At("/verifyActPwd")
	public View verifyActPwd(HttpServletRequest request,
			HttpServletResponse response) {
		String actId = request.getParameter("actId");
		String userId = request.getParameter("userId");
		String actPassword = request.getParameter("secretcode");
		String parUsrId = request.getParameter("parUsrId");

		Activity sactivitiy = null;
		User user = null;
		int availablePoint = 0;
		Map<String, String> data = new HashMap<String, String>();

		try {
			sactivitiy = gameServices.getInfoFromActivity(actId);
			user = userActivityServices.getUserInfo(userId);
			availablePoint = gameServices.getAvailablePoints(parUsrId);
			if (sactivitiy != null && user != null) {
				String pwd = user.getActPassword();
				if (actPassword != null && actPassword.equals(pwd)) {
					data.put("rev", "Y");
					if (sactivitiy.getStakePoints() > 0
							&& (availablePoint - sactivitiy.getStakePoints() <= 0)) {
						data.put("rev", "L");
					}
				} else {
					data.put("rev", "N");
				}
			} else {
				data.put("rev", "F");
			}

		} catch (Exception e) {
			e.printStackTrace();
			data.put("rev", "F");
		}

		return new ViewWrapper(new UTF8JsonView(new JsonFormat()), data);

	}

	// 这个方法用于锁定user points
	private void lockUserPointBasedOnActId(String userId, String actId, int num) {
		try {
			Activity sactivitiy = gameServices.getInfoFromActivity(actId);
			int points = sactivitiy.getStakePoints();
			UserPoints up = userPointsService.getUserpointsByUserId(userId);
			if (up == null) {
				return;
			}
			userPointsService.updateLockPointsByUserId(
					num * points + up.getLockedPoints(), userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@At("/clickZan")
	public boolean clickZan(HttpServletRequest request,
			HttpServletResponse response) {
		Boolean isNewZan = Boolean.parseBoolean(request.getParameter("newZan"));
		int commentId = Integer.parseInt(request.getParameter("commentId"));
		String userId = request.getParameter("userId");
		GameServices gameServices = new GameServices();
		ActivityComments activityComments = gameServices
				.getActivityCommentsById(commentId);
		ClickZan clickZan = new ClickZan();
		clickZan.setUserId(userId);
		clickZan.setCommentId(commentId);
		clickZan.setCreateTime(new Timestamp(System.currentTimeMillis()));
		if (isNewZan) {
			try {
				gameServices.insertZan(clickZan, activityComments.getZan() + 1);
				return true;
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return false;
			}
		} else {
			try {
				gameServices.deleteZan(clickZan, activityComments.getZan() - 1);
				return true;
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return false;
			}
		}

	}

	@At("/insertAjaxReplycomments")
	public View insertAjaxReplycomments(@Param("activityId") String activityId,
			@Param("commentId") String commentId,
			@Param("openId") String openId, @Param("touserId") String touserId,
			HttpServletRequest request, HttpServletResponse response) {

		String comments = request.getParameter("comments");//@Param("comment") String comment
		List<String> data = new ArrayList<String>();
		Timestamp currentTime = new Timestamp(System.currentTimeMillis());
		WechatUser touserUser = null;
		int commentid = Integer.parseInt(commentId);
		int remarkId = 0;
		commentsReply = new CommentsReply();
		commentsReply.setCommentId(Integer.parseInt(commentId));
		commentsReply.setComments(comments);
		commentsReply.setTouserId(touserId);
		commentsReply.setUserId(openId);
		commentsReply.setCreateTime(currentTime);
		try {
			wechatUser = gameServices.getInfoFromWechatUser(openId);
			touserUser = gameServices.getInfoFromWechatUser(touserId);
			gameServices.insertComments(commentsReply);
			remarkId = gameServices.getNewestCommentsReplyId(commentsReply);
			// 发送系统消息
			SysMessage smes = new SysMessage();
			Activity mAct = gameServices.getInfoFromActivity(activityId);
			Date date = new Date();
			smes.setActivityId(activityId);
			if (openId.equalsIgnoreCase(touserId)) {
				comments = "<a href='http://"+App.APP_SERVER+"/"+App.APP_NAME+"/weixin/baseoauth?action=onlineGame&activityId="+activityId+"'>"+comments+"</a>";
				
				smes.setBody(mAct.getActivityRemark()+wechatUser.getNickName() + "说：“" + comments + "”");
				
			} else {
				comments = "<a href='http://"+App.APP_SERVER+"/"+App.APP_NAME+"/weixin/baseoauth?action=onlineGame&activityId="+activityId+"'>"+comments+"</a>";
				
				smes.setBody(mAct.getActivityRemark()+wechatUser.getNickName() + "对<"
						+ touserUser.getNickName() + ">说：“" + comments + "”");
			}

			smes.setFromUserId(wechatUser.getUserId());
			smes.setToUserId(mAct.getUserId());
			smes.setStatus(0);
			smes.setSendTime(date);
			smes.setTitle(mAct.getActivityDesc());
//			userInfoService.sendSysMessage(smes); 暂时取消发系统消息

			// 发送客服消息
			// 发送客服消息给活动发起者
			if (!mAct.getUserId().equalsIgnoreCase(wechatUser.getUserId())) {
				CustomMsgUtil.sendCustomMsg(mAct.getUserId(), smes.getBody());
			}

			// 发送同commentsID下的其他人

			List<String> revList = gameServices
					.getAllreplyUserIDBasedOnCommentsId(commentId);
			if (revList != null && revList.size() > 0) {
				for (int i = 0; i < revList.size(); i++) {
					if (!revList.get(i).equalsIgnoreCase(mAct.getUserId())
							&& !revList.get(i).equalsIgnoreCase(
									wechatUser.getUserId())) {

						CustomMsgUtil.sendCustomMsg(revList.get(i),
								smes.getBody());

						// 针对某条评论讨论的用户，发送未读信息。
						UnreadMessage unreadMes = new UnreadMessage();
						unreadMes.setActivityId(activityId);
						unreadMes.setParticipateUserId(revList.get(i));
						unreadMes.setCreateTime(currentTime);
						unreadMes.setUnread(1);
						unreadMes.setReplyUserId(openId);
						unreadMes.setCommentId(commentid);
						unreadMes.setRemarkId(remarkId);
						unreadMesService.insertUnreadMes(unreadMes);
					}
				}
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		data.add(wechatUser.getNickName());
		data.add(openId);
		if (touserUser == null) {
			data.add("");
		} else {
			data.add(touserUser.getNickName());
		}
		data.add(touserId);
		data.add(comments);
		return new ViewWrapper(new UTF8JsonView(new JsonFormat()), data);
	}

	@At("/sysActParticipateList")
	public View sysActParticipateList(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String activityId = request.getParameter("activityId");
		List<WechatUser> yesParticipateWechatInfo = gameServices
				.getYesParticipateWechatInfoByActId(activityId);
		List<WechatUser> noParticipateWechatInfo = gameServices
				.getNoParticipateWechatInfoByActId(activityId);
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("yesParticipateWechatInfo", yesParticipateWechatInfo);
		data.put("noParticipateWechatInfo", noParticipateWechatInfo);
		return new ViewWrapper(new JspView("jsp.participateWechatInfoDetail"),
				data);
	}
	
}
