package com.happy.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.nutz.dao.Chain;
import org.nutz.dao.Cnd;
import org.nutz.dao.Sqls;
import org.nutz.dao.sql.Criteria;
import org.nutz.dao.sql.Sql;
import org.nutz.dao.sql.SqlCallback;

import com.happy.dao.common.BaseDao;
import com.happy.model.Activity;
import com.happy.model.CareAbout;
import com.happy.model.Participate;
import com.happy.utils.CommonUtil;

public class ActivityDao extends BaseDao{
	
	//根据条件查询
	public Activity getActivityByActivityId(String activityId)throws Exception{
		Activity activity = null;
		Criteria cir = Cnd.cri();
		if(CommonUtil.notEmpty(activityId)){			
			cir.where().andEquals("activity_id", activityId).andNotEquals("activity_status", -2);
			activity = dao.fetch(Activity.class, cir);
		}			
		
		return activity;
	}	
	
	
	//获取某用户的胜场act信息
	public List<Map> getWinActivityByUserId(String userId,int templateId)throws Exception{
		Sql sql = Sqls.queryRecord( "SELECT * "+
									"FROM (  "+
									
									"SELECT act.create_time ,act.activity_id,act.activity_desc,act.activity_stake,act.result_status "+
									"FROM activity act ,participate part  "+
									"WHERE act.activity_id = part.activity_id "+
									"and part.user_id = '"+userId+"' "+
									"and act.result_status = 2 "+
									"and part.partici_type = 'Y' "+
									"and act.template_id = '"+templateId+"' "+
									
									"UNION ALL "+
									
									"SELECT act.create_time ,act.activity_id,act.activity_desc,act.activity_stake,act.result_status "+
									"FROM activity act ,participate part  "+
									"WHERE act.activity_id = part.activity_id "+
									"and part.user_id = '"+userId+"' "+
									"and act.result_status = 1 "+
									"and part.partici_type = 'N' "+
									"and act.template_id = '"+templateId+"' "+
									
								"	UNION ALL  "+
									
								"	select act.create_time ,act.activity_id,act.activity_desc,act.activity_stake,act.result_status "+
								"	from activity act  "+
								"	where act.user_id = '"+userId+"' "+
								"	and act.result_status = 2 "+
								"	and act.template_id = '"+templateId+"' "+
								"	) a ORDER BY a.create_time limit 0,5");	
		if(!userId.equals(null)){
			sql.setCallback( new SqlCallback() {
				@Override
				 public Object invoke(Connection conn, ResultSet rs, Sql sql) throws SQLException {
			    	List<Map> list =  new LinkedList<Map>();
				    while (rs.next()) {
				    	Map<String, String> temp = new HashMap<String, String>();
				    	temp.put("create_time", rs.getString("create_time"));
				    	temp.put("activity_id", rs.getString("activity_id"));
				    	temp.put("activity_desc", rs.getString("activity_desc"));
				    	temp.put("activity_stake", rs.getString("activity_stake"));
				    	temp.put("result_status", rs.getString("result_status"));
				    	list.add(temp);
					}
				    return list;
				}			
		    });
		    dao.execute(sql);
		}
		return sql.getList(Map.class);
	}	
	//获取某用户的负场act信息
		public List<Map> getLoseActivityByUserId(String userId,int templateId)throws Exception{
			Sql sql = Sqls.queryRecord( "SELECT * "+
										"FROM (  "+
										
										"SELECT act.create_time ,act.activity_id,act.activity_desc,act.activity_stake,act.result_status "+
										"FROM activity act ,participate part  "+
										"WHERE act.activity_id = part.activity_id "+
										"and part.user_id = '"+userId+"' "+
										"and act.result_status = 1 "+
										"and part.partici_type = 'Y' "+
										"and act.template_id = '"+templateId+"' "+
										
										"UNION ALL "+
										
										"SELECT act.create_time ,act.activity_id,act.activity_desc,act.activity_stake,act.result_status "+
										"FROM activity act ,participate part  "+
										"WHERE act.activity_id = part.activity_id "+
										"and part.user_id = '"+userId+"' "+
										"and act.result_status = 2 "+
										"and part.partici_type = 'N' "+
										"and act.template_id = '"+templateId+"' "+
										
									"	UNION ALL  "+
										
									"	select act.create_time ,act.activity_id,act.activity_desc,act.activity_stake,act.result_status "+
									"	from activity act  "+
									"	where act.user_id = '"+userId+"' "+
									"	and act.result_status = 1 "+
									"	and act.template_id = '"+templateId+"' "+
									"	) a ORDER BY a.create_time  limit 0,5");	
			if(!userId.equals(null)){
				sql.setCallback( new SqlCallback() {
					@Override
					 public Object invoke(Connection conn, ResultSet rs, Sql sql) throws SQLException {
				    	List<Map> list =  new LinkedList<Map>();
					    while (rs.next()) {
					    	Map<String, String> temp = new HashMap<String, String>();
					    	temp.put("create_time", rs.getString("create_time"));
					    	temp.put("activity_id", rs.getString("activity_id"));
					    	temp.put("activity_desc", rs.getString("activity_desc"));
					    	temp.put("activity_stake", rs.getString("activity_stake"));
					    	temp.put("result_status", rs.getString("result_status"));
					    	list.add(temp);
						}
					    return list;
					}			
			    });
			    dao.execute(sql);
			}
			return sql.getList(Map.class);
		}	
	
