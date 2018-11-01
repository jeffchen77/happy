package com.happy.dao;

import org.nutz.dao.Cnd;
import org.nutz.dao.sql.Criteria;

import com.happy.dao.common.BaseDao;
import com.happy.model.WechatUser;
import com.happy.utils.CommonUtil;

public class WechatUserDao extends BaseDao{
	
	//根据条件查询
	public WechatUser getByUserId(String userId)throws Exception{
		WechatUser wechatUser = null;
		Criteria cir = Cnd.cri();
		if(CommonUtil.notEmpty(userId)){
			cir.where().andEquals("user_id", userId);
			wechatUser = dao.fetch(WechatUser.class, cir);
		}			
		
		return wechatUser;
	}	
	//插入微信user
	public String insert(WechatUser wecharUser) throws Exception{		
		dao.insert(wecharUser);
		return "success";
	}

		 
}
