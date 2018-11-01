package com.happy.action;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.nutz.mvc.View;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.view.JspView;
import org.nutz.mvc.view.ViewWrapper;

import com.happy.model.Activity;
import com.happy.model.User;
import com.happy.model.UserPoints;
import com.happy.model.WechatUser;
import com.happy.service.FindActivityService;
import com.happy.service.GameServices;
import com.happy.service.UserInfoService;
import com.happy.service.UserPointsService;

@At("/")
public class FormOfPartsAction {
	
	protected FindActivityService findActService = new FindActivityService();
	protected GameServices gameServices = new GameServices();
	@At("/formOfPartsInAct")
	public View formOfPartsInAct(HttpServletRequest request,HttpServletResponse response) throws Exception{
		
		//当前活动act_id
		String actId = request.getParameter("actId");
		//获取当前活动信息
		Activity activity  = gameServices.getInfoFromActivity(actId);
		String targetProphecy = request.getParameter("percent");//直接获取 80 ，90等比例数字
		//结果数据准备
		Map<String,Object> data = new HashMap<String,Object>();
		
		
			//筛选比例
			
			if (targetProphecy == null){
				targetProphecy = "0" ;
			}
			//第一步获取该活动的参与人有哪些
			int templateId = 1;
			if(activity.getTypeId() != null){
				templateId = Integer.parseInt(activity.getTypeId());
			}
			
			List<Map> yesParticipateWechatInfoall = gameServices.getYesParticipateWechatInfoByActId(actId,templateId );
			List<Map> noParticipateWechatInfoall = gameServices.getNoParticipateWechatInfoByActId(actId,templateId);
			
		//分别所占的数量
		int yesPartNum = 0;
		List<Map>  yesParticipateWechatInfo = new LinkedList<Map>();
		for(int i=0 ; i < yesParticipateWechatInfoall.size() ; i++ ){
			String tempForecastAcc = yesParticipateWechatInfoall.get(i).get("forecastAccuracyOfTmplate").toString();
			if(Integer.parseInt(tempForecastAcc.substring(0, tempForecastAcc.length()-1)) >= Integer.parseInt(targetProphecy)){
				yesPartNum ++;
				yesParticipateWechatInfo.add(yesParticipateWechatInfoall.get(i));
			}
		}
		
		int noPartNum = 0;
		List<Map>  noParticipateWechatInfo = new LinkedList<Map>();
		for(int i=0 ; i < noParticipateWechatInfoall.size() ; i++ ){
			String tempForecastAcc = noParticipateWechatInfoall.get(i).get("forecastAccuracyOfTmplate").toString();
			if(Integer.parseInt(tempForecastAcc.substring(0, tempForecastAcc.length()-1)) >= Integer.parseInt(targetProphecy)){
				noPartNum ++;
				noParticipateWechatInfo.add(noParticipateWechatInfoall.get(i));
			}
		}
		
		data.put("yesParticipateWechatInfo", yesParticipateWechatInfo);
		data.put("noParticipateWechatInfo", noParticipateWechatInfo);
		data.put("win", yesPartNum);
		data.put("lose", noPartNum);
		data.put("actId", actId);
		data.put("templateId", templateId);
		return new ViewWrapper(new JspView("jsp.formOfParts"),data);
		
	}
	
	
	@At("/gameListOfUser")
	public View gameListOfUser(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String userId = request.getParameter("userId");
		WechatUser wechatUser = null;
		User user = null;
		UserPoints userPoints =null;
		UserInfoService userInfoService = new UserInfoService();
		UserPointsService userPointsService = new UserPointsService();
		String temp = (String) (request.getParameter("templateId")!=null ? request.getParameter("templateId") : 1);
		int templateId = Integer.parseInt(temp);
		//获取胜场
		List<Map> listOfWinAct = gameServices.getWinActOfUser(userId, templateId);
		//获取负场
		List<Map> listOfLoseAct = gameServices.getLoseActOfUser(userId, templateId);
		//获取用户信息
		wechatUser = userInfoService.getWechatUserById(userId);
		user = userInfoService.getUserByUserId(userId);
		userPoints = userPointsService.getUserpointsByUserId(userId);
		
		Map<String,Object> data = new HashMap<String,Object>();
		data.put("listOfWinAct", listOfWinAct);
		data.put("listOfLoseAct", listOfLoseAct);
		data.put("wechatUser", wechatUser);
		data.put("user", user);
		data.put("userPoints", userPoints);
		
		return new ViewWrapper(new JspView("jsp.gameListOfUser"),data);
	}
	
}
