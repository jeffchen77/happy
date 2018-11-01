package com.happy.dao;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.nutz.dao.Chain;
import org.nutz.dao.Cnd;
import org.nutz.dao.Sqls;
import org.nutz.dao.sql.Sql;
import org.nutz.dao.sql.SqlCallback;

import com.happy.dao.common.BaseDao;
import com.happy.model.UnreadMesUserInfo;
import com.happy.model.UnreadMessage;


public class UnreadMesDao extends BaseDao{
	//插入新的未读评论信息
	public void insertUnreadMes(UnreadMessage unreadMes){
		dao.insert(unreadMes);
	}
	//update已读评论信息
	public void updateUnreadMes(String activityId,String participateUserId){
		dao.update("unread_message", Chain.make("unread", 0), Cnd.wrap("activity_id='"+activityId+"' and participate_user_id='"+participateUserId+"'"));
	}
	//获取未读评论信息#停止使用
	public List<UnreadMesUserInfo> getUnreadMes(String participateUserId){
		Sql sql =  Sqls.queryRecord("SELECT COUNT(um.unread) countOfUnOfEachAct, um.activity_id activityId,MAX(um.create_time) createTime,  "+
									"						um.participate_user_id participateUserId,  "+
									"						um.reply_user_id replyUserId, "+
									"					(SELECT act.activity_remark FROM activity act WHERE act.activity_id = um.activity_id ) AS activityRemark, "+
									"					(SELECT act.activity_desc FROM activity act WHERE act.activity_id = um.activity_id ) AS acitvityDes, "+
									"					(SELECT wu.headimgurl FROM webchat_user wu WHERE wu.user_id = um.reply_user_id ) AS replyUserheadImgUrl "+
									"	FROM unread_message um "+
									"	WHERE um.unread = 1 "+
									"	AND um.participate_user_id = '"+participateUserId+"' "+
									"	GROUP BY um.activity_id");
		sql.setCallback(new SqlCallback(){
			public Object invoke(Connection conn, ResultSet rs, Sql sql) throws SQLException{
				List<UnreadMesUserInfo> list = new LinkedList<UnreadMesUserInfo>();
				while(rs.next()){
					UnreadMesUserInfo unreadMes = dao.getEntity(UnreadMesUserInfo.class).getObject(rs,null);
					list.add(unreadMes);
				}
				return list;
			}
		});
		dao.execute(sql);
		return sql.getList(UnreadMesUserInfo.class);
	}
	
