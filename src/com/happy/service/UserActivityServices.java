package com.happy.service;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message.RecipientType;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.nutz.dao.Chain;
import org.nutz.dao.Cnd;

import com.happy.conf.ConfFactory;
import com.happy.dao.ActivityDao;
import com.happy.dao.ParticipateDao;
import com.happy.dao.UserDao;
import com.happy.dao.WechatUserDao;
import com.happy.model.Activity;
import com.happy.model.CareAbout;
import com.happy.model.Participate;
import com.happy.model.User;
import com.happy.model.WechatUser;

public class UserActivityServices  {
	
	private ParticipateDao participateDao;
	private ActivityDao activityDao;
	private WechatUserDao wechatUserDao;
	private UserDao userDao;
	public UserActivityServices()
	{
		participateDao=new ParticipateDao();
		activityDao=new ActivityDao();
		wechatUserDao=new WechatUserDao();
		userDao = new UserDao();
	}
	
	public int getPartiDoubleNum(String act, String usrId)
	{
		return participateDao.getParticipateDoubleNum(act, usrId);
	}
	
	public List<Activity> getActByUserId(String userId) throws Exception{
		List<Activity> actByUserId = activityDao.getActivityByUserId(userId);
		return actByUserId;
	}
	
	public WechatUser getWebchatUserInfo(String usrId) throws Exception
	{
		WechatUser person = wechatUserDao.getByUserId(usrId);
		return person;
	}
	
	public User getUserInfo(String usrId) throws Exception
	{
		User user = userDao.getUserByUserId(usrId);
		return user;
	}
	
	public void deleteCareActivity(String activityId,String usrId) throws Exception
	{
		activityDao.deleteCareAct(activityId,usrId);
		
		return;
	}
	
	public List<Activity> getActivityByUserId(String usrId, String sortTime) throws Exception
	{
		List<Activity> activities = activityDao.getActivityByUserId(usrId, sortTime);
		return activities;
	}
	public Activity getActivityByActivityId(String activityId) throws Exception
	{
		Activity activity = activityDao.getActivityByActivityId(activityId);
		return activity;
	}
	public List<Participate> getParticipateByUserId(String usrId) throws Exception
	{
		List<Participate> participate = activityDao.getParticipateByUserId(usrId);
		return participate;
	}
	public List<Participate> getParticipateByUserId(String usrId, String nextTime) throws Exception
	{
		List<Participate> participate = activityDao.getParticipateByUserId(usrId, nextTime);
		return participate;
	}
	public List<CareAbout> getCareByUserId(String usrId, String nextTime) throws Exception
	{
		List<CareAbout> care = activityDao.getCareByUserId(usrId, nextTime);
		return care;
	}
	
