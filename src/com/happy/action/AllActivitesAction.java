package com.happy.action;


import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;
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

import com.happy.conf.ConfFactory;
import com.happy.model.Activity;
import com.happy.model.Participate;
import com.happy.model.Program;
import com.happy.model.SysMessage;
import com.happy.model.UnreadMesUserInfo;
import com.happy.model.UnreadMessage;
import com.happy.model.User;
import com.happy.model.UserPoints;
import com.happy.service.AwardService;
import com.happy.service.GameServices;
import com.happy.service.UnreadMesService;
import com.happy.service.UserActivityServices;
import com.happy.service.UserInfoService;
import com.happy.service.UserPointsService;
import com.happy.utils.CustomMsgUtil;
import com.happy.utils.MailUtil;
import com.happy.weixin.app.App;
import com.happy.weixin.tokenweb.TokenWeb;
import com.happy.weixin.tokenweb.TokenWebService;


@At("/")
public class AllActivitesAction {
	private static Logger log = LogManager.getLogger(AllActivitesAction.class);
	protected UserActivityServices userActivityService = new UserActivityServices();
	protected UserInfoService userInfoService = new UserInfoService();
	protected UserPointsService userPointsService = new UserPointsService();
	protected UnreadMesService unreadMesService = new UnreadMesService();
	protected SysMessage mes = null;
	protected Activity activitiy = null;
	protected GameServices gameServices = new GameServices();
	
	private String MAIL_SUBJECT=ConfFactory.getConf().get("mail.subject","结果通知---朕以为");
	