	//获取已读对最新评论详情
	public  List<Map> getReadedMesAndRep( String participateUserId)throws Exception{
		Sql sql = Sqls.create(
				"	SELECT a.*,act.activity_remark,act.activity_desc,act.user_id ownerUserId "+
				"	FROM( "+
				"			SELECT count(um.activity_id) countOfact,um.activity_id ,MAX(um.create_time) create_time "+
				"						FROM unread_message um  "+
				"					WHERE um.unread != 1  "+
				"						AND um.participate_user_id = '"+participateUserId+"'  "+
				"						GROUP BY um.activity_id  "+
				"						ORDER BY create_time DESC "+
                "    					LIMIT 5 "+
				"				) a  "+
				"	LEFT JOIN activity act on a.activity_id = act.activity_id");
		final String partUserI = participateUserId;
		sql.setCallback(new SqlCallback() {
			@Override
	        public Object invoke(Connection conn, ResultSet rs, Sql sql) throws SQLException {
	            List<Map> list = new ArrayList<Map>();
	            
	            while (rs.next())
	            {
	            	 Map mp=new HashMap();
	            	 mp.put("countOfact", rs.getString("countOfact"));
	            	 mp.put("activityId", rs.getString("activity_id"));
	            	 mp.put("activityRemark", rs.getString("activity_remark"));
	            	 mp.put("activityDesc", rs.getString("activity_desc"));
	            	 mp.put("ownerUserId", rs.getString("ownerUserId"));
	            	 try {
						List<Map> readedReplyCommentList = getReadedReplyCommentList(partUserI,mp.get("activityId").toString() );
						mp.put("readedReplyCommentList", readedReplyCommentList);
						
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

	public List<Map> getReadedReplyCommentList(String participateUserId,String activityId){
		Sql  sql = Sqls.queryRecord("SELECT a.comment_id,a.create_time,a.reply_user_id, "+
									"			(SELECT wu.headimgurl FROM webchat_user wu WHERE wu.user_id = a.reply_user_id) as imgOfreply, "+
									"			(SELECT wu.nickname FROM webchat_user wu WHERE wu.user_id = a.reply_user_id) as nickOfreply, "+
									"			a.replyComments, "+
									"			a.touser_id, "+
									"			(SELECT wu.headimgurl FROM webchat_user wu WHERE wu.user_id = a.touser_id) as toUserHead, "+
									"			(SELECT wu.nickname FROM webchat_user wu WHERE wu.user_id = a.touser_id) as nickOftoUser "+
									"FROM ( "+
									"	SELECT um.activity_id, "+
									"	(SELECT act.user_id FROM activity act WHERE act.activity_id = um.activity_id) AS touser_id, "+
									"	um.create_time, "+
									"	um.comment_id, "+
									"	(SELECT ac.comments FROM activity_comments ac WHERE ac.id = um.comment_id) AS replyComments, "+
									"	um.reply_user_id   "+
									"	FROM unread_message um "+
									"	WHERE um.remark_id = 0 "+
									"	AND um.participate_user_id = '"+participateUserId+"' "+
									"	AND um.activity_id = '"+activityId+"' "+
									")a "+
									"UNION "+
									"SELECT a.comment_id,a.create_time,a.reply_user_id, "+
									"			(SELECT wu.headimgurl FROM webchat_user wu WHERE wu.user_id = a.reply_user_id) as imgOfreply, "+
									"			(SELECT wu.nickname FROM webchat_user wu WHERE wu.user_id = a.reply_user_id) as nickOfreply, "+
									"			a.replyComments, "+
									"			a.touser_id, "+
									"			(SELECT wu.headimgurl FROM webchat_user wu WHERE wu.user_id = a.touser_id) as toUserHead, "+
									"			(SELECT wu.nickname FROM webchat_user wu WHERE wu.user_id = a.touser_id) as nickOftoUser "+
									"FROM ( "+
									"  SELECT um.comment_id, "+
									"				um.create_time, "+
									"				um.reply_user_id, "+
									"				(SELECT cr.comments FROM comments_reply cr WHERE cr.id = um.remark_id ) AS replyComments, "+
									"				(SELECT cr.touser_id FROM comments_reply cr WHERE cr.id = um.remark_id) AS touser_id "+
									"	FROM unread_message um "+
									"	WHERE um.remark_id != 0 "+
									"	AND um.participate_user_id = '"+participateUserId+"' "+
									"	AND um.activity_id = '"+activityId+"' "+
									") a");
		sql.setCallback(new SqlCallback(){
			public Object invoke(Connection conn, ResultSet rs, Sql sql) throws SQLException {
				List<Map> list =  new LinkedList<Map>();
			    while (rs.next()) {
		    		Map<String, String> temp = new HashMap<String, String>();
		    		temp.put("commentId", rs.getString("comment_id"));
		    		temp.put("createTime", rs.getString("create_time"));
		    		temp.put("replyUserId", rs.getString("reply_user_id"));
		    		temp.put("imgOfreply", rs.getString("imgOfreply"));
		    		temp.put("nickOfreply", rs.getString("nickOfreply"));
		    		temp.put("replyComments", rs.getString("replyComments"));
		    		temp.put("touserId", rs.getString("touser_id"));
		    		temp.put("toUserHead", rs.getString("toUserHead"));
		    		temp.put("nickOftoUser", rs.getString("nickOftoUser"));
			    	list.add(temp);
				}
			    return list;
			}
		});
		dao.execute(sql);
		return sql.getList(Map.class);
		
	}
	
	
	
	
	
	
	
	//获取未读评论消息详情
	public  List<Map> getUnreadMesAndRep( String participateUserId)throws Exception{
		Sql sql = Sqls.create(
				"			SELECT a.*,act.activity_remark,act.activity_desc,act.user_id ownerUserId "+
				"	FROM( "+
				"			SELECT count(um.activity_id) countOfact,um.activity_id,MAX(um.create_time) create_time "+
				"						FROM unread_message um "+
				"						WHERE um.unread = 1 "+
				"						AND um.participate_user_id = '"+participateUserId+"' "+
				"						GROUP BY um.activity_id order by create_time desc "+
				"				) a "+
				"	LEFT JOIN activity act on a.activity_id = act.activity_id");
		final String partUserI = participateUserId;
		sql.setCallback(new SqlCallback() {
			@Override
	        public Object invoke(Connection conn, ResultSet rs, Sql sql) throws SQLException {
	            List<Map> list = new ArrayList<Map>();
	            
	            while (rs.next())
	            {
	            	 Map mp=new HashMap();
	            	 mp.put("countOfact", rs.getString("countOfact"));
	            	 mp.put("activityId", rs.getString("activity_id"));
	            	 mp.put("activityRemark", rs.getString("activity_remark"));
	            	 mp.put("activityDesc", rs.getString("activity_desc"));
	            	 mp.put("ownerUserId", rs.getString("ownerUserId"));
	            	 try {
						List<Map> unreadReplyCommentList = getUnreadReplyCommentList(partUserI,mp.get("activityId").toString() );
						if(unreadReplyCommentList.size()>0){
							mp.put("unreadReplyCommentList", unreadReplyCommentList);
//							mp.put("ReplyTagCss", "tag");
						}
						else{
							mp.put("unreadReplyCommentList", unreadReplyCommentList);
//							mp.put("ReplyTagCss", "");
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
	
	public List<Map> getUnreadReplyCommentList(String participateUserId,String activityId){
		Sql  sql = Sqls.queryRecord("select tp.* from ( "
									+ "SELECT a.comment_id,a.create_time,a.reply_user_id,"+
									"			(SELECT wu.headimgurl FROM webchat_user wu WHERE wu.user_id = a.reply_user_id) as imgOfreply, "+
									"			(SELECT wu.nickname FROM webchat_user wu WHERE wu.user_id = a.reply_user_id) as nickOfreply, "+
									"			a.replyComments, "+
									"			a.touser_id, "+
									"			(SELECT wu.headimgurl FROM webchat_user wu WHERE wu.user_id = a.touser_id) as toUserHead, "+
									"			(SELECT wu.nickname FROM webchat_user wu WHERE wu.user_id = a.touser_id) as nickOftoUser "+
									"FROM ( "+
									"	SELECT um.activity_id, "+
									"	(SELECT act.user_id FROM activity act WHERE act.activity_id = um.activity_id) AS touser_id, "+
									"	um.create_time, "+
									"	um.comment_id, "+
									"	(SELECT ac.comments FROM activity_comments ac WHERE ac.id = um.comment_id) AS replyComments, "+
									"	um.reply_user_id   "+
									"	FROM unread_message um "+
									"	WHERE um.unread = 1 "+
									"	AND um.remark_id = 0 "+
									"	AND um.participate_user_id = '"+participateUserId+"' "+
									"	AND um.activity_id = '"+activityId+"' "+
									")a "+
									"UNION "+
									"SELECT a.comment_id,a.create_time,a.reply_user_id,"+
									"			(SELECT wu.headimgurl FROM webchat_user wu WHERE wu.user_id = a.reply_user_id) as imgOfreply, "+
									"			(SELECT wu.nickname FROM webchat_user wu WHERE wu.user_id = a.reply_user_id) as nickOfreply, "+
									"			a.replyComments, "+
									"			a.touser_id, "+
									"			(SELECT wu.headimgurl FROM webchat_user wu WHERE wu.user_id = a.touser_id) as toUserHead, "+
									"			(SELECT wu.nickname FROM webchat_user wu WHERE wu.user_id = a.touser_id) as nickOftoUser "+
									"FROM ( "+
									"  SELECT um.comment_id, "+
									"				um.create_time, "+
									"				um.reply_user_id, "+
									"				(SELECT cr.comments FROM comments_reply cr WHERE cr.id = um.remark_id ) AS replyComments, "+
									"				(SELECT cr.touser_id FROM comments_reply cr WHERE cr.id = um.remark_id) AS touser_id "+
									"	FROM unread_message um "+
									"	WHERE um.unread = 1 "+
									"	AND um.remark_id != 0 "+
									"	AND um.participate_user_id = '"+participateUserId+"' "+
									"	AND um.activity_id = '"+activityId+"' "+
									") a"
									+ " ) tp order by tp.create_time desc ");
		sql.setCallback(new SqlCallback(){
			public Object invoke(Connection conn, ResultSet rs, Sql sql) throws SQLException {
				List<Map> list =  new LinkedList<Map>();
			    while (rs.next()) {
		    		Map<String, String> temp = new HashMap<String, String>();
		    		temp.put("commentId", rs.getString("comment_id"));
		    		temp.put("createTime", rs.getString("create_time"));
		    		temp.put("replyUserId", rs.getString("reply_user_id"));
		    		temp.put("imgOfreply", rs.getString("imgOfreply"));
		    		temp.put("nickOfreply", rs.getString("nickOfreply"));
		    		temp.put("replyComments", rs.getString("replyComments"));
		    		temp.put("touserId", rs.getString("touser_id"));
		    		temp.put("toUserHead", rs.getString("toUserHead"));
		    		temp.put("nickOftoUser", rs.getString("nickOftoUser"));
			    	list.add(temp);
				}
			    return list;
			}
		});
		dao.execute(sql);
		return sql.getList(Map.class);
		
	}
	

	public List<Map> getNBestComment(){
		Sql sql = Sqls.queryRecord("SELECT b.activityId,b.comment_id,b.commentsOfNBest,b.createTimecommentsOfNBest,b.userIdOfNBest, "+
									"				(SELECT act.activity_desc FROM activity act WHERE act.activity_id = b.activityId) AS activityDesc, "+
									"				(SELECT act.activity_remark FROM activity act WHERE act.activity_id = b.activityId) AS activityRemark, "+
									"				(SELECT act.create_time FROM activity act WHERE act.activity_id = b.activityId) AS createTimeOfact, "+
									"				(SELECT act.user_id FROM activity act WHERE act.activity_id = b.activityId) AS userIdOfFaqizhe, "+
									"				(SELECT wu.headimgurl FROM webchat_user wu WHERE wu.user_id = b.userIdOfNBest ) AS headImagOfNBest, "+
									"				(SELECT wu.nickname FROM webchat_user wu WHERE wu.user_id = b.userIdOfNBest ) AS nickOfNBest, "
									+ "              b.countOFcom"+
									"	FROM(		 "+
									"			SELECT  "+
									"					(SELECT ac.activity_id FROM activity_comments ac WHERE ac.id = a.comment_id) activityId, "+
									"					a.comment_id, "+
									"					(SELECT ac.comments FROM activity_comments ac WHERE ac.id = a.comment_id) commentsOfNBest, "+
									"					(SELECT ac.create_time FROM activity_comments ac WHERE ac.id = a.comment_id) createTimecommentsOfNBest, "+
									"					(SELECT ac.user_id FROM activity_comments ac WHERE ac.id = a.comment_id) userIdOfNBest,"
									+ "                  a.countOFcom "+
									"			FROM( "+
									"				SELECT cr.comment_id ,COUNT(cr.comment_id) countOFcom"+
									"				FROM comments_reply cr  WHERE cr.create_time > date_sub(curdate(),interval 30 day) "+
									"				GROUP BY cr.comment_id   "+
									"				ORDER BY COUNT(cr.comment_id) DESC   "+
									"				LIMIT 10 "+
									"			) a "+
									"	)b");
		sql.setCallback(new SqlCallback(){
			public Object invoke(Connection conn, ResultSet rs, Sql sql) throws SQLException {
				List<Map> list =  new LinkedList<Map>();
			    while (rs.next()) {
			    	 Map temp = new HashMap();
		    		temp.put("activityId", rs.getString("activityId"));
		    		temp.put("commentId", rs.getString("comment_id"));
		    		temp.put("commentsOfNBest", rs.getString("commentsOfNBest"));
		    		temp.put("createTimecommentsOfNBest", rs.getString("createTimecommentsOfNBest"));
		    		temp.put("userIdOfNBest", rs.getString("userIdOfNBest"));
		    		temp.put("activityDesc", rs.getString("activityDesc"));
		    		temp.put("createTimeOfact", rs.getString("createTimeOfact"));
		    		temp.put("userIdOfFaqizhe", rs.getString("userIdOfFaqizhe"));
		    		temp.put("headImagOfNBest", rs.getString("headImagOfNBest"));
		    		temp.put("nickOfNBest", rs.getString("nickOfNBest"));
		    		temp.put("countOFcom", rs.getString("countOFcom"));
		    		temp.put("activityRemark", rs.getString("activityRemark"));
		    		
			    	try {
						List<Map> allRepOfThisCommentId = getAllRepOfThisCommentId( rs.getString("comment_id"));
						temp.put("allRepOfThisCommentId", allRepOfThisCommentId);
					} catch (Exception e) {
						e.printStackTrace();
					} 
			    	list.add(temp);
				}
			    return list;
			}
		});
		dao.execute(sql);
		return sql.getList(Map.class);
	}
	
	
	private List<Map> getAllRepOfThisCommentId(String commentID) {
		Sql sql = Sqls.queryRecord("SELECT a.fromUserId, "+
									"				(SELECT wu.headimgurl FROM webchat_user wu WHERE wu.user_id = a.fromUserId) headImagOffromUser, "+
									"				(SELECT wu.nickname FROM webchat_user wu WHERE wu.user_id = a.fromUserId) nickOffromUser, "+
									"				a.toUserId, "+
									"				(SELECT wu.headimgurl FROM webchat_user wu WHERE wu.user_id = a.toUserId) headImagOftoUser, "+
									"				(SELECT wu.nickname FROM webchat_user wu WHERE wu.user_id = a.toUserId) nickOftoUser, "+
									"				a.commentsReply, "+
									"				a.create_time "+
									"FROM ( "+
									"	SELECT cr.user_id fromUserId,cr.touser_id toUserId,cr.comments commentsReply,cr.create_time "+
									"	FROM comments_reply cr "+
									"	WHERE cr.comment_id = '"+commentID+"'  "+
									"	ORDER BY cr.create_time "+
									") a");
		sql.setCallback(new SqlCallback(){
			public Object invoke(Connection conn, ResultSet rs, Sql sql) throws SQLException {
				List<Map> list =  new LinkedList<Map>();
			    while (rs.next()) {
		    		Map<String, String> temp = new HashMap<String, String>();
		    		temp.put("fromUserId", rs.getString("fromUserId"));
		    		temp.put("headImagOffromUser", rs.getString("headImagOffromUser"));
		    		temp.put("nickOffromUser", rs.getString("nickOffromUser"));
		    		temp.put("toUserId", rs.getString("toUserId"));
		    		temp.put("headImagOftoUser", rs.getString("headImagOftoUser"));
		    		temp.put("nickOftoUser", rs.getString("nickOftoUser"));
		    		temp.put("commentsReply", rs.getString("commentsReply"));
		    		temp.put("create_time", rs.getString("create_time"));
			    	list.add(temp);
				}
			    return list;
			}
		});
		dao.execute(sql);
		return sql.getList(Map.class);
	}
}