	public List<CareAbout> getCareByUserId(String userId, String nextTime)throws Exception{
		
		String sqlstr = "";
		if(nextTime == null)
		{
			sqlstr = "select a.* from care_about a,activity b where a.attitude_type='gz' and a.user_id='"+userId+"'and a.activity_id=b.activity_id  order by case b.activity_status when '0' then 1 when '1' then 2 when '2' then 3 when '-1' then 4   else 5 end,b.create_time desc limit 10";
		}
		else
		{
			sqlstr = "select a.* from care_about a,activity b where b.create_time<'"+nextTime+"' and a.attitude_type='gz' and a.user_id='"+userId+"'and a.activity_id=b.activity_id  order by case b.activity_status when '0' then 1 when '1' then 2 when '2' then 3 when '-1' then 4   else 5 end,b.create_time desc limit 10";
		}
		Sql sql = Sqls.queryRecord(sqlstr);		
		sql.setCallback(new SqlCallback(){
		    public Object invoke(Connection conn, ResultSet rs, Sql sql) throws SQLException {
		    	List<CareAbout> list =  new LinkedList<CareAbout>();
			    while (rs.next()) {
			    	CareAbout m = dao.getEntity(CareAbout.class).getObject(rs, null);
			    	list.add(m);
				}
			    return list;
			}
		});
		dao.execute(sql);
		 return sql.getList(CareAbout.class);
	
}	
	public List<Participate> getParticipateByUserId(String userId)throws Exception{
		
	 	String sqlstr = "";
	 		sqlstr = "select a.* from participate a,activity b where a.user_id='"+userId+"'and a.activity_id=b.activity_id  order by case b.activity_status when '0' then 1 when '1' then 2 when '2' then 3 when '-1' then 4   else 5 end,b.create_time desc";
	 	
		Sql sql = Sqls.queryRecord(sqlstr);		
		sql.setCallback(new SqlCallback(){
		    public Object invoke(Connection conn, ResultSet rs, Sql sql) throws SQLException {
		    	List<Participate> list =  new LinkedList<Participate>();
			    while (rs.next()) {
			    	Participate m = dao.getEntity(Participate.class).getObject(rs, null);
			    	list.add(m);
				}
			    return list;
			}
		});
		dao.execute(sql);
		 return sql.getList(Participate.class);
	
}	
	public List<Participate> getParticipateByUserId(String userId, String nextTime)throws Exception{
		
		 	String sqlstr = "";
		 	if(nextTime == null)
		 	{
		 		sqlstr = "select a.* from participate a,activity b where a.user_id='"+userId+"'and a.activity_id=b.activity_id  order by case b.activity_status when '0' then 1 when '1' then 2 when '2' then 3 when '-1' then 4   else 5 end,b.create_time desc limit 10";
		 	}
		 	else
		 	{
		 		sqlstr = "select a.* from participate a,activity b where b.create_time<'"+nextTime+"' and a.user_id='"+userId+"'and a.activity_id=b.activity_id  order by case b.activity_status when '0' then 1 when '1' then 2 when '2' then 3 when '-1' then 4   else 5 end,b.create_time desc limit 10";
		 	}
			Sql sql = Sqls.queryRecord(sqlstr);		
			sql.setCallback(new SqlCallback(){
			    public Object invoke(Connection conn, ResultSet rs, Sql sql) throws SQLException {
			    	List<Participate> list =  new LinkedList<Participate>();
				    while (rs.next()) {
				    	Participate m = dao.getEntity(Participate.class).getObject(rs, null);
				    	list.add(m);
					}
				    return list;
				}
			});
			dao.execute(sql);
			 return sql.getList(Participate.class);
		
	}	
	
