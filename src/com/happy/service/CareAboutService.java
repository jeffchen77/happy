package com.happy.service;

import com.happy.dao.CareAboutDao;
import com.happy.model.CareAbout;

public class CareAboutService {
		CareAboutDao cad = new CareAboutDao();
	public boolean valid(String activityId,String userId,String flagType){
		boolean flag= false;
		
		CareAbout ca=cad.fetch(activityId,userId,flagType);
		if(ca==null)
		{
			cad.insert(activityId, userId,flagType);
			flag=true;
		}
		return flag;
		
	}
	public int countOnlookers(String activityId,String flagType){
		
		return cad.queryAllOnlookers(activityId,flagType);
	}

}
