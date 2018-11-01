package com.happy.service;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import com.happy.action.OnLineAction;
import com.happy.dao.ActivityCommentsDao;
import com.happy.dao.ActivityDao;
import com.happy.dao.ParticipateDao;
import com.happy.dao.UserPointsDao;
import com.happy.dao.WechatUserDao;
import com.happy.model.Activity;
import com.happy.model.ActivityComments;
import com.happy.model.ClickZan;
import com.happy.model.CommentsReply;
import com.happy.model.Participate;
import com.happy.model.UserPoints;
import com.happy.model.WechatUser;

public class GameServices  {
	private static Logger log = LogManager.getLogger(GameServices.class);

	private ParticipateDao participateDao;
	private ActivityCommentsDao commentsDao;
	private ActivityDao activityDao;
	private WechatUserDao wechatUserDao;
	private UserPointsDao userPointsDao;
	public GameServices()
	{
		participateDao=new ParticipateDao();
		commentsDao=new ActivityCommentsDao();
		activityDao=new ActivityDao();
		wechatUserDao=new WechatUserDao();	
		userPointsDao = new UserPointsDao();
	}
	
	public List<String> getActivityById(String activityid) throws Exception
	{
		List<String> participate=null;
		participate=participateDao.getActivityById(activityid);
		return participate;
	}
	
	public List<String> getActivityByIdNo(String activityid) throws Exception
	{
		List<String> participateNO=null;
		participateNO=participateDao.getActivityByIdNo(activityid);
		return participateNO;
	}
	public List<Map> getActivityByIdNoImgAndDou(String activityid) throws Exception
	{
		List<Map> participateNO=null;
		participateNO=participateDao.getActivityByIdNoImgAndDou(activityid);
		return participateNO;
	}
	public List<String> getNicknameByIdYes(String activityid) throws Exception
	{
		List<String> participateNicknameYes=null;
		participateNicknameYes=participateDao.getYesNickname(activityid);
		return participateNicknameYes;
	}
	public List<String> getNicknameByIdNo(String activityid) throws Exception
	{
		List<String> participateNicknameNO=null;
		participateNicknameNO=participateDao.getNoNickname(activityid);
		return participateNicknameNO;
	}
	public  List<String> getCurrentInsertCommentId(String activityId,String userId)throws Exception
	{
		List<String> getCurrentInsertCommentId=null;
		getCurrentInsertCommentId=commentsDao.getCurrentInsertCommentId(activityId,userId);
		return getCurrentInsertCommentId;
	}
	public List<Map> getCommentsInfo(String activityid) throws Exception
	{
		List<Map> commentsInfo=null;
		commentsInfo=commentsDao.getCommentsInfo(activityid);
		return commentsInfo;
	}
	
	public List<Map> getCommentsInfoAndZan(List<Map> getCommentsInfo,String userId) throws Exception
	{
		List<Map> commentsInfo=null;
		commentsInfo=commentsDao.getCommentsInfoAndZan(getCommentsInfo, userId);
		return commentsInfo;
	}
	public List<WechatUser> getYesParticipateWechatInfoByActId(String activityid) throws Exception
	{
		List<WechatUser> getParticipateWechatInfo=null;
		getParticipateWechatInfo = participateDao.getYesParticipateWechatInfoByActId(activityid);
		return getParticipateWechatInfo;
	}
	public List<Map> getYesParticipateWechatInfoByActId(String activityid,int templateId) throws Exception
	{
		List<Map> getParticipateWechatInfo=null;
		getParticipateWechatInfo = participateDao.getYesParticipateWechatInfoByActId(activityid,templateId);
		return getParticipateWechatInfo;
	}
	
	public List<WechatUser> getNoParticipateWechatInfoByActId(String activityid) throws Exception
	{
		List<WechatUser> getParticipateWechatInfo=null;
		getParticipateWechatInfo = participateDao.getNoParticipateWechatInfoByActId(activityid);
		return getParticipateWechatInfo;
	}
	public List<Map> getNoParticipateWechatInfoByActId(String activityid,int templateId) throws Exception
	{
		List<Map> getParticipateWechatInfo=null;
		getParticipateWechatInfo = participateDao.getNoParticipateWechatInfoByActId(activityid,templateId);
		return getParticipateWechatInfo;
	}
	
	public List<Map> getWinActOfUser(String userId,int templateId) throws Exception{
		List<Map> winActOfuser = null;
		winActOfuser = activityDao.getWinActivityByUserId(userId, templateId);
		return winActOfuser;
	}
	
	public List<Map> getLoseActOfUser(String userId,int templateId) throws Exception{
		List<Map> loseActOfuser = null;
		loseActOfuser = activityDao.getLoseActivityByUserId(userId, templateId);
		return loseActOfuser;
	}
	
