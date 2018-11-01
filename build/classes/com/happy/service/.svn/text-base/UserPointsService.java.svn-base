package com.happy.service;

import java.sql.Timestamp;
import java.util.List;

import com.happy.dao.UserPointsDao;
import com.happy.model.PointsTrans;
import com.happy.model.UserPoints;
import com.happy.model.PersonTransRecord;

public class UserPointsService {
	UserPointsDao userPointsDao = new UserPointsDao();
	//获取用户城池数
	public UserPoints getUserpointsByUserId(String userId){
		UserPoints userPoints = userPointsDao.getUserpointsByUserId(userId);
		return userPoints;
	}
	//更新用户锁定城池数
	public void updateLockPointsByUserId(int lockPoints,String userId){
		userPointsDao.updateLockPointsByUserId(lockPoints, userId);
	}
	
	//更新用户锁定城池数
	public void updateTotalPointsByUserId(int total,String userId){
		userPointsDao.updateTotalPointsByUserId(total, userId);
	}
	
	//更新用户锁定城池数
	public void insertPointsTran(String actId,String userId, int bef, int aft, int tran, int win){
		PointsTrans pt = new PointsTrans();
		pt.setActPgmId(actId);
		pt.setAftTransPoints(aft);
		pt.setBefTransPoints(bef);
		pt.setTransPoints(tran);
		pt.setTransTime(new Timestamp(System.currentTimeMillis()));
		pt.setTransType(win);
		pt.setUserId(userId);
		userPointsDao.insertPointsTran(pt);
	}
	
	//获取十条流水
	public List<PersonTransRecord> getTenTransRecordsByUserId(String userId,int pageNumber) throws Exception
	{
		List<PersonTransRecord> personTransRecord = userPointsDao.getTenTransRecordsByUserId(userId, pageNumber);
		return personTransRecord;
	}
	//新用户首次获得城池
	public void insertPoints(String userId, int allPoints){
		UserPoints userPt = new UserPoints();
		userPt.setUserId(userId);
		userPt.setAllPoints(allPoints);
		userPt.setCreateTime(new Timestamp(System.currentTimeMillis()));
		userPointsDao.insertUserPoints(userPt);
	}
	//获得已领取奖励的记录
		public PointsTrans getPointsTransByUserIdAndPgmId(String userId,String pgmId){
			PointsTrans pointsTrans = userPointsDao.getPointsTransByUserIdAndPgmId(userId, pgmId);
			return pointsTrans;
		}
}
