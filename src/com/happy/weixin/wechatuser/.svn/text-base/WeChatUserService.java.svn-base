package com.happy.weixin.wechatuser;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.sql.Timestamp;
import java.util.Date;
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
import com.happy.dao.UserDao;
import com.happy.dao.WechatUserDao;
import com.happy.model.User;
import com.happy.model.WechatUser;
import com.happy.service.UserPointsService;
import com.happy.utils.CommonUtil;
import com.happy.weixin.app.App;
import com.happy.weixin.token.Token;
import com.happy.weixin.token.TokenFactory;
import com.happy.weixin.tokenweb.TokenWeb;
import com.happy.weixin.tokenweb.TokenWebService;

/**
 * 微信用户业务逻辑
 * @author fei
 */
public class WeChatUserService {
	
	private static final Log log = LogFactory.getLog(WeChatUserService.class);	
	
	
	private static final String GET_USER = "https://api.weixin.qq.com/sns/userinfo";
	/**新接口获取用户信息*/
	private static final String GET_USER1 = "https://api.weixin.qq.com/cgi-bin/user/info";

	/**
	 * 通过授权页面的方式， 获取一个微信用户的用户信息
	 * @return
	 */
    public static WechatUser getWeixinUser(String code) throws Exception{
    	
    	TokenWeb tokenweb = TokenWebService.getNewTokenWebObject(App.APP_ID,App.APP_SECRET, code);
    	WechatUser wechatUser = WeChatUserService.getUser(App.APP_ID, tokenweb);
    	
    	return wechatUser;
    }
	
	/**
	 * http://mp.weixin.qq.com/wiki/17/c0f37d5704f0b64713d5d2c37b468d75.html
	 * 通过一个code 获得用户信息   (前提看scope是什么 )
	 * @param appId
	 * @param appsecret
	 * @param code
	 * @return
	 */
	public static WechatUser getUser(String appId,TokenWeb tokenWeb) throws Exception{
		WechatUser wechatUser =null;
		if(tokenWeb == null) return null;
		wechatUser = getFromMysql(appId,tokenWeb.getOpenId());
		if(wechatUser!=null)
			return wechatUser;
		String access_token = tokenWeb.getTokenStr();
		String openid = tokenWeb.getOpenId();
		String userStr = getUserInfo(access_token, openid);
		log.debug("wecharuser json : " + userStr);
		wechatUser = strToWeChatUser(userStr);
		//插入新用户到微信user表
		WechatUserDao dao = new WechatUserDao();
		if(wechatUser!=null&&wechatUser.getUserId()!=null)
		{
		Timestamp createTime = Timestamp.valueOf(CommonUtil.formatDateTimeToYYYYMMDDHHMMSS(new Date()));
		wechatUser.setCreateTime(createTime);
		wechatUser.setUpdateTime(createTime);
		dao.insert(wechatUser);
		
		User user=new User();
		UserDao udao = new UserDao();
		user.setUserId(wechatUser.getUserId());
		user.setNickName(wechatUser.getNickName());
		user.setMoralRank("1");
		user.setCreateTime(createTime);
		user.setUpdateTime(createTime);
		
		udao.insert(user);
		
		UserPointsService  userPointsService = new UserPointsService();
		userPointsService.insertPoints(wechatUser.getUserId(), 10);
		}
		
		return wechatUser;
	}
	
	public static WechatUser getFromMysql(String appId,String openId) throws Exception{
		WechatUserDao dao = new WechatUserDao();
		WechatUser wechatUser = dao.getByUserId(openId);
		return wechatUser;		
	}
	
	/**
	 * 新版获取用户信息，试用前，该公众号必须在微信开放平台绑定过,需要是关注了公众号的用户。
	 * wiki
     * http://mp.weixin.qq.com/wiki/14/bb5031008f1494a59c6f71fa0f319c66.html
     * @param appId
     * @param appsecret
     * @param code
     * @return
	 * @throws Exception 
     */
    public static WechatUser getUserNew(String appid,String openId) throws Exception{
        //获取总token
        Token token = TokenFactory.getToken(App.APP_ID, App.APP_SECRET);
        if(token == null) return null;
        String access_token = token.getTokenStr();
        
        String userStr = getUserInfo1(access_token, openId);
        log.debug("wecharuser json : " + userStr);
        WechatUser wecharUser = strToWeChatUser(userStr);
        return wecharUser;
    }
	
    
	/**
	 * 获取一个微信用户的用户信息
	 * @return
	 */
	public static String getUserInfo(String access_token,String openid) {
		HttpClient httpclient = new DefaultHttpClient();
		HttpGet httpget = new HttpGet(GET_USER + "?access_token="+access_token+"&openid="+openid+"&lang=zh_CN");
		try {

			URL u = new URL(GET_USER);
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
     * 获取一个微信用户的用户信息
     * @return
     */
    public static String getUserInfo1(String access_token,String openid) {
        HttpClient httpclient = new DefaultHttpClient();
        HttpGet httpget = new HttpGet(GET_USER1 + "?access_token="+access_token+"&openid="+openid);
        try {

            URL u = new URL(GET_USER1);
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
	
	@SuppressWarnings("rawtypes")
	public static WechatUser strToWeChatUser(String json){
		WechatUser weChatUser = new WechatUser();
		Map map = new Gson().fromJson(json, Map.class);
		String openid = (String)map.get("openid");
		weChatUser.setOpenId(openid);
		weChatUser.setUserId(openid);
		String nickname = (String)map.get("nickname");
		weChatUser.setNickName(nickname);
		int sex = map.get("sex") ==null ? 0 : ((Double)map.get("sex")).intValue();		
		weChatUser.setSex(sex);
		String city = (String)map.get("city");
		weChatUser.setCity(city);
		String province = (String)map.get("province");
		weChatUser.setProvince(province);
	
		String country = (String)map.get("country");
		weChatUser.setCountry(country);
		String headimgurl = (String)map.get("headimgurl");
		weChatUser.setHeadImgUrl(headimgurl);
		String unionid = (String)map.get("unionid");
		weChatUser.setUnionId(unionid);
		return weChatUser;
	}
}
