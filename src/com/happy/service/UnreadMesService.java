package com.happy.service;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import com.happy.dao.UnreadMesDao;
import com.happy.model.UnreadMesUserInfo;
import com.happy.model.UnreadMessage;

public class UnreadMesService {
	private UnreadMesDao unreadMesDao = new UnreadMesDao();
	
	public void insertUnreadMes(UnreadMessage unreadMes){
		unreadMesDao.insertUnreadMes(unreadMes);
	}
	
	//update已读评论信息
	public void updateUnreadMes(String activityId,String participateUserId){
		unreadMesDao.updateUnreadMes(activityId, participateUserId);
	}
	
	public List<UnreadMesUserInfo> getUnreadMes(String participateUserId){
		List<UnreadMesUserInfo> unreadMesList = unreadMesDao.getUnreadMes(participateUserId);
		return unreadMesList;
	}
	
	public List<Map> getNBestComment(){
		List<Map> theNBestComment = unreadMesDao.getNBestComment();
		List<Map>  fanhuizhi =  new LinkedList<Map>();
		for(int i=0 ; i < theNBestComment.size() ; i++){
			Boolean actInfanhuizhilist = false;
		
			Map mpOffanhuizhi = new HashMap();
			String actId = theNBestComment.get(i).get("activityId").toString();
			List<Map> commentListOfTheActID = new LinkedList<Map>();
			Map mpOfcommentlistOfTheActID = new HashMap();//同一个actid下的不同comment的mp 组合成 commentListOfTheActID
			for(int x = 0 ; x < fanhuizhi.size() ; x++){
				if(actId.equalsIgnoreCase(fanhuizhi.get(x).get("activityId").toString())){
					actInfanhuizhilist = true;
				}
			}//判断当前遍历的actid是否已经存在于返回的list中
			
			if(actInfanhuizhilist == false){//当前actid不在返回list中，则插入新的actid，并把对应的comentinfo放入对应的list中
				mpOffanhuizhi.put("activityId", actId);
				mpOffanhuizhi.put("activityDesc", theNBestComment.get(i).get("activityDesc").toString());				
				mpOffanhuizhi.put("activityRemark", theNBestComment.get(i).get("activityRemark"));
				commentListOfTheActID.add(theNBestComment.get(i));
				for(int j = i+1 ; j < theNBestComment.size() ; j++ ){
					if(actId.equalsIgnoreCase(theNBestComment.get(j).get("activityId").toString())){//后面循环出的activityId等于新插入actID，则把整条数据放入comm内容中
						commentListOfTheActID.add(theNBestComment.get(j));
					}
				}
				
				mpOffanhuizhi.put("commentListOfTheActID", commentListOfTheActID);
				fanhuizhi.add(mpOffanhuizhi);
			}
		}
		
		//合并activityID
		return fanhuizhi;
	}
	
	public List<Map> getUnreadMesAndRep( String participateUserId)throws Exception{
		List<Map> theUnreadMesAndRep = unreadMesDao.getUnreadMesAndRep(participateUserId);
		return theUnreadMesAndRep;
	}
	
	public List<Map> getReadedMesAndRep( String participateUserId)throws Exception{
		List<Map> theReadedMesAndRep = unreadMesDao.getReadedMesAndRep(participateUserId);
		return theReadedMesAndRep;
	}
	
}
