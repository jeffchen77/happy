package com.happy.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.nutz.mvc.View;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Param;
import org.nutz.mvc.view.JspView;
import org.nutz.mvc.view.ViewWrapper;

import com.happy.service.WeixinEventService;
import com.happy.utils.CommonUtil;
import com.happy.utils.SignUtil;
import com.happy.weixin.MenuService;
import com.happy.weixin.app.App;

@At("/weixin")
public class WeixinAction {
	
	@At("/baseoauth")
	public View getAuthBase(@Param("action")String action,@Param("activityId") String activityId,
			@Param("paramstr") String paramstr, HttpServletRequest request,HttpServletResponse response){		
		String redirectUrl = "http://"+App.APP_SERVER+"/"+App.APP_NAME+"/"+action+"?scope=base&activityId="+activityId;
		if(!CommonUtil.isEmpty(paramstr))
		{
			redirectUrl += "&"+paramstr;
		}
		String num = request.getParameter("num");
		if(!CommonUtil.isEmpty(num))
		{
			redirectUrl += "&num="+num;
		}
			try {
				response.sendRedirect("https://open.weixin.qq.com/connect/oauth2/authorize?appid="+App.APP_ID+"&redirect_uri="+
			URLEncoder.encode(redirectUrl, "utf-8")+"&response_type=code&scope=snsapi_base&state=123#wechat_redirect");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			return null;
		}
	

	
	@At("/oauth")
	public View getAuthcode(@Param("action")String action,@Param("activityId") String activityId,
			@Param("paramstr") String paramstr, HttpServletRequest request,HttpServletResponse response){
	String redirectUrl = "http://"+App.APP_SERVER+"/"+App.APP_NAME+"/"+action+"?scope=userinfo&activityId="+activityId;
		if(!CommonUtil.isEmpty(paramstr))
		{
			redirectUrl += "&"+paramstr;
		}
		String num = request.getParameter("num");
		if(!CommonUtil.isEmpty(num))
		{
			redirectUrl += "&num="+num;
		}
		try {
			response.sendRedirect("https://open.weixin.qq.com/connect/oauth2/authorize?appid="+App.APP_ID+"&redirect_uri="+
		URLEncoder.encode(redirectUrl, "utf-8")+"&response_type=code&scope=snsapi_userinfo&state=123#wechat_redirect");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}

	@At("/createMenu")
	public View createWeiMenu(HttpServletRequest request,HttpServletResponse response){
		try
		{
		 MenuService.createMenu();
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		request.setAttribute("menuCreated", "Y");
		return new ViewWrapper(new JspView("jsp.index"),"");
	}

	
	@At("/weievent")
	public View weievent(HttpServletRequest request,HttpServletResponse response){
		String method = request.getMethod();
		if("GET".equalsIgnoreCase(method))
		{
			//get 方法
			weiDoGet(request, response);
		}
		else if("POST".equalsIgnoreCase(method))
		{
			//post 方法
			weiDoPost(request, response);
		}
		else
		{
			//DO NOTHING
		}
		return null;
	}
	
	/*
	 * get 方法, 处理微信发送的get 请求
	 */
	private void weiDoGet(HttpServletRequest request,HttpServletResponse response)
	{
		try
		{
			// 微信加密签名
			String signature = request.getParameter("signature");
			// 时间戳
			String timestamp = request.getParameter("timestamp");
			// 随机数
			String nonce = request.getParameter("nonce");
			// 随机字符串
			String echostr = request.getParameter("echostr");
	
			PrintWriter out = response.getWriter();
			// 通过检验signature对请求进行校验，若校验成功则原样返回echostr，表示接入成功，否则接入失败
			if (SignUtil.checkSignature(signature, timestamp, nonce)) {
				out.print(echostr);
			}
			out.close();
			out = null;
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	
	/*
	 * post 方法， 处理微信发送的post 请求
	 */
	private void weiDoPost(HttpServletRequest request,HttpServletResponse response)
	{
		try
		{
			// 将请求、响应的编码均设置为UTF-8（防止中文乱码）  
	        request.setCharacterEncoding("UTF-8");
	        response.setCharacterEncoding("UTF-8");
	        
	     // 调用核心业务类接收消息、处理消息  
	        String respMessage = WeixinEventService.processRequest(request); 
	        
	        PrintWriter out = response.getWriter();  
	        out.print(respMessage);  
	        out.close();  
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}

}
