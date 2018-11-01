package com.happy.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
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
import com.happy.model.ActivityComments;
import com.happy.model.ClickZan;
import com.happy.model.CommentsReply;
import com.happy.model.UserPoints;
import com.happy.utils.CommonUtil;

public class ActivityCommentsDao extends BaseDao{
	
	
	//根据条件查询
	public  List<Map> getCommentsInfoAndZan(List<Map> getCommentsInfo,String userId)throws Exception{
		ClickZan clickZan = null;
		for(int i=0;i<getCommentsInfo.size();i++){
			int id=Integer.parseInt((String) getCommentsInfo.get(i).get("CommentId"));
			Criteria cir = Cnd.cri();
			cir.where().andEquals("comment_id", id).andEquals("user_id", userId);
			clickZan = dao.fetch(ClickZan.class, cir);	
			if(clickZan!=null){
				getCommentsInfo.get(i).put("ZanClass", "text-danger");
			}else{
				getCommentsInfo.get(i).put("ZanClass", "");
			}	
		}
		
		return getCommentsInfo;
		
	}
	public  List<String> getCurrentInsertCommentId(String activityId,String userId)throws Exception{
		Sql sql = Sqls.create(
				"select MAX(id) as commentId from activity_comments where"
				+ " activity_id='"+activityId+"' and "+"user_id='"+userId+"'");
		sql.setCallback(new SqlCallback() {
			@Override
	        public Object invoke(Connection conn, ResultSet rs, Sql sql) throws SQLException {
	            List<String> list = new LinkedList<String>();
	            while (rs.next())
	                list.add(rs.getString("commentId"));
	            return list;
	        }

			
	    });
	    dao.execute(sql);
	    return sql.getList(String.class);
	}
	public  List<String> getCurrentInsertReplyCommentId(int commentId,String userId)throws Exception{
		Sql sql = Sqls.create(
				"select MAX(id) as remarkId from comments_reply where"
				+ " comment_id ='"+commentId+"' and "+"user_id='"+userId+"'");
		sql.setCallback(new SqlCallback() {
			@Override
	        public Object invoke(Connection conn, ResultSet rs, Sql sql) throws SQLException {
	            List<String> list = new LinkedList<String>();
	            while (rs.next())
	                list.add(rs.getString("remarkId"));
	            return list;
	        }

			
	    });
	    dao.execute(sql);
	    return sql.getList(String.class);
	}
	public  List<Map> getCommentsInfo(String activityId)throws Exception{
		Sql sql = Sqls.create(
				" SELECT a.*,ifnull(b.all_points,0) all_points,ifnull(b.locked_points,0) lockedPoints , "+
				" (select aty.forecast_accuracy from accuracy_type aty where aty.type_id = a.template_id and aty.user_id = a.user_id ) as forecast_accuracy  "+
				" FROM(  "+
				" select a.headimgurl,a.nickname,b.comments,a.user_id,b.create_time,b.zan,b.id ,  "+
				" 				(select act.template_id from activity act where act.activity_id = b.activity_id) as template_id "+
				"  from webchat_user a,activity_comments b,user c  "+
				"  where b.activity_id='"+activityId+"'  "+
				"  and  a.user_id=b.user_id  "+
				"  and a.user_id = c.user_id "+
				"  order by b.create_time DESC,b.zan DESC "+
				"  ) a "+
				"  LEFT JOIN user_points b on a.user_id = b.user_id "+
				" order by a.create_time DESC,a.zan DESC");
		
		sql.setCallback(new SqlCallback() {
			@Override
	        public Object invoke(Connection conn, ResultSet rs, Sql sql) throws SQLException {
	            List<Map> list = new ArrayList<Map>();
	            
	            while (rs.next())
	            {
	            	 Map mp=new HashMap();
	            	 mp.put("HeadURL", rs.getString("headimgurl"));
	            	 mp.put("Name", rs.getString("nickname"));
	            	 mp.put("CommentId", rs.getString("id"));
	            	 mp.put("UserId", rs.getString("user_id"));
	            	 mp.put("Zan", rs.getString("zan"));
	            	 mp.put("Comments", rs.getString("comments"));
	            	 mp.put("CreateTime", rs.getString("create_time"));
	            	 mp.put("ForecastAccuracy", rs.getString("forecast_accuracy"));
	            	 mp.put("AllPoints", rs.getString("all_points"));
	            	 mp.put("lockedPoints", rs.getString("lockedPoints"));
	            	 
	            	 try {
						List<Map> replyCommentList=getCommentsInfoAndCommentReply(Integer.parseInt((String)mp.get("CommentId")));
						if(replyCommentList.size()>0){
							mp.put("ReplyCommentList", replyCommentList);
							mp.put("ReplyTagCss", "tag");
						}
						else{
							mp.put("ReplyCommentList", replyCommentList);
							mp.put("ReplyTagCss", "");
						}
						
						
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} 
	            		 if(!mp.isEmpty())
                     {
                     list.add(mp);
                        
                     }
	            	
	            }
	            return list;
	        }

			
	    });
	    dao.execute(sql);
	    return sql.getList(Map.class);
	}
	public  List<Map> getCommentsInfoAndCommentReply(int commentId)throws Exception{
		Sql sql = Sqls.create(
				"select a.user_id,a.touser_id,a.comments,a.id, (select nickname from webchat_user b where b.user_id=a.user_id) as nickname,(select nickname from webchat_user b where b.user_id=a.touser_id) as commentReplyName from comments_reply a where"
				+ " a.comment_id='"+commentId+"' order by a.create_time ASC");
		
		sql.setCallback(new SqlCallback() {
			@Override
	        public Object invoke(Connection conn, ResultSet rs, Sql sql) throws SQLException {
	            List<Map> list = new ArrayList<Map>();
	            
	            while (rs.next())
	            {
	            	 Map mp=new HashMap();
	            	 mp.put("replyUserId", rs.getString("user_id"));
	            	 mp.put("replyUserName", rs.getString("nickname"));
	            	 mp.put("replyTouserId", rs.getString("touser_id"));
	            	 mp.put("replyTouserName", rs.getString("commentReplyName"));
	            	 mp.put("replyCommentId", rs.getString("id"));
	            	 mp.put("replyComments", rs.getString("comments"));
	            	 
	            		 if(!mp.isEmpty())
                     {
                     list.add(mp);
                        
                     }
	            	
	            }
	            return list;
	        }

			
	    });
	    dao.execute(sql);
	    return sql.getList(Map.class);
	}
		
