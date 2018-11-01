package com.happy.utils;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Formatter;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import com.happy.weixin.ticket.Ticket;
import com.happy.weixin.ticket.TicketFactory;
import com.happy.weixin.token.Token;
import com.happy.weixin.token.TokenFactory;


public class Sign {
	public static void main(String[] args) {
		String jsapi_ticket = "jsapi_ticket";
		// 注意 URL 一定要动态获取，不能 hardcode
		String url = "http://example.com";
		Map<String, String> ret = sign(jsapi_ticket, url);
		for (Map.Entry entry : ret.entrySet()) {
			System.out.println(entry.getKey() + ", " + entry.getValue());
		}
	};
	/*
	 * get wx config from redis
	 */
	public static Map<String, String> getSignParams(String url,String appId,String appsecret) throws Exception{
	    Token token = TokenFactory.getTokenFromRedis(appId, appsecret);
	    if (token == null) {
            return new HashMap<String, String>();
        }
		Ticket ticket = TicketFactory.getTicketFromRedis(appId, token.getTokenStr());
		return sign(ticket.getTicketStr(), url);
	}
	
	/*
	 * get wx config from mysql
	 */
	public static Map<String, String> getSignParamsFromMysql(String url,String appId,String appsecret) throws Exception{
	    Token token = TokenFactory.getToken(appId, appsecret);
	    if (token == null) {
            return new HashMap<String, String>();
        }
		Ticket ticket = TicketFactory.getTicket(appId, token.getTokenStr());
		return sign(ticket.getTicketStr(), url);
	}


	public static Map<String, String> sign(String jsapi_ticket, String url) {
		Map<String, String> ret = new HashMap<String, String>();
		String nonce_str = create_nonce_str();
		String timestamp = create_timestamp();
		String string1;
		String signature = "";

		// 注意这里参数名必须全部小写，且必须有序
		string1 = "jsapi_ticket=" + jsapi_ticket + "&noncestr=" + nonce_str + "&timestamp=" + timestamp + "&url=" + url;
		System.out.println(string1);

		try {
			MessageDigest crypt = MessageDigest.getInstance("SHA-1");
			crypt.reset();
			crypt.update(string1.getBytes("UTF-8"));
			signature = byteToHex(crypt.digest());
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		ret.put("url", url);
		ret.put("jsapi_ticket", jsapi_ticket);
		ret.put("nonceStr", nonce_str);
		ret.put("timestamp", timestamp);
		ret.put("signature", signature);

		return ret;
	}

	private static String byteToHex(final byte[] hash) {
		Formatter formatter = new Formatter();
		for (byte b : hash) {
			formatter.format("%02x", b);
		}
		String result = formatter.toString();
		formatter.close();
		return result;
	}

	private static String create_nonce_str() {
		return UUID.randomUUID().toString();
	}

	private static String create_timestamp() {
		return Long.toString(System.currentTimeMillis() / 1000);
	}
}
