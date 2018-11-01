package com.happy.service;

import java.util.List;

import com.happy.dao.ComplaintDao;
import com.happy.model.Complaint;

public class ComplaintService {
	ComplaintDao complaintDao = new ComplaintDao();
	public void insertComplaint(Complaint complaint) throws Exception{
		complaintDao.insertComplaint(complaint);
	}
	
	public List<Complaint> getComplaintByTwoUserId(String activityId,String actOwerId,String complaintOwerId) throws Exception{
		List<Complaint> complaint = complaintDao.getComplaintByTwoUserId( activityId,actOwerId, complaintOwerId);
		return complaint;
	}
}
