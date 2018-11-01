package com.happy.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.nutz.json.JsonFormat;
import org.nutz.mvc.View;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.view.JspView;
import org.nutz.mvc.view.UTF8JsonView;
import org.nutz.mvc.view.ViewWrapper;

import com.happy.service.UserInfoService;
import com.happy.service.UserReportsService;
import com.happy.utils.CustomMsgUtil;

public class UserReportsAction {
	UserReportsService urs = new UserReportsService();
	UserInfoService uf = new UserInfoService();
	
	@At("/getUserReport")
	public View getUserReport(HttpServletRequest request,HttpServletResponse response){
		Map<String,Object> data = new HashMap<String,Object>();
		String userId = request.getParameter("userId");
		List<Map> reportForUserId = null;
		reportForUserId = urs.getUserReport(userId);
		List<Map> reportForAllUser = null;
		reportForAllUser = urs.getAllUserReport();
		
		//一下代码是判断用户有多少个赞和当前用户赞了哪些人
		if(reportForAllUser!=null && reportForAllUser.size()>0)
		{
			for(int i=0; i<reportForAllUser.size(); i++)
			{
				Map<String, String> tmap = (HashMap<String, String>)reportForAllUser.get(i);
				String toUserId = (String)tmap.get("userId");
				int toTotal = urs.getClickZanTotal(toUserId);
				tmap.put("toTotal", toTotal+"");
				//当前用户赞过这个人吗
				int isClickedToday = urs.isClickZanToday(userId, toUserId);
				tmap.put("isClickedToday", isClickedToday+"");
			}
		}
		
		data.put("reportForUserId", reportForUserId);
		data.put("reportForAllUser", reportForAllUser);
		data.put("userOpenId", userId);
		return new ViewWrapper(new JspView("jsp.userReports"),data);	
	}
	
	@At("surport/doSurport")
	public View doSurport(HttpServletRequest request,HttpServletResponse response){
		String fromUserId = request.getParameter("fromUserId");
		String toUserId = request.getParameter("toUserId");
		urs.insertReportZhan(fromUserId, toUserId);
		String nickName = null;
		try {
			nickName = uf.getUserByUserId(fromUserId).getNickName();
		} catch (Exception e) {
			e.printStackTrace();
		}
		CustomMsgUtil.sendCustomMsg(toUserId, nickName+"送"+"/:heart");
		return new ViewWrapper(new UTF8JsonView(new JsonFormat()), 1);
	}
}
