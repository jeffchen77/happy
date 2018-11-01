package com.happy.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.nutz.dao.Cnd;
import org.nutz.dao.Sqls;
import org.nutz.dao.sql.Criteria;
import org.nutz.dao.sql.Sql;
import org.nutz.dao.sql.SqlCallback;

import com.happy.dao.common.BaseDao;
import com.happy.model.Participate;
import com.happy.model.PersonTransRecord;
import com.happy.model.WechatUser;
import com.happy.utils.CommonUtil;


public class ParticipateDao extends BaseDao{

	public int getParticipateDoubleNum(String act, String usrId)
	{
		Participate participate =null;
		Criteria cir = Cnd.cri();
		if(CommonUtil.notEmpty(act) && CommonUtil.notEmpty(usrId)){
			cir.where().andEquals("activity_id", act).andEquals("user_id", usrId);
			participate = dao.fetch(Participate.class, cir);
		}
		if(participate != null)
		{
			return participate.getDoubleNum();
		}
		else
		{
			return 1;
		}
	}
	
	//根据条件查询
	public int findParticipate(String userId ,String activityId)throws Exception{
		Participate participate =null;
		int returnVar=-1;
		Criteria cir = Cnd.cri();
		if(CommonUtil.notEmpty(activityId)&&CommonUtil.notEmpty(userId)){
			cir.where().andEquals("activity_id", activityId).andEquals("user_id", userId);
			participate = dao.fetch(Participate.class, cir);
		}			
		if(participate==null)
		{
			returnVar=1;
		}
		return returnVar;
	}	
	public List<Participate> getParticipateByActId(String actId) throws Exception{
		List<Participate> actls=null;
		Criteria cir = Cnd.cri();
		if(CommonUtil.notEmpty(actId)){
			cir.where().andEquals("activity_id", actId);
			actls = dao.query(Participate.class, cir);
		}			
		return actls;
	}
	//根据条件查询
	public List<String> getActivityById(String activityId)throws Exception{
		
		/*Sql sql = Sqls.create(
				"select a.headimgurl from activity a,participate b where"
				+ " a.activity_id='"+activityId+"' and  a.activity_id=b.activity_id and b.partici_type='N'");*/
		
		Sql sql = Sqls.create(
				"select a.headimgurl from webchat_user a, participate b, activity c where"
				+ " c.activity_id='"+activityId+"' and  c.activity_id=b.activity_id and b.user_id=a.user_id");
		
		sql.setCallback(new SqlCallback() {
			@Override
	        public Object invoke(Connection conn, ResultSet rs, Sql sql) throws SQLException {
	            List<String> list = new LinkedList<String>();
	            while (rs.next())
	                list.add(rs.getString("headimgurl"));
	            return list;
	        }

			
	    });
	    dao.execute(sql);
	    return sql.getList(String.class);
	}
	//根据条件查询
		public List<Map> getActivityByIdNoImgAndDou(String activityId)throws Exception{
			
			/*Sql sql = Sqls.create(
					"select a.headimgurl from activity a,participate b where"
					+ " a.activity_id='"+activityId+"' and  a.activity_id=b.activity_id and b.partici_type='N'");*/
			
			Sql sql = Sqls.create(
					"select a.headimgurl,b.double_num from webchat_user a, participate b, activity c where"
					+ " c.activity_id='"+activityId+"' and  c.activity_id=b.activity_id and b.partici_type='N' and b.user_id=a.user_id");
			
			sql.setCallback(new SqlCallback() {
				@Override
		        public Object invoke(Connection conn, ResultSet rs, Sql sql) throws SQLException {
		            List<Map> list = new LinkedList<Map>();
		            while (rs.next()){
		            	Map<String, String> temp = new HashMap<String, String>();
		            	temp.put("headimgurl", rs.getString("headimgurl"));
		            	temp.put("double_num", rs.getString("double_num"));
		            	 list.add(temp);
		            }
		               
		            return list;
		        }

				
		    });
		    dao.execute(sql);
		    return sql.getList(Map.class);
		}
		
