package com.happy.action;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.nutz.json.JsonFormat;
import org.nutz.mvc.View;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Param;
import org.nutz.mvc.view.JspView;
import org.nutz.mvc.view.UTF8JsonView;
import org.nutz.mvc.view.ViewWrapper;

import com.happy.model.Activity;
import com.happy.model.SysMessage;
import com.happy.model.User;
import com.happy.model.UserPoints;
import com.happy.model.WechatUser;
import com.happy.service.ChallengeThemeService;
import com.happy.service.SysLoginService;
import com.happy.service.URLService;
import com.happy.service.UserActivityServices;
import com.happy.service.UserInfoService;
import com.happy.service.UserPointsService;
import com.happy.utils.CommonUtil;
import com.happy.utils.CustomMsgUtil;
import com.happy.utils.Sign;
import com.happy.weixin.app.App;
import com.happy.weixin.wechatuser.WeChatUserService;

@At("/")
public class SysAdminLoginAction {

	private static Logger log = LogManager.getLogger(SysAdminLoginAction.class);

	protected SysLoginService sysLoginService = new SysLoginService();
	protected UserActivityServices userActivityService = new UserActivityServices();
	protected UserInfoService userInfoService = new UserInfoService();
	protected UserPointsService userPointsService = new UserPointsService();
	protected ChallengeThemeService challengeThemeService = new ChallengeThemeService();

	/*
	 * 绯荤粺绠＄悊鍛樼櫥褰曢〉闈�
	 */
	@At("/syslogin")
	public View sysLogin() {
		return new ViewWrapper(new JspView("jsp.syslogin"), "");
	}

	/*
	 * 绯荤粺绠＄悊鍛樼櫥褰曢〉闈�
	 */
	@At("/login")
	public View login(HttpServletRequest request, HttpServletResponse response) {
		String userId = request.getParameter("inputUsr");
		String pwdId = request.getParameter("inputPwd");
		if ("sysadmin".equalsIgnoreCase(userId)
				&& "sysadmin".equalsIgnoreCase(pwdId)) {
			List<Activity> data = new ArrayList<Activity>();
			data = sysLoginService.getSysActivity();
			request.setAttribute("acts", data);
			return new ViewWrapper(new JspView("jsp.showSystemAction"), null);
		} else {
			return new ViewWrapper(new JspView("jsp.syslogin"), "");
		}
	}

	/*
	 * 绯荤粺绠＄悊鍛樼櫥褰曢〉闈�
	 */
	@At("/verifyPwdBefore")
	public View verifyPwdBefore(HttpServletRequest request,
			HttpServletResponse response) {
		String userId = request.getParameter("username");
		String pwdId = request.getParameter("pwdword");
		if ("sysadmin".equalsIgnoreCase(userId)
				&& "sysadmin".equalsIgnoreCase(pwdId)) {
			return new ViewWrapper(new UTF8JsonView(new JsonFormat()), "1");
		} else {
			return new ViewWrapper(new UTF8JsonView(new JsonFormat()), "0");
		}
	}

