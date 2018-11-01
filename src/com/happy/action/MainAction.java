package com.happy.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.nutz.mvc.View;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.By;
import org.nutz.mvc.annotation.Encoding;
import org.nutz.mvc.annotation.Filters;
import org.nutz.mvc.annotation.Modules;
import org.nutz.mvc.annotation.Param;
import org.nutz.mvc.view.JspView;
import org.nutz.mvc.view.ViewWrapper;

import com.happy.filter.LogFilter;
import com.happy.model.WechatUser;
import com.happy.service.GameServices;
import com.happy.service.URLService;
import com.happy.utils.CustomMsgUtil;
import com.happy.utils.Sign;
import com.happy.weixin.app.App;
import com.happy.weixin.tokenweb.TokenWeb;
import com.happy.weixin.tokenweb.TokenWebService;
import com.happy.weixin.wechatuser.WeChatUserService;

@Modules(scanPackage=true)
@Encoding(input="UTF-8", output="UTF-8")
@Filters(value = {@By(type = LogFilter.class)})
public class MainAction {
	
	protected GameServices gameServices = new GameServices();
	@At("/")
	public View index(HttpServletRequest request,HttpServletResponse response){
		Map<String,Object> data = new HashMap<String,Object>();
		try
		{
		String url = URLService.getFullUrl(request);
		Map<String,String> weixinparames = Sign.getSignParams(url, App.APP_ID, App.APP_SECRET);
		weixinparames.put("appId", App.APP_ID);
		data.put("weixinparames", weixinparames);
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return new ViewWrapper(new JspView("jsp.index"),data);
	}
	@At("/testoauth")
	public View testOauth(@Param("code")String code,@Param("scope")String scope,@Param("activityId") String activityId,
			HttpServletRequest request,HttpServletResponse response){	
		WechatUser wechatUser = null;
		try
		{
		TokenWeb tokenweb=TokenWebService.getNewTokenWebObject(App.APP_ID, App.APP_SECRET, code);
		String openId =tokenweb.getOpenId();
		wechatUser = gameServices.getInfoFromWechatUser(openId);
		if(wechatUser==null)
		{
	String redirectUrl = "http://"+App.APP_SERVER+"/"+App.APP_NAME+"/weixin/oauth?scope=userinfo&activityId="+activityId+"&action=testBussiness";
			response.sendRedirect(redirectUrl);
			return null;
		}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		Map<String,Object> data = new HashMap<String,Object>();
		request.setAttribute("WechatUser", wechatUser);
		request.setAttribute("activityId", activityId);
		return new ViewWrapper(new JspView("jsp.test"),"");
	}
	
	@At("/testBussiness")
	public View testBussiness(@Param("code")String code,@Param("scope")String scope,@Param("activityId") String activityId,
			HttpServletRequest request,HttpServletResponse response){
		
		WechatUser wechatUser = null;
		try
		{
			wechatUser = WeChatUserService.getWeixinUser(code);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		Map<String,Object> data = new HashMap<String,Object>();
		request.setAttribute("WechatUser", wechatUser);
		request.setAttribute("activityId", activityId);
		return new ViewWrapper(new JspView("jsp.test"),"");
	}
	@At("/testmsg")
	public View testmsg(HttpServletRequest request,HttpServletResponse response){
		Map<String,Object> data = new HashMap<String,Object>();
		try
		{
			String userId=(String)request.getParameter("userId");
		int ret=0;
//		int ret = CustomMsgUtil.sendResultTemplateMsg(userId, "");
		request.setAttribute("msgret", ret);
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return new ViewWrapper(new JspView("jsp.index"),0);
	}
}