	public  Activity getInfoFromActivity(String activityId) throws Exception 
	{
		
		
		Activity activitiy=activityDao.getActivityByActivityId(activityId);
		
		return activitiy;
	}
	public  WechatUser getInfoFromWechatUser(String userId) throws Exception 
	{
		
		
		WechatUser wechatUser=wechatUserDao.getByUserId(userId);
	
		return wechatUser;
	}
	public List<String> getParticipateByYes(String activityid) throws Exception
	{
		List<String> participateYes=null;
		participateYes=participateDao.getYes(activityid);
		return participateYes;
	}
	public List<Map> getParticipateByYesImgAndDou(String activityid) throws Exception
	{
		List<Map> participateYes=null;
		participateYes=participateDao.getYesImgAndDou(activityid);
		return participateYes;
	}
	public String saveParticipate(Participate participate)throws Exception
	{
		int ret = findParticipate(participate.getUserId(), participate.getActivityId());
		if(ret != -1)
		{
		participateDao.save(participate);
		}
		return "SUCCESS";
	}
	
	public String insertComments(ActivityComments activitycomments)throws Exception
	{
		commentsDao.save(activitycomments);
		return "SUCCESS";
	}
	public int getNewestCommentsId(String userId,Timestamp currentTime,String activityId) throws Exception{
		
		List<String> getCurrentInsertCommentId=null;
		getCurrentInsertCommentId=commentsDao.getCurrentInsertCommentId(activityId,userId);
		return Integer.parseInt(getCurrentInsertCommentId.get(0)) ;
		
	}
	public String insertComments(CommentsReply commentsReply)throws Exception
	{
		commentsDao.save(commentsReply);
		return "SUCCESS";
	}
	public int getNewestCommentsReplyId(CommentsReply commentsReply) throws Exception{
		List<String> getCurrentInsertCommentId=null;
		getCurrentInsertCommentId=commentsDao.getCurrentInsertReplyCommentId(commentsReply.getCommentId(),commentsReply.getUserId());
		return Integer.parseInt(getCurrentInsertCommentId.get(0)) ;
	}
	public String updateActivityStatus(Activity activity)throws Exception
	{
		activityDao.updateActivityStatusByActId(activity.getActivityId(), activity.getActivityStatus());
		return "SUCCESS";
	}
	
	public int findParticipate(String userId ,String activityId)throws Exception{
		int returnVar=-1;
		 returnVar=participateDao.findParticipate(userId, activityId);
		 return returnVar;
	} 
	
	public List<Participate> findParticipateByActid(String activityId) throws Exception{
		List<Participate> participates = participateDao.getParticipateByActId(activityId);
		return participates;
	}
	
	public List<String> getAllParticipateBasedOnActId(String actId)
	{
		try
		{
			log.info("“getAllParticipateBasedOnActId的"+actId+"”");
			List<String> yesPart = activityDao.getUserIdBasedOnActId(actId, "Y");
			List<String> noPart = activityDao.getUserIdBasedOnActId(actId, "N");
			
			List<String> revList = new ArrayList<String>();
			
			revList.addAll(yesPart);
			revList.addAll(noPart);
			
			return revList;
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return null;
		}
	}
	//查找同一commentID下的用户userid
	public List<String> getAllreplyUserIDBasedOnCommentsId(String commentsId)
	{
		try
		{
			List<String> replyUserIDListOfSameCommmenId = activityDao.getAllreplyUserIDBasedOnCommentsId(commentsId);
			
			return replyUserIDListOfSameCommmenId;
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return null;
		}
	}
	public String isNeedPassword(String activityid) throws Exception
	{
		Activity act = activityDao.getActivityByActivityId(activityid);
		String type = act.getAcitvityType();
		if("1".equalsIgnoreCase(type))
		{
			return "Y";
		}
		else
		{
			return "N";
		}
	}
	
	public int getAvailablePoints(String userId) throws Exception
	{
		UserPoints up = userPointsDao.getUserpointsByUserId(userId);
		if(up!=null)
		{
			return up.getAllPoints()-up.getLockedPoints();
		}
		return -1;
	}
	
	public List<Map> getDellDetailInfo(String activityid) throws Exception
	{
		
		return userPointsDao.getDellDetailInfo(activityid);
	}
	//点赞
	public String insertZan(ClickZan clickZan,int zanCount)throws Exception
	{
		commentsDao.insertZan(clickZan);
		commentsDao.updateActivityCommentsById(clickZan.getCommentId(), zanCount);
		return "SUCCESS";
	}
	
	//取消点赞
		public String deleteZan(ClickZan clickZan,int zanCount)throws Exception
		{
			commentsDao.deleteZan(clickZan.getCommentId(), clickZan.getUserId());
			commentsDao.updateActivityCommentsById(clickZan.getCommentId(), zanCount);
			return "SUCCESS";
		}
		public ActivityComments getActivityCommentsById(int commentId){
			
			return commentsDao.getActivityCommentsById(commentId);
		}
}
