package com.happy.service;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import com.happy.dao.UserReportDao;
import com.happy.model.ReportClickZan;

public class UserReportsService {
	UserReportDao urd = new UserReportDao();
	public List<Map> getUserReport(String userId){
		return urd.getUserReport(userId);
	}
	
	public List<Map> getAllUserReport(){
		return urd.getAllUserReport();
	}
	
	public int getClickZanTotal(String userId)
	{
		if(userId==null || "".equalsIgnoreCase(userId))
		{
			return 0;
		}
		
		return urd.getClickZanTotal(userId);
	}
	
	public int isClickZanToday(String fromUserId, String toUserId)
	{
		if(fromUserId==null || toUserId==null)
		{
			return 0;
		}
		int is = urd.isClickZanToday(fromUserId, toUserId);
		if(is>0)
		{
			return 1;
		}
		return 0;
	}
	
	public void insertReportZhan(String fromUserId, String toUserId)
	{
		ReportClickZan clickZan = new ReportClickZan();
		clickZan.setFromUserId(fromUserId);
		clickZan.setToUserId(toUserId);
		Timestamp ts = new Timestamp(System.currentTimeMillis());
		clickZan.setCreateTime(ts);
		urd.insertReportZhan(clickZan);
	}
}
