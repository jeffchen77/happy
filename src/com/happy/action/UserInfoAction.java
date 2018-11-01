package com.happy.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.http.HttpEntity;
import org.apache.http.HttpHost;
import org.apache.http.HttpRequest;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.nutz.json.Json;
import org.nutz.mvc.View;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;
import org.nutz.mvc.view.JspView;
import org.nutz.mvc.view.ViewWrapper;

import com.happy.utils.CustomMsgUtil;
import com.google.gson.Gson;
import com.google.gson.internal.LinkedTreeMap;
import com.happy.model.PersonTransRecord;
import com.happy.model.User;
import com.happy.model.UserPoints;
import com.happy.model.WechatUser;
import com.happy.service.UserInfoService;
import com.happy.service.UserPointsService;
import com.happy.utils.CommonUtil;
import com.happy.utils.SendSMS;
import com.happy.utils.WeiXinUtil;
import com.happy.weixin.app.App;
import com.happy.weixin.token.Token;
import com.happy.weixin.token.TokenFactory;
import com.happy.weixin.token.TokenService;
import com.happy.weixin.tokenweb.TokenWeb;
import com.happy.weixin.tokenweb.TokenWebService;
import com.happy.weixin.wechatuser.WeChatUserService;
import com.taobao.api.internal.toplink.embedded.websocket.util.StringUtil;

import net.sf.json.JSONObject;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
//import com.happy.utils.SendSMS;
import java.net.URL;
import java.sql.Timestamp;

public class UserInfoAction {
	private static Logger log = LogManager.getLogger(UserInfoAction.class);
	UserInfoService userInfoService = new UserInfoService();
	
	@At("/myInfoIndex")
	public View myInfoIndex(@Param("code")String code,@Param("scope")String scope,@Param("activityId") String activityId,
			HttpServletRequest request,HttpServletResponse response) throws Exception{
		
		WechatUser wechatUser = null;
		UserPoints userPoints = null;
		User user = null;
		UserInfoService userInfoService = new UserInfoService();
		UserPointsService userPointsService = new UserPointsService();
		try{
			TokenWeb tokenweb=TokenWebService.getNewTokenWebObject(App.APP_ID, App.APP_SECRET, code);
			String openId =tokenweb.getOpenId();
			wechatUser = userInfoService.getWechatUserById(openId);
			
			if(wechatUser==null){
				String redirectUrl = "http://"+App.APP_SERVER+"/"+App.APP_NAME+"/weixin/oauth?action=wechatUserInfoOfMyInfo&activityId="+activityId;
				response.sendRedirect(redirectUrl);
				return null;
			}
			user = userInfoService.getUserByUserId(openId);
			userPoints = userPointsService.getUserpointsByUserId(wechatUser.getOpenId());
		}catch(Exception e){
			e.printStackTrace();
		}
		Map<String,Object> data = new HashMap<String,Object>();
		int upperLV = Integer.parseInt(user.getMoralRank());
		String dsbRate=null;
		if(user.getForecastAccuracy()!=null){
			 dsbRate=user.getForecastAccuracy();	
		}
		else{
			 dsbRate="";	
		}
		//int residueLV = Integer.parseInt(user.getMoralRank())%5;
		data.put("activityId", activityId);
		data.put("upperLV", upperLV);
		data.put("dsbRate", dsbRate);
		//data.put("residueLV", residueLV);
		
		data.put("userPoints", userPoints);
		data.put("wechatUser", wechatUser);
		data.put("user",user);
		
//		String openId = "oxw8iwQ_DPNKHlfM6MRUp7n2sFcI";
//		WechatUser wechatUser = new WechatUser();
//		wechatUser = userInfoService.getWechatUserById(openId);
//		User user = userInfoService.getUserByUserId(openId);
//		Map<String,Object> data = new HashMap<String,Object>();
//		int upperLV = Integer.parseInt(user.getMoralRank())/5;
//		int residueLV = Integer.parseInt(user.getMoralRank())%5;
//		data.put("activityId", activityId);
//		data.put("upperLV", upperLV);
//		data.put("residueLV", residueLV);
//		data.put("user", user);
//		data.put("wechatUser", wechatUser);
		
		return new ViewWrapper(new JspView("jsp.myInfo"),data);
	}
	
	@At("/wechatUserInfoOfMyInfo")
	public View wechatUserInfoOfMyInfo(@Param("code")String code,@Param("scope")String scope,@Param("activityId") String activityId,
			HttpServletRequest request,HttpServletResponse response) throws Exception{
		WechatUser wechatUser = null;
		try{
			//获取微信信息
			wechatUser = WeChatUserService.getWeixinUser(code);
		}catch(Exception e){
			e.printStackTrace();
		}
		
		Map<String,Object> data = new HashMap<String,Object>();
		
		String openId = wechatUser.getOpenId();
		User user = userInfoService.getUserByUserId(openId);
		
		data.put("activityId", activityId);
		data.put("user", user);
		data.put("wechatUser", wechatUser);
		return new ViewWrapper(new JspView("jsp.myInfo"),data);
	}
	
