package com.happy.utils;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

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
import com.happy.datasource.redis.RedisCache;
import com.happy.model.SysMessage;
import com.happy.service.GameServices;
import com.happy.service.UserActivityServices;
import com.happy.service.UserInfoService;
import com.happy.service.UserReportsService;
import com.happy.weixin.app.App;
import com.happy.weixin.token.Token;

public class CustomMsgUtil {
	
	private static Log log = LogFactory.getLog(CustomMsgUtil.class);
	private static final String TOKEN_STR_KEY = "access_token";
	private static final String TOKEN_DATE_KEY = "lastdate";
	private static String CUSTOM_TOKEN = "wxtoken";
	private static String CUSTOM_URL = "https://api.weixin.qq.com/cgi-bin/message/custom/send?access_token=";
	private static String TOKEN_URL = "https://api.weixin.qq.com/cgi-bin/token";	
	private static String TEMPLATE_URL = "https://api.weixin.qq.com/cgi-bin/message/template/send?access_token=";
	
	public static int sendDueTemplateMsg(SysMessage mess)
	{
		log.error("start send due template message."+mess.getToUserId());
		int rev = 0;
		if(mess.getToUserId()==null || mess.getToUserId().length()<20)
			return 1;
		try{
		Token accessToken = null;
		accessToken = getAccessToken(App.APP_ID, App.APP_SECRET);
		if(accessToken==null)
		{
			return -1;
		}
		String strurl="http://"+App.APP_SERVER+"/"+App.APP_NAME+"/weixin/baseoauth?action=onlineGame&activityId="+mess.getActivityId();
		String first="你好,请及时发布活动结果";
		String keyword1=mess.getActivityDesc();
		String keyword2=CommonUtil.formatDateTimeToYYYYMMDDHHMM(mess.getExpiredTime());
		
		String remark = "点击发布结果";
		
		String url = TEMPLATE_URL + accessToken.getTokenStr();
		String strJson = "{\"touser\" :\""+mess.getToUserId()+"\",";
        strJson += "\"template_id\":\"jGa1lip4d4fuyGL3AyNm9iaYdpWC1jm53LVVSfDHryE\",";
        strJson += "\"url\":\""+strurl+"\",";
        strJson += "\"data\":{";
        strJson += "\"first\":{\"value\":\""+first+"\",\"color\":\"#173177\"},";
        strJson += "\"keyword1\":{\"value\":\""+keyword1+"\",\"color\":\"#173177\"},";
        strJson += "\"keyword2\":{\"value\":\""+keyword2+"\",\"color\":\"#173177\"},";
        strJson += "\"remark\":{\"value\":\""+remark+"\",\"color\":\"#173177\"}";
        strJson += "}}";
        log.debug("sendtemplateurl:"+url);
        log.debug("strJson:"+strJson);
        JSONObject ret = WeiXinUtil.httpRequest(url, "POST", strJson);
        log.debug("result="+ret);
        if(ret == null)
        {
        	return -1;
        }
        Double errcode = ret.getDouble("errcode");
        if(errcode!=0){
        	//没关注公众号,{"errcode":43004,"errmsg":"require subscribe hint: [S6uNDA0373zbg7]"}
        	if(errcode == 43004)
        	{
        	UserInfoService userInfoService = new UserInfoService();
			userInfoService.updateUnGzUserInfo(mess.getToUserId(), 0);
        	}
        	return -1;
        }
	}catch(Exception ex)
	{
		log.error("send due template message."+ ex.getMessage());
		ex.printStackTrace();
	}
		return rev;
	}
	public static int sendTendTemplateMsg(SysMessage mess)
	{
		log.error("start send tend template message."+mess.getToUserId());
		int rev = 0;
		if(mess.getToUserId()==null || mess.getToUserId().length()<20)
			return 1;
		try{
		Token accessToken = null;
		accessToken = getAccessToken(App.APP_ID, App.APP_SECRET);
		if(accessToken==null)
		{
			return -1;
		}
//		String strurl="http://"+App.APP_SERVER+"/"+App.APP_NAME+"/weixin/baseoauth?action=onlineGame&activityId="+mess.getActivityId();
		String strurl = "http://"+App.APP_SERVER+"/"+App.APP_NAME+"/formOfPartsInAct?actId="+mess.getActivityId()+"&percent=0";
		String guess=mess.getActivityDesc();
		String result="";
	
		int percent = Integer.parseInt(mess.getPerCent().replace("%", ""));
		String remark = "";
		String first="";
		if(mess.getActivityId().indexOf("Day") != -1 || mess.getActivityId().indexOf("Week") != -1){
			first="你好！您对本次竞猜，已经入股！";
			if(percent<=40){
				remark="根据系统数据计算，股市要走绿！";
			}else if(percent>=60){
				remark="根据系统数据计算，股市要翻红！";
			}else{
				remark="这次的股市，系统也拿不准！";
			}
			
			if("Y".equalsIgnoreCase(mess.getParticiType()))
			{
				result = "翻红！";
			}
			else if("N".equalsIgnoreCase(mess.getParticiType()))
			{
				result = "走绿！";
			}
		}else{
			first="你好,你已成功参与朕以为活动预测";
			if(percent<=40){
				remark="根据系统数据计算，该事不会发生！";
			}else if(percent>=60){
				remark="根据系统数据计算，该事定会发生！";
			}else{
				remark="系统无法预测该事件是否会发生！";
			}
			
			if("Y".equalsIgnoreCase(mess.getParticiType()))
			{
				result = "支持";
			}
			else if("N".equalsIgnoreCase(mess.getParticiType()))
			{
				result = "反对";
			}
		}
		
		
		String url = TEMPLATE_URL + accessToken.getTokenStr();
		String strJson = "{\"touser\" :\""+mess.getToUserId()+"\",";
        strJson += "\"template_id\":\"U9L3efy9qHDENPwrLerL_Ys6X6g4bA2XlVBBG-A_4Oc\",";
        strJson += "\"url\":\""+strurl+"\",";
        strJson += "\"data\":{";
        strJson += "\"first\":{\"value\":\""+first+"\",\"color\":\"#173177\"},";
        strJson += "\"guess\":{\"value\":\""+guess+"\",\"color\":\"#173177\"},";
        strJson += "\"options\":{\"value\":\""+result+"\",\"color\":\"#173177\"},";
        strJson += "\"remark\":{\"value\":\""+remark+"\",\"color\":\"#173177\"}";
        strJson += "}}";
        log.debug("sendtemplateurl:"+url);
        log.debug("strJson:"+strJson);
        JSONObject ret = WeiXinUtil.httpRequest(url, "POST", strJson);
        log.debug("result="+ret);
        if(ret == null)
        {
        	return -1;
        }
        Double errcode = ret.getDouble("errcode");
        if(errcode!=0){
        	//没关注公众号,{"errcode":43004,"errmsg":"require subscribe hint: [S6uNDA0373zbg7]"}
        	if(errcode == 43004)
        	{
        	UserInfoService userInfoService = new UserInfoService();
			userInfoService.updateUnGzUserInfo(mess.getToUserId(), 0);
        	}
        	return -1;
        }
	}catch(Exception ex)
	{
		log.error("send tend template message."+ ex.getMessage());
		ex.printStackTrace();
	}
		return rev;
	}
	
/*	public static void main(String[] arg){
		SysMessage mess  = new SysMessage();
		mess.setToUserId("xxxxx");
		CustomMsgUtil.sendHistoryPartTemplateMsg(mess);
	}*/
	public static int sendHistoryPartTemplateMsg(SysMessage mess){
		int rev = 0;
		if(mess.getToUserId()==null)
			return 1;
		try{	
			Token accessToken = null;
			accessToken = getAccessToken(App.APP_ID, App.APP_SECRET);
			String paramstr = "userId="+mess.getToUserId()+"&templateId="+1;
			if(accessToken==null)
			{
				return -1;
			}
			String userId = mess.getToUserId();
			String strurl = "http://"+App.APP_SERVER+"/happy/gameListOfUser?userId="+mess.getToUserId()+"&templateId="+1;
//			String strurl="http://"+App.APP_SERVER+"/"+App.APP_NAME+"/weixin/baseoauth?action=gameListOfUser&paramstr="+paramstr;
			String first="边疆告急！";
			
			//比赛场次
			UserActivityServices userActivityServices = new UserActivityServices();
			int usersAct = userActivityServices.getActByUserId(userId).size() + userActivityServices.getParticipateByUserId(userId).size();
			String keyword1 ="共参与"+ String.valueOf(usersAct) + "场";
			
			//比赛时间
			Date date=new Date();
			  DateFormat format=new SimpleDateFormat("yyyy-MM-dd");
			  String time=format.format(date);
			String keyword2 = "截止"+time;
			
			//最好成绩:目前赢场
			GameServices gameServices = new GameServices();
			List<Map> listOfWinAct = gameServices.getWinActOfUser(userId, 1);
			String keyword3 = "赢了"+String.valueOf(listOfWinAct.size())+"场";
			
			//成绩排名
			UserReportsService urs = new UserReportsService();
			List<Map> reportForUserId = null;
			reportForUserId = urs.getUserReport(userId);
			String position = (String) reportForUserId.get(0).get("rownum");
			String keyword4 = "第"+position+"名";
			//获得积分
			String points = (String) reportForUserId.get(0).get("allPoints");
			String keyword5 = "拥有"+points+"座城池！";
			
			String remark = "点击查看您的战况,继续攻城掠地！";
			String url = TEMPLATE_URL + accessToken.getTokenStr();
			String strJson = "{\"touser\" :\""+mess.getToUserId()+"\",";
	        strJson += "\"template_id\":\"VTa44S-HRijOEt2Y2M9PuHP4mORf3j6JoWPnL3pdGok\",";
	        strJson += "\"url\":\""+strurl+"\",";
	        strJson += "\"data\":{";
	        strJson += "\"first\":{\"value\":\""+first+"\",\"color\":\"#173177\"},";
	        strJson += "\"keyword1\":{\"value\":\""+keyword1+"\",\"color\":\"#173177\"},";
	        strJson += "\"keyword2\":{\"value\":\""+keyword2+"\",\"color\":\"#173177\"},";
	        strJson += "\"keyword3\":{\"value\":\""+keyword3+"\",\"color\":\"#173177\"},";
	        strJson += "\"keyword4\":{\"value\":\""+keyword4+"\",\"color\":\"#173177\"},";
	        strJson += "\"keyword5\":{\"value\":\""+keyword5+"\",\"color\":\"#173177\"},";
	        strJson += "\"remark\":{\"value\":\""+remark+"\",\"color\":\"#173177\"}";
	        strJson += "}}";
	        log.debug("sendtemplateurl:"+url);
	        log.debug("strJson:"+strJson);
	        JSONObject ret = WeiXinUtil.httpRequest(url, "POST", strJson);
	        log.debug("result="+ret);
	        if(ret == null)
	        {
	        	return -1;
	        }
	        Double errcode = ret.getDouble("errcode");
	        if(errcode!=0){
	        	//没关注公众号,{"errcode":43004,"errmsg":"require subscribe hint: [S6uNDA0373zbg7]"}
	        	if(errcode == 43004){
	        		UserInfoService userInfoService = new UserInfoService();
	        		userInfoService.updateUnGzUserInfo(mess.getToUserId(), 0);
	        	}
	        	return -1;
	        }
		}catch(Exception ex){
			log.error("send tend template message."+ ex.getMessage());
			ex.printStackTrace();
		}
		return rev;
	}
	