	/*
	 * 绯荤粺绠＄悊鍛樼櫥褰曢〉闈�
	 */
	@At("/doWinOrLoseAction")
	public View doWinOrLoseAction(HttpServletRequest request,
			HttpServletResponse response) {
		String winflag = request.getParameter("winflag");
		int status = Integer.parseInt(winflag);
		String actId = request.getParameter("actId");
		String msg = request.getParameter("msg");
		/*
		 * List<String> userIds = null; List<String> proUserIds = null;
		 */
		// 缁撶畻浠ｇ爜
		Activity activity = null;
		try {
			activity = userActivityService.getActivityByActivityId(actId);
			if (activity != null) {
				billSettlement(actId, status, msg);
				userActivityService.saveResultFlag(actId, status);
			} else {
				return new ViewWrapper(new UTF8JsonView(new JsonFormat()), "0");
			}
		} catch (Exception e1) {
			e1.printStackTrace();
			return new ViewWrapper(new UTF8JsonView(new JsonFormat()), "0");
		}

		/*
		 * try { userActivityService.saveResultFlag(actId, status);
		 * //寰楀埌鍙嶅鐨剈serid userIds =
		 * userActivityService.getUserIdBasedOnActId(actId, "N"); //寰楀埌鏀寔鐨剈serid
		 * proUserIds = userActivityService.getUserIdBasedOnActId(actId, "Y");
		 * }catch (Exception e) { e.printStackTrace(); return new
		 * ViewWrapper(new UTF8JsonView(new JsonFormat()), "0"); }
		 */

		/*
		 * // 鍙戦�绯荤粺娑堟伅缁欏弽瀵硅� if(userIds!=null && userIds.size()>0) { SysMessage mes=
		 * null; for(int i=0; i<userIds.size();i++) { String cusContent=""; mes
		 * = new SysMessage(); mes.setActivityId(actId); if(status==1) {
		 * mes.setBody("浣犲湪娲诲姩銆�+activity.getActivityRemark()+"銆嬩腑鍙栬儨浜�); cusContent
		 * = "鎭枩鎮紝浣犲湪娲诲姩<"+activity.getActivityRemark()+">涓彇鑳滀簡"; } else
		 * if(status==2) {
		 * mes.setBody("浣犲湪娲诲姩銆�+activity.getActivityRemark()+"銆嬩腑澶辫触浜�); cusContent
		 * = "寰堟姳姝夛紝浣犲湪娲诲姩<"+activity.getActivityRemark()+">涓け璐ヤ簡"; } else
		 * if(status==3) {
		 * mes.setBody("娲诲姩銆�+activity.getActivityRemark()+"銆嬪凡鍥犳晠鍙栨秷"); cusContent
		 * = "浣犲弬涓庣殑娲诲姩<"+activity.getActivityRemark()+">鍥犳晠鍙栨秷浜�; }
		 * mes.setFromUserId(activity.getUserId());
		 * mes.setToUserId(userIds.get(i)); mes.setStatus(0);
		 * mes.setSendTime(new Date()); mes.setTitle("銆愮粨鏋滈�鐭ャ�"); try {
		 * userInfoService.sendSysMessage(mes); } catch (Exception e) {
		 * e.printStackTrace(); } CustomMsgUtil.sendCustomMsg(userIds.get(i),
		 * cusContent); } }
		 */

		/*
		 * // 鍙戦�绯荤粺娑堟伅缁欐敮鎸佽� if(proUserIds!=null && proUserIds.size()>0) {
		 * SysMessage mes= null; for(int i=0; i<proUserIds.size();i++) { String
		 * cusContent=""; mes = new SysMessage(); mes.setActivityId(actId);
		 * if(status==1) {
		 * mes.setBody("浣犲湪娲诲姩銆�+activity.getActivityRemark()+"銆嬩腑澶辫触浜�); cusContent
		 * = "寰堟姳姝夛紝浣犲湪娲诲姩<"+activity.getActivityRemark()+">涓け璐ヤ簡"; } else
		 * if(status==2) {
		 * mes.setBody("浣犲湪娲诲姩銆�+activity.getActivityRemark()+"銆嬩腑鍙栬儨浜�); cusContent
		 * = "鎭枩鎮紝浣犲湪娲诲姩<"+activity.getActivityRemark()+">涓彇鑳滀簡"; } else
		 * if(status==3) {
		 * mes.setBody("娲诲姩銆�+activity.getActivityRemark()+"銆嬪凡鍥犳晠鍙栨秷"); cusContent
		 * = "浣犲弬涓庣殑娲诲姩<"+activity.getActivityRemark()+">鍥犳晠鍙栨秷浜�; }
		 * mes.setFromUserId(activity.getUserId());
		 * mes.setToUserId(proUserIds.get(i)); mes.setStatus(0);
		 * mes.setSendTime(new Date()); mes.setTitle("銆愮粨鏋滈�鐭ャ�"); try {
		 * userInfoService.sendSysMessage(mes); } catch (Exception e) {
		 * e.printStackTrace(); } CustomMsgUtil.sendCustomMsg(proUserIds.get(i),
		 * cusContent); } }
		 */

		return new ViewWrapper(new UTF8JsonView(new JsonFormat()), "1");
	}