		//根据条件查询
		public List<String> getActivityByIdNo(String activityId)throws Exception{
			
			/*Sql sql = Sqls.create(
					"select a.headimgurl from activity a,participate b where"
					+ " a.activity_id='"+activityId+"' and  a.activity_id=b.activity_id and b.partici_type='N'");*/
			
			Sql sql = Sqls.create(
					"select a.headimgurl from webchat_user a, participate b, activity c where"
					+ " c.activity_id='"+activityId+"' and  c.activity_id=b.activity_id and b.partici_type='N' and b.user_id=a.user_id");
			
			sql.setCallback(new SqlCallback() {
				@Override
		        public Object invoke(Connection conn, ResultSet rs, Sql sql) throws SQLException {
		            List<String> list = new LinkedList<String>();
		            while (rs.next()){
		            	 list.add(rs.getString("headimgurl"));
		            }
		               
		            return list;
		        }

				
		    });
		    dao.execute(sql);
		    return sql.getList(String.class);
		}
	
	
	public String  save(Participate participate)throws Exception{
		
		dao.insert(participate);
		return "SUCCESS";
	}
	
	//根据条件查询
		public List<WechatUser> getYesParticipateWechatInfoByActId(String activityid) throws Exception{
			Sql sql = Sqls.create("SELECT b.* FROM participate a LEFT JOIN webchat_user b ON a.user_id = b.openid WHERE a.activity_id = '"+activityid+"' and a.partici_type = 'Y' ");
			sql.setCallback(new SqlCallback() {
				@Override
				public Object invoke(Connection conn, ResultSet rs, Sql sql) throws SQLException{
					List<WechatUser> list = new LinkedList<WechatUser>();
					while(rs.next()){
						WechatUser wechatUser = dao.getEntity(WechatUser.class).getObject(rs, null);
						list.add(wechatUser);
					}
					 return list;
				}
			});
			dao.execute(sql);
			return sql.getList(WechatUser.class);
		}
		public List<Map> getYesParticipateWechatInfoByActId(String activityid,int templateId) throws Exception{
			Sql sql = Sqls.create("SELECT usr.*, " +
					"	(select aty.forecast_accuracy  " +
					"	from accuracy_type aty  " +
					"	WHERE aty.type_id = '"+templateId+"'  " +
					"	and aty.user_id = usr.user_id) forecastAccuracyOfTmplate ," +
					"	(select aty.count_all  " +
					"	from accuracy_type aty  " +
					"	WHERE aty.type_id = '"+templateId+"'  " +
					"	and aty.user_id = usr.user_id) countAllOfTmplate " +
					" FROM webchat_user usr  " +
					" WHERE usr.user_id in ( " +
					" SELECT ptpt.user_id " +
					" FROM participate ptpt  " +
					" WHERE ptpt.activity_id = '"+activityid+"' AND ptpt.partici_type = 'Y')");
				sql.setCallback(new SqlCallback() {
				@Override
				public Object invoke(Connection conn, ResultSet rs, Sql sql) throws SQLException{
					List<Map> list = new LinkedList<Map>();
					while(rs.next()){
						Map<String, String> temp = new HashMap<String, String>();
			    		temp.put("user_id", rs.getString("user_id"));
			    		temp.put("nickName", rs.getString("nickname"));
			    		temp.put("headImgUrl", rs.getString("headimgurl"));
			    		temp.put("countAllOfTmplate",rs.getString("countAllOfTmplate"));
			    		temp.put("forecastAccuracyOfTmplate", rs.getString("forecastAccuracyOfTmplate"));//当前template_id对应的准确率
				    	list.add(temp);
					}
					 return list;
				}
			});
			dao.execute(sql);
			return sql.getList(Map.class);
		}
		
