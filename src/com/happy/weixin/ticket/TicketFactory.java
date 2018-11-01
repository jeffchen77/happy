package com.happy.weixin.ticket;

/**
 * 微信jsapi 门票工厂 
 * @author fei
 */
public class TicketFactory {
	/**
	 * 根据应用ID 和 accessToken 获得一个jsapi门票
	 * ID 或者 访问token没有,就返回null
	 * @param appId 应用ID
	 * @param accessToken token访问权限
	 * @return Ticket
	 * @throws Exception 
	 */
	public static Ticket getTicketFromRedis(String appId,String accessToken)throws Exception{

		Ticket ticket = TicketService.getRromRedis(appId);
		if(ticket == null){
			Ticket gticket = TicketService.generateNewTicketForRedis(appId, accessToken);
			return gticket;
		}else{
			if(TicketService.isValid(ticket)){
				return ticket;
			}else{
				Ticket gticket = TicketService.generateNewTicketForRedis(appId, accessToken);
				return gticket;
			}
		}
	}
	public static Ticket getTicket(String appId,String accessToken) throws Exception{
		Ticket ticket = TicketService.getFromMysql(appId);
		if(ticket == null){
			Ticket gticket = TicketService.generateNewTicket(appId, accessToken);
			return gticket;
		}else{
			if(TicketService.isValid(ticket)){
				return ticket;
			}else{
				Ticket gticket = TicketService.generateNewTicket(appId, accessToken);
				return gticket;
			}
		}
	}
}