	// 杩欎釜鏂规硶鏄处鍗曠殑缁撶畻
	private void billSettlement(String actId, int status, String msg) {
		try {
			Activity activity = userActivityService
					.getActivityByActivityId(actId);
			List<String> supportUserIds = userActivityService
					.getUserIdBasedOnActId(actId, "Y");
			List<String> opponentUserIds = userActivityService
					.getUserIdBasedOnActId(actId, "N");
			int points = activity.getStakePoints();
			SysMessage mess = null;
			// 瑙ｉ攣鍙戣捣鑰�
			// unLockPoints(activity.getUserId(), points);
			int dNum = 1;
			// 瑙ｉ攣鏀寔鑰�
			for (int i = 0; i < supportUserIds.size(); i++) {
				dNum = userActivityService.getPartiDoubleNum(activity.getActivityId(), supportUserIds.get(i));
				unLockPoints(supportUserIds.get(i), points * dNum);
			}
			// 瑙ｉ攣鍙嶅鑰�
			for (int i = 0; i < opponentUserIds.size(); i++) {
				dNum = userActivityService.getPartiDoubleNum(activity.getActivityId(), opponentUserIds.get(i));
				unLockPoints(opponentUserIds.get(i), points * dNum);
			}

			// 鎵ц浜ゆ槗鏄庣粏
			if ((opponentUserIds != null && opponentUserIds.size() <= 0)
					|| (supportUserIds != null && supportUserIds.size() <= 0)) {
				// 娌℃湁鍙嶅鑰呮垨鑰呮病鏈夋敮鎸佽�鐨勬儏鍐�
				if (status == 1) {
					// 娲诲姩鏀拺鑰呭け璐�
					if (supportUserIds != null && supportUserIds.size() > 0) {
						for (int i = 0; i < supportUserIds.size(); i++) {
							/*CustomMsgUtil
									.sendCustomMsg(
											supportUserIds.get(i),
											activity.getActivityRemark()
													+ "寰堟姳姝夛紝浣犻娴嬪け璐ヤ簡锛屼絾鏄敱浜庢椿鍔ㄦ病鏈夊弽瀵规柟锛屾墍浠ヤ綘鍦ㄦ娲诲姩澶卞幓浜�涓煄姹狅紒");
							mes = new SysMessage();
							mes.setBody(activity.getActivityRemark()
									+ "寰堟姳姝夛紝浣犻娴嬪け璐ヤ簡锛屼絾鏄敱浜庢椿鍔ㄦ病鏈夊弽瀵规柟锛屾墍浠ヤ綘鍦ㄦ娲诲姩澶卞幓浜�涓煄姹狅紒");
							mes.setFromUserId(activity.getUserId());
							mes.setToUserId(supportUserIds.get(i));
							mes.setStatus(0);
							mes.setActivityId(activity.getActivityId());
							mes.setSendTime(new Date());
							mes.setTitle("銆愮粨鏋滈�鐭ャ�");
							userInfoService.sendSysMessage(mes);*/
							
							updatePointsDetail(activity.getActivityId(),
									supportUserIds.get(i), 0, 0);
							mess=new SysMessage();
							mess.setToUserId(supportUserIds.get(i));
							mess.setActivityId(activity.getActivityId());
							mess.setStatus(status);
							mess.setActivityDesc(activity.getActivityDesc());
							mess.setPoints(0);
							CustomMsgUtil.sendSystemResultTemplateMsg(mess, msg);
						}
					}

					// 娲诲姩鍙嶅鑰呰耽
					if (opponentUserIds != null && opponentUserIds.size() > 0) {
						for (int i = 0; i < opponentUserIds.size(); i++) {
							/*CustomMsgUtil
									.sendCustomMsg(
											opponentUserIds.get(i),
											activity.getActivityRemark()
													+ "鎭枩鎮紝浣犻娴嬫纭紝浣嗘槸鐢变簬娲诲姩娌℃湁鏀寔鏂癸紝鎵�互浣犲湪姝ゆ椿鍔ㄤ腑娲诲姩浜�涓煄姹狅紒");
							mes = new SysMessage();
							mes.setBody(activity.getActivityRemark()
									+ "鎭枩鎮紝浣犻娴嬫纭紝浣嗘槸鐢变簬娲诲姩娌℃湁鏀寔鏂癸紝鎵�互浣犲湪姝ゆ椿鍔ㄤ腑娲诲姩浜�涓煄姹狅紒");
							mes.setFromUserId(activity.getUserId());
							mes.setToUserId(opponentUserIds.get(i));
							mes.setStatus(0);
							mes.setActivityId(activity.getActivityId());
							mes.setSendTime(new Date());
							mes.setTitle("銆愮粨鏋滈�鐭ャ�");
							userInfoService.sendSysMessage(mes);*/
							
							updatePointsDetail(activity.getActivityId(),
									opponentUserIds.get(i), 0, 1);
							mess=new SysMessage();
							mess.setToUserId(opponentUserIds.get(i));
							mess.setActivityId(activity.getActivityId());
							mess.setStatus(2);
							mess.setActivityDesc(activity.getActivityDesc());
							mess.setPoints(0);
							CustomMsgUtil.sendSystemResultTemplateMsg(mess, msg);
						}
					}

				} else if (status == 2) {
					// 娲诲姩鏀拺鑰呮垚鍔�
					if (supportUserIds != null && supportUserIds.size() > 0) {
						for (int i = 0; i < supportUserIds.size(); i++) {
							/*CustomMsgUtil
									.sendCustomMsg(
											supportUserIds.get(i),
											activity.getActivityRemark()
													+ "鎭枩鎮紝浣犻娴嬫纭紝浣嗘槸鐢变簬娲诲姩娌℃湁鍙嶅鏂癸紝鎵�互浣犲湪姝ゆ椿鍔ㄤ腑鑾峰緱浜�涓煄姹狅紒");
							mes = new SysMessage();
							mes.setBody(activity.getActivityRemark()
									+ "鎭枩鎮紝浣犻娴嬫纭紝浣嗘槸鐢变簬娲诲姩娌℃湁鍙嶅鏂癸紝鎵�互浣犲湪姝ゆ椿鍔ㄤ腑鑾峰緱浜�涓煄姹狅紒");
							mes.setFromUserId(activity.getUserId());
							mes.setToUserId(supportUserIds.get(i));
							mes.setStatus(0);
							mes.setActivityId(activity.getActivityId());
							mes.setSendTime(new Date());
							mes.setTitle("銆愮粨鏋滈�鐭ャ�");
							userInfoService.sendSysMessage(mes);*/
							
							updatePointsDetail(activity.getActivityId(),
									supportUserIds.get(i), 0, 1);
							mess=new SysMessage();
							mess.setToUserId(supportUserIds.get(i));
							mess.setActivityId(activity.getActivityId());
							mess.setStatus(status);
							mess.setActivityDesc(activity.getActivityDesc());
							mess.setPoints(0);
							CustomMsgUtil.sendSystemResultTemplateMsg(mess, msg);
						}
					}

					// 娲诲姩鍙嶅鑰呰緭
					if (opponentUserIds != null && opponentUserIds.size() > 0) {
						for (int i = 0; i < opponentUserIds.size(); i++) {
							/*CustomMsgUtil
									.sendCustomMsg(
											opponentUserIds.get(i),
											activity.getActivityRemark()
													+ "寰堟姳姝夛紝浣犻娴嬪け璐ヤ簡锛屼絾鏄敱浜庢椿鍔ㄦ病鏈夋敮鎸佹柟锛屾墍浠ヤ綘鍦ㄦ娲诲姩涓け鍘讳簡0涓煄姹狅紒");
							mes = new SysMessage();
							mes.setBody(activity.getActivityRemark()
									+ "寰堟姳姝夛紝浣犻娴嬪け璐ヤ簡锛屼絾鏄敱浜庢椿鍔ㄦ病鏈夋敮鎸佹柟锛屾墍浠ヤ綘鍦ㄦ娲诲姩涓け鍘讳簡0涓煄姹狅紒");
							mes.setFromUserId(activity.getUserId());
							mes.setToUserId(opponentUserIds.get(i));
							mes.setStatus(0);
							mes.setActivityId(activity.getActivityId());
							mes.setSendTime(new Date());
							mes.setTitle("銆愮粨鏋滈�鐭ャ�");
							userInfoService.sendSysMessage(mes);*/
							
							updatePointsDetail(activity.getActivityId(),
									opponentUserIds.get(i), 0, 0);
							mess=new SysMessage();
							mess.setToUserId(opponentUserIds.get(i));
							mess.setActivityId(activity.getActivityId());
							mess.setStatus(1);
							mess.setActivityDesc(activity.getActivityDesc());
							mess.setPoints(0);
							CustomMsgUtil.sendSystemResultTemplateMsg(mess, msg);
						}
					}
				}
			} else {
				// 娲诲姩鏈夊弽瀵硅� 骞朵笖鏈夋敮鎸佽�
				if (status == 1) {
					int surLostPoints = 0;
					// 娲诲姩鏀拺鑰呭け鍘籶oints
					if (supportUserIds != null && supportUserIds.size() > 0) {
						for (int i = 0; i < supportUserIds.size(); i++) {
							/*CustomMsgUtil.sendCustomMsg(supportUserIds.get(i),
									activity.getActivityRemark()
											+ "寰堟姳姝夛紝浣犻娴嬪け璐ヤ簡锛屼綘鍦ㄦ娲诲姩涓け鍘讳簡" + points
											+ "涓煄姹狅紒");
							mes = new SysMessage();
							mes.setBody(activity.getActivityRemark()
									+ "寰堟姳姝夛紝浣犻娴嬪け璐ヤ簡锛屼綘鍦ㄦ娲诲姩涓け鍘讳簡" + points + "涓煄姹狅紒");
							mes.setFromUserId(activity.getUserId());
							mes.setToUserId(supportUserIds.get(i));
							mes.setStatus(0);
							mes.setActivityId(activity.getActivityId());
							mes.setSendTime(new Date());
							mes.setTitle("銆愮粨鏋滈�鐭ャ�");
							userInfoService.sendSysMessage(mes);*/
							dNum = userActivityService.getPartiDoubleNum(activity.getActivityId(), supportUserIds.get(i));
							updatePointsDetail(activity.getActivityId(),
									supportUserIds.get(i), points * dNum, 0);
							surLostPoints += points * dNum;
							mess=new SysMessage();
							mess.setToUserId(supportUserIds.get(i));
							mess.setActivityId(activity.getActivityId());
							mess.setStatus(status);
							mess.setActivityDesc(activity.getActivityDesc());
							mess.setPoints(points * dNum);
							CustomMsgUtil.sendSystemResultTemplateMsg(mess, msg);
						}
					}

					// ////////////////
					// 璁＄畻鍙嶅鑰呭簲璇ヨ幏寰楃殑鍩庢睜鏁伴噺
					//int totalLose = points * (supportUserIds.size());
					int perSurpNum = 0;
					for(int i=0; i<opponentUserIds.size(); i++)
					{
						perSurpNum += userActivityService.getPartiDoubleNum(activity.getActivityId(), opponentUserIds.get(i));
					}
					
					int perPoints = surLostPoints / perSurpNum;
					int yushu = surLostPoints % perSurpNum;
					// ///////////////
					// 娲诲姩鍙嶅鑰呮椿鍔╬oints
					if (opponentUserIds != null && opponentUserIds.size() > 0) {
						for (int i = 0; i < opponentUserIds.size(); i++) {
							dNum = userActivityService.getPartiDoubleNum(activity.getActivityId(), opponentUserIds.get(i));
							int tempPoint = perPoints * dNum;
							if (i < yushu) {
								tempPoint += 1;
							}
							/*CustomMsgUtil.sendCustomMsg(opponentUserIds.get(i),
									activity.getActivityRemark()
											+ "鎭枩鎮紝浣犻娴嬫纭紝浣犲湪姝ゆ椿鍔ㄤ腑鑾峰緱浜� + tempPoint
											+ "涓煄姹狅紒");
							mes = new SysMessage();
							mes.setBody(activity.getActivityRemark()
									+ "鎭枩鎮紝浣犱腑棰勬祴姝ｇ‘锛屼綘鍦ㄦ娲诲姩涓幏寰椾簡" + tempPoint
									+ "涓煄姹狅紒");
							mes.setFromUserId(activity.getUserId());
							mes.setToUserId(opponentUserIds.get(i));
							mes.setStatus(0);
							mes.setActivityId(activity.getActivityId());
							mes.setSendTime(new Date());
							mes.setTitle("銆愮粨鏋滈�鐭ャ�");
							userInfoService.sendSysMessage(mes);*/
							updatePointsDetail(activity.getActivityId(),
									opponentUserIds.get(i), tempPoint, 1);
							mess=new SysMessage();
							mess.setToUserId(opponentUserIds.get(i));
							mess.setActivityId(activity.getActivityId());
							mess.setStatus(2);
							mess.setActivityDesc(activity.getActivityDesc());
							mess.setPoints(tempPoint);
							CustomMsgUtil.sendSystemResultTemplateMsg(mess, msg);
						}
					}
				} else if (status == 2) {
					// 鏀寔鑰呮垚鍔�
					int oppLostNum = 0;
					// 娲诲姩鍙嶅鑰呭け鍘籶oints
					if (opponentUserIds != null && opponentUserIds.size() > 0) {
						for (int i = 0; i < opponentUserIds.size(); i++) {
							/*CustomMsgUtil.sendCustomMsg(opponentUserIds.get(i),
									activity.getActivityRemark()
											+ "寰堟姳姝夛紝浣犻娴嬪け璐ヤ簡锛屼綘鍦ㄦ娲诲姩涓け鍘讳簡" + points
											+ "涓煄姹狅紒");
							mes = new SysMessage();
							mes.setBody(activity.getActivityRemark()
									+ "寰堟姳姝夛紝浣犻娴嬪け璐ヤ簡锛屼綘鍦ㄦ娲诲姩涓け鍘讳簡" + points + "涓煄姹狅紒");
							mes.setFromUserId(activity.getUserId());
							mes.setToUserId(opponentUserIds.get(i));
							mes.setStatus(0);
							mes.setActivityId(activity.getActivityId());
							mes.setSendTime(new Date());
							mes.setTitle("銆愮粨鏋滈�鐭ャ�");
							userInfoService.sendSysMessage(mes);*/
							dNum = userActivityService.getPartiDoubleNum(activity.getActivityId(), opponentUserIds.get(i));
							updatePointsDetail(activity.getActivityId(),
									opponentUserIds.get(i), points * dNum, 0);
							oppLostNum += points * dNum;
							mess=new SysMessage();
							mess.setToUserId(opponentUserIds.get(i));
							mess.setActivityId(activity.getActivityId());
							mess.setStatus(1);
							mess.setActivityDesc(activity.getActivityDesc());
							mess.setPoints(points * dNum);
							CustomMsgUtil.sendSystemResultTemplateMsg(mess, msg);
						}
					}

					// ////////////////
					// 璁＄畻鏀寔鑰呭簲璇ヨ幏寰楃殑鍩庢睜鏁伴噺
					//int totalLose = points * opponentUserIds.size();
					int peroppNum = 0;
					for(int i=0; i<supportUserIds.size(); i++)
					{
						peroppNum += userActivityService.getPartiDoubleNum(activity.getActivityId(), supportUserIds.get(i));
					}
					
					int perPoints = oppLostNum / (peroppNum);
					int yushu = oppLostNum % (peroppNum);

					// 娲诲姩鏀寔鑰呰幏寰楀煄姹犳暟
					for (int i = 0; i < supportUserIds.size(); i++) {
						dNum = userActivityService.getPartiDoubleNum(activity.getActivityId(), supportUserIds.get(i));
						int surPoint = perPoints * dNum;
						if (i < yushu) {
							surPoint += 1;
						}
						/*CustomMsgUtil.sendCustomMsg(supportUserIds.get(i),
								activity.getActivityRemark()
										+ "鎭枩鎮紝浣犻娴嬫纭簡锛屼綘鍦ㄦ娲诲姩涓幏寰椾簡" + surPoint
										+ "涓煄姹狅紒");
						mes = new SysMessage();
						mes.setBody(activity.getActivityRemark()
								+ "鎭枩鎮紝浣犻娴嬫纭簡锛屼綘鍦ㄦ娲诲姩涓幏寰椾簡" + surPoint + "涓煄姹狅紒");
						mes.setFromUserId(activity.getUserId());
						mes.setActivityId(activity.getActivityId());
						mes.setToUserId(supportUserIds.get(i));
						mes.setStatus(0);
						mes.setSendTime(new Date());
						mes.setTitle("銆愮粨鏋滈�鐭ャ�");
						userInfoService.sendSysMessage(mes);*/
						updatePointsDetail(activity.getActivityId(),
								supportUserIds.get(i), surPoint, 1);
						mess=new SysMessage();
						mess.setToUserId(supportUserIds.get(i));
						mess.setActivityId(activity.getActivityId());
						mess.setStatus(status);
						mess.setActivityDesc(activity.getActivityDesc());
						mess.setPoints(surPoint);
						CustomMsgUtil.sendSystemResultTemplateMsg(mess, msg);
					}

				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 鏇存柊鏄庣粏琛�
	private void updatePointsDetail(String actId, String userId, int points,
			int win) {
		UserPoints up = userPointsService.getUserpointsByUserId(userId);
		if (up == null) {
			return;
		}
		int befPoints = up.getAllPoints();
		int aftPoints = 0;
		if (win == 1) {
			aftPoints = befPoints + points;
		} else if (win == 0) {
			aftPoints = befPoints - points;
		}

		// 鏇存柊鎬诲叡鐨刾oints鏁伴噺
		userPointsService.updateTotalPointsByUserId(aftPoints, userId);

		// 鎻掑叆鍒版槑缁嗚〃涓�
		userPointsService.insertPointsTran(actId, userId, befPoints, aftPoints,
				points, win);
	}

	// 瑙ｉ攣
	private void unLockPoints(String userId, int points) {
		UserPoints up = userPointsService.getUserpointsByUserId(userId);
		if (up == null) {
			return;
		}
		userPointsService.updateLockPointsByUserId(up.getLockedPoints()
				- points, userId);
	}

	/*
	 * 涓�敭澶嶅埗鐨勫姛鑳�
	 */
	@At("/onekeycopy")
	public View oneKeyCopy(@Param("code") String code,
			@Param("scope") String scope,
			@Param("activityId") String activityId, HttpServletRequest request,
			HttpServletResponse response) {

		WechatUser wechatUser = null;
		UserPoints userPoints = null;
		try {
			// 鑾峰彇寰俊淇℃伅
			wechatUser = WeChatUserService.getWeixinUser(code);
		} catch (Exception e) {
			e.printStackTrace();
		}
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("wechatUser", wechatUser);
		User user = new User();
		user.setUserId(wechatUser.getOpenId());
		user.setNickName(wechatUser.getNickName());
		user.setMoralRank("1");
		user.setIntegritylRank("5");
		userPoints = userPointsService.getUserpointsByUserId(wechatUser
				.getOpenId());
		data.put("userPoints", userPoints);
		this.challengInfo(user, wechatUser, data, request, response);

		Activity activity;
		try {
			activity = userActivityService.getActivityByActivityId(activityId);
			data.put("defaultAct", activity);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return new ViewWrapper(new JspView("jsp.challengTheme"), data);
	}

	/*
	 * challengInfo method
	 */

	private void challengInfo(User user, WechatUser wechatUser,
			Map<String, Object> data, HttpServletRequest request,
			HttpServletResponse response) {

		try {
			int upperLV = Integer.parseInt(user.getMoralRank());
			String dsbRate = null;
			if (user.getForecastAccuracy() != null) {
				dsbRate = user.getForecastAccuracy();
			} else {
				dsbRate = "";
			}
			data.put("upperLV", upperLV);
			data.put("user", user);
			data.put("dsbRate", dsbRate);
			data.put("wechatUser", wechatUser);
			// weixin JSAPI auth
			String url = URLService.getFullUrl(request);
			Map<String, String> weixinparames = Sign.getSignParams(url,
					App.APP_ID, App.APP_SECRET);
			weixinparames.put("appId", App.APP_ID);
			data.put("weixinparames", weixinparames);
			request.setAttribute("appServer", App.APP_SERVER);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/*
	 * 绯荤粺绠＄悊鍛樼櫥褰曢〉闈�
	 */
	@At("/insertSysAct")
	public View insertSysAct(HttpServletRequest request,
			HttpServletResponse response) {
		String actDesc = request.getParameter("actDesc");
		String actpunish = request.getParameter("actpunish");
		String actdeadline = request.getParameter("actdeadline");
		String partNum = request.getParameter("partNum");
		String publishTime = request.getParameter("publishTime");
		String stackNum = request.getParameter("stackNum");
		String yuanWenUrl = request.getParameter("yuanWenUrl");
		String wailianTitle = request.getParameter("wailianTitle");
		String wailianUrl = request.getParameter("wailianUrl");
		String activitytype=request.getParameter("activitytype");
		System.out.println("打印activity的值："+activitytype);
		String templateId;
		//根据活动类型来获取插入数据库对应的数值，其中2-->股票，1-->热点，3--->财经
		if(activitytype.trim().equals("股票")){
			templateId="2";			
		}else if(activitytype.trim().equals("财经")){
			templateId="3";
		}else{
			templateId="1";
		}

		Activity activity = new Activity();
		String time=CommonUtil.formatDateTimeToYYYYMMDDHHMMSSExt(new Date());
		String activityId = "CTSystemAdmin"+time;
		String userId = "systemadmin";
		String activityType = "2";
		int activityStatus = 0;                                           
		String activityRemark = CommonUtil.getRandEmoji();
		int resultStatus =  0;
		int executeStatus = 0;
		Timestamp createTime = Timestamp.valueOf(CommonUtil.formatDateTimeToYYYYMMDDHHMMSS(new Date()));

		activity.setActivityId(activityId);
		activity.setUserId(userId);
		activity.setAcitvityType(activityType);
		activity.setActivityDesc(actDesc);
		activity.setActivityStake(actpunish);
		activity.setActivityDeadline(Timestamp.valueOf(actdeadline));
		activity.setParticiLimititation(Integer.valueOf(partNum));
		activity.setActivityStatus(activityStatus);
		activity.setActivityRemark(activityRemark);
		activity.setCreateTime(createTime);
		activity.setPublishDate(Timestamp.valueOf(publishTime));
		activity.setResultStatus(resultStatus);
		activity.setExecuteStatus(executeStatus);
		activity.setStakePoints(Integer.parseInt(stackNum));
		activity.setOriginalUrl(yuanWenUrl);
		activity.setTitleBackNews(wailianTitle);
		activity.setImgBackBews(wailianUrl);
		activity.setTypeId(templateId);
		
		sysLoginService.insertAct(activity);
		return new ViewWrapper(new UTF8JsonView(new JsonFormat()), "1");
	}
	
	@At("/getOverdueActivity")
	public View getOverdueActivity(HttpServletRequest request,HttpServletResponse response){
		List<HashMap<String, Object>> data = new ArrayList<HashMap<String, Object>>();
		data = sysLoginService.getOverdueActivity(-7);
		return new ViewWrapper(new UTF8JsonView(new JsonFormat()), data);
	}
	
	@At("/stopOverdueActivity")
	public View stopOverdueActivity(HttpServletRequest request,HttpServletResponse response){
		String actid = request.getParameter("actid");
		try
		{
			Activity activity = userActivityService.getActivityByActivityId(actid);
			List<String> supportUserIds = userActivityService.getUserIdBasedOnActId(actid, "Y");
			List<String> opponentUserIds = userActivityService.getUserIdBasedOnActId(actid, "N");
			int points = activity.getStakePoints();
			
			//瑙ｉ攣娲诲姩鍙戣捣鑰�
			unLockPoints(activity.getUserId(), points);
			
			int dNum = 1;
			if(supportUserIds !=null && supportUserIds.size()>0)
			{
				// 瑙ｉ攣鏀寔鑰�
				for (int i = 0; i < supportUserIds.size(); i++) {
					dNum = userActivityService.getPartiDoubleNum(activity.getActivityId(), supportUserIds.get(i));
					unLockPoints(supportUserIds.get(i), points * dNum);
				}
			}
			
			if(opponentUserIds !=null && opponentUserIds.size()>0)
			{
				// 瑙ｉ攣鍙嶅鑰�
				for (int i = 0; i < opponentUserIds.size(); i++) {
					dNum = userActivityService.getPartiDoubleNum(activity.getActivityId(), opponentUserIds.get(i));
					unLockPoints(opponentUserIds.get(i), points * dNum);
				}
			}
			
			//鏍囪姝ゆ椿鍔�
			userActivityService.saveResultFlag(actid, -1);

		}
		catch(Exception e)
		{
			e.printStackTrace();
			return new ViewWrapper(new UTF8JsonView(new JsonFormat()), 0);
		}
		return new ViewWrapper(new UTF8JsonView(new JsonFormat()), 1);
	}
}