	public static int sendResultTemplateMsg(SysMessage mess)
	{
		log.error("start send tend template message."+mess.getToUserId());
		int rev = 0;
		if(mess.getToUserId()==null || mess.getToUserId().length()<20)
			return 1;
		try{		
		Token accessToken = null;
		accessToken = getAccessToken(App.APP_ID, App.APP_SECRET);
		if(accessToken==null)
		{
			return -1;
		}
		String strurl="http://"+App.APP_SERVER+"/"+App.APP_NAME+"/weixin/baseoauth?action=onlineGame&activityId="+mess.getActivityId();
		String first="朕以为活动已公布答案";
		String guess=mess.getActivityDesc();
		String result="";
		String remark="";
		if(mess.getStatus()==1)
		{
			result="预测失败，失去"+mess.getPoints()+"城池";
			remark="很抱歉, 继续撸！！！！！";
		}
		else if(mess.getStatus()==2)
		{
			result="预测成功，获得"+mess.getPoints()+"城池";
			remark="恭喜你, 神预测！！！！！";
		}
		else
		{
			result="取消";
			remark="预测活动取消！！！！！";
		}
		
		String url = TEMPLATE_URL + accessToken.getTokenStr();
		String strJson = "{\"touser\" :\""+mess.getToUserId()+"\",";
        strJson += "\"template_id\":\"xc-3e5xrxt9vPJTYa94WtnqLS9Bn9jCX1EGslKekNdw\",";
        strJson += "\"url\":\""+strurl+"\",";
        strJson += "\"data\":{";
        strJson += "\"first\":{\"value\":\""+first+"\",\"color\":\"#173177\"},";
        strJson += "\"guess\":{\"value\":\""+guess+"\",\"color\":\"#173177\"},";
        strJson += "\"result\":{\"value\":\""+result+"\",\"color\":\"#173177\"},";
        strJson += "\"remark\":{\"value\":\""+remark+"\",\"color\":\"#173177\"}";
        strJson += "}}";
        log.debug("sendtemplateurl:"+url);
        log.debug("strJson:"+strJson);
        JSONObject ret = WeiXinUtil.httpRequest(url, "POST", strJson);
        log.debug("result="+ret);
        if(ret == null)
        {
        	return -1;
        }
        Double errcode = ret.getDouble("errcode");
        if(errcode!=0){
        	//没关注公众号,{"errcode":43004,"errmsg":"require subscribe hint: [S6uNDA0373zbg7]"}
        	if(errcode == 43004)
        	{
        	UserInfoService userInfoService = new UserInfoService();
			userInfoService.updateUnGzUserInfo(mess.getToUserId(), 0);
        	}
        	return -1;
        }
		}catch(Exception ex)
		{
			log.error("send result template message."+ ex.getMessage());
			ex.printStackTrace();
		}
		return rev;
	}
	public static int sendCustomMsg(String toUser, String content)
	{
		int rev = 0;
		if(toUser==null || toUser.length()<20)
			return 1;
		Token accessToken = null;
		accessToken = getAccessToken(App.APP_ID, App.APP_SECRET);
		if(accessToken==null)
		{
			return 1;
		}
		
		String url = CUSTOM_URL + accessToken.getTokenStr();
		String strJson = "{\"touser\" :\""+toUser+"\",";
        strJson += "\"msgtype\":\"text\",";
        strJson += "\"text\":{";
        strJson += "\"content\":\""+content+"\"";
        strJson += "}}";
        log.debug("sendurl:"+url);
        log.debug("strJson:"+strJson);
//        String result = send(url, strJson);
        JSONObject result = WeiXinUtil.httpRequest(url, "POST", strJson);
        log.debug("result="+result);
        if(result == null)
        {
        	return -1;
        }
        Double errcode = result.getDouble("errcode");
        if(errcode!=0){
        	//没关注公众号的，或者长时间没有和公众号交互的
        	// "errcode": 45015, 
        	//"errmsg": "response out of time limit or subscription is canceled hint: [WUtkiA0179age3]"
        	//"errcode":40003,"errmsg":"invalid openid hint: [TyFmga0433ge13]"
        	if(errcode == 45015||errcode==40003)
        	{
        	UserInfoService userInfoService = new UserInfoService();
			userInfoService.updateUnGzUserInfo(toUser, 0);
			return -2;
        	}
        	return -1;
        }
//        Gson gson = new Gson();
//        Map<String, Object> cm = gson.fromJson(result, Map.class);
//        if(cm != null)
//        {
//        	double errorCode = (Double)cm.get("errcode");
//        	if(errorCode!=0)
//        	{
//        		rev = -1;
//        	}
//        	
//        }
		return rev;
	}
	