		public List<WechatUser> getNoParticipateWechatInfoByActId(String activityid) throws Exception{
			Sql sql = Sqls.create("SELECT b.* FROM participate a LEFT JOIN webchat_user b ON a.user_id = b.openid WHERE a.activity_id = '"+activityid+"' and a.partici_type = 'N'");
			sql.setCallback(new SqlCallback() {
				@Override
				public Object invoke(Connection conn, ResultSet rs, Sql sql) throws SQLException{
					List<WechatUser> list = new LinkedList<WechatUser>();
					while(rs.next()){
						WechatUser wechatUser = dao.getEntity(WechatUser.class).getObject(rs, null);
						list.add(wechatUser);
					}
					 return list;
				}
			});
			dao.execute(sql);
			return sql.getList(WechatUser.class);
		}
		public List<Map> getNoParticipateWechatInfoByActId(String activityid ,int templateId) throws Exception{
			Sql sql = Sqls.create("SELECT usr.*, " +
								"	(select aty.forecast_accuracy  " +
								"	from accuracy_type aty  " +
								"	WHERE aty.type_id = '"+templateId+"'  " +
								"	and aty.user_id = usr.user_id) forecastAccuracyOfTmplate ," +
								"	(select aty.count_all  " +
								"	from accuracy_type aty  " +
								"	WHERE aty.type_id = '"+templateId+"'  " +
								"	and aty.user_id = usr.user_id) countAllOfTmplate " +
								" FROM webchat_user usr  " +
								" WHERE usr.user_id in ( " +
								" SELECT ptpt.user_id " +
								" FROM participate ptpt  " +
								" WHERE ptpt.activity_id = '"+activityid+"' AND ptpt.partici_type = 'N')");
			sql.setCallback(new SqlCallback() {
				@Override
				public Object invoke(Connection conn, ResultSet rs, Sql sql) throws SQLException{
					List<Map> list = new LinkedList<Map>();
					while(rs.next()){
						Map<String, String> temp = new HashMap<String, String>();
			    		temp.put("user_id", rs.getString("user_id"));
			    		temp.put("nickName", rs.getString("nickname"));
			    		temp.put("headImgUrl", rs.getString("headimgurl"));
			    		temp.put("countAllOfTmplate",rs.getString("countAllOfTmplate"));
			    		temp.put("forecastAccuracyOfTmplate", rs.getString("forecastAccuracyOfTmplate"));//当前template_id对应的准确率
				    	list.add(temp);
					}
					 return list;
				}
			});
			dao.execute(sql);
			return sql.getList(Map.class);
		}
		

		public List<Map> getYesImgAndDou(String activityid)throws Exception{
			
			Sql sql = Sqls.create(
					"select a.headimgurl,b.double_num from webchat_user a,participate b , activity c where"
					+ " c.activity_id='"+activityid+"' and  a.user_id=b.user_id and b.partici_type='Y' and  c.activity_id=b.activity_id");
			
			sql.setCallback(new SqlCallback() {
				@Override
		        public Object invoke(Connection conn, ResultSet rs, Sql sql) throws SQLException {
		            List<Map> list = new LinkedList<Map>();
		            while (rs.next()){
		            	Map<String, String> temp = new HashMap<String, String>();
		            	temp.put("headimgurl", rs.getString("headimgurl"));
		            	temp.put("double_num", rs.getString("double_num"));
		            	 list.add(temp);
		            }
		               
		            return list;
		        }

				
		    });
		    dao.execute(sql);
		    return sql.getList(Map.class);
		}
		
		public List<String> getYes(String activityid)throws Exception{
			
			Sql sql = Sqls.create(
					"select a.headimgurl from webchat_user a,participate b , activity c where"
					+ " c.activity_id='"+activityid+"' and  a.user_id=b.user_id and b.partici_type='Y' and  c.activity_id=b.activity_id");
			
			sql.setCallback(new SqlCallback() {
				@Override
		        public Object invoke(Connection conn, ResultSet rs, Sql sql) throws SQLException {
		            List<String> list = new LinkedList<String>();
		            while (rs.next()){
		            	 list.add(rs.getString("headimgurl"));
		            }
		               
		            return list;
		        }

				
		    });
		    dao.execute(sql);
		    return sql.getList(String.class);
		}
		//根据条件查询
				public List<String> getYesNickname(String activityid)throws Exception{
					
					Sql sql = Sqls.create(
							"select a.nickname from webchat_user a,participate b , activity c where"
							+ " c.activity_id='"+activityid+"' and  a.user_id=b.user_id and b.partici_type='Y' and  c.activity_id=b.activity_id");
					
					sql.setCallback(new SqlCallback() {
						@Override
				        public Object invoke(Connection conn, ResultSet rs, Sql sql) throws SQLException {
				            List<String> list = new LinkedList<String>();
				            while (rs.next())
				                list.add(rs.getString("nickname"));
				            return list;
				        }

						
				    });
				    dao.execute(sql);
				    return sql.getList(String.class);
				}	
				//根据条件查询
				public List<String> getNoNickname(String activityid)throws Exception{
					
					Sql sql = Sqls.create(
							"select a.nickname from webchat_user a,participate b , activity c where"
							+ " c.activity_id='"+activityid+"' and  a.user_id=b.user_id and b.partici_type='N' and  c.activity_id=b.activity_id");
					
					sql.setCallback(new SqlCallback() {
						@Override
				        public Object invoke(Connection conn, ResultSet rs, Sql sql) throws SQLException {
				            List<String> list = new LinkedList<String>();
				            while (rs.next())
				                list.add(rs.getString("nickname"));
				            return list;
				        }

						
				    });
				    dao.execute(sql);
				    return sql.getList(String.class);
				}	
		
		
}
