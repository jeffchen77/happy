package com.happy.utils;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.security.SecureRandom;

import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.TrustManager;

import net.sf.json.JSONObject;

import org.nutz.log.Log;
import org.nutz.log.Logs;

import com.happy.model.menu.MainMenu;

/**
 * 微信公众平台通用接口工具类
 * @author Administrator
 *
 */
public class WeiXinUtil {

	public static final Log log = Logs.getLog(WeiXinUtil.class);
	
	/** 获取access_token的接口地址（GET） 限200（次/天）*/
	public static final String WEIXIN_ACCESS_TOKEN_URL = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=APPID&secret=APPSECRET";
	/** 有房服务器响应用户发送消息的接口地址（POST）*/
	public static final String YOFANGSERVER_SEND_WEIXINSERVER_URL = "https://api.weixin.qq.com/cgi-bin/message/custom/send?access_token=ACCESS_TOKEN";
	/** 菜单创建的接口地址（POST）限100（次/天）*/
	public static final String WEIXIN_CREATE_MENU_URL = "https://api.weixin.qq.com/cgi-bin/menu/create?access_token=ACCESS_TOKEN";
	/** 菜单查询的接口地址（GET）限10000（次/天）*/
	public static final String WEIXIN_QUERY_MENU_URL = "https://api.weixin.qq.com/cgi-bin/menu/get?access_token=ACCESS_TOKEN";
	/** 菜单删除的接口地址（GET）限100（次/天）*/
	public static final String WEIXIN_REMOVE_MENU_URL = "https://api.weixin.qq.com/cgi-bin/menu/delete?access_token=ACCESS_TOKEN";
	/** 文本字数限制最大字节长度*/
	public static final int WEIXIN_CONTENT_MAX_LENGTH = 2047;//针对UTF-8编码格式
	
	/**
	 * 发起Https请求并获取结果
	 * @param requestUrl 请求URL
	 * @param requestMethod 请求方式(GET/POST)
	 * @param outputStr 提交数据
	 * @return JSONObject
	 */
	public static JSONObject httpRequest(String requestUrl, String requestMethod, String outputStr){
		JSONObject json = null;
		StringBuffer sb = new StringBuffer();
		try{
			//创建SSLContext对象，并使用我们指定的信任管理器初始化
			TrustManager[] tm = {new MyX509TrustManager()};
			SSLContext sslContext = SSLContext.getInstance("SSL", "SunJSSE");
			sslContext.init(null, tm, new SecureRandom());
			//从上述SSLContext对象中得到SSLSocketFactory对象
			SSLSocketFactory ssf = sslContext.getSocketFactory();
			URL url = new URL(requestUrl);
			HttpsURLConnection conn = (HttpsURLConnection)url.openConnection();
			conn.setSSLSocketFactory(ssf);
			conn.setDoOutput(true);
			conn.setDoInput(true);
			conn.setUseCaches(false);
			//设置请求方式
			conn.setRequestMethod(requestMethod);
			if("GET".equalsIgnoreCase(requestMethod)){
				conn.connect();
			}
			//当有数据提交时
			if(CommonUtil.notEmpty(outputStr)){
				OutputStream os = conn.getOutputStream();
				//注意编码格式，防止中文乱码
				os.write(outputStr.getBytes("UTF-8"));
				os.close();
			}
			
			//将返回的输入流转换为字符串
			InputStream is = conn.getInputStream();
			InputStreamReader read = new InputStreamReader(is, "UTF-8");
			BufferedReader br = new BufferedReader(read);
			String str = null;
			while((str = br.readLine()) != null){
				sb.append(str);
			}
			br.close();
			read.close();
			is.close();
			is = null;
			conn.disconnect();
			json = JSONObject.fromObject(sb.toString());
		}catch(Exception e){
			log.debug("https request error !!!"+e.getMessage());
			e.printStackTrace();
		}
		return json;
	}
	
	/**
	 * 从微信服务器获取access_token
	 * @param appid 凭证ID
	 * @param appsecret 密钥
	 * @return AccessToken
	 */
	public static JSONObject getAccessToken(String appid, String appsecret){
		String requestUrl = WEIXIN_ACCESS_TOKEN_URL.replace("APPID", appid).replace("APPSECRET", appsecret);
		JSONObject json = httpRequest(requestUrl, "GET", null);
		return json;
	}
	
	/**
	 * 创建微信菜单
	 * @param menu 菜单实例
	 * @param access_token 有效的微信access_token
	 * @return Integer, 0表示成功，否则失败
	 */
	public static int createMenu(MainMenu menu, String access_token){
		int result = 0;
		String requestUrl = WEIXIN_CREATE_MENU_URL.replace("ACCESS_TOKEN", access_token);
		//将菜单实例转换为JSON字符串
		String jsonMenu = JSONObject.fromObject(menu).toString();
		//调用接口创建菜单
		JSONObject json = httpRequest(requestUrl, "POST", jsonMenu);
		if(null != json){
			result = json.getInt("errcode");
			if(0 != result){
				log.debug("创建微信菜单失败，错误：errorCode="+json.getInt("errcode")+"，errorMsg="+json.getString("errmsg"));
			}
		}
		return result;
	}
	
	/**
	 * 通过有效的微信access_token查询菜单
	 * @param access_token 有效的微信access_token
	 * @return JSONObject
	 */
	public static JSONObject queryMenu(String access_token){
		String requestUrl = WEIXIN_QUERY_MENU_URL.replace("ACCESS_TOKEN", access_token);
		JSONObject json = httpRequest(requestUrl, "GET", null);
		return json;
	}
	
	/**
	 * 通过有效的微信access_token删除菜单
	 * @param access_token 有效的微信access_token
	 * @return JSONObject
	 */
	public static int removeMenu(String access_token){
		int result = 0;
		String requestUrl = WEIXIN_REMOVE_MENU_URL.replace("ACCESS_TOKEN", access_token);
		JSONObject json = httpRequest(requestUrl, "GET", null);
		if(null != json){
			result = json.getInt("errcode");
			if(0 != result){
				log.debug("删除微信菜单失败，错误：errorCode="+json.getInt("errcode")+"，errorMsg="+json.getString("errmsg"));
			}
		}
		return result;
	}
	
	/**
	 * 验证响应微信服务器的文本内容长度是否有效
	 * @param content 响应微信服务器文本内容
	 * @return true:有效 false:无效
	 */
	public static boolean checkContentLength(String content){
		boolean validity = true;
		int size = 0;
		if(CommonUtil.notEmpty(content)){
			try {
				size = content.getBytes("utf-8").length;
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			if(size > WEIXIN_CONTENT_MAX_LENGTH) validity = false;
		}
		return validity;
	}
	
	public static void send(){
		
	}
}