	public List<Participate> getParticipateByActId (String actId) throws Exception{
		List<Participate> participate = null;
		participate = participateDao.getParticipateByActId(actId);
		return participate;
	}
	public List<HashMap<String, Object>> getCareInfo(String usrId, String nextTime) throws Exception
	{
		List<HashMap<String, Object>> data = new ArrayList<HashMap<String, Object>>();
		List<CareAbout> care = null;
		WechatUser person = null;
		Activity activity =null;
		//得到关注的列表
		care = getCareByUserId(usrId, nextTime);
		
		if(care!=null && care.size()>0)
		{	//遍历
			for(int index=0; index<care.size(); index++)
			{	
				//获取每条参与记录的发起者ID和活动信息
				HashMap<String, Object> hm = new HashMap<String, Object>();
				CareAbout actInfo = care.get(index);
				
				if(actInfo==null)
				{
					continue;
				}
				//获取发起者信息
				String activityId = actInfo.getActivity_id();
				activity = activityDao.getActivityByActivityId(activityId);
				person = getWebchatUserInfo(activity.getUserId());
				if(person==null){
					return null;
				}
				//放入发起者的信息到map里面---头像，昵称，状态
				hm.put("header_img", person.getHeadImgUrl());
				hm.put("header_userId", person.getUserId());
				String nickName = person.getNickName();
				if(nickName!=null && nickName.length()>=7)
				{
					nickName = nickName.substring(0, 7);
					nickName = nickName +"。。。";
				}
				
				//获取activity信息
				
				String time = "";
				Timestamp createTime = activity.getCreateTime();
				String createStr = null;
				if(createTime!=null)
				{
					createStr = createTime.toString();
					time = createStr.substring(0, createStr.length()-2);
				}
				hm.put("header_name", nickName);
				hm.put("header_time", time);
				
				int actStatus = activity.getActivityStatus();
				if(actStatus==0)
				{
					hm.put("header_status", "已发起");
				}
				else if(actStatus==1)
				{
					hm.put("header_status", "进行中");
				}
				else if(actStatus==2)
				{
					hm.put("header_status", "已完成");
				}
				else if(actStatus==-1)
				{
					hm.put("header_status", "已取消");
				}
				else
				{
					hm.put("header_status", "未知");
				}
				//结束---放入发起者的信息到map里面---头像，昵称，状态
				
				//得到活动的详细信息	
				hm.put("act_title", activity.getActivityDesc());
				hm.put("act_content", activity.getActivityStake());
				String actTime = activity.getActivityDeadline()!=null?activity.getActivityDeadline().toString():"9999-12-31";
				hm.put("act_time", actTime.substring(0, actTime.length()-2));				
				hm.put("act_id", activity.getActivityId());
				//结束--得到活动的详细信息
				
				//得到参与者的头像
				try 
				{
					//得到所有的参与者，无聊是支持者还是参与者
					List<String> parter = participateDao.getActivityById(activity.getActivityId());
					if(parter==null)
					{
						parter = new ArrayList<String>();
					}
					hm.put("act_parter", parter);
					
					//得到支持者
					List<String> parterYes = participateDao.getYes(activity.getActivityId());
					if(parterYes==null)
					{
						parterYes = new ArrayList<String>();
					}
					hm.put("act_parter_yes", parterYes);
					
					//得到反对者
					List<String> parterNo = participateDao.getActivityByIdNo(activity.getActivityId());
					if(parterNo==null)
					{
						parterNo = new ArrayList<String>();
					}
					hm.put("act_parter_no", parterNo);
				} catch (Exception e) {
					e.printStackTrace();
				}
				
				//得到用户选择的状态
				hm.put("act_result", activity.getResultStatus());
				//结束--得到用户选择的状态
				data.add(hm);
			}
		}
		
		return data;
	}	
	
	
	public List<HashMap<String, Object>> getParticipateInfo(String usrId, String nextTime) throws Exception
	{
		List<HashMap<String, Object>> data = new ArrayList<HashMap<String, Object>>();
		List<Participate> participate = null;
		WechatUser person = null;
		Activity activity =null;
		//得到全部参与互动的列表
		participate = getParticipateByUserId(usrId, nextTime);
		
		if(participate!=null && participate.size()>0)
		{	//遍历
			for(int index=0; index<participate.size(); index++)
			{	
				//获取每条参与记录的发起者ID和活动信息
				HashMap<String, Object> hm = new HashMap<String, Object>();
				Participate actInfo = participate.get(index);
				
				if(actInfo==null)
				{
					continue;
				}
				//获取发起者信息
				String activityId = actInfo.getActivityId();
				activity = activityDao.getActivityByActivityId(activityId);
				person = getWebchatUserInfo(activity.getUserId());
				if(person==null){
					return null;
				}
				//放入发起者的信息到map里面---头像，昵称，状态
				hm.put("header_img", person.getHeadImgUrl());
				hm.put("header_userId", person.getUserId());
				String nickName = person.getNickName();
				if(nickName!=null && nickName.length()>=7)
				{
					nickName = nickName.substring(0, 7);
					nickName = nickName +"。。。";
				}
				
				//获取activity信息
				
				String time = "";
				Timestamp createTime = activity.getCreateTime();
				String createStr = null;
				if(createTime!=null)
				{
					createStr = createTime.toString();
					time = createStr.substring(0, createStr.length()-2);
				}
				hm.put("header_name", nickName);
				hm.put("header_time", time);
				
				int actStatus = activity.getActivityStatus();
				if(actStatus==0)
				{
					hm.put("header_status", "已发起");
				}
				else if(actStatus==1)
				{
					hm.put("header_status", "进行中");
				}
				else if(actStatus==2)
				{
					hm.put("header_status", "已完成");
				}
				else if(actStatus==-1)
				{
					hm.put("header_status", "已取消");
				}
				else
				{
					hm.put("header_status", "未知");
				}
				//结束---放入发起者的信息到map里面---头像，昵称，状态
				
				//得到活动的详细信息	
				hm.put("act_title", activity.getActivityDesc());
				hm.put("act_content", activity.getActivityStake());
				String actTime = activity.getActivityDeadline()!=null?activity.getActivityDeadline().toString():"9999-12-31";
				hm.put("act_time", actTime.substring(0, actTime.length()-2));				
				hm.put("act_id", activity.getActivityId());
				//结束--得到活动的详细信息
				
				//得到参与者的头像
				try 
				{
					//得到所有的参与者，无聊是支持者还是参与者
					List<String> parter = participateDao.getActivityById(activity.getActivityId());
					if(parter==null)
					{
						parter = new ArrayList<String>();
					}
					hm.put("act_parter", parter);
					
					//得到支持者
					List<String> parterYes = participateDao.getYes(activity.getActivityId());
					if(parterYes==null)
					{
						parterYes = new ArrayList<String>();
					}
					hm.put("act_parter_yes", parterYes);
					
					//得到反对者
					List<String> parterNo = participateDao.getActivityByIdNo(activity.getActivityId());
					if(parterNo==null)
					{
						parterNo = new ArrayList<String>();
					}
					hm.put("act_parter_no", parterNo);
				} catch (Exception e) {
					e.printStackTrace();
				}
				
				//得到用户选择的状态
				hm.put("act_result", activity.getResultStatus());
				//结束--得到用户选择的状态
				data.add(hm);
			}
		}
		
		return data;
	}
	
	
	public List<HashMap<String, Object>> getUserActivityInfo(String usrId, String sortTime) throws Exception
	{
		List<HashMap<String, Object>> data = new ArrayList<HashMap<String, Object>>();
		List<Activity> activities = null;
		WechatUser person = null;
		User user = null;
		
		//得到活动发起者的头像，昵称等信息
		person = getWebchatUserInfo(usrId);
		user = getUserInfo(usrId);
		if(person==null || user==null)
		{
			return null;
		}
		//得到活动发起者所发起的所有的活动列表
		activities = getActivityByUserId(usrId, sortTime);
		
		if(activities!=null && activities.size()>0)
		{
			for(int index=0; index<activities.size(); index++)
			{
				HashMap<String, Object> hm = new HashMap<String, Object>();
				Activity actInfo = activities.get(index);
				
				if(actInfo==null)
				{
					continue;
				}
				//放入发起者的信息到map里面---头像，昵称，状态
				hm.put("header_img", person.getHeadImgUrl());
				hm.put("header_userId", person.getUserId());
				hm.put("header_level", Integer.parseInt(user.getMoralRank()));
				String nickName = person.getNickName();
				if(nickName!=null && nickName.length()>=7)
				{
					nickName = nickName.substring(0, 7);
					nickName = nickName +"。。。";
				}
				String time = "";
				Timestamp createTime = actInfo.getCreateTime();
				String createStr = null;
				if(createTime!=null)
				{
					createStr = createTime.toString();
					time = createStr.substring(0, createStr.length()-2);
					Timestamp timeNow = new Timestamp(System.currentTimeMillis());
					long dvalue =(timeNow.getTime()-createTime.getTime())/(1000*60);
					int delAble = 0;//不可删除
					hm.put("delAble", delAble);
					if(dvalue <= 3){
						hm.put("delAble", 1);
					}
				}
				
				hm.put("header_name", nickName);
				hm.put("header_time", time);
				
				int actStatus = actInfo.getActivityStatus();
				if(actStatus==0)
				{
					hm.put("header_status", "已发起");
				}
				else if(actStatus==1)
				{
					hm.put("header_status", "进行中");
				}
				else if(actStatus==2)
				{
					hm.put("header_status", "已完成");
				}
				else if(actStatus==-1)
				{
					hm.put("header_status", "已取消");
				}
				else
				{
					hm.put("header_status", "未知");
				}
				//结束---放入发起者的信息到map里面---头像，昵称，状态
				
				//得到活动的详细信息	
				hm.put("act_title", actInfo.getActivityDesc());
				hm.put("act_content", actInfo.getActivityStake());
				String actTime = actInfo.getActivityDeadline()!=null?actInfo.getActivityDeadline().toString():"9999-12-31";
				hm.put("act_time", actTime.substring(0, actTime.length()-2));				
				hm.put("act_id", actInfo.getActivityId());
				//结束--得到活动的详细信息
				
				//得到参与者的头像
				try 
				{
					//得到所有的参与者，无聊是支持者还是参与者
					List<String> parter = participateDao.getActivityById(actInfo.getActivityId());
					if(parter==null)
					{
						parter = new ArrayList<String>();
					}
					hm.put("act_parter", parter);
					
					//得到支持者
					List<String> parterYes = participateDao.getYes(actInfo.getActivityId());
					if(parterYes==null)
					{
						parterYes = new ArrayList<String>();
					}
					hm.put("act_parter_yes", parterYes);
					
					//得到反对者
					List<String> parterNo = participateDao.getActivityByIdNo(actInfo.getActivityId());
					if(parterNo==null)
					{
						parterNo = new ArrayList<String>();
					}
					hm.put("act_parter_no", parterNo);
				} catch (Exception e) {
					e.printStackTrace();
				}
				//结束--得到参与者的头像
				
				//得到用户选择的状态
				hm.put("act_result", actInfo.getResultStatus());
				//结束--得到用户选择的状态
				data.add(hm);
			}
		}
		
		return data;
	}
	
