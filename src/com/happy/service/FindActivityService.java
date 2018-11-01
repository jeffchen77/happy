package com.happy.service;

import java.util.List;
import java.util.Map;

import com.happy.dao.ActivityDao;
import com.happy.dao.CareAboutDao;
import com.happy.model.CareAbout;

public class FindActivityService {
	private ActivityDao activityDao;
	private CareAboutDao careAboutDao;
	
	public FindActivityService()
	{
		activityDao = new ActivityDao();
		careAboutDao = new CareAboutDao();
	}
	
	/*
	 * 此方法用于返回activity的头像，描述信息等
	 * */
	public List<Map> getTopTenActivityRecords(int type)
	{
		return activityDao.getTopTenActivityRecords( type);
	}
	
	/*
	 * 此方法用于得到活动参与者的头像
	 * */
	public List<String> getActParHeaderImg(String actId)
	{
		return activityDao.getActParHeaderImg(actId);
	}
	
	/*
	 * 此方法用于得到下10个活动记录
	 * */
	public List<Map> getNextTopTenActivityRecords(int type,int page)
	{
		return activityDao.getNextTopTenActivityRecords(type,page);
	}
	//获取固定的本周活动和本日活动
	public List<Map> getActsOfWeekAndDay(){
		return activityDao.getActsOfWeekAndDay();
	}
	
	
	/*
	 * 此方法用于得到活动参与者的头像
	 * */
	public boolean isCared(String usrId, String actId)
	{
		CareAbout ca=careAboutDao.fetch(actId,usrId,"gz");
		if(ca==null)
		{
			return false;
		}
		else
		{
			return true;
		}
	}
	
}
