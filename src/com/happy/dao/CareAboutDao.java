package com.happy.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

import org.nutz.dao.Cnd;
import org.nutz.dao.Sqls;
import org.nutz.dao.sql.Criteria;
import org.nutz.dao.sql.Sql;
import org.nutz.dao.sql.SqlCallback;

import com.happy.dao.common.BaseDao;
import com.happy.model.CareAbout;
import com.happy.utils.CommonUtil;

public class CareAboutDao extends BaseDao{

	//fetch CareAbout from DB by userId and activityId
	public CareAbout fetch(String activityId,String userId,String attitudeType){
		CareAbout careAbout = null;
			Criteria cir = Cnd.cri();
			if(CommonUtil.notEmpty(attitudeType)&&CommonUtil.notEmpty(userId)&&CommonUtil.notEmpty(activityId)){
				cir.where().andEquals("user_id", userId);
				cir.where().andEquals("activity_id", activityId);
				if("gz".equalsIgnoreCase(attitudeType))
				{
				cir.where().andEquals("attitude_type", attitudeType);
				}
				else
				{
				cir.where().andIn("attitude_type", "nn","bb","rb");
				}
				 careAbout = dao.fetch(CareAbout.class, cir);
			}			
			
		return careAbout;
	}
	
	// insert new care people
	public void insert(String activityId, String userId,String attitudeType){
		CareAbout careAbout = new CareAbout();
		Date date =new Date();
		careAbout.setActivity_id(activityId);
		careAbout.setUser_id(userId);
		careAbout.setCreate_user(userId);
		careAbout.setCreate_time(date);
		careAbout.setAttitudeType(attitudeType); 
		dao.insert(careAbout);
	
	}
	public int queryAllOnlookers(String activityId,String attitudeType){
		if(CommonUtil.notEmpty(activityId)){
			Sql sql = Sqls.create("Select count(*) FROM care_about WHERE activity_id=@activityId AND attitude_type=@attitudeType");
			sql.params().set("activityId", activityId);
			sql.params().set("attitudeType", attitudeType);
			  sql.setCallback(new SqlCallback(){
			        public Object invoke(Connection conn, ResultSet rs, Sql sql) throws SQLException {
			            while (rs.next())
			            {
			            	 return rs.getInt(1);
			            }
			            return 0;
			        }
			  } );     
			dao.execute(sql);
			return sql.getInt();
			
		}			
		
		return 0;
		
	}
}
