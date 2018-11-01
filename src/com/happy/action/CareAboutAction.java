package com.happy.action;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.nutz.json.JsonFormat;
import org.nutz.mvc.View;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Param;
import org.nutz.mvc.view.UTF8JsonView;
import org.nutz.mvc.view.ViewWrapper;

import com.happy.model.Activity;
import com.happy.model.ActivityComments;
import com.happy.model.Participate;
import com.happy.model.User;
import com.happy.model.WechatUser;
import com.happy.service.CareAboutService;
import com.happy.service.GameServices;
import com.happy.service.UserInfoService;
import com.happy.utils.CommonUtil;

public class CareAboutAction {
	protected CareAboutService care = new CareAboutService();
	protected UserInfoService userServie= new UserInfoService();
	protected GameServices gameServices = new GameServices();

	@At("/careAbout")
	public View careAbout(@Param("activityId") String activityId,@Param("userId") String userId,@Param("flag") String attitudeType,
			HttpServletRequest request,HttpServletResponse response){
		
		List<String> data = new ArrayList<String>();
		if("gz".equalsIgnoreCase(attitudeType))
		{
			
			try
			{
			User user=userServie.getUserByUserId(userId);
			if(user== null || (CommonUtil.isEmpty(user.getEmailAddress()) && CommonUtil.isEmpty(user.getPhoneNumber())))
			{
				return new ViewWrapper(new UTF8JsonView(new JsonFormat()), "NOT");
			}
			else
			{
			boolean b=care.valid(activityId,userId,attitudeType);
			if(b)
			{
				
				return new ViewWrapper(new UTF8JsonView(new JsonFormat()), "yes");
			}
			}
			}catch(Exception e){
				e.printStackTrace();
			}
			
		
		}
		else
		{ 
			boolean b=care.valid(activityId,userId,attitudeType);
			if(b)
			{
				data=insertComments(userId,activityId,attitudeType);
				List<String> commentIdList=null;
				try {
					commentIdList = gameServices.getCurrentInsertCommentId(activityId, userId);
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				if(commentIdList!=null){
					data.add(commentIdList.get(0));	
				}
				
				return new ViewWrapper(new UTF8JsonView(new JsonFormat()), data);
			}
			
		}
		
		return new ViewWrapper(new UTF8JsonView(new JsonFormat()), "no");
		
	}
	
	public List<String> insertComments(String userId, String activityId,String attitudeType) {
		WechatUser wechatUser=new WechatUser();
		List<String> data = new ArrayList<String>();
		Timestamp currentTime = new Timestamp(System.currentTimeMillis());
		ActivityComments activitycomments = new ActivityComments();
		activitycomments.setActivityId(activityId);
		activitycomments.setUserId(userId);
		String comments="";
		if("bb".equalsIgnoreCase(attitudeType))
			comments="我看好你";
		else if("rb".equalsIgnoreCase(attitudeType))
			comments="我强烈反对";
		else
		{
			comments="我只是路过的";
		}
		activitycomments.setComments(comments);
		activitycomments.setCreateTime(currentTime);
		try {
			wechatUser = gameServices.getInfoFromWechatUser(userId);
			gameServices.insertComments(activitycomments);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if(wechatUser==null)
		{
			data.add("");
			data.add("游客");	
		}
		else
		{
		data.add(wechatUser.getHeadImgUrl());
		data.add(wechatUser.getNickName());
		}
		data.add(comments);
		data.add(currentTime.toString());
		return data;

	}
	
	@At("/getOnlookers")
	public View getOnlookers(@Param("activityId") String activityId){
		List<Integer> data = new ArrayList<Integer>();
		
		int gzCount=care.countOnlookers(activityId,"gz");
		int bbCount=care.countOnlookers(activityId,"bb");
		int rbCount=care.countOnlookers(activityId,"rb");
		int nnCount=care.countOnlookers(activityId,"nn");
		
		data.add(gzCount);
		data.add(bbCount);
		data.add(rbCount);
		data.add(nnCount);
		
		return new ViewWrapper(new UTF8JsonView(new JsonFormat()), data);
	}
	public static void main(String args[]){
		String userId="     ";
		String activityId="3r52ysgdak";
		int count=0;
		CareAboutService care = new CareAboutService();
		count=care.countOnlookers(activityId,"gz");
//		boolean b=care.valid(activityId,userId);
		System.out.println(CommonUtil.getRandEmoji());		
		System.out.println(count);
	
	}
}
