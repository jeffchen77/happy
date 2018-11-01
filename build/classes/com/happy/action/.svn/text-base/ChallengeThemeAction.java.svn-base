package com.happy.action;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.nutz.mvc.View;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Param;
import org.nutz.mvc.view.JspView;
import org.nutz.mvc.view.ViewWrapper;

import com.happy.model.Activity;
import com.happy.model.User;
import com.happy.model.UserPoints;
import com.happy.model.WechatUser;
import com.happy.service.ChallengeThemeService;
import com.happy.service.URLService;
import com.happy.service.UserInfoService;
import com.happy.service.UserPointsService;
import com.happy.utils.CommonUtil;
import com.happy.utils.Sign;
import com.happy.weixin.app.App;
import com.happy.weixin.tokenweb.TokenWeb;
import com.happy.weixin.tokenweb.TokenWebService;
import com.happy.weixin.wechatuser.WeChatUserService;

public class ChallengeThemeAction {
	private static Logger log = LogManager.getLogger(ChallengeThemeAction.class);
	
	ChallengeThemeService challengeThemeService = new ChallengeThemeService();
	UserPointsService userPointsService = new UserPointsService();
	//主题页选择
	//www.76idea.com/happy/weixin/baseoauth?action=FrontOfChallengIndex
	@At("/FrontOfChallengIndex")
	public View FrontOfChallengIndex(@Param("code")String code,@Param("scope")String scope,@Param("activityId") String activityId,
			HttpServletRequest request,HttpServletResponse response) throws Exception{

		return new ViewWrapper(new JspView("jsp.frontOfChallengeTheme"),"");
	}
	//保存挑战内容信息
	@At("/ChallengeTheme")
	public View challengeThemeSave(HttpServletRequest request,HttpServletResponse response){
		Activity activity = new Activity();
		log.debug("进入保存页面");
		Date date=new Date();
		String time=CommonUtil.formatDateTimeToYYYYMMDDHHMMSSExt(date);		 
		
		//获取页面post信息
		String activityId = "CT"+request.getParameter("userId")+time;
		String userId = request.getParameter("userId");
		String templateId = request.getParameter("templateId");
		String typeTemp = request.getParameter("secratCodeChecked") == null ? "" : request.getParameter("secratCodeChecked");
		String activityType = typeTemp.equalsIgnoreCase("on") ? "1" :"0";
		String activityDesc = request.getParameter("activityDesc").replace("\r\n", "  ");
		String numOfCity = request.getParameter("numOfCity");
		int stakePoints = Integer.parseInt(numOfCity);
		int lockPoints = userPointsService.getUserpointsByUserId(userId).getLockedPoints() + stakePoints;
		String actIsCheck = request.getParameter("VRChecked") == null ? " " : request.getParameter("VRChecked") ;
		String activityStake = actIsCheck.equalsIgnoreCase("on") ?  request.getParameter("activityStake".replace("\r\n", "  ")) :"朕要为此赌上"+numOfCity+"座城池！" ;
		
		Timestamp activityDeadline = Timestamp.valueOf(request.getParameter("test_default")+":00");
		Timestamp publishDate = Timestamp.valueOf(request.getParameter("test_publish")+":00");
		int particiLimititation =  Integer.parseInt(request.getParameter("particiLimititation"));
		
		int activityStatus = 0;                                           
		String activityRemark = CommonUtil.getRandEmoji();		//update by robert
		int resultStatus =  0;
		int executeStatus = 0;
		Timestamp createTime = Timestamp.valueOf(CommonUtil.formatDateTimeToYYYYMMDDHHMMSS(date));
		
		activity.setActivityId(activityId);
		activity.setUserId(userId);
		activity.setAcitvityType(activityType);
		activity.setActivityDesc(activityDesc);
		activity.setActivityStake(activityStake);
		activity.setActivityDeadline(activityDeadline);
		activity.setParticiLimititation(particiLimititation);
		activity.setActivityStatus(activityStatus);
		activity.setActivityRemark(activityRemark);
		activity.setCreateTime(createTime);
		activity.setPublishDate(publishDate);
		activity.setResultStatus(resultStatus);
		activity.setExecuteStatus(executeStatus);
		activity.setStakePoints(stakePoints);
		activity.setTypeId(templateId);
		
		try{
			challengeThemeService.insertChallengeTheme(activity);
			userPointsService.updateLockPointsByUserId(lockPoints, userId);
			String prepage = "fromChall=y";
			String redirectUrl = "http://"+App.APP_SERVER+"/"+App.APP_NAME+"/weixin/baseoauth?action=onlineGame&activityId="+activity.getActivityId()+"&paramstr="+prepage;
			log.debug(redirectUrl);
			response.sendRedirect(redirectUrl);
		}catch(Exception e){
			log.debug(e.getMessage());
		}
		return null;
	}
	
