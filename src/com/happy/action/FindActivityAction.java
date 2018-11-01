package com.happy.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.nutz.json.JsonFormat;
import org.nutz.mvc.View;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Param;
import org.nutz.mvc.view.JspView;
import org.nutz.mvc.view.UTF8JsonView;
import org.nutz.mvc.view.ViewWrapper;

import com.happy.model.UnreadMesUserInfo;
import com.happy.model.User;
import com.happy.service.CareAboutService;
import com.happy.service.FindActivityService;
import com.happy.service.UnreadMesService;
import com.happy.service.UserActivityServices;
import com.happy.service.UserInfoService;
import com.happy.weixin.app.App;
import com.happy.weixin.tokenweb.TokenWeb;
import com.happy.weixin.tokenweb.TokenWebService;

@At("/")
public class FindActivityAction {

	protected FindActivityService findActivityService = new FindActivityService();
	protected UnreadMesService unreadMesService = new UnreadMesService();
	protected UserInfoService userInfoService = new UserInfoService();
	protected CareAboutService careAboutService = new CareAboutService();
	protected UserActivityServices userActivityService = new UserActivityServices();
		
	@At("/findActivity")
	public View findActivities(@Param("code")String code,HttpServletRequest request,HttpServletResponse response){
		TokenWeb tokenweb=TokenWebService.getNewTokenWebObject(App.APP_ID, App.APP_SECRET, code);
		String userId =tokenweb.getOpenId();
		
//		String userId = "oxw8iwQ_DPNKHlfM6MRUp7n2sFcI";
		//当先选择的行业类型1、热点、2股市，3财经
		String typeOfKind = request.getParameter("type");
		int typeOfkindint = 2;
		if(typeOfKind != null){
			typeOfkindint = Integer.parseInt(typeOfKind);
		}
		
		List<Map> acts = new ArrayList<Map>();
		//获取是否有未读信息列表
		UnreadMesUserInfo unreadMes = new UnreadMesUserInfo();
		//获取本周的固定活动和今天的固定活动
		List<Map> actsOfWeekAndDay = new ArrayList<Map>();
		actsOfWeekAndDay = findActivityService.getActsOfWeekAndDay();
		
		acts = findActivityService.getNextTopTenActivityRecords(typeOfkindint,0);
		List<UnreadMesUserInfo>  listOfUnread = new LinkedList<UnreadMesUserInfo>();
		listOfUnread = unreadMesService.getUnreadMes(userId);
		int countOfUnread = 0;
		//获取是否有未读信息列表
		if(listOfUnread.size()>0){
			unreadMes = listOfUnread.get(0);
			for(int i = 0 ; i < listOfUnread.size() ; i++){
				countOfUnread = countOfUnread + listOfUnread.get(i).getCountOfUnOfEachAct();
			}
		}
		if(actsOfWeekAndDay!=null && actsOfWeekAndDay.size()>0)
		{
			List<String> tempList = null;
			for(int i=0; i<actsOfWeekAndDay.size(); i++)
			{
				tempList = new ArrayList<String>();
				Map tempMap = actsOfWeekAndDay.get(i);
				tempList = findActivityService.getActParHeaderImg((String)tempMap.get("activity_id"));
				tempMap.put("parimg", tempList);
				//判断是否关注了此活动
				try
				{
					User user = userInfoService.getUserByUserId(userId);
					if(user!=null)
					{
						String tempActId = (String)tempMap.get("activity_id");
						if(findActivityService.isCared(userId, tempActId))
						{
							tempMap.put("isGz", 1);
						}
						else
						{
							tempMap.put("isGz", 0);
						}
					}
					else
					{
						tempMap.put("isGz", -1);
					}
				}
				catch(Exception e)
				{
					e.printStackTrace();
				}
			}
		}
		
		if(acts!=null && acts.size()>0)
		{
			List<String> tempList = null;
			for(int i=0; i<acts.size(); i++)
			{
				tempList = new ArrayList<String>();
				Map tempMap = acts.get(i);
				tempList = findActivityService.getActParHeaderImg((String)tempMap.get("activity_id"));
				tempMap.put("parimg", tempList);
				//判断是否关注了此活动
				try
				{
					User user = userInfoService.getUserByUserId(userId);
					if(user!=null)
					{
						String tempActId = (String)tempMap.get("activity_id");
						if(findActivityService.isCared(userId, tempActId))
						{
							tempMap.put("isGz", 1);
						}
						else
						{
							tempMap.put("isGz", 0);
						}
					}
					else
					{
						tempMap.put("isGz", -1);
					}
				}
				catch(Exception e)
				{
					e.printStackTrace();
				}
			}
			Map neMap = acts.get(acts.size()-1);
			request.setAttribute("page", "0");
		}
		request.setAttribute("userId", userId);
		request.setAttribute("acts", acts);
		request.setAttribute("actsOfWeekAndDay", actsOfWeekAndDay);
		request.setAttribute("typeId", typeOfkindint);
		request.setAttribute("unreadMes", unreadMes);
		request.setAttribute("countOfUnread", countOfUnread);
//		return new ViewWrapper(new UTF8JsonView(new JsonFormat()), null);
		return new ViewWrapper(new JspView("jsp.findactivity2"),null);
	}
	
	
	@At("/loadMore")
	public View loadMoreAct(HttpServletRequest request,HttpServletResponse response){
		List<Map> data = new ArrayList<Map>();
		List<Map> actsOfWeekAndDay = new ArrayList<Map>();
		List<Map> tempAct = new ArrayList<Map>();
		String typeOfKind = request.getParameter("type");
		int typeOfkindint = 1;
		if(typeOfKind != null){
			typeOfkindint = Integer.parseInt(typeOfKind);
		}
		
		String page = request.getParameter("page");
		int pageOfkindint = 0;
		if(page != null){
			pageOfkindint = Integer.parseInt(page);
		}
		if(pageOfkindint == 0){
			actsOfWeekAndDay = findActivityService.getActsOfWeekAndDay();
		}

		String userId = request.getParameter("userId");
		tempAct = findActivityService.getNextTopTenActivityRecords(typeOfkindint,pageOfkindint);
		if(typeOfkindint == 2 && pageOfkindint == 0){
			data.addAll(actsOfWeekAndDay);
		}
		data.addAll(tempAct);			
			if(data!=null && data.size()>0)
			{
				List<String> tempList = null;
				for(int i=0; i<data.size(); i++)
				{
					tempList = new ArrayList<String>();
					Map tempMap = data.get(i);
					tempList = findActivityService.getActParHeaderImg((String)tempMap.get("activity_id"));
					tempMap.put("parimg", tempList);
					try
					{
						User user = userInfoService.getUserByUserId(userId);
						if(user!=null)
						{
							String tempActId = (String)tempMap.get("activity_id");
							if(findActivityService.isCared(userId, tempActId))
							{
								tempMap.put("isGz", 1);
							}
							else
							{
								tempMap.put("isGz", 0);
							}
						}
						else
						{
							tempMap.put("isGz", -1);
						}
					}
					catch(Exception e)
					{
						e.printStackTrace();
					}
				}
			}
		return new ViewWrapper(new UTF8JsonView(new JsonFormat()), data);
	}
	
	@At("care/careOrNot")
	public View careOrNot(HttpServletRequest request,HttpServletResponse response){
		String userId = request.getParameter("userId");
		String actId = request.getParameter("actId");
		String flag = request.getParameter("flag");
		if("1".equalsIgnoreCase(flag))
		{
			//关注
			careAboutService.valid(actId, userId, "gz");
		}
		else
		{
			//取消关注
			try {
				userActivityService.deleteCareActivity(actId, userId);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return new ViewWrapper(new UTF8JsonView(new JsonFormat()), 1);
	}
	
	@At("/listOfNBuser")
	public View listOfNBuser(HttpServletRequest request,HttpServletResponse response){
		//得到用户的头像
		String userId = request.getParameter("userId");
		Map<String,Object> data = new HashMap<String,Object>();
		List<HashMap<String, Object>> dataAllAct = new ArrayList<HashMap<String, Object>>();
		//获取是否有未读信息列表
		try
		{
			dataAllAct = userActivityService.getUserActivityInfo(userId, null);
			
			
			data.put("dataAllAct", dataAllAct);
			data.put("theUserId", userId);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return new ViewWrapper(new JspView("jsp.listOfNBestUser"),data);
	}
}
