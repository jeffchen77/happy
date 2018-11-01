package com.happy.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.nutz.dao.Cnd;
import org.nutz.dao.Sqls;
import org.nutz.dao.sql.Sql;
import org.nutz.dao.sql.SqlCallback;

import com.happy.dao.common.BaseDao;
import com.happy.model.ReportClickZan;

public class UserReportDao extends BaseDao{
	//获取userid用户排行榜信息
	public List<Map> getUserReport(String userId){
		Sql sql = Sqls.queryRecord("SELECT  a.*,b.nickname,b.headimgurl,c.forecast_accuracy,d.all_points  "+
									"FROM  user_report a,webchat_user b,user c ,user_points d "+
									"WHERE  a.user_id = b.user_id  "+
									"AND a.user_id = c.user_id  " + 
									"AND a.user_id = d.user_id  "+ 
									" and a.user_id != 'systemadmin' "+
									"ORDER BY d.all_points desc");
		final String userid = userId;
		sql.setCallback(new SqlCallback(){
			public Object invoke(Connection conn, ResultSet rs, Sql sql) throws SQLException {
				List<Map> list =  new LinkedList<Map>();
				int rownum = 0;
			    while (rs.next()) {
			    	rownum++;
			    	if(userid.equalsIgnoreCase(rs.getString("user_id"))){
			    		Map<String, String> temp = new HashMap<String, String>();
			    		temp.put("rownum", Integer.toString(rownum));
			    		temp.put("nickname", rs.getString("nickname"));
				    	temp.put("userId", rs.getString("user_id"));
				    	temp.put("winCount", rs.getString("win_count"));
				    	temp.put("lostCount", rs.getString("lost_count"));
				    	temp.put("selfPic", rs.getString("self_pic"));
				    	temp.put("headimgurl", rs.getString("headimgurl"));
				    	temp.put("forecastAccuracy", rs.getString("forecast_accuracy"));
				    	temp.put("allPoints",  rs.getString("all_points"));
				    	list.add(temp);
			    	}
				}
			    return list;
			}
		});
		dao.execute(sql);
		return sql.getList(Map.class);
	}
	//获取所有用户排行榜信心
	public List<Map> getAllUserReport(){
		Sql sql = Sqls.queryRecord("SELECT  a.*,b.nickname,b.headimgurl,c.forecast_accuracy,d.all_points,d.locked_points  "+
									"FROM  user_report a,webchat_user b,user c,user_points d   "+
									"WHERE  a.user_id = b.user_id  "+
									"AND a.user_id = c.user_id   "+
									"AND a.user_id = d.user_id  "+
									" and a.user_id != 'systemadmin' "+
									"ORDER BY d.all_points desc  limit 10");
		sql.setCallback(new SqlCallback(){
			public Object invoke(Connection conn, ResultSet rs, Sql sql) throws SQLException {
				List<Map> list =  new LinkedList<Map>();
				int rownum = 0;
			    while (rs.next()) {
			    	rownum++;
			    	Map<String, String> temp = new HashMap<String, String>();
			    	temp.put("nickname", rs.getString("nickname"));
			    	temp.put("rownum", Integer.toString(rownum));
			    	temp.put("userId", rs.getString("user_id"));
			    	temp.put("winCount", rs.getString("win_count"));
			    	temp.put("lostCount", rs.getString("lost_count"));
			    	temp.put("selfPic", rs.getString("self_pic"));
			    	temp.put("headimgurl", rs.getString("headimgurl"));
			    	temp.put("forecastAccuracy", rs.getString("forecast_accuracy"));
			    	temp.put("allPoints",  rs.getString("all_points"));
			    	temp.put("lockedPoints", rs.getString("locked_points"));
			    	list.add(temp);
				}
			    return list;
			}
		});
		dao.execute(sql);
		return sql.getList(Map.class);
	}
	
	public int getClickZanTotal(String userId)
	{
		return dao.count(ReportClickZan.class, Cnd.wrap("to_user_id='"+userId+"'"));
	}
	
	public int isClickZanToday(String fromUserId, String toUserId)
	{
		//这个方法是用于每日签到部分的
		DateFormat format=new SimpleDateFormat("yyyy-MM-dd");
		String dtStr = format.format(new Date());
		String begin = dtStr + " 00:00:00";
		String end = dtStr + " 23:59:59";
		String sql = "from_user_id='"+fromUserId+"' and to_user_id='"+toUserId+"' and create_time>='"+begin+"' and create_time<='"+end+"'";
		return dao.count(ReportClickZan.class, Cnd.wrap(sql));
	}

	public void insertReportZhan(ReportClickZan clickZan)
	{
		dao.insert(clickZan);
	}
}