	 private static String send(String action,String json)
	 {
		 URL url;
		 try 
		 {
			 url = new URL(action);
			 HttpURLConnection http = (HttpURLConnection) url.openConnection();
			 http.setRequestMethod("POST");
			 http.setDoOutput(true);
			 http.setDoInput(true);
			 System.setProperty("sun.net.client.defaultConnectTimeout", "30000");
			 System.setProperty("sun.net.client.defaultReadTimeout", "30000");
			 http.connect();
			 OutputStream os = http.getOutputStream();
			 os.write(json.getBytes("UTF-8"));
			 InputStream is = http.getInputStream();
			 int size = is.available();
			 byte[] jsonBytes = new byte[size];
			 is.read(jsonBytes);
			 String result = new String(jsonBytes, "UTF-8");
			 log.debug("result="+result);
			 os.flush();
			 os.close();
			 return result;
		 } catch (Exception e) 
		 {
			 log.debug("send:"+e.getMessage());
			 e.printStackTrace();
			 return null;
		 }
	 }
	
	private static Token getAccessToken(String appId, String appScrete)
	{
		try
		{
			Token token = getRromRedis(appId, appScrete);
			if(token == null)
			{
				Token gtoken = generateNewTokenForRedis(appId, appScrete);
				return gtoken;
			}
			else
			{
				if(isValid(token)){
					return token;
				}else{
					Token gtoken = generateNewTokenForRedis(appId, appScrete);
					return gtoken;
				}
			}
		}catch(Exception e)
		{
			e.printStackTrace();
			return null;
		}
	}
	