	public String  save(ActivityComments activitycomments)throws Exception{
		
		dao.insert(activitycomments);
		return "SUCCESS";
	}
	public int getNewestCommentsId(String userId,Timestamp currentTime,String activityId){
		ActivityComments activityComments = null;
		Criteria cir = Cnd.cri();
		cir.where().andEquals("user_id", userId).andEquals("create_time", currentTime).andEquals("activity_id", activityId);
		activityComments = dao.fetch(ActivityComments.class, cir);				
		return (int) activityComments.getId();
	}
public String  save(CommentsReply commentsReply)throws Exception{
		
		dao.insert(commentsReply);
		return "SUCCESS";
	}

public int getNewestCommentsReplyId(CommentsReply commentsReply){
	CommentsReply commentsReplyback = null;
	Criteria cir = Cnd.cri();
	cir.where().andEquals("comment_id", commentsReply.getCommentId()).andEquals("user_id", commentsReply.getUserId()).andEquals("touser_id", commentsReply.getTouserId()).andEquals("create_time", commentsReply.getCreateTime());
	commentsReplyback = dao.fetch(CommentsReply.class, cir);				
	return (int) commentsReplyback.getId();
}



public String  insertZan(ClickZan clickZan)throws Exception{
		
		dao.insert(clickZan);
		return "SUCCESS";
	}
public ActivityComments getActivityCommentsById(int id){
	ActivityComments activityComments = null;
	Criteria cir = Cnd.cri();
	cir.where().andEquals("id", id);
	activityComments = dao.fetch(ActivityComments.class, cir);				
	return activityComments;
}

public String  deleteZan(int commentId, String usrId)throws Exception{
	
	 Sql sql =Sqls.create("DELETE FROM click_zan WHERE comment_id=@commentId AND user_id=@usrId");
		
	 sql.params().set("commentId", commentId);
	 sql.params().set("usrId", usrId);
	 dao.execute(sql);
	 return "SUCCESS";
}
public void updateActivityCommentsById( int id, int zanCount){
	dao.update("activity_comments", Chain.make("zan", zanCount), Cnd.wrap("id='"+id+"'"));
} 


	
}
