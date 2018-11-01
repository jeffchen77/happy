package com.happy.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.nutz.mvc.View;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Param;
import org.nutz.mvc.view.JspView;
import org.nutz.mvc.view.ViewWrapper;

import com.happy.model.PointsTrans;
import com.happy.model.Program;
import com.happy.model.User;
import com.happy.model.UserPoints;
import com.happy.model.WechatUser;
import com.happy.service.AwardService;
import com.happy.service.PointsShopService;
import com.happy.service.UserInfoService;
import com.happy.service.UserPointsService;
import com.happy.weixin.wechatuser.WeChatUserService;

public class AwardAction {

	private static Logger log = LogManager.getLogger(AwardAction.class);
	private PointsShopService pointsShopService = new PointsShopService();
	/*
	 * 跳到领取奖励页面
	 */
	@At("/getAwardIndex")
	public View getAwardIndex(@Param("code")String code, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		List<Program> pgmList = new ArrayList<Program>();

		AwardService awardService = new AwardService();
		WechatUser wechatUser = null;
		UserInfoService userInfoService = new UserInfoService();
		String dsbRate = null;
		List<Map> awardMap = new ArrayList<Map>();
		List<Map> goods = null;
		User user = null;
		UserPointsService userPointsService = new UserPointsService();
		PointsTrans pointsTrans = null;
		UserPoints userPoints = null;
		try {
			wechatUser = WeChatUserService.getWeixinUser(code);
			user = userInfoService.getUserByUserId(wechatUser.getOpenId());
			userPoints=userPointsService.getUserpointsByUserId(user.getUserId());
			// 获取数据库所有的信息
			pgmList = awardService.getAllPrograms();
			goods = pointsShopService.getAllGoods(1);
			for (int i = 0; i < pgmList.size(); i++) {
				Program pgm = new Program();
				pgm = pgmList.get(i);
				// 获取活动奖励列表
				Map<String, Object> mapHadRead = new HashMap<String, Object>();
				mapHadRead.put("divId", "awardInfo" + i);
				mapHadRead.put("pgmTitle", pgm.getPgmTitle());
				mapHadRead.put("pgmDesc", pgm.getPgmDesc());
				mapHadRead.put("pgmId", pgm.getPgmId());
				mapHadRead.put("pgmPoints", pgm.getPgmPoints());
				pointsTrans=userPointsService.getPointsTransByUserIdAndPgmId(user.getUserId(), pgm.getPgmId());
				if(pointsTrans!=null){
					mapHadRead.put("isGet","hasGet");
				}
				else{
					mapHadRead.put("isGet","waitGet");
				}
				awardMap.add(mapHadRead);
				
				if(user.getForecastAccuracy()!=null){
					 dsbRate=user.getForecastAccuracy();	
				}
				else{
					 dsbRate="";	
				}

			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		// 放到request， 并返回页面
		request.setAttribute("awardMap", awardMap);
		request.setAttribute("hotgoods", goods);
		request.setAttribute("theUserId", user.getUserId());
		request.setAttribute("wechatUser", wechatUser);
		request.setAttribute("dsbRate", dsbRate);
		request.setAttribute("user", user);
		request.setAttribute("userPoints", userPoints);
		
		return new ViewWrapper(new JspView("jsp.getAward"), "");
	}
	
	@At("/getAward")
	public boolean getAward(HttpServletRequest request,HttpServletResponse response){
		int pgmPoints = Integer.parseInt(request.getParameter("pgmPoints"));
		String pgmId=request.getParameter("pgmId");
		String userId = request.getParameter("userId");
		PointsTrans pointsTrans = null;
		UserPointsService userPointsService = new UserPointsService();
		pointsTrans=userPointsService.getPointsTransByUserIdAndPgmId(userId, pgmId);
		if(pointsTrans!=null)
		{
			return false;
		}
		UserPoints userPoints=userPointsService.getUserpointsByUserId(userId);
		if(userPoints!=null){
			try{
				int type = 2;
				if("PGMDAY".equalsIgnoreCase(pgmId))
				{
					type = 3;
				}
				userPointsService.insertPointsTran(pgmId, userId, userPoints.getAllPoints(), userPoints.getAllPoints()+pgmPoints, pgmPoints, type);
				userPointsService.updateTotalPointsByUserId(userPoints.getAllPoints()+pgmPoints, userId);	
				return true;
			}catch(Exception e){
				e.printStackTrace();
				return false;
			}
					
		}
		else{
			try{
				userPointsService.insertPointsTran(pgmId, userId, 0, pgmPoints, pgmPoints, 2);
				userPointsService.insertPoints(userId,pgmPoints);
				return true;
			}catch(Exception e){
				e.printStackTrace();
				return false;
			}	
		}
		
		
	}
}
