package com.happy.weixin.app;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.happy.dao.common.HostConfig;


public class App {
	/** 基础权限，只获得 openId-直接302*/
	public static final String SCOPE_BASE = "snsapi_base";
	/** 高级权限，获得用户详细信息-有弹出确认*/
	public static final String SCOPE_USERINFO = "snsapi_userinfo";
	private static Log log = LogFactory.getLog(App.class);
	/** 所有涉及到appId的都从 TokenService.appId 获取 -->注意 appId  appsecrect 不允许修改*/
    /** 默认是正式环境appId*/
    public static String APP_ID = "wx4315ad5a9a5f1bfb";
    /** 默认是正式环境appsecrect*/
    public static String APP_SECRET = "e207cd45f96978428d4888319e114ee1";
    /** 微信公众平台支付功能-商户号ID*/
//    public static String MCH_ID = "1248851801";
    /** 微信公众平台支付功能-支付密码*/
    public static String PAY_SECRET = "A4ObsmD6dzxAAvtGz2zW2CkHZUaQYsFb";
    /** 默认是正式环镜服务器域名*/
    public static String APP_SERVER = HostConfig.WEIXIN_HOST;  

    /** 默认是正式环镜服务器域名*/
    public static String APP_NAME = "happy";  
    
    /**系统用户小朕子的账号*/
    public static String SYSTEM_ADMIN = "systemadmin";
    
  /**redis key 胜负率*/
  	public static String FORECAST_ACC = "forecastAcc";
  	
    /**微信支持的表情符号子集*/
	/*public static String[] APP_EMOJI_LIST = new String[] { "/:ladybug", "/:pig", "/:hug", "/:gift", "/:sun",
														"/:moon", "/:footb", "/:li", "/:cake", "/:eat",
														"/:coffee", "/:beer", "/:oo", "/:<W>", "/:B-)",
														"/:P-(","/:xx","/:!!!", "/:,@!","/::,@"};🚹*/
   /* public static String[] APP_EMOJI_LIST = new String[] { "♈","🌏", "♉","🌑", "♊","🌔","🌓", "♋","🌙", "♌","🌕",
															"♍","🌛","🌟", "♎","🌠","🕐", "♏","🕑","♐","🕒", "♑","🕓","🕔","🕕","🕖","🕗"
															,"🕘","🕙","♒","🕚","🕛","⌚", "♓","⌛","⏰", "⛎","⏳"};*/
    public static String[] APP_EMOJI_LIST = new String[] { "♈", "♉", "♊", "♋", "♌","♍", "♎", "♏", "♐", "♑","♒", "♓", "⛎"};
    
	/**支持方随机插入评论预计*/
	public static String[] APP_SUPPORT_LIST = new String[] { "臣以为，皇上圣明！", "你说的话，我都相信！", "你信吗？反正我是相信的！", "字字珠玑！", "臣誓死追随",
														"哎哟，不错哦！"};
	/**支持方随机插入评论预计*/
	public static String[] APP_AGAINST_LIST = new String[] { "臣以为，此事万万不可！", "你咋不上天呢？", "你信吗？反正我是不信的！", "信口开河！", "套路深，回农村！",
														"扯得凶！"};
	
    static {
        //如果是测试环境
        if (HostConfig.weixinDebug) {
            APP_ID = "wx4315ad5a9a5f1bfb";
            APP_SECRET = "e207cd45f96978428d4888319e114ee1";
//            APP_SERVER = APP_SERVER;
            APP_NAME = "happydev";    
            PAY_SECRET = "A4ObsmD6dzxAAvtGz2zW2CkHZUaQYsFb";
        }
        log.debug(HostConfig.weixinDebug ? "测试环境" : "生产环境");
        log.debug("APP_ID : " + APP_ID);
        log.debug("APP_SECRET : " + APP_SECRET);
        log.debug("APP_SERVER : " + APP_SERVER);
        log.debug("APP_NAME : " + APP_NAME);
        log.debug("PAY_SECRET : " + PAY_SECRET);        
    }
}