	/**
	 * 从redis中获取token
	 * @param appId
	 * @param appsecret
	 * @return
	 */
	public static Token getRromRedis(String appId,String appsecret){
		log.debug("getRromRedis - appId : " + appId + " appsecret : " + appsecret);
		RedisCache rc = new RedisCache();
		String tokenstr = rc.hget(CUSTOM_TOKEN, appId);
		if(tokenstr == null) return null;
		Token token = jsonstrToToken(tokenstr);
		return token;
	}
	
	/**
	 * 从redis中获取token
	 * @param tokenstr
	 * @return
	 */
	public static Token jsonstrToToken(String tokenstr){
		Map<String,Object> map = new Gson().fromJson(tokenstr, Map.class);
		String tokenStr = (String)map.get(TOKEN_STR_KEY);
		Double datetimedouble = (Double)map.get(TOKEN_DATE_KEY);
		long datetimelong = datetimedouble.longValue();
		Token token = new Token();
		token.setTokenStr(tokenStr);
		token.setDate(new Date(datetimelong));
		return token;
	}
	
	/**
	 * 从redis中获取token
	 * @param appId
	 * @param appsecret
	 * @return
	 */
	public static Token generateNewTokenForRedis(String appId,String appsecret) throws Exception{
		log.debug("generateNewToken - appId : " + appId + " appsecret : " + appsecret);
		String tokenstr = getNewToken(appId, appsecret);
		Token token = strToNewToken(tokenstr);
				
		String resdisStr = tokenToStr(token);
		if (CommonUtil.isEmpty(resdisStr)) {
		    return token;
        }
		RedisCache rc = new RedisCache();
		rc.hset(CUSTOM_TOKEN, appId,resdisStr);
		return token;
	}
	
