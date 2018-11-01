package com.happy.dao;

import java.sql.Timestamp;
import java.util.Date;

import com.happy.model.Activity;
import com.happy.model.WechatUser;
import com.happy.model.WeichatPublic;
import com.happy.utils.CommonUtil;
import com.happy.weixin.token.Token;

public class WeichatPublicDaoTest {
	public static void main(String[] args) throws Exception{
//		WeichatPublicDao dao = WeichatPublicDao.getDao();
//		List<WeichatPublic> ls = dao.queryByAppId("wx55f96531fedd8ebf");
//		System.out.println(ls);
//		WeichatPublic iter = new WeichatPublic();
//		
////			System.out.println("----------"+iter.getProName());	
//		
//			Token token=new Token();
//			token.setTokenStr("23423423");
//			token.setDate(new Date());
		//dao.updateToken("wx55f96531fedd8ebf", token);
//		Ticket ticket=new Ticket();
//		ticket.setTicketStr("0uS4kc0VCuT5kpjubmslSHqxyAL0VkfDDXSRecSqUU6");
//		ticket.setDate(new Date());
//		dao.updateTicket("wx55f96531fedd8ebf", ticket);
//		iter=dao.fetch("wx55f96531fedd8ebf");
//		System.out.println(iter.getProName()+"------"+ iter.getTicketDt().toString()+"----------"+iter.getTokenDt().toString());
//		
//		WechatUserDao dao = new WechatUserDao();
//		WechatUser user=new WechatUser();
//		user=dao.getByUserId("111");
////		System.out.println(user);
//		System.out.println(user.getOpenId()+"-----------"+user.getUserId());
//		ChallengeThemeDao dao1= new ChallengeThemeDao();
//		Activity act=new Activity();
//		act.setActivityId("CToxw8iwTNSBnMFnSJ2kz4RPo7V9Bk20160411173752");
//		act.setUserId("oxw8iwTNSBnMFnSJ2kz4RPo7V9Bk");
//		act.setAcitvityType("00");
//		act.setActivityDesc("勇士破连胜记录");
//		dao1.insertChallengeTheme(act);
		Timestamp createTime = Timestamp.valueOf(CommonUtil.formatDateTimeToYYYYMMDDHHMMSS(new Date()));
		System.out.println(createTime);
	}
}
