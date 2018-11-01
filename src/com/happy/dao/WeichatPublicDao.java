package com.happy.dao;

import java.util.List;

import org.nutz.dao.Cnd;
import org.nutz.dao.Sqls;
import org.nutz.dao.sql.Criteria;
import org.nutz.dao.sql.Sql;

import com.happy.dao.common.BaseDao;
import com.happy.model.WeichatPublic;
import com.happy.utils.CommonUtil;
import com.happy.weixin.ticket.Ticket;
import com.happy.weixin.token.Token;

public class WeichatPublicDao extends BaseDao{

	public void updateToken(String appId, Token token)throws Exception
	{
		Sql sql = Sqls.create("UPDATE weichat_public SET token=@token , token_dt=@token_dt $condition");

		   sql.params().set("token", token.getTokenStr());
		   sql.params().set("token_dt", token.getDate());
		   sql.setCondition(Cnd.wrap("where app_id='"+appId+"'"));
		   dao.execute(sql);
	}
	
	public void updateTicket(String appId, Ticket ticket)throws Exception
	{
		Sql sql = Sqls.create("UPDATE weichat_public SET ticket=@ticket,ticket_dt=@ticket_dt $condition");

		   sql.params().set("ticket", ticket.getTicketStr());
		   sql.params().set("ticket_dt", ticket.getDate());
		   sql.setCondition(Cnd.wrap("where app_id='"+appId+"'"));
		   dao.execute(sql);
	}
	
	//模糊条件查询
	public List<WeichatPublic> queryByAppID(String appId)throws Exception{
		List<WeichatPublic> WechatHappy = null;
		Criteria cir = Cnd.cri();
		if(CommonUtil.notEmpty(appId)){
			cir.where().andEquals("app_id", appId);
			dao.query(WeichatPublic.class, cir, null);
		}			
		 
		return WechatHappy;
	}
	
	//根据条件查询
	public WeichatPublic fetch(String appId)throws Exception{
		WeichatPublic WeichatPublic = null;
		Criteria cir = Cnd.cri();
		if(CommonUtil.notEmpty(appId)){
			cir.where().andEquals("app_id", appId);
			WeichatPublic = dao.fetch(WeichatPublic.class, cir);
		}			
		
		return WeichatPublic;
	}
}