	/**
	 * 获取一个token
	 * @return
	 */
	private static String getNewToken(String appid,String appsecret) {
		HttpClient httpclient = new DefaultHttpClient();
		HttpGet httpget = new HttpGet(TOKEN_URL + "?grant_type=client_credential&appid=" + appid + "&secret=" + appsecret);
		try {

			URL u = new URL(TOKEN_URL);
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
	 * 新token的json 没有获得时间，自生成时间
	 * @param tokenstr token,json字符串
	 * @return Token
	 */
	public static Token strToNewToken(String tokenstr){
		Map<String,Object> map = new Gson().fromJson(tokenstr, Map.class);
		if (map == null) {
		    return null;
		}
		String tokenStr = (String)map.get(TOKEN_STR_KEY);
		Date date = new Date();
		map.put(TOKEN_DATE_KEY, date.getTime());
		Token token = new Token();
		token.setTokenStr(tokenStr);
		token.setDate(date);
		return token;
	}
	
	/**
	 * Token对象转换成json
	 * @param token 
	 * @return String
	 */
	public static String tokenToStr(Token token){
	    if (token == null) { return null;}
		Map<String,Object> map = new HashMap<String,Object>();
		Date date = token.getDate();
		String tokenStr = token.getTokenStr();
		map.put(TOKEN_DATE_KEY, date.getTime());
		map.put(TOKEN_STR_KEY, tokenStr);
		String value = new Gson().toJson(map);
		return value;
	}
	
	/**
	 * 
	 * @param token
	 * @return
	 */
	public static boolean isValid(Token token){
		
		if(token == null)return false;
		Date date = token.getDate();
		if(date == null) return false;
		long datetime = date.getTime();
		Date now = new Date();
		long nowdatetime = now.getTime();
		//生成时间的1小时50分钟后 大于当前时间说明未超时,未过期,有效
		if(datetime+6600000 > nowdatetime){
			log.debug("isValid : " + true);
			return true;
		}
		//已过期
		else{
			log.debug("isValid : " + false);
			return false;
		}
	}
	
	public static int sendSystemResultTemplateMsg(SysMessage mess, String msg)
	{
		log.error("start send tend template message."+mess.getToUserId());
		int rev = 0;
		if(mess.getToUserId()==null || mess.getToUserId().length()<20)
			return 1;
		try{		
		Token accessToken = null;
		accessToken = getAccessToken(App.APP_ID, App.APP_SECRET);
		if(accessToken==null)
		{
			return -1;
		}
		String strurl="http://"+App.APP_SERVER+"/"+App.APP_NAME+"/weixin/baseoauth?action=onlineGame&activityId="+mess.getActivityId();
		String first="结果理由:"+msg;
		String guess=mess.getActivityDesc();
		String result="";
		String remark="";
		if(mess.getStatus()==1)
		{
			result="预测失败，失去"+mess.getPoints()+"城池";
			remark="很抱歉, 继续撸！！！！！";
		}
		else if(mess.getStatus()==2)
		{
			result="预测成功，获得"+mess.getPoints()+"城池";
			remark="恭喜你, 神预测！！！！！";
		}
		else
		{
			result="取消";
			remark="预测活动取消！！！！！";
		}
		
		String url = TEMPLATE_URL + accessToken.getTokenStr();
		String strJson = "{\"touser\" :\""+mess.getToUserId()+"\",";
        strJson += "\"template_id\":\"xc-3e5xrxt9vPJTYa94WtnqLS9Bn9jCX1EGslKekNdw\",";
        strJson += "\"url\":\""+strurl+"\",";
        strJson += "\"data\":{";
        strJson += "\"first\":{\"value\":\""+first+"\",\"color\":\"#173177\"},";
        strJson += "\"guess\":{\"value\":\""+guess+"\",\"color\":\"#173177\"},";
        strJson += "\"result\":{\"value\":\""+result+"\",\"color\":\"#173177\"},";
        strJson += "\"remark\":{\"value\":\""+remark+"\",\"color\":\"#173177\"}";
        strJson += "}}";
        log.debug("sendtemplateurl:"+url);
        log.debug("strJson:"+strJson);
        JSONObject ret = WeiXinUtil.httpRequest(url, "POST", strJson);
        log.debug("result="+ret);
        if(ret == null)
        {
        	return -1;
        }
        Double errcode = ret.getDouble("errcode");
        if(errcode!=0){
        	//没关注公众号,{"errcode":43004,"errmsg":"require subscribe hint: [S6uNDA0373zbg7]"}
        	if(errcode == 43004)
        	{
        	UserInfoService userInfoService = new UserInfoService();
			userInfoService.updateUnGzUserInfo(mess.getToUserId(), 0);
        	}
        	return -1;
        }
		}catch(Exception ex)
		{
			log.error("send result template message."+ ex.getMessage());
			ex.printStackTrace();
		}
		return rev;
	}
}