	public List<Activity> getActivityByUserId(String userId, String sortTime)throws Exception{
		List<Activity> actls=null;
		//Criteria cir = Cnd.cri();
		if(CommonUtil.notEmpty(userId)){
			//cir.where().andEquals("user_id", userId).andNotEquals("activity_status", -2);
			String strSql = "";
			if(sortTime==null)
			{
				strSql = "user_id='"+userId+"' and activity_status!=-2 order by case activity_status when '0' then 1 when '1' then 2 when '2' then 3 when '-1' then 4   else 5 end,create_time desc limit 10";
			}
			else
			{
				strSql = "create_time<'"+sortTime+"' and user_id='"+userId+"' and activity_status!=-2 order by case activity_status when '0' then 1 when '1' then 2 when '2' then 3 when '-1' then 4   else 5 end,create_time desc limit 10";
			}
			actls = dao.query(Activity.class, Cnd.wrap(strSql));
		}			
		return actls;
	}	

	public List<Activity> getActivityByUserId(String userId)throws Exception{
		List<Activity> actls=null;
		//Criteria cir = Cnd.cri();
		if(CommonUtil.notEmpty(userId)){
			String strSql = "";
				strSql = "user_id='"+userId+"' and activity_status!=-2 order by case activity_status when '0' then 1 when '1' then 2 when '2' then 3 when '-1' then 4   else 5 end ";
			actls = dao.query(Activity.class, Cnd.wrap(strSql));
		}			
		return actls;
	}	
	
	
	public void updateResultStatusByActId(String actId, int resultFlag) throws Exception
	{	
		dao.update(Activity.class, Chain.make("result_status",resultFlag), Cnd.where("activity_id","=",actId));
		dao.update(Activity.class, Chain.make("result_date",new Timestamp(System.currentTimeMillis())), Cnd.where("activity_id","=",actId));
		dao.update(Activity.class, Chain.make("activity_status",2), Cnd.where("activity_id","=",actId));
	}
	
	public void deleteCareAct(String actId, String usrId) throws Exception
	{
		 Sql sql =Sqls.create("DELETE FROM care_about WHERE activity_id=@act AND user_id=@usrId");
		
		 sql.params().set("act", actId);
		 sql.params().set("usrId", usrId);
		 dao.execute(sql);
	}
	
	public List<String> getMailAddressBasedOnActId(String actId, String yOrN) throws Exception
	{
		Sql sql = Sqls.create(
				"select a.email_address from user a, participate b, activity c where"
				+ " c.activity_id='"+actId+"' and  c.activity_id=b.activity_id and b.partici_type='"+yOrN+"' and b.user_id=a.user_id");
		
		sql.setCallback(new SqlCallback() {
			@Override
	        public Object invoke(Connection conn, ResultSet rs, Sql sql) throws SQLException {
	            List<String> list = new LinkedList<String>();
	            while (rs.next())
	                list.add(rs.getString("email_address"));
	            return list;
	        }			
	    });
	    dao.execute(sql);
	    return sql.getList(String.class);
	}
	
	public List<String> getAllNickNameBasedOnActId(String actId, String yOrN) throws Exception
	{
		Sql sql = Sqls.create(
				"select a.nick_name from user a, participate b, activity c where"
				+ " c.activity_id='"+actId+"' and c.activity_id=b.activity_id and b.partici_type='"+yOrN+"' and b.user_id=a.user_id");
		
		sql.setCallback(new SqlCallback() {
			@Override
	        public Object invoke(Connection conn, ResultSet rs, Sql sql) throws SQLException {
	            List<String> list = new LinkedList<String>();
	            while (rs.next())
	                list.add(rs.getString("nick_name"));
	            return list;
	        }			
	    });
	    dao.execute(sql);
	    return sql.getList(String.class);
	}
	
	public List<String> getUserIdBasedOnActId(String actId, String yOrN) throws Exception
	{
		Sql sql = Sqls.create(
				"select a.user_id from user a, participate b, activity c where"
				+ " c.activity_id='"+actId+"' and  c.activity_id=b.activity_id and b.partici_type='"+yOrN+"' and b.user_id=a.user_id");
		
		sql.setCallback(new SqlCallback() {
			@Override
	        public Object invoke(Connection conn, ResultSet rs, Sql sql) throws SQLException {
	            List<String> list = new LinkedList<String>();
	            while (rs.next())
	                list.add(rs.getString("user_id"));
	            return list;
	        }			
	    });
	    dao.execute(sql);
	    return sql.getList(String.class);
	}
	
