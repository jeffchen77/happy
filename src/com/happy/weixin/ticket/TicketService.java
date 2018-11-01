package com.happy.weixin.ticket;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.http.HttpEntity;
import org.apache.http.HttpHost;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;

import com.google.gson.Gson;
import com.happy.dao.WeichatPublicDao;
import com.happy.datasource.redis.RedisCache;
import com.happy.model.WeichatPublic;
import com.happy.weixin.token.TokenService;

/**
 * 门票业务逻辑
 * @author lizhao
 *
 */
public class TicketService {
	private static Log log = LogFactory.getLog(TokenService.class);
	private static final String GETTICKET = "https://api.weixin.qq.com/cgi-bin/ticket/getticket";
	
	private static final String TICKET_DATE_KEY = "lastdate";
	
	private static final String TICKET_STR_KEY = "ticket";
	
	private static final String TICKET_KEY = "wxticket";
	
	/**
	 * 获取一个ticket
	 * @return
	 */
	public static String getNewTicket(String accessToken) {
		HttpClient httpclient = new DefaultHttpClient();
		HttpGet httpget = new HttpGet(GETTICKET + "?access_token="+accessToken+"&type=jsapi");
		try {

			URL u = new URL(GETTICKET);
			HttpHost host = new HttpHost(u.getHost(), u.getPort(), u.getProtocol());
			HttpResponse response = httpclient.execute(host, httpget);
			HttpEntity entity = response.getEntity();
			/** 内容结果 */
			byte[] contentBytes = EntityUtils.toByteArray(entity);
			String content = new String(contentBytes, "utf-8");
			return content;
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			httpget.abort();
			httpclient.getConnectionManager().shutdown();
		}
		return null;
	}
	
	/**
	 * 新ticket的json 没有获得时间，自生成时间
	 * @param tokenstr token,json字符串
	 * @return Token
	 */
	@SuppressWarnings("unchecked")
	public static Ticket strToNewTicket(String ticketstr){
		Map<String,Object> map = new Gson().fromJson(ticketstr, Map.class);
		String ticketStr = (String)map.get(TICKET_STR_KEY);
		Date date = new Date();
		map.put(TICKET_DATE_KEY, date.getTime());
		Ticket ticket = new Ticket();
		ticket.setTicketStr(ticketStr);
		ticket.setDate(date);
		return ticket;
	}
	
	/**
	 * ticket对象转换成json
	 * @param ticket 
	 * @return String
	 */
	public static String ticketToStr(Ticket ticket){
		Map<String,Object> map = new HashMap<String,Object>();
		Date date = ticket.getDate();
		String tokenStr = ticket.getTicketStr();
		map.put(TICKET_DATE_KEY, date.getTime());
		map.put(TICKET_STR_KEY, tokenStr);
		String value = new Gson().toJson(map);
		return value;
	}
	
	/**
	 * token对象
	 * @param ticketstr
	 * @return Token对象
	 */
	@SuppressWarnings("unchecked")
	public static Ticket strToTicket(String ticketStr,Date ticDate){
//		Map<String,Object> map = new Gson().fromJson(ticketJsonStr, Map.class);
//		String str = (String)map.get(TICKET_STR_KEY);
//		Double datetimedouble = (Double)map.get(TICKET_DATE_KEY);
//		long datetimelong = datetimedouble.longValue();
		Ticket ticket = new Ticket();
		ticket.setTicketStr(ticketStr);
		ticket.setDate(ticDate);
		return ticket;
	}
	/**
	 * redis中的ticket的json转换成token对象
	 * @param ticketstr
	 * @return Token对象
	 */
	@SuppressWarnings("unchecked")
	public static Ticket strToTicket(String ticketJsonStr){
		Map<String,Object> map = new Gson().fromJson(ticketJsonStr, Map.class);
		String str = (String)map.get(TICKET_STR_KEY);
		Double datetimedouble = (Double)map.get(TICKET_DATE_KEY);
		long datetimelong = datetimedouble.longValue();
		Ticket ticket = new Ticket();
		ticket.setTicketStr(str);
		ticket.setDate(new Date(datetimelong));
		return ticket;
	}
	
	/**
	 * @param ticket
	 * @return
	 */
	public static boolean isValid(Ticket ticket){
		if(ticket == null)return false;
		Date date = ticket.getDate();
		if(date == null) return false;
		long datetime = date.getTime();
		Date now = new Date();
		long nowdatetime = now.getTime();
		//生成时间的1小时50分钟后 大于当前时间说明未超时,未过期,有效
		if(datetime+6600000 > nowdatetime){
			return true;
		}
		//已过期
		else{
			return false;
		}
	}
	
	/**
	 * 生成新ticket for mysql
	 * @param appId
	 * @return
	 */
	public static Ticket generateNewTicket(String appId,String accessToken)throws Exception{
		String ticketstr = getNewTicket(accessToken);
		Ticket ticket = strToNewTicket(ticketstr);
		WeichatPublicDao dao = new WeichatPublicDao();
		dao.updateTicket(appId, ticket);
		
		return ticket;
	}
	/**
	 * 生成新ticket for redis
	 * @param appId
	 * @return
	 */
	public static Ticket generateNewTicketForRedis(String appId,String accessToken)throws Exception{
		String ticketstr = getNewTicket(accessToken);
		Ticket ticket = strToNewTicket(ticketstr);
		
		String ticketStr = ticketToStr(ticket);
		RedisCache rc = new RedisCache();
		rc.hset(TICKET_KEY, appId,ticketStr);
		return ticket;
	}
	
	/**
	 * 从redis中获取token
	 * @param appId
	 * @param appsecret
	 * @return
	 */
	public static Ticket getRromRedis(String appId){
		RedisCache rc = new RedisCache();
		String ticketStr = rc.hget(TICKET_KEY, appId);
		if(ticketStr == null) return null;
		Ticket ticket = strToTicket(ticketStr);
		return ticket;
	}
	public static Ticket getFromMysql(String appId) throws Exception{
		WeichatPublicDao dao = new WeichatPublicDao();
		WeichatPublic wp = dao.fetch(appId);
		String ticketStr = wp.getTicket();
		Date ticDate = wp.getTicketDt();
		log.debug("getTicketFromMysql:"+ticketStr+"   ticDate:"+ticDate);
		if(ticketStr == null) return null;
		Ticket ticket = new Ticket();
		ticket.setTicketStr(ticketStr);
		ticket.setDate(ticDate);
		return ticket;
	}
}
