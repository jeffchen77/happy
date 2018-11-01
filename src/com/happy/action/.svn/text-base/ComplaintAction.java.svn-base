package com.happy.action;

import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.nutz.mvc.View;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.view.JspView;
import org.nutz.mvc.view.ViewWrapper;

import com.happy.model.Activity;
import com.happy.model.Complaint;
import com.happy.model.SysMessage;
import com.happy.model.User;
import com.happy.service.ComplaintService;
import com.happy.service.UserActivityServices;
import com.happy.service.UserInfoService;
import com.happy.utils.CommonUtil;

public class ComplaintAction {
	
	private static Logger log = LogManager.getLogger(ComplaintAction.class);
	
	ComplaintService complaintSerivce = new ComplaintService();
	UserInfoService userInfoService = new UserInfoService();
	UserActivityServices userActivityService = new UserActivityServices();
	
	@At("/insertComplaint")
	public void insertComplaint(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String activityId = request.getParameter("activityId");
		String activityOwnerUserId = request.getParameter("activityOwnerUserId");
		String complaintOwnerUserId = request.getParameter("complaintOwnerUserId");
		String complaintContent = request.getParameter("complaintContent");
		Date date=new Date();
		Timestamp createTime = Timestamp.valueOf(CommonUtil.formatDateTimeToYYYYMMDDHHMMSS(date));
		
		Complaint complaint = new Complaint();
		complaint.setActivity_id(activityId);
		complaint.setCreate_user(complaintOwnerUserId);
		complaint.setComplaint_content(complaintContent);
		complaint.setCreate_time(createTime);
		complaint.setExcute_status("0");
		
		SysMessage mes = new SysMessage();
		mes.setActivityId(activityId);
		mes.setBody(complaintContent);
		mes.setFromUserId(complaintOwnerUserId);
		mes.setToUserId(activityOwnerUserId);
		mes.setStatus(0);
		mes.setSendTime(createTime);
		mes.setTitle("投诉！");
		
//		List<Complaint> complaintBefore = complaintSerivce.getComplaintByTwoUserId(activityId, activityOwnerUserId, complaintOwnerUserId);
//		int size = complaintBefore.size();
//		if(size > 0){
//			response.getWriter().write("1");
//		}else{
			try{
				List<String> recipients = new LinkedList<String>();
				StringBuffer content = new StringBuffer();
				
				User actOwner = userInfoService.getUserByUserId(activityOwnerUserId);
				User complaintUser = userInfoService.getUserByUserId(complaintOwnerUserId);
				Activity activity = userActivityService.getActivityByActivityId(activityId);
				

				String mailTitle = "朕以为---投诉情况通知";
				//接收人地址
				recipients.add(actOwner.getEmailAddress());
				recipients.add(complaintUser.getEmailAddress());
				//邮件内容
				content.append("这是一个投诉通知，在‘"+activity.getActivityDesc()+"’活动中，"+complaintUser.getNickName()+"投诉有朋友未能及时执行奖惩互动！！");
				
				complaintSerivce.insertComplaint(complaint);
				userInfoService.sendSysMessage(mes);
				userActivityService.sendMessage(recipients,mailTitle,content.toString());
			}catch(Exception e){
			}
			response.getWriter().write("0");
//		}
		
	}
	
	
	
	@At("/complaintIndex")
	public View complaintIndex(HttpServletRequest request,HttpServletResponse response){
		Map<String,Object> data = new HashMap<String,Object>();
		String activityId = request.getParameter("activityId");
		String activityOwnerUserId = request.getParameter("activityOwnerUserId");
		String complaintOwnerUserId = request.getParameter("complaintOwnerUserId");
		data.put("activityId", activityId);
		data.put("activityOwnerUserId", activityOwnerUserId);
		data.put("complaintOwnerUserId", complaintOwnerUserId);
		return new ViewWrapper(new JspView("jsp.complaintIndex"),data);
	}
}