	public List<String> getAllreplyUserIDBasedOnCommentsId(String commentsID) throws Exception
	{
		Sql sql = Sqls.create("SELECT DISTINCT(user_id) "+
								"FROM ( "+
								"			SELECT user_id "+
								"			FROM comments_reply a  "+
								"			WHERE a.comment_id = '"+commentsID+"' "+
								"			UNION "+
								"			SELECT touser_id user_id "+
								"			FROM comments_reply a  "+
								"			WHERE a.comment_id = '"+commentsID+"' "+
								") a "+
								"where a.user_id IS NOT NULL");
		
		sql.setCallback(new SqlCallback() {
			@Override
	        public Object invoke(Connection conn, ResultSet rs, Sql sql) throws SQLException {
	            List<String> list = new LinkedList<String>();
	            while (rs.next())
	                list.add(rs.getString("user_id"));
	            return list;
	        }			
	    });
	    dao.execute(sql);
	    return sql.getList(String.class);
	}
	
	public String updateActivityStatusByActId(String actId, int activityStatus) throws Exception
	{
		
		dao.update(Activity.class, Chain.make("activity_status",activityStatus), Cnd.where("activity_id","=",actId));
		
		return "SUCCESS";
	}
	
	public List<String> getUserNameAndActTitle(String actId) throws Exception
	{
		Sql sql = Sqls.create(
				"select a.nick_name, c.activity_desc,c.activity_stake,a.email_address from user a, activity c where"
				+ " c.activity_id='"+actId+"' and c.user_id=a.user_id");
		
		sql.setCallback(new SqlCallback() {
			@Override
	        public Object invoke(Connection conn, ResultSet rs, Sql sql) throws SQLException {
				List<String> list = new LinkedList<String>();
	            while (rs.next())
	                list.add(rs.getString(1)+"&&"+rs.getString(2)+"&&"+rs.getString(3)+"&&"+rs.getString(4));
	            return list;
	        }			
	    });
	    dao.execute(sql);
	    return sql.getList(String.class);
	}
	
	/*
	 * 得到前10个活动记录
	 * */
	public List<Map> getTopTenActivityRecords(int type )
	{
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Calendar cal = Calendar.getInstance();
		String str = sf.format(cal.getTime());
		//Sql sql = Sqls.queryRecord("select a.id, b.headimgurl, b.nickname, a.activity_id, a.user_id, a.activity_desc, a.activity_stake, a.activity_status, a.create_time, a.stake_points from activity a, webchat_user b where a.acitvity_type!='1' and a.stake_points>0 and a.user_id=b.user_id and a.result_status=0 and a.activity_deadline > '"+str+"' order by a.id desc limit 5;");		
		Sql sql = Sqls.queryRecord("select a.id, b.headimgurl, b.nickname, a.activity_id, a.user_id, a.activity_desc, a.activity_stake, a.activity_status, "
				+ "a.create_time, a.stake_points ,a.img_back_news,a.title_back_news from activity a, webchat_user b where a.acitvity_type!='1' "
				+ "and a.stake_points>0 and a.user_id=b.user_id and a.result_status=0 and a.activity_status != -2 and a.template_id="+ type +" order by a.id desc limit 10;");
		sql.setCallback(new SqlCallback(){
		    public Object invoke(Connection conn, ResultSet rs, Sql sql) throws SQLException {
		    	List<Map> list =  new LinkedList<Map>();
			    while (rs.next()) {
			    	Map<String, String> temp = new HashMap<String, String>();
			    	temp.put("id", rs.getString("id"));
			    	temp.put("headimgurl", rs.getString("headimgurl"));
			    	String ni = rs.getString("nickname");
			    	if(ni!=null && ni.length()>=6)
			    	{
			    		ni = ni.substring(0, 6);
			    		ni = ni + "...";
			    	}
			    	temp.put("nickname", ni);
			    	temp.put("activity_id", rs.getString("activity_id"));
			    	temp.put("user_id", rs.getString("user_id"));
			    	temp.put("activity_desc", rs.getString("activity_desc"));
			    	temp.put("activity_stake", rs.getString("activity_stake"));
			    	temp.put("activity_status", rs.getString("activity_status"));
			    	temp.put("img_back_news", rs.getString("img_back_news"));
			    	temp.put("title_back_news", rs.getString("title_back_news"));
			    	String time = rs.getString("create_time");
			    	if(time!=null)
			    	{
			    		time = time.substring(0, time.length()-2);
			    	}
			    	temp.put("create_time", time);
			    	temp.put("stake_points", rs.getString("stake_points"));
			    	list.add(temp);
				}
			    return list;
			}
		});
		dao.execute(sql);
		return sql.getList(Map.class);
	}
	
