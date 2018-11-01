package com.happy.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
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
import com.happy.model.CareAbout;
import com.happy.model.PersonTransRecord;
import com.happy.model.PointsTrans;
import com.happy.model.UserPoints;
import com.happy.utils.CommonUtil;

public class UserPointsDao extends BaseDao{
	//根据userId获取userPoint	
	public UserPoints getUserpointsByUserId(String userId){
		UserPoints userPoints = null;
		Criteria cir = Cnd.cri();
		if(CommonUtil.notEmpty(userId)){
			cir.where().andEquals("user_id", userId);
			userPoints = dao.fetch(UserPoints.class, cir);
		}					
		return userPoints;
	}
	//根据userId修改points
	public void updateLockPointsByUserId(int lockPoints,String userId){
		dao.update("user_points", Chain.make("locked_points", lockPoints), Cnd.wrap("user_id='"+userId+"'"));
	}
	
	//根据userId修改points
	public void updateTotalPointsByUserId(int total,String userId){
		dao.update("user_points", Chain.make("all_points", total).add("update_time", new Timestamp(System.currentTimeMillis())), Cnd.wrap("user_id='"+userId+"'"));
	}
	
	//插入交易明细表
	public void insertPointsTran(PointsTrans pt)
	{
		dao.insert(pt);
	}
	
	//插入新用户城池
		public void insertUserPoints(UserPoints pt)
		{
			dao.insert(pt);
		}
		//根据userId和pgmId获取PointsTran	
		public PointsTrans getPointsTransByUserIdAndPgmId(String userId,String pgmId){
			PointsTrans pointsTrans = null;
			Criteria cir = Cnd.cri();
			if(CommonUtil.notEmpty(userId)){
				if("PGMDAY".equalsIgnoreCase(pgmId))
				{
					//这个方法是用于每日签到部分的
					DateFormat format=new SimpleDateFormat("yyyy-MM-dd");
					String dtStr = format.format(new Date());
					String begin = dtStr + " 00:00:00";
					String end = dtStr + " 23:59:59";
					cir.where().andEquals("user_id", userId).andEquals("act_pgm_id", pgmId).and("trans_time", ">=", begin).and("trans_time", "<=", end);
				}
				else
				{
					cir.where().andEquals("user_id", userId).andEquals("act_pgm_id", pgmId);
				}
				pointsTrans = dao.fetch(PointsTrans.class, cir);
			}					
			return pointsTrans;
		}
	//查询交易明细
	public List<Map> getDellDetailInfo(String activityid)
	{
		
		Sql sql = Sqls.queryRecord("select b.headimgurl, a.trans_type, a.trans_points from points_trans a, webchat_user b where a.act_pgm_id='"+activityid+"' and a.user_id = b.user_id;");		
		sql.setCallback(new SqlCallback(){
		    public Object invoke(Connection conn, ResultSet rs, Sql sql) throws SQLException {
		    	List<Map> list =  new LinkedList<Map>();
			    while (rs.next()) {
			    	Map<String, String> temp = new HashMap<String, String>();
			    	temp.put("picture", rs.getString("headimgurl"));
			    	temp.put("winlose", rs.getString("trans_type"));
			    	temp.put("points", rs.getString("trans_points"));
			    	list.add(temp);
				}
			    return list;
			}
		});
		dao.execute(sql);
		return sql.getList(Map.class);
	}
	//获取用户所有交易流水，按时间排序
		public List<PersonTransRecord> getTenTransRecordsByUserId(String userId,int pageNumber){
			Sql sql = Sqls.queryRecord("SELECT pt.act_pgm_id actId,"+
									       "act.user_id actOwnerId,"+
									       "wu.headimgurl headImgUrl,"+
									       "pt.user_id recordOwnerId,"+
										   "pt.bef_trans_points befTransPoints,"+
									       "pt.trans_points transPoints,"+
									       "pt.aft_trans_points aftTransPoints,"+
									       "pt.trans_time transTime "+
									"FROM   points_trans pt "+
									"LEFT JOIN activity act ON pt.act_pgm_id = act.activity_id "+
									"LEFT JOIN webchat_user wu ON act.user_id = wu.user_id "+
									"where pt.user_id = '"+userId+"' "+
									"ORDER BY pt.trans_time DESC "+
									"LIMIT "+(pageNumber-1)*10+","+(pageNumber*10-1)+" ") ;
			sql.setCallback(new SqlCallback(){
			    public Object invoke(Connection conn, ResultSet rs, Sql sql) throws SQLException {
			    	List<PersonTransRecord> list =  new LinkedList<PersonTransRecord>();
				    while (rs.next()) {
				    	PersonTransRecord m = dao.getEntity(PersonTransRecord.class).getObject(rs, null);
				    	list.add(m);
					}
				    return list;
				}
			});
			dao.execute(sql);
			 return sql.getList(PersonTransRecord.class);
		}
}