	@At("/myActivityIndex")
	public View getAllActivities(@Param("userId") String userId,@Param("ownerOrParter") String ownerOrParter){
		//得到用户的头像
//		userId = "222";
		Map<String,Object> data = new HashMap<String,Object>();
		List<HashMap<String, Object>> dataAllAct = new ArrayList<HashMap<String, Object>>();
		List<HashMap<String, Object>> dataParter = new ArrayList<HashMap<String, Object>>();
		//取得当前user收藏的活动
		List<HashMap<String, Object>> careParter =new ArrayList<HashMap<String, Object>>();
		//获取是否有未读信息列表
		UnreadMesUserInfo unreadMes = new UnreadMesUserInfo();
		try
		{
			dataAllAct = userActivityService.getUserActivityInfo(userId, null);
			dataParter = userActivityService.getParticipateInfo(userId, null);
			careParter = userActivityService.getCareInfo(userId, null);
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
			
			
			data.put("dataAllAct", dataAllAct);
			data.put("dataParter", dataParter);
			data.put("careParter", careParter);
			data.put("ownerOrParter", ownerOrParter);
			data.put("theUserId", userId);
			data.put("unreadMes", unreadMes);
			data.put("countOfUnread", countOfUnread);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return new ViewWrapper(new JspView("jsp.allactivities"),data);
	}
	

	@At("/saveUserSelected")
	public View saveUserSelected(@Param("actId") String actId, @Param("status") int status, @Param("dialogComment") String dialogComment)
	{
		List<HashMap<String, String>> data = new ArrayList<HashMap<String, String>>();
		try
		{			
			userActivityService.saveResultFlag(actId, status);
			//结算代码
			Activity activity = userActivityService.getActivityByActivityId(actId);
			if(activity.getStakePoints()>0)
			{
				data = billSettlement(actId, status, dialogComment);
			}
			
			//得到反对的人的邮件地址，并且发送邮件通知
			List<String> recipients = userActivityService.getMailAddressBasedOnActId(actId, "N");
			List<String> nickNames = userActivityService.getAllNickNameBasedOnActId(actId, "N");
//			List<String> userIds = userActivityService.getUserIdBasedOnActId(actId, "N");
			//得到支持者的信息
			List<String> proRecipients = userActivityService.getMailAddressBasedOnActId(actId, "Y");
			List<String> proNickNames = userActivityService.getAllNickNameBasedOnActId(actId, "Y");
//			List<String> proUserIds = userActivityService.getUserIdBasedOnActId(actId, "Y");
			
			
			List<String> list = userActivityService.getUserNameAndActTitle(actId);
			
			if(list!=null && list.size()>0  && activity!=null)
			{
				Map<String, String> paraMap = new HashMap<String, String>();
				String titlename = list.get(0);
				String arrTitle[] = titlename.split("&&");
				paraMap.put("actname", arrTitle[1]);
				paraMap.put("actuser", arrTitle[0]);
				paraMap.put("stake", arrTitle[2]);
				
				//活动支持者
				String proStrNames = "";
				if(proNickNames!=null && proNickNames.size()>0)
				{
					for(int i=0; i<proNickNames.size(); i++)
					{
						proStrNames+=proNickNames.get(i);
						if(i!=proNickNames.size()-1)
						{
							proStrNames+=",";
						}
					}
				}
				else
				{
					proStrNames = "无支持者";
				}
				paraMap.put("proparuser", proStrNames);
				
				//活动反对者
				String strNames = "";
				if(nickNames!=null && nickNames.size()>0)
				{
					for(int i=0; i<nickNames.size(); i++)
					{
						strNames+=nickNames.get(i);
						if(i!=nickNames.size()-1)
						{
							strNames+=",";
						}
					}
				}
				else
				{
					strNames = "无反对者";
				}
				paraMap.put("paruser", strNames);
				
				try{
				//添加发起者邮件地址到发送列表中
				recipients.add(arrTitle[3]);
				recipients.addAll(proRecipients);
				
				//获取发起者的邮件地址
				String userMail = arrTitle[3];
				List<String> sender = new ArrayList<String>();
				sender.add(userMail);
			
				//发送邮件给参与者
				if(status==1)
				{
					//参与者赢了
					MailUtil.SendMail(recipients, MAIL_SUBJECT, MailUtil.generateContent(paraMap, "actresultwin.ftl"));
				}
				else if(status==2)
				{
					//参与者输了
					MailUtil.SendMail(recipients, MAIL_SUBJECT, MailUtil.generateContent(paraMap, "actresultlose.ftl"));
				}	
				//此else 条件目前没用，暂时放在这里
				else if(status==3)
				{
					
					MailUtil.SendMail(recipients, MAIL_SUBJECT, MailUtil.generateContent(paraMap, "activitycanel.ftl"));
					
					MailUtil.SendMail(sender, MAIL_SUBJECT, MailUtil.generateContent(paraMap, "activitycanel.ftl"));
				}	
				//userActivityService.sendMessage(recipients,mailTitle,content.toString());
				}catch(Exception ex)
				{
					log.error("send mail message:"+ex.getMessage());
					ex.printStackTrace();
				}
				
				/*try{
				// 发送系统消息给反对者
				if(userIds!=null && userIds.size()>0)
				{
					SysMessage mes= null;
					for(int i=0; i<userIds.size();i++)
					{
						String cusContent="";
						mes = new SysMessage();
						mes.setActivityId(actId);
						if(status==1)
						{
							mes.setBody("你在活动《"+arrTitle[1]+"》中取胜了");
							cusContent = "恭喜您，你在活动<"+arrTitle[1]+">中取胜了";
						}
						else if(status==2)
						{
							mes.setBody("你在活动《"+arrTitle[1]+"》中失败了");
							cusContent = "很抱歉，你在活动<"+arrTitle[1]+">中失败了";
						}
						else if(status==3)
						{
							mes.setBody("活动《"+arrTitle[1]+"》已因故取消");
							cusContent = "你参与的活动<"+arrTitle[1]+">因故取消了";
						}
						mes.setFromUserId(activity.getUserId());
						mes.setToUserId(userIds.get(i));
						mes.setStatus(0);
						mes.setSendTime(new Date());
						mes.setTitle("【结果通知】");
//						userInfoService.sendSysMessage(mes);
//						CustomMsgUtil.sendCustomMsg(userIds.get(i), cusContent);
					}
				}
				}catch(Exception ex)
				{
					log.error("发送系统消息给反对者:"+ex.getMessage());
					ex.printStackTrace();
				}
				
				try{
				// 发送系统消息给支持者
				if(proUserIds!=null && proUserIds.size()>0)
				{
					SysMessage mes= null;
					for(int i=0; i<proUserIds.size();i++)
					{
						String cusContent="";
						mes = new SysMessage();
						mes.setActivityId(actId);
						if(status==1)
						{
							mes.setBody("你在活动《"+arrTitle[1]+"》中失败了");
							cusContent = "很抱歉，你在活动<"+arrTitle[1]+">中失败了";
						}
						else if(status==2)
						{
							mes.setBody("你在活动《"+arrTitle[1]+"》中取胜了");
							cusContent = "恭喜您，你在活动<"+arrTitle[1]+">中取胜了";
						}
						else if(status==3)
						{
							mes.setBody("活动《"+arrTitle[1]+"》已因故取消");
							cusContent = "你参与的活动<"+arrTitle[1]+">因故取消了";
						}
						mes.setFromUserId(activity.getUserId());
						mes.setToUserId(proUserIds.get(i));
						mes.setStatus(0);
						mes.setSendTime(new Date());
						mes.setTitle("【结果通知】");
//						userInfoService.sendSysMessage(mes);
						CustomMsgUtil.sendCustomMsg(proUserIds.get(i), cusContent);
					}
				}
				}catch(Exception ex)
				{
					log.error("发送系统消息给支持者:"+ex.getMessage());
					ex.printStackTrace();
				}
				//发送系统消息给活动发起者
				SysMessage usrMes= new SysMessage();
				usrMes.setActivityId(actId);
				if(status==1)
				{
					usrMes.setBody("你在你发起的活动《"+arrTitle[1]+"》中预测失败了");
				}
				else if(status==2)
				{
					usrMes.setBody("你在你发起的活动《"+arrTitle[1]+"》中预测成功了");
				}
				//此else 条件目前没用，暂时保留在这里
				else if(status==3)
				{
					usrMes.setBody("你发起的活动《"+arrTitle[1]+"》已因故取消");
				}
				usrMes.setFromUserId(activity.getUserId());
				usrMes.setToUserId(activity.getUserId());
				usrMes.setStatus(0);
				usrMes.setSendTime(new Date());
				usrMes.setTitle("【结果通知】");
//				userInfoService.sendSysMessage(usrMes);
				CustomMsgUtil.sendCustomMsg(activity.getUserId(), usrMes.getBody());*/
			}
		} 
		catch (Exception e)
		{
			log.error(e.getMessage());
			e.printStackTrace();
		}
		return new ViewWrapper(new UTF8JsonView(new JsonFormat()), data);
	}

	/*
	 * user come from 服务号
	 */
	@At("/activeIndex")
	public View activeIndex(@Param("code")String code,@Param("scope")String scope,
			HttpServletRequest request,HttpServletResponse response) throws Exception{
		
		
		TokenWeb tokenweb=TokenWebService.getNewTokenWebObject(App.APP_ID, App.APP_SECRET, code);
		String userId =tokenweb.getOpenId();
		return this.getAllActivities(userId, "1");
				
	}

	
	
	@At("/activityOfParter")
	public void activityOfParter(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String actId = request.getParameter("actId");
		try{
			List<Participate> partLs = userActivityService.getParticipateByActId(actId);
			int lsSize = partLs.size();
			if(lsSize == 0){
				response.setContentType("text/html;charset=UTF-8");
				response.getWriter().write("0");
			}else{
				response.setContentType("text/html;charset=UTF-8");
				response.getWriter().write("1");
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	
	
	@At("/cancelCare")
	public View cancelCare(@Param("actId") String activityId,@Param("userId") String userId,
			HttpServletRequest request,HttpServletResponse response) throws Exception{

	    //移除关注
		userActivityService.deleteCareActivity(activityId, userId);
		
		return new ViewWrapper(new UTF8JsonView(new JsonFormat()), "no");
		
	}
	
	
	@At("/deleteTheActivity")
	public void deleteTheActivity(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String actId = request.getParameter("actId");
		String creatTime = request.getParameter("creatTime");
		Timestamp createTimets = new Timestamp(System.currentTimeMillis()); 
		createTimets = Timestamp.valueOf(creatTime);
		Timestamp ts = new Timestamp(System.currentTimeMillis());
		long dvalue =(ts.getTime()-createTimets.getTime())/(1000*60);
		if(dvalue >= 3){
			response.setContentType("text/html;charset=UTF-8");
			response.getWriter().write("3");
		}else{
			try
			{	//设置saveResultFlag为-2		
				userActivityService.updateActivityStatusByActId(actId, -2);
				try
				{
					Activity activity = userActivityService.getActivityByActivityId(actId);
					unLockPoints(activity.getUserId(), activity.getStakePoints());
				}
				catch(Exception e)
				{
					e.printStackTrace();
				}
				//得到反对的人的邮件地址，并且发送邮件通知
				List<String> recipients = userActivityService.getMailAddressBasedOnActId(actId, "N");
				List<String> list = userActivityService.getUserNameAndActTitle(actId);
				if(list!=null && list.size()>0 && recipients!=null && recipients.size()>0)
				{
					String titlename = list.get(0);
					String arrTitle[] = titlename.split("&&");
					
					String mailTitle = "朕以为---活动情况通知";
					StringBuffer content = new StringBuffer();
					
					content.append("亲爱的<朕以为>参与者:</br>");
					content.append("  您参与的<"+arrTitle[1]+">活动已经在发起活动的三分钟内被删除了,");
					content.append("如有任何疑问，请登录微信公众号《朕以为》申诉。---朕以为!");
					userActivityService.sendMessage(recipients,mailTitle,content.toString());
				}
			} 
			catch (Exception e)
			{
				e.printStackTrace();
			}
			response.setContentType("text/html;charset=UTF-8");
			response.getWriter().write("0");
		}
		
	}

	
	@At("/insertPress")
	public void insertPress(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String actId = request.getParameter("activityId");
		String activityOwner = request.getParameter("activityOwnerUserId");
		String userId=request.getParameter("complaintOwnerUserId");
		Date date = new Date();
		mes= new SysMessage();
		//取出活动的所有参与者
		activitiy = gameServices.getInfoFromActivity(actId);	
		
		//发送系统消息			
		mes.setActivityId(actId);
		mes.setBody("请尽快执行预测奖惩！！");
		mes.setFromUserId(userId);
		mes.setToUserId(activityOwner);
		mes.setStatus(0);
		mes.setSendTime(date);
		mes.setTitle("【催促】"+activitiy.getActivityDesc());
		userInfoService.sendSysMessage(mes);
		
		 User user=null;
		 user = userInfoService.getUserByUserId(activityOwner);
		 
		//发送邮件
		List<String> recipients =new LinkedList<String>();
		recipients.add(user.getEmailAddress());
		List<String> list = userActivityService.getUserNameAndActTitle(actId);
		if(list!=null && list.size()>0 && recipients!=null && recipients.size()>0)
		{
			String titlename = list.get(0);
			String arrTitle[] = titlename.split("&&");
			
			String mailTitle = "朕以为---【活动奖惩催促】";
			StringBuffer content = new StringBuffer();
			
			content.append("亲爱的<朕以为>参与者:</br>");
			content.append("  您参与的<"+arrTitle[1]+">活动已经结束，请尽快执行活动奖惩！！！");
			content.append("如有任何疑问，请登录微信公众号《朕以为》申诉。---朕以为!");
			userActivityService.sendMessage(recipients,mailTitle,content.toString());
		}
	}
	
	@At("/insertPressOwner")
	public void insertPressOwner(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String actId = request.getParameter("activityId");
		String userId=request.getParameter("complaintOwnerUserId");
		Date date = new Date();
		mes= new SysMessage();
		List<Participate> actls=null;
		//取出活动的所有参与者
		actls=userActivityService.getParticipateByActId(actId);
		activitiy = gameServices.getInfoFromActivity(actId);	
		

		for(Participate par:actls){
			
			//发送系统消息			
			mes.setActivityId(actId);
			mes.setBody("请尽快执行预测奖惩！！！");
			mes.setFromUserId(userId);
			mes.setToUserId(par.getUserId());
			mes.setStatus(0);
			mes.setSendTime(date);
			mes.setTitle("【活动奖惩催促】"+activitiy.getActivityDesc());
			userInfoService.sendSysMessage(mes);
			}
		
		 
		//发送邮件
		List<String> recipients = userActivityService.getMailAddressBasedOnActId(actId, "N");
		List<String> list = userActivityService.getUserNameAndActTitle(actId);
		if(list!=null && list.size()>0 && recipients!=null && recipients.size()>0)
		{
			String titlename = list.get(0);
			String arrTitle[] = titlename.split("&&");
			
			String mailTitle = "朕以为---【活动奖惩催促】";
			StringBuffer content = new StringBuffer();
			
			content.append("亲爱的<朕以为>参与者:</br>");
			content.append("  您参与的<"+arrTitle[1]+">活动已经结束，请尽快执行活动奖惩！！！");
			content.append("如有任何疑问，请登录微信公众号《朕以为》申诉。---朕以为!");
			userActivityService.sendMessage(recipients,mailTitle,content.toString());
		}
	}
	
	//这个方法是账单的结算
	private List<HashMap<String, String>> billSettlement(String actId, int status, String dialogComment)
	{
		List<HashMap<String, String>> data = new ArrayList<HashMap<String, String>>();
		SysMessage mess=null;
		try
		{
			Activity activity = userActivityService.getActivityByActivityId(actId);
			List<String>  supportUserIds = userActivityService.getUserIdBasedOnActId(actId, "Y");
			List<String> opponentUserIds = userActivityService.getUserIdBasedOnActId(actId, "N");
			int points = activity.getStakePoints();
			
			//解锁发起者
			unLockPoints(activity.getUserId(), points);
			int moreFlag = 0;
			int pgmstack = 0;
			if(supportUserIds.size()+opponentUserIds.size()>=3)
			{
				try
				{
					moreFlag = 1;
					AwardService ads = new AwardService();
					Program pg = ads.getProgramById("PGMNEW");
					pgmstack = pg.getPgmPoints();
					updatePointsDetail(activity.getActivityId(), activity.getUserId(), pgmstack, 1);
				}catch(Exception e)
				{
					e.printStackTrace();
					moreFlag = 0;
				}
			}
			int dNum = 1;
			//解锁支持者
			for(int i=0; i<supportUserIds.size(); i++)
			{
				dNum = userActivityService.getPartiDoubleNum(activity.getActivityId(), supportUserIds.get(i));
				unLockPoints(supportUserIds.get(i), points * dNum);
			}
			//解锁反对者
			for(int i=0; i<opponentUserIds.size(); i++)
			{
				dNum = userActivityService.getPartiDoubleNum(activity.getActivityId(), opponentUserIds.get(i));
				unLockPoints(opponentUserIds.get(i), points * dNum);
			}
			
			//执行交易明细
			if(opponentUserIds!=null && opponentUserIds.size()<=0)
			{				
				//没有反对者的情况
				if(status==1)
				{
					//失败
					HashMap<String, String> temp = new HashMap<String, String>();
					//活动发起者失败
					temp.put("winlose", "-1");
					temp.put("points", "0");
					temp.put("picture", getPic(activity.getUserId()));
					temp.put("moreFlag", moreFlag+"");
					temp.put("pgmstack", pgmstack+"");
					data.add(temp);
					updatePointsDetail(activity.getActivityId(), activity.getUserId(), 0, 0);
					mess=new SysMessage();
					mess.setToUserId(activity.getUserId());
					mess.setActivityId(activity.getActivityId());
					mess.setStatus(status);
					mess.setActivityDesc(activity.getActivityDesc());
					mess.setPoints(0);
					if(dialogComment==null || "".equalsIgnoreCase(dialogComment))
					{
						CustomMsgUtil.sendResultTemplateMsg(mess);
					}
					else
					{
						CustomMsgUtil.sendSystemResultTemplateMsg(mess, dialogComment);
					}
					//活动支撑者失败
					if(supportUserIds!=null && supportUserIds.size()>0)
					{
						for(int i=0; i<supportUserIds.size(); i++)
						{
							temp = new HashMap<String, String>();
							temp.put("winlose", "-1");
							temp.put("points", "0");
							temp.put("picture", getPic(supportUserIds.get(i)));
							temp.put("moreFlag", moreFlag+"");
							temp.put("pgmstack", pgmstack+"");
							data.add(temp);							
							updatePointsDetail(activity.getActivityId(), supportUserIds.get(i), 0, 0);
							mess=new SysMessage();
							mess.setToUserId(supportUserIds.get(i));
							mess.setActivityId(activity.getActivityId());
							mess.setStatus(status);
							mess.setActivityDesc(activity.getActivityDesc());
							mess.setPoints(0);
							if(dialogComment==null || "".equalsIgnoreCase(dialogComment))
							{
								CustomMsgUtil.sendResultTemplateMsg(mess);
							}
							else
							{
								CustomMsgUtil.sendSystemResultTemplateMsg(mess, dialogComment);
							}
						}
					}
				}
				else if(status==2)
				{
					//成功
					HashMap<String, String> temp = new HashMap<String, String>();
					//活动发起者成功
					temp.put("winlose", "1");
					temp.put("points", "0");
					temp.put("picture", getPic(activity.getUserId()));
					temp.put("moreFlag", moreFlag+"");
					temp.put("pgmstack", pgmstack+"");
					data.add(temp);
					updatePointsDetail(activity.getActivityId(), activity.getUserId(), 0, 1);
					mess=new SysMessage();
					mess.setToUserId(activity.getUserId());
					mess.setActivityId(activity.getActivityId());
					mess.setStatus(status);
					mess.setActivityDesc(activity.getActivityDesc());
					mess.setPoints(0);
					if(dialogComment==null || "".equalsIgnoreCase(dialogComment))
					{
						CustomMsgUtil.sendResultTemplateMsg(mess);
					}
					else
					{
						CustomMsgUtil.sendSystemResultTemplateMsg(mess, dialogComment);
					}
					
					//活动支撑者成功
					if(supportUserIds!=null && supportUserIds.size()>0)
					{
						for(int i=0; i<supportUserIds.size(); i++)
						{
							temp = new HashMap<String, String>();
							temp.put("winlose", "1");
							temp.put("points", "0");
							temp.put("picture", getPic(supportUserIds.get(i)));
							temp.put("moreFlag", moreFlag+"");
							temp.put("pgmstack", pgmstack+"");
							data.add(temp);
							updatePointsDetail(activity.getActivityId(), supportUserIds.get(i), 0, 1);
							mess=new SysMessage();
							mess.setToUserId(supportUserIds.get(i));
							mess.setActivityId(activity.getActivityId());
							mess.setStatus(status);
							mess.setActivityDesc(activity.getActivityDesc());
							mess.setPoints(0);
							if(dialogComment==null || "".equalsIgnoreCase(dialogComment))
							{
								CustomMsgUtil.sendResultTemplateMsg(mess);
							}
							else
							{
								CustomMsgUtil.sendSystemResultTemplateMsg(mess, dialogComment);
							}
						}
					}
				}
			}
			else
			{
				//有反对者
				if(status==1)
				{
					//活动支持方总共失去的城池数量
					int supportLostNum = 0;
					//支持者失败
					HashMap<String, String> temp = new HashMap<String, String>();
					//活动发起者失败
					temp.put("winlose", "-1");
					temp.put("points", String.valueOf(points));
					temp.put("picture", getPic(activity.getUserId()));
					temp.put("moreFlag", moreFlag+"");
					temp.put("pgmstack", pgmstack+"");
					data.add(temp);
					updatePointsDetail(activity.getActivityId(), activity.getUserId(), points, 0);
					mess=new SysMessage();
					mess.setToUserId(activity.getUserId());
					mess.setActivityId(activity.getActivityId());
					mess.setStatus(status);
					mess.setActivityDesc(activity.getActivityDesc());
					mess.setPoints(points);
					if(dialogComment==null || "".equalsIgnoreCase(dialogComment))
					{
						CustomMsgUtil.sendResultTemplateMsg(mess);
					}
					else
					{
						CustomMsgUtil.sendSystemResultTemplateMsg(mess, dialogComment);
					}
					supportLostNum += points;
					//活动支撑者失去points
					if(supportUserIds!=null && supportUserIds.size()>0)
					{
						for(int i=0; i<supportUserIds.size(); i++)
						{
							dNum = userActivityService.getPartiDoubleNum(activity.getActivityId(), supportUserIds.get(i));
							temp = new HashMap<String, String>();
							temp.put("winlose", "-1");
							temp.put("points", String.valueOf(points * dNum));
							temp.put("picture", getPic(supportUserIds.get(i)));
							temp.put("moreFlag", moreFlag+"");
							temp.put("pgmstack", pgmstack+"");
							data.add(temp);
							updatePointsDetail(activity.getActivityId(), supportUserIds.get(i), points * dNum, 0);
							supportLostNum += (points * dNum);
							mess=new SysMessage();
							mess.setToUserId(supportUserIds.get(i));
							mess.setActivityId(activity.getActivityId());
							mess.setStatus(status);
							mess.setActivityDesc(activity.getActivityDesc());
							mess.setPoints(points * dNum);
							if(dialogComment==null || "".equalsIgnoreCase(dialogComment))
							{
								CustomMsgUtil.sendResultTemplateMsg(mess);
							}
							else
							{
								CustomMsgUtil.sendSystemResultTemplateMsg(mess, dialogComment);
							}
						}
					}
					
					//////////////////
					//计算反对者应该获得的城池数量
					//int totalLose = points * (supportUserIds.size()+1);
					int perOppNum = 0;
					for(int i=0; i<opponentUserIds.size(); i++)
					{
						perOppNum += userActivityService.getPartiDoubleNum(activity.getActivityId(), opponentUserIds.get(i));
					}
					int perPoints = supportLostNum/perOppNum;
					int yushu = supportLostNum%perOppNum;
					/////////////////
					//活动反对者活动points
					if(opponentUserIds!=null && opponentUserIds.size()>0)
					{
						for(int i=0; i<opponentUserIds.size(); i++)
						{
							dNum = userActivityService.getPartiDoubleNum(activity.getActivityId(), opponentUserIds.get(i));
							int tempPoint = perPoints * dNum;
							if(i<yushu)
							{
								tempPoint+=1;
							}
							temp = new HashMap<String, String>();
							temp.put("winlose", "1");
							temp.put("points", String.valueOf(tempPoint));
							temp.put("picture", getPic(opponentUserIds.get(i)));
							temp.put("moreFlag", moreFlag+"");
							temp.put("pgmstack", pgmstack+"");
							data.add(temp);
							updatePointsDetail(activity.getActivityId(), opponentUserIds.get(i), tempPoint, 1);
							 mess=new SysMessage();
							mess.setToUserId(opponentUserIds.get(i));
							mess.setActivityId(activity.getActivityId());
							mess.setStatus(2);
							mess.setActivityDesc(activity.getActivityDesc());
							mess.setPoints(tempPoint);
							if(dialogComment==null || "".equalsIgnoreCase(dialogComment))
							{
								CustomMsgUtil.sendResultTemplateMsg(mess);
							}
							else
							{
								CustomMsgUtil.sendSystemResultTemplateMsg(mess, dialogComment);
							}
						}
					}
				}
				else if(status==2)
				{
					//反对者总共失去的城池数
					int oppLoseTotalNum = 0;
					//支持者成功
					HashMap<String, String> temp = new HashMap<String, String>();
					//活动反对者失去points
					if(opponentUserIds!=null && opponentUserIds.size()>0)
					{
						for(int i=0; i<opponentUserIds.size(); i++)
						{
							dNum = userActivityService.getPartiDoubleNum(activity.getActivityId(), opponentUserIds.get(i));
							temp = new HashMap<String, String>();
							temp.put("winlose", "-1");
							temp.put("points", String.valueOf(points * dNum));
							temp.put("picture", getPic(opponentUserIds.get(i)));
							temp.put("moreFlag", moreFlag+"");
							temp.put("pgmstack", pgmstack+"");
							data.add(temp);
							updatePointsDetail(activity.getActivityId(), opponentUserIds.get(i), points * dNum, 0);
							oppLoseTotalNum += points * dNum;
							mess=new SysMessage();
							mess.setToUserId(opponentUserIds.get(i));
							mess.setActivityId(activity.getActivityId());
							mess.setStatus(1);
							mess.setActivityDesc(activity.getActivityDesc());
							mess.setPoints(points * dNum);
							if(dialogComment==null || "".equalsIgnoreCase(dialogComment))
							{
								CustomMsgUtil.sendResultTemplateMsg(mess);
							}
							else
							{
								CustomMsgUtil.sendSystemResultTemplateMsg(mess, dialogComment);
							}
						}
					}
					
					//////////////////
					//计算支持者应该获得的城池数量
					//int totalLose = points * opponentUserIds.size();
					int perSurpNum = 0;
					for(int i=0; i<supportUserIds.size(); i++)
					{
						perSurpNum += userActivityService.getPartiDoubleNum(activity.getActivityId(), supportUserIds.get(i));
					}
					int perPoints = oppLoseTotalNum/(perSurpNum+1);
					int yushu = oppLoseTotalNum%(perSurpNum+1);
					
					int actPointUser = perPoints;
					if(yushu>0)
					{
						actPointUser = actPointUser+1;
					}
					//活动发起者活动城池数
					temp = new HashMap<String, String>();
					temp.put("winlose", "1");
					temp.put("points", String.valueOf(actPointUser));
					temp.put("picture", getPic(activity.getUserId()));
					temp.put("moreFlag", moreFlag+"");
					temp.put("pgmstack", pgmstack+"");
					data.add(temp);
					updatePointsDetail(activity.getActivityId(), activity.getUserId(), actPointUser, 1);
					 mess=new SysMessage();
					mess.setToUserId(activity.getUserId());
					mess.setActivityId(activity.getActivityId());
					mess.setStatus(status);
					mess.setActivityDesc(activity.getActivityDesc());
					mess.setPoints(actPointUser);
					if(dialogComment==null || "".equalsIgnoreCase(dialogComment))
					{
						CustomMsgUtil.sendResultTemplateMsg(mess);
					}
					else
					{
						CustomMsgUtil.sendSystemResultTemplateMsg(mess, dialogComment);
					}
					
					//活动支持者获得城池数
					for(int i=0; i<supportUserIds.size(); i++)
					{
						dNum = userActivityService.getPartiDoubleNum(activity.getActivityId(), supportUserIds.get(i));
						int surPoint = perPoints * dNum;
						if(i < yushu-1)
						{
							surPoint+=1;
						}
						temp = new HashMap<String, String>();
						temp.put("winlose", "1");
						temp.put("points", String.valueOf(surPoint));
						temp.put("picture", getPic(supportUserIds.get(i)));
						temp.put("moreFlag", moreFlag+"");
						temp.put("pgmstack", pgmstack+"");
						data.add(temp);
						updatePointsDetail(activity.getActivityId(), supportUserIds.get(i), surPoint, 1);
						 mess=new SysMessage();
						mess.setToUserId(supportUserIds.get(i));
						mess.setActivityId(activity.getActivityId());
						mess.setStatus(status);
						mess.setActivityDesc(activity.getActivityDesc());
						mess.setPoints(surPoint);
						if(dialogComment==null || "".equalsIgnoreCase(dialogComment))
						{
							CustomMsgUtil.sendResultTemplateMsg(mess);
						}
						else
						{
							CustomMsgUtil.sendSystemResultTemplateMsg(mess, dialogComment);
						}
					}	
					
				}
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return data;
	}
	
	//得到头像url地址
	private String getPic(String userId)
	{
		return userInfoService.getPic(userId);
	}
	
	//解锁
	private void unLockPoints(String userId, int points)
	{
		UserPoints up = userPointsService.getUserpointsByUserId(userId);
		if(up == null)
		{
			return;
		}
		userPointsService.updateLockPointsByUserId(up.getLockedPoints()-points, userId);
	}
	
	//更新明细表
	private void updatePointsDetail(String actId, String userId, int points, int win)
	{
		UserPoints up = userPointsService.getUserpointsByUserId(userId);
		if(up == null)
		{
			return;
		}
		int befPoints = up.getAllPoints();
		int aftPoints = 0;
		if(win == 1)
		{
			aftPoints = befPoints + points;
		}
		else if(win == 0)
		{
			aftPoints = befPoints - points;
		}
		
		//更新总共的points数量
		userPointsService.updateTotalPointsByUserId(aftPoints, userId);
		
		//插入到明细表中
		userPointsService.insertPointsTran(actId, userId, befPoints, aftPoints, points, win);
	}
	
	@At("/loadMoreActivity")
	public View loadMoreAct(HttpServletRequest request,HttpServletResponse response){
		Map<String,Object> data = new HashMap<String,Object>();
		List<HashMap<String, Object>> dataAllAct = new ArrayList<HashMap<String, Object>>();
		String flag = request.getParameter("flag");
		String nextTime = request.getParameter("next");
		String userId = request.getParameter("userId");
		try
		{
			if("1".equalsIgnoreCase(flag))
			{
				dataAllAct = userActivityService.getUserActivityInfo(userId, nextTime);
				data.put("dataAllAct", dataAllAct);
			}
			else if("2".equalsIgnoreCase(flag))
			{
				dataAllAct = userActivityService.getParticipateInfo(userId, nextTime);
				data.put("dataAllAct", dataAllAct);
			}
			else if("3".equalsIgnoreCase(flag))
			{
				dataAllAct = userActivityService.getCareInfo(userId, nextTime);
				data.put("dataAllAct", dataAllAct);
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return new ViewWrapper(new UTF8JsonView(new JsonFormat()), data);
	}

}