	/*
	 * 得到活动参与者的头像
	 * */
	public List<String> getActParHeaderImg(String actId)
	{
		Sql sql = Sqls.queryRecord("select w.headimgurl from participate p, webchat_user w where p.activity_id='"+actId+"' and p.user_id = w.user_id;");		
		sql.setCallback(new SqlCallback(){
		    public Object invoke(Connection conn, ResultSet rs, Sql sql) throws SQLException {
		    	List<String> list =  new ArrayList<String>();
			    while (rs.next()) {
			    	list.add(rs.getString("headimgurl"));
				}
			    return list;
			}
		});
		dao.execute(sql);
		return sql.getList(String.class);
	}
	
	/*
	 * 得到前10个活动记录
	 * */
	public List<Map> getNextTopTenActivityRecords(int type,int page)
	{
		//本周固定活动使用条件为id中包含Week，7天之内创建的
				SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				Calendar cal = Calendar.getInstance();
				int oneWeek = -7;
				cal.add(cal.DATE, oneWeek);
				String oneWeekAgo = sf.format(cal.getTime());
				//1天之内的
				Calendar cal1 = Calendar.getInstance();
				int oneDay = -1;
				cal1.add(cal1.DATE, oneDay);
				String oneDayAgo = sf.format(cal1.getTime());
		//Sql sql = Sqls.queryRecord("select a.id, b.headimgurl, b.nickname, a.activity_id, a.user_id, a.activity_desc, a.activity_stake, a.activity_status, a.create_time, a.stake_points from activity a, webchat_user b where a.acitvity_type!='1' and a.stake_points>0 and a.user_id=b.user_id and a.result_status=0 and a.activity_deadline > '"+str+"' and a.id<"+nextId+" order by a.id desc limit 5;");	
		Sql sql = Sqls.queryRecord("select a.id, b.headimgurl, b.nickname, a.activity_id, a.user_id, a.activity_desc, a.activity_stake, a.activity_status, a.create_time, a.stake_points,a.template_id "
				+ "from activity a, webchat_user b where a.acitvity_type!='1' "
				+ "and a.stake_points>0 and a.user_id=b.user_id and a.result_status=0 and a.activity_status !=-2 "
				+ "and a.template_id = "+type+" "
						+ " and a.id not in (SELECT b.id "
				 + "FROM (  "
				+ " select a.id, b.headimgurl, b.nickname, a.activity_id, a.user_id, a.activity_desc, a.activity_stake, a.activity_status, a.create_time, a.stake_points,a.template_id "
				+ "from activity a, webchat_user b where a.acitvity_type!='1' "
				+ "and a.stake_points>0 and a.user_id=b.user_id and a.result_status=0 and a.activity_status !=-2 "
				+ "and a.activity_id like '%Week%' and a.create_time > '"+oneWeekAgo+"'"
				+ "UNION ALL "
				+ "select a.id, b.headimgurl, b.nickname, a.activity_id, a.user_id, a.activity_desc, a.activity_stake, a.activity_status, a.create_time, a.stake_points,a.template_id "
				+ "from activity a, webchat_user b where a.acitvity_type!='1' "
				+ "and a.stake_points>0 and a.user_id=b.user_id and a.result_status=0 and a.activity_status !=-2 "
				+ "and a.activity_id like '%Day%' and a.create_time > '"+oneDayAgo+"'"
						+ ") b )"
						+ " order by a.id desc limit "+ page*10 +","+ (page+1)*10 +";");	
		sql.setCallback(new SqlCallback(){
		    public Object invoke(Connection conn, ResultSet rs, Sql sql) throws SQLException {
		    	List<Map> list =  new LinkedList<Map>();
			    while (rs.next()) {
			    	Map<String, String> temp = new HashMap<String, String>();
			    	temp.put("id", rs.getString("id"));
			    	temp.put("headimgurl", rs.getString("headimgurl"));
			    	String ni = rs.getString("nickname");
			    	if(ni!=null && ni.length()>=6)
			    	{
			    		ni = ni.substring(0, 6);
			    		ni = ni + "...";
			    	}
			    	temp.put("nickname", ni);
			    	temp.put("activity_id", rs.getString("activity_id"));
			    	temp.put("user_id", rs.getString("user_id"));
			    	temp.put("activity_desc", rs.getString("activity_desc"));
			    	temp.put("activity_stake", rs.getString("activity_stake"));
			    	temp.put("activity_status", rs.getString("activity_status"));
			    	String time = rs.getString("create_time");
			    	if(time!=null)
			    	{
			    		time = time.substring(0, time.length()-2);
			    	}
			    	temp.put("create_time", time);
			    	temp.put("stake_points", rs.getString("stake_points"));
			    	temp.put("template_id", rs.getString("template_id"));
			    	list.add(temp);
				}
			    return list;
			}
		});
		dao.execute(sql);
		return sql.getList(Map.class);
	}
	
