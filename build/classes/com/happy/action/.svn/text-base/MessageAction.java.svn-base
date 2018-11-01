package com.happy.action;

import java.util.ArrayList;
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
import org.nutz.mvc.annotation.Param;
import org.nutz.mvc.view.JspView;
import org.nutz.mvc.view.UTF8JsonView;
import org.nutz.mvc.view.ViewWrapper;

import com.happy.model.SysMessage;
import com.happy.model.UnreadMesUserInfo;
import com.happy.model.UnreadMessage;
import com.happy.model.WechatUser;
import com.happy.service.UnreadMesService;
import com.happy.service.UserInfoService;
import com.happy.utils.CommonUtil;
import com.happy.weixin.app.App;
import com.happy.weixin.tokenweb.TokenWeb;
import com.happy.weixin.tokenweb.TokenWebService;

public class MessageAction {
	private static Logger log = LogManager.getLogger(MessageAction.class);
	UserInfoService userInfoService = new UserInfoService();
	
    /*
     * 获取系统消息
     */
	@At("/getMessage")
	public View getSysMessageById(@Param("userId") String userId, @Param("status") String status,
			HttpServletRequest request,HttpServletResponse response) throws Exception
	{
		List<SysMessage> mesList = new ArrayList<SysMessage>();	
		//未读消息ComentsInfoNotRead
		List<Map> ComentsInfoNotRead =  new ArrayList<Map>();
		//已读消息ComentsInfoHadRead
		List<Map> ComentsInfoHadRead =  new ArrayList<Map>();
		
		try{
			//获取数据库所有的信息
			mesList = userInfoService.getSysMessageById(userId,status);
			for(int i =0 ;i < mesList.size(); i++)
			{  	
				SysMessage mes = new SysMessage();
				mes = mesList.get(i);
				if(mes.getStatus() == 1)
				{
					//获取已读信息
					Map<String,Object> mapHadRead = new HashMap<String,Object>();
					mapHadRead.put("href", "#readMsgOneContent"+i);
					mapHadRead.put("id", "readMsgOneContent"+i);
					mapHadRead.put("divId", "readMsgOne"+i);
					mapHadRead.put("spanId", "readMsgOne"+i+"Icon");
					mapHadRead.put("userId", mes.getToUserId());
					mapHadRead.put("sendTime", CommonUtil.formatDateTimeToYYYYMMDDHHMMSS(mes.getSendTime()));
					mapHadRead.put("body", mes.getBody());
					mapHadRead.put("title",  mes.getTitle());
					WechatUser weChatUser = new WechatUser(); 
					weChatUser = userInfoService.getWechatUserById(mes.getFromUserId());
					//获取头像url
					if(weChatUser != null)
					{
						mapHadRead.put("head",weChatUser.getHeadImgUrl());
					}
					ComentsInfoHadRead.add(mapHadRead);
				}
				else if(mes.getStatus() == 0)
				{
					//获取未读信息
					Map<String,Object> mapNotRead = new HashMap<String,Object>();
					mapNotRead.put("href", "#unreadMsgOneContent"+i);
					mapNotRead.put("id", "unreadMsgOneContent"+i);
					mapNotRead.put("divId", "unreadMsgOne"+i);
					mapNotRead.put("userId", mes.getToUserId());
					mapNotRead.put("spanId", "unreadMsgOne"+i+"Icon");
					mapNotRead.put("sendTime", CommonUtil.formatDateTimeToYYYYMMDDHHMMSS(mes.getSendTime()));
					mapNotRead.put("body", mes.getBody());
					mapNotRead.put("title",  mes.getTitle());
					WechatUser weChatUser = new WechatUser(); 
					weChatUser = userInfoService.getWechatUserById(mes.getFromUserId());
					//获取头像url
					if(weChatUser != null)
					{
						mapNotRead.put("head",weChatUser.getHeadImgUrl());
					}
					
					userInfoService.readSysMessage(0,mes.getToUserId());
					ComentsInfoNotRead.add(mapNotRead);
				}	
			}	
		}catch(Exception e){
			e.printStackTrace();
		}
			//放到request， 并返回页面
			 request.setAttribute("ComentsInfoNotRead", ComentsInfoNotRead);	
			 request.setAttribute("ComentsInfoHadRead", ComentsInfoHadRead);
			 request.setAttribute("theUserId", userId);
			 return new ViewWrapper(new JspView("jsp.message"),"");	
	}	
	
	/*
	 * user come from 服务号
	 */
	@At("/messageIndex")
	public View messageIndex(@Param("code")String code,@Param("scope")String scope,
			HttpServletRequest request,HttpServletResponse response) throws Exception{
		
		
		TokenWeb tokenweb=TokenWebService.getNewTokenWebObject(App.APP_ID, App.APP_SECRET, code);
		String userId =tokenweb.getOpenId();	
		return this.getSysMessageById(userId, null, request, response);				
		
	}
	
	@At("/toListOfUnread")
	public View toListOfUnread(@Param("code")String code,HttpServletRequest request,HttpServletResponse response) throws Exception{
		String userId = request.getParameter("userId");
		if(userId == null){
			TokenWeb tokenweb=TokenWebService.getNewTokenWebObject(App.APP_ID, App.APP_SECRET, code);
			userId =tokenweb.getOpenId();
		}
		Map<String,Object> data = new HashMap<String,Object>();
		
		UnreadMesService unreadMesService = new UnreadMesService();
		List<Map> listOfUnread =  unreadMesService.getUnreadMesAndRep(userId);
		List<Map> listOfReaded =  unreadMesService.getReadedMesAndRep(userId);
		List<Map> nBestComment  = unreadMesService.getNBestComment();
		data.put("listOfUnread", listOfUnread);
		data.put("listOfReaded", listOfReaded);
		data.put("nBestComment", nBestComment);
		data.put("openId", userId);
		return new ViewWrapper(new JspView("jsp.listOfUnreadMes"),data);
		
	}
	@At("/getSysTip")
	public View getSysTip(HttpServletRequest request,HttpServletResponse response)throws Exception{
				
		String tipId = request.getParameter("tipId");	
		SysMessage mess = userInfoService.getSysTip("sysadmin", tipId);
		return new ViewWrapper(new UTF8JsonView(new JsonFormat()), mess);
		
	}
}
