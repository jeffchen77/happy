package com.happy.service;

import java.util.List;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import com.happy.dao.MessageDao;
import com.happy.dao.UserDao;
import com.happy.dao.WechatUserDao;
import com.happy.datasource.redis.RedisCache;
import com.happy.model.SysMessage;
import com.happy.model.User;
import com.happy.model.WechatUser;
import com.happy.utils.CommonUtil;
import com.happy.weixin.app.App;

public class UserInfoService {
	private static Logger log = LogManager.getLogger(UserInfoService.class);
	UserDao Userdao = new UserDao();
	WechatUserDao wechatUserdao = new WechatUserDao();
	MessageDao mesDao = new MessageDao();
	
	//获取胜负率从redis或者mysql
	public String sysForecastAcc() throws Exception{		
		
		RedisCache rc = new RedisCache();
		String forecastAcc = rc.hget(App.FORECAST_ACC, App.SYSTEM_ADMIN);
		log.debug("get forecase acc from Redis - "+forecastAcc);
		if(CommonUtil.isEmpty(forecastAcc))
		{
		User user =new User();
		user= this.getUserByUserId(App.SYSTEM_ADMIN);
		forecastAcc = user.getForecastAccuracy();
		log.debug("get forecase acc from mysql - "+forecastAcc);
		//同时写入胜负率到Redis
		rc.hset(App.FORECAST_ACC, App.SYSTEM_ADMIN,forecastAcc);
		}
		return forecastAcc;
	}
	//读取已存在的用户信息
	public User getUserByUserId(String userId) throws Exception{
		return Userdao.getUserByUserId(userId);
	}
	
	//读取微信用户信息
	public WechatUser getWechatUserById(String userId) throws Exception{
		return wechatUserdao.getByUserId(userId);
	}
	
	//保存用户邮件信息
	public void updateEmailById(User user){
		Userdao.updateEmailById(user);
	}
	//保存用户电话信息
		public void updatePhoneById(User user){
			Userdao.updatePhoneById(user);
		}
	//保存用户活动面膜	
	public void updateActPasswordById(String userId, String actPassword){
		Userdao.updateActPasswordById(userId,actPassword);
	}
	
	//获取系统的message
	public SysMessage getSysTip(String userId,String tipId) throws Exception
	{
		SysMessage mess =  mesDao.getSysTip(userId, tipId);
		return mess;
	}	
	//获取用户的message
		public List<SysMessage> getSysMessageById(String userId,String status)
		{
			List<SysMessage> mesList =  mesDao.getSysMessageById(userId, status);
			return mesList;
		}
	//发送信息	
		public void sendSysMessage(SysMessage mes) throws Exception
		{
			mesDao.sendSysMessage(mes);
		}
	//读取系统消息
		public void readSysMessage(Integer mesId,String userId)
		{
			mesDao.readUserSysMes(mesId,userId);
		}
		
		//更新关注公众号用户的信息
		
		public void updateGzUserInfo(String openid, String headimgurl,String nickname, int gzFlag)
		{
			Userdao.updateGzUserInfo(openid, headimgurl, nickname, gzFlag);
		}
		//更新未关注公众号用户的信息
		public void updateUnGzUserInfo(String openid, int gzFlag)
		{
			Userdao.updateUnGzUserInfo(openid, gzFlag);
		}
		
		public String getPic(String userId)
		{
			String rev = null;
			try {
				WechatUser user = wechatUserdao.getByUserId(userId);
				if(user != null)
				{
					rev = user.getHeadImgUrl();
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			return rev;
		}
}