	@At("/challengIndex")
	public View challengIndex(@Param("code")String code,@Param("scope")String scope,@Param("activityId") String activityId,
			HttpServletRequest request,HttpServletResponse response) throws Exception{
		
		WechatUser wechatUser = null;
		User user = null;
		UserPoints userPoints = null;
		UserInfoService userInfoService = new UserInfoService();
		UserPointsService userPointsService = new UserPointsService();
		String templateId = request.getParameter("templateID");
		String paramstr = "templateId="+templateId;
		
		try{
			TokenWeb tokenweb=TokenWebService.getNewTokenWebObject(App.APP_ID, App.APP_SECRET, code);
			String openId =tokenweb.getOpenId();
			log.debug("openId拿到为："+openId);
			wechatUser = userInfoService.getWechatUserById(openId);
			user = userInfoService.getUserByUserId(openId);
			userPoints = userPointsService.getUserpointsByUserId(openId);
			if(wechatUser==null){
				String redirectUrl = "http://"+App.APP_SERVER+"/"+App.APP_NAME+"/weixin/oauth?action=wechatUserInfo&paramstr="+paramstr;
				response.sendRedirect(redirectUrl);
				return null;
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
				
		Map<String,Object> data = new HashMap<String,Object>();
		data.put("userPoints", userPoints);
		data.put("templateId", templateId);

		
		this.challengInfo(user, wechatUser, data, request, response);
//		
//		String openId = "oxw8iwb3QpPdigEac5FgUUeWMx-s";
//		WechatUser wechatUser = null;
//		UserInfoService userInfoService = new UserInfoService();
//		UserPointsService userPointsService = new UserPointsService();
//		Date date = new Date();
//		DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
//		String rightNow = format.format(date);
//		
//	    wechatUser = userInfoService.getWechatUserById(openId);
//		Map<String,Object> data = new HashMap<String,Object>();
//		User user = userInfoService.getUserByUserId(openId);
//		UserPoints userPoints = userPointsService.getUserpointsByUserId(openId);
//		int upperLV = Integer.parseInt("8")/5;
//		int residueLV = Integer.parseInt("8")%5;
//		data.put("user", user);
//		data.put("upperLV", upperLV);
//		data.put("residueLV", residueLV);
//		data.put("wechatUser", wechatUser);
//		data.put("rightNow", rightNow);
//		data.put("userPoints", userPoints);

		return new ViewWrapper(new JspView("jsp.challengTheme"),data);
	}
	
	@At("/wechatUserInfo")
	public View wechatUserInfo(@Param("code")String code,@Param("scope")String scope,@Param("activityId") String activityId,
			HttpServletRequest request,HttpServletResponse response){
		
		WechatUser wechatUser = null;
		UserPoints userPoints = null;
		String templateId = request.getParameter("templateId");
		try{
			//获取微信信息
			wechatUser = WeChatUserService.getWeixinUser(code);
		}catch(Exception e){
			e.printStackTrace();
		}
		Map<String,Object> data = new HashMap<String,Object>();
		data.put("wechatUser", wechatUser);
		User user = new User();
		user.setUserId(wechatUser.getOpenId());
		user.setNickName(wechatUser.getNickName());
		user.setMoralRank("1");	
		user.setIntegritylRank("5");
		userPoints = userPointsService.getUserpointsByUserId(wechatUser.getOpenId());
		data.put("userPoints", userPoints);
		data.put("templateId", templateId);
		this.challengInfo(user, wechatUser, data, request, response);
		return new ViewWrapper(new JspView("jsp.challengTheme"),data);
	}
	
	private void challengInfo(User user,WechatUser wechatUser,Map<String,Object> data,
			HttpServletRequest request,HttpServletResponse response){
		
		try
		{
			int upperLV = Integer.parseInt(user.getMoralRank());
			String dsbRate=null;
			if(user.getForecastAccuracy()!=null){
				 dsbRate=user.getForecastAccuracy();	
			}
			else{
				 dsbRate="";	
			}
			data.put("upperLV", upperLV);
			data.put("user", user);
			data.put("dsbRate", dsbRate);
			data.put("wechatUser", wechatUser);	
		//weixin JSAPI auth
		String url = URLService.getFullUrl(request);
		Map<String,String> weixinparames = Sign.getSignParams(url, App.APP_ID, App.APP_SECRET);
		weixinparames.put("appId", App.APP_ID);
		data.put("weixinparames", weixinparames);
		request.setAttribute("appServer", App.APP_SERVER);
		}catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	
	@At("/updateActPassWord")
	public void updateActPassWord(HttpServletRequest request,HttpServletResponse response){
		String userId = request.getParameter("userId");
		String actPassword = request.getParameter("secretcode");
		UserInfoService userInfoService = new UserInfoService();
		try{
			userInfoService.updateActPasswordById(userId, actPassword);
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
}
