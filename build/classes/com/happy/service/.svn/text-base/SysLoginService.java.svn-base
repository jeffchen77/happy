package com.happy.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.happy.dao.ActivityDao;
import com.happy.dao.ChallengeThemeDao;
import com.happy.model.Activity;

public class SysLoginService {
	private ActivityDao activityDao = null;
	private ChallengeThemeDao challengeThemeDao = new ChallengeThemeDao();
	
	public SysLoginService()
	{
		activityDao = new ActivityDao();
	}
	
	/*
	 * 此方法用于得到活动参与者的头像
	 * */
	public List<Activity> getSysActivity()
	{
		return activityDao.getSysActivity();
	}
	
	/*
	 * 此方法用于得到活动参与者的头像
	 * */
	public void insertAct(Activity act)
	{
		try {
			challengeThemeDao.insertChallengeTheme(act);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public List<HashMap<String, Object>> getOverdueActivity(int day){
		List<HashMap<String, Object>> data = new ArrayList<HashMap<String, Object>>();		
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, day);
		String oneWeekAgo = sf.format(cal.getTime());
		List<Activity> acts = activityDao.getOverdueActivity(oneWeekAgo);
		if(acts!=null && acts.size()>0)
		{
			HashMap<String, Object> hp = null;
			for(int i=0; i< acts.size(); i++)
			{
				Activity a = acts.get(i);
				hp = new HashMap<String, Object>();
				hp.put("actid", a.getActivityId());
				hp.put("acttitle", a.getActivityDesc());
				hp.put("actpoints", a.getStakePoints()+"");
				hp.put("actpublishtime", a.getPublishDate().toString());
				long cTime = a.getPublishDate().getTime();
				long nTime = Calendar.getInstance().getTimeInMillis();
				double dDays = (nTime - cTime) / (24 * 60 * 60 * 1000 * 1.0);
				String dueDays = String.format("%.1f", dDays);
				hp.put("duedays", dueDays);
				data.add(hp);
			}
		}
		return data;
	}
	
}
