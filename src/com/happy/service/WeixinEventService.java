package com.happy.service;

import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.happy.utils.MessageUtil;
import com.happy.weixin.model.resp.TextMessage;

public class WeixinEventService {
	public static String processRequest(HttpServletRequest request) {
		String respMessage = null;
		try {
			
			Map<String, String> requestMap = MessageUtil.parseXml(request);
			String msgType = requestMap.get("MsgType");
			// 回复文本消息
			if("text".equalsIgnoreCase(msgType))
			{
				String fromUserName = requestMap.get("FromUserName");
				String toUserName = requestMap.get("ToUserName");
				String content = requestMap.get("Content");
				
				TextMessage textMessage = new TextMessage();
				textMessage.setToUserName(fromUserName);
				textMessage.setFromUserName(toUserName);
				textMessage.setCreateTime(new Date().getTime());
				textMessage.setMsgType(MessageUtil.RESP_MESSAGE_TYPE_TEXT);
				textMessage.setFuncFlag(0);
				
				String respContent = null;
				if("0".equalsIgnoreCase(content))
				{
					respContent="返回图文，功能正在完善中.";
					textMessage.setContent(respContent);
					respMessage = MessageUtil.textMessageToXml(textMessage);
				}
				else if("9".equalsIgnoreCase(content))
				{
					respContent="如有建议，评论，反馈，投诉联系我们，QQ群 168189525 期待与你的相遇， 想听到你的声音！";
					textMessage.setContent(respContent);
					respMessage = MessageUtil.textMessageToXml(textMessage);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return respMessage;
	}
}