	public void saveResultFlag(String actId, int status) throws Exception
	{
		activityDao.updateResultStatusByActId(actId, status);
	}
	
	public String updateActivityStatusByActId(String actId, int activityStatus) throws Exception
	{
		activityDao.updateActivityStatusByActId(actId, activityStatus);		
		return "SUCCESS";
	}
	
	
	public List<String> getMailAddressBasedOnActId(String actId, String yorN) throws Exception
	{
		List<String> recipients = activityDao.getMailAddressBasedOnActId(actId, yorN);
		return recipients;
	}
	
	public List<String> getAllNickNameBasedOnActId(String actId, String yorN) throws Exception
	{
		List<String> nicknames = activityDao.getAllNickNameBasedOnActId(actId, yorN);
		return nicknames;
	}
	
	public List<String> getUserIdBasedOnActId(String actId, String yorN) throws Exception
	{
		List<String> userIds = activityDao.getUserIdBasedOnActId(actId, yorN);
		return userIds;
	}
	
	public void sendMessage(List<String> recipients, String subject, String content) throws Exception
	{
		Properties props = new Properties();
		props.put("mail.smtp.host", ConfFactory.getConf().get("mail.host","smtp.sina.com"));
		props.put("mail.smtp.auth", ConfFactory.getConf().get("mail.auth","true"));
		props.put("mail.smtp.port", ConfFactory.getConf().get("mail.port","25"));
		
        Session mailSession = Session.getInstance(props,new MailAuthenticator(ConfFactory.getConf().get("mail.user","qiniugongzuoshi@sina.com"),ConfFactory.getConf().get("mail.password","qiniuno.1")));

        MimeMessage message = new MimeMessage(mailSession);
        
        message.setFrom(new InternetAddress(ConfFactory.getConf().get("mail.user","qiniugongzuoshi@sina.com")));  
        
        InternetAddress[] addresses = new InternetAddress[recipients.size()];
        for (int i = 0; i < recipients.size(); i++)
        {
            if(recipients.get(i)!=null)
            {
            	addresses[i] = new InternetAddress(recipients.get(i));
            }
        }
        message.setRecipients(RecipientType.BCC, addresses); 
  
        message.setSentDate(Calendar.getInstance().getTime());  
        message.setSubject(subject);
        message.setContent(content,"text/html;charset=utf-8");  
 
        message.saveChanges();
        // 第三步：发送消息  
        Transport.send(message); 
	}
	
	public List<String> getUserNameAndActTitle(String actId) throws Exception
	{
		
		return activityDao.getUserNameAndActTitle(actId);
		
	}
	
	class MailAuthenticator extends Authenticator
	{
		private String username;
		private String password;
		
		public MailAuthenticator(String username, String password)
		{
		    this.username = username;
		    this.password = password;
		}
		
		@Override
	    protected PasswordAuthentication getPasswordAuthentication()
		{
			return new PasswordAuthentication(username, password);
	    }
	}
}
