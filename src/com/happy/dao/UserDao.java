package com.happy.dao;

import org.nutz.dao.Chain;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.dao.Sqls;
import org.nutz.dao.impl.NutDao;
import org.nutz.dao.sql.Criteria;
import org.nutz.dao.sql.Sql;

import com.alibaba.druid.pool.DruidDataSource;
import com.happy.dao.common.BaseDao;
import com.happy.datasource.mysql.DataManager;
import com.happy.model.User;
import com.happy.model.WechatUser;
import com.happy.utils.CommonUtil;

public class UserDao extends BaseDao{
	
	
	//根据条件查询user
	public User getUserByUserId(String userId)throws Exception{
		User user = null;
		Criteria cir = Cnd.cri();
		if(CommonUtil.notEmpty(userId)){
			cir.where().andEquals("user_id", userId);
			user = dao.fetch(User.class, cir);
		}					
		return user;
	}
	
	public void updateEmailById( User user){
		Sql sql = Sqls.create("UPDATE user SET email_address=@emailAddress $condition");
		
		sql.params().set("emailAddress", user.getEmailAddress());
		sql.setCondition(Cnd.wrap(" where user_id = '"+user.getUserId()+"'"));
		
		dao.execute(sql);
	}
	
	public void updateActPasswordById( String userId, String actPassword){
		dao.update("user", Chain.make("act_password", actPassword), Cnd.wrap("user_id='"+userId+"'"));
	} 
	
	public void updatePhoneById( User user){
		Sql sql = Sqls.create("UPDATE user SET phone_number=@phoneNumber $condition");
		
		sql.params().set("phoneNumber", user.getPhoneNumber());
		sql.setCondition(Cnd.wrap(" where user_id = '"+user.getUserId()+"'"));
		
		dao.execute(sql);
	}
	
	//插入user
		public String insert(User user) throws Exception{		
			dao.insert(user);
			return "success";
		}
		//更新关注公众号用户的信息
		public void updateGzUserInfo(String openid, String headimgurl,String nickname, int gzFlag)
		{
			dao.update("user", Chain.make("user_name", nickname).add("nick_name", nickname).add("gz_flag", gzFlag), Cnd.wrap("user_id='"+openid+"'"));
			dao.update("webchat_user", Chain.make("nickname", nickname).add("headimgurl", headimgurl), Cnd.wrap("user_id='"+openid+"'"));
		}
		//更新未关注公众号用户的信息
		public void updateUnGzUserInfo(String openid, int gzFlag)
		{
			dao.update("user", Chain.make("gz_flag", gzFlag), Cnd.wrap("user_id='"+openid+"'"));
		}
		

}
