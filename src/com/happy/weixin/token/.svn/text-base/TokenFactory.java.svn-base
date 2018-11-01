package com.happy.weixin.token;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;


public class TokenFactory {
	
	private static Log log = LogFactory.getLog(TokenFactory.class);

	public static Token getTokenFromRedis(String appId,String appsecret)throws Exception{

		Token token = TokenService.getRromRedis(appId, appsecret);
		if(token == null){
			Token gtoken = TokenService.generateNewTokenForRedis(appId, appsecret);
			return gtoken;
		}else{
			if(TokenService.isValid(token)){
				return token;
			}else{
				Token gtoken = TokenService.generateNewTokenForRedis(appId, appsecret);
				return gtoken;
			}
		}
	}
	//此方法以及废弃，请从redis获取Token
	public static Token getToken(String appId,String appsecret) throws Exception{
		Token token = TokenService.getFromMysql(appId, appsecret);
		if(token == null){
			Token gtoken = TokenService.generateNewToken(appId, appsecret);
			return gtoken;
		}else{
			if(TokenService.isValid(token)){
				return token;
			}else{
				Token gtoken = TokenService.generateNewToken(appId, appsecret);
				return gtoken;
			}
		}
	}
	
}
