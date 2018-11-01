package com.happy.dao;

import java.util.List;

import org.nutz.dao.Cnd;
import org.nutz.dao.sql.Criteria;

import com.happy.dao.common.BaseDao;
import com.happy.model.Complaint;
import com.happy.utils.CommonUtil;

public class ComplaintDao extends BaseDao{
	
	public void insertComplaint(Complaint complaint) throws Exception{
		dao.insert(complaint);
	}
	
	public List<Complaint> getComplaintByTwoUserId(String activityId,String actOwerId,String complaintOwerId)throws Exception{
		List<Complaint> complaints=null;
		Criteria cir = Cnd.cri();
		if(CommonUtil.notEmpty(activityId)){
			cir.where().andEquals("activity_id", activityId).andEquals("create_user", complaintOwerId);
			complaints = dao.query(Complaint.class, cir);
		}	
		return complaints;
	}
	
}