	//获取本周固定活动和本日固定活动
	public List<Map> getActsOfWeekAndDay(){
		//本周固定活动使用条件为id中包含Week，7天之内创建的
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Calendar cal = Calendar.getInstance();
		int oneWeek = -7;
		cal.add(cal.DATE, oneWeek);
		String oneWeekAgo = sf.format(cal.getTime());
		//1天之内的
		Calendar cal1 = Calendar.getInstance();
		int oneDay = -1;
		cal1.add(cal1.DATE, oneDay);
		String oneDayAgo = sf.format(cal1.getTime());
		
		Sql sql = Sqls.queryRecord("SELECT * "+
				"FROM (  "+
				" select a.id, b.headimgurl, b.nickname, a.activity_id, a.user_id, a.activity_desc, a.activity_stake, a.activity_status, a.create_time, a.stake_points,a.template_id "
				+ "from activity a, webchat_user b where a.acitvity_type!='1' "
				+ "and a.user_id=b.user_id and a.activity_status !=-2 "
				+ "and a.activity_id like '%Week%' and a.create_time in ( SELECT MAX(create_time) FROM activity a where a.activity_id like '%Week%') "
				+ "UNION ALL "
				+ "select a.id, b.headimgurl, b.nickname, a.activity_id, a.user_id, a.activity_desc, a.activity_stake, a.activity_status, a.create_time, a.stake_points,a.template_id "
				+ "from activity a, webchat_user b where a.acitvity_type!='1' "
				+ "and a.user_id=b.user_id and a.activity_status !=-2 "
				+ "and a.activity_id like '%Day%' and a.create_time in ( SELECT MAX(create_time) FROM activity a where a.activity_id like '%Day%') "
						+ ") a"
				);	
		sql.setCallback(new SqlCallback(){
		    public Object invoke(Connection conn, ResultSet rs, Sql sql) throws SQLException {
		    	List<Map> list =  new LinkedList<Map>();
			    while (rs.next()) {
			    	Map<String, String> temp = new HashMap<String, String>();
			    	temp.put("id", rs.getString("id"));
			    	temp.put("headimgurl", rs.getString("headimgurl"));
			    	String ni = rs.getString("nickname");
			    	if(ni!=null && ni.length()>=6)
			    	{
			    		ni = ni.substring(0, 6);
			    		ni = ni + "...";
			    	}
			    	temp.put("nickname", ni);
			    	temp.put("activity_id", rs.getString("activity_id"));
			    	temp.put("user_id", rs.getString("user_id"));
			    	temp.put("activity_desc", rs.getString("activity_desc"));
			    	temp.put("activity_stake", rs.getString("activity_stake"));
			    	temp.put("activity_status", rs.getString("activity_status"));
			    	String time = rs.getString("create_time");
			    	if(time!=null)
			    	{
			    		time = time.substring(0, time.length()-2);
			    	}
			    	temp.put("create_time", time);
			    	temp.put("stake_points", rs.getString("stake_points"));
			    	temp.put("template_id", rs.getString("template_id"));
			    	
			    	list.add(temp);
				}
			    return list;
			}
		});
		dao.execute(sql);
		return sql.getList(Map.class);
	}
	
	/*
	 * 得到系统的活动
	 * */
	public List<Activity> getSysActivity()
	{
		String sql = "acitvity_type='2' and result_status=0 order by create_time";
		return dao.query(Activity.class, Cnd.wrap(sql));
	}
	
	/*
	 * 得到过期的活动
	 * */
	public List<Activity> getOverdueActivity(String d)
	{
		String sql = "acitvity_type !='2' and activity_status != -2 and result_status=0 and publish_date < '"+d+"' order by publish_date";
		return dao.query(Activity.class, Cnd.wrap(sql));
	}
	
}