	@At("/updateEmail")
	public boolean updatePhoneNum(HttpServletRequest request,HttpServletResponse response){
		String email = request.getParameter("Email");
		String userId = request.getParameter("userId");
		User user = new User();
		user.setEmailAddress(email);
		user.setUserId(userId);
		try{
			userInfoService.updateEmailById(user);
			return true;
		}catch(Exception e){
			e.printStackTrace();
			return false;
		}
	}
	
	@At("/bandPhoneNum")
	public boolean bandPhoneNum(HttpServletRequest request,HttpServletResponse response){
		String newPhoneNum = request.getParameter("newPhoneNum");
		String userId = request.getParameter("userId");
		User user = new User();
		user.setPhoneNumber(newPhoneNum);
		user.setUserId(userId);
		try{
			userInfoService.updatePhoneById(user);
			return true;
		}catch(Exception e){
			e.printStackTrace();
			return false;
		}
	}
	
	@At("/getPhoneNum")
	public void getPhoneNum(HttpServletRequest request,HttpServletResponse response){
		String phoneNum = request.getParameter("phoneNum");
		String userId = request.getParameter("userId");
		String randNum = CommonUtil.randNum(4);
		try{
			//调用短信接口，发送信息
			SendSMS.sendAuthCd(phoneNum,userId,randNum); 
			
			response.setContentType("text/html;charset=UTF-8"); 
			response.getWriter().write(randNum);
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	@At("/checkHasPhone")
	public void checkHasPhone(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String userId = request.getParameter("userId");
		User user = userInfoService.getUserByUserId(userId);
		String phoneNum = user.getPhoneNumber();
		if(phoneNum == null || "".equals(phoneNum)){
			response.getWriter().write("0");
		}else{
			response.getWriter().write("1");
		}
	}

	@At("/updateImagUrl")
	public void updateImgUrl(HttpServletRequest request,HttpServletResponse response) throws Exception{
		//访问地址组合
		String USER_INFO_URL = "https://api.weixin.qq.com/cgi-bin/user/info";
		Token  token = TokenFactory.getTokenFromRedis(App.APP_ID, App.APP_SECRET);
		String openId = request.getParameter("userId");
		String action_url = USER_INFO_URL + "?access_token=" + token.getTokenStr() + "&openid=" + openId + "&lang=zh_CN";
//		log.info(action_url);
		//获取
		JSONObject json = WeiXinUtil.httpRequest(action_url, "GET", null);
		if(json.has("subscribe")){
//			log.info(json.toString());
			double subscribe = json.getDouble("subscribe");
			if(subscribe == 1){
				//关注了公众号了的
				String openid = json.getString("openid");
				String headimgurl = json.getString("headimgurl");
				String nickname = json.getString("nickname");
				userInfoService.updateGzUserInfo(openid, headimgurl, nickname, 1);
				response.getWriter().write(headimgurl);
			}else{
				//没关注公众号的
				String openid = json.getString("openid");
				userInfoService.updateUnGzUserInfo(openid, 0);
				response.getWriter().write("0");
			}
		}
	}
	@At("/guanZhu")
	public void updateGuanZhu(HttpServletRequest request,HttpServletResponse response) throws Exception{
		//更新关注Flag
		String openId = request.getParameter("userId");
		userInfoService.updateUnGzUserInfo(openId, 1);
		response.getWriter().write("1");		
	}
	
	@At("getTransPointsRecords")
	public View getTransPointsRecords(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String userId = request.getParameter("userId");
		int pageNum = Integer.parseInt(request.getParameter("pageNumber"));
		UserPointsService userPointsService = new UserPointsService();
		List<PersonTransRecord> personTransRecord = userPointsService.getTenTransRecordsByUserId(userId, pageNum);
		return new ViewWrapper(new JspView("jsp.personTransRecord"),personTransRecord);
	}
	
	@At("myProphecy")
	public View myProphecy(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String userId = "2";//request.getParameter("userId");
		Map<String,Object> data = new HashMap<String,Object>();
		User user = userInfoService.getUserByUserId(userId);
		String forecastAccuracy = user.getForecastAccuracy();
		int winNumOfTime =  Integer.parseInt(forecastAccuracy.substring(0, forecastAccuracy.length()-1));
		int loseNumOfTime = 100-winNumOfTime;
		data.put("win", winNumOfTime);
		data.put("lose", loseNumOfTime);
		return new ViewWrapper(new JspView("jsp.myProphecy"),data);
	}
	
	
}
