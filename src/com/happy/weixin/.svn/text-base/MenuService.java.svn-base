package com.happy.weixin;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.happy.model.menu.Button;
import com.happy.model.menu.CommonButton;
import com.happy.model.menu.MainMenu;
import com.happy.utils.WeiXinUtil;
import com.happy.weixin.app.App;
import com.happy.weixin.token.Token;
import com.happy.weixin.token.TokenFactory;

/**
 *  https://api.weixin.qq.com/cgi-bin/menu/create?access_token=ACCESS_TOKEN
 * 
 * 
 * @author fei
 */
public class MenuService {
	
	private static Log log = LogFactory.getLog(MenuService.class);
	
	
	/** 点击*/
	public static final String MENU_TYPE_CLICK = "click";
	/** 视图*/
	public static final String MENU_TYPE_VIEW = "view";
	
	/** 发起活动key*/
	public static final String KEY_CHALLENGE = "http://www.76idea.com/happy/weixin/baseoauth?action=challengIndex";
	/** 活动管理key*/
	public static final String KEY_ACTIVES = "http://www.76idea.com/happy/weixin/baseoauth?action=activeIndex";
	/** 我的消息key*/
	public static final String KEY_MESSAGE = "http://www.76idea.com/happy/weixin/baseoauth?action=messageIndex";
	
	/**
	 * 查询微信自定义菜单
	 * @param access_token 有效的微信access_token
	 * @return MainMenu
	 */
	/*public static MainMenu findMenu(){
		String access_token = TokenService.getRromRedis();
		JSONObject json = WeiXinUtil.queryMenu(access_token);
		if(null != json){
			if(null != json.get("errcode")){
				log.debug("获取微信服务器中自定义菜单失败，错误：errorCode="+json.getInt("errcode")+"，errorMsg="+json.getString("errmsg"));
				return null;
			}else{
				MainMenu menu = formatJson(json);
				log.debug("获取微信服务器中自定义菜单：" + json.toString());
				return menu;
			}
		}else{
			return null;
		}
	}*/
	/**
	 * 创建微信自定义菜单
	 */
	public static void createMenu()throws Exception{
		MainMenu menu = getMenu();
		Token token = TokenFactory.getTokenFromRedis(App.APP_ID, App.PAY_SECRET);
		if (token == null) {
            return;
        }
		
		String access_token = token.getTokenStr();
		log.debug("create menu token:"+access_token);
		WeiXinUtil.createMenu(menu, access_token);
	}
	/**
	 * 构造微信自定义菜单对象
	 * 备注：目前微信公众平台自定义菜单一级菜单最多定义3个(字数限制5个)，二级菜单最多5个(字数限制7个)
	 * @return MainMenu
	 */
	private static MainMenu getMenu(){
		MainMenu menu = new MainMenu();
	
		CommonButton challengeBtn = new CommonButton();
		challengeBtn.setName("发起活动");
		challengeBtn.setType(MENU_TYPE_VIEW);
		challengeBtn.setKey(KEY_CHALLENGE);
		
		CommonButton activesBtn = new CommonButton();
		activesBtn.setName("活动管理");
		activesBtn.setType(MENU_TYPE_VIEW);
		activesBtn.setKey(KEY_ACTIVES);
		
		CommonButton messageBtn = new CommonButton();
		messageBtn.setName("我的消息");
		messageBtn.setType(MENU_TYPE_VIEW);
		messageBtn.setKey(KEY_MESSAGE);
		//设置菜单
		menu.setButton(new Button[]{challengeBtn, activesBtn, messageBtn});
		return menu;
	}
}
