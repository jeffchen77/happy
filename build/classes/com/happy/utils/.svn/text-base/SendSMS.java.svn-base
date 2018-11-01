package com.happy.utils;

import com.taobao.api.ApiException;
import com.taobao.api.DefaultTaobaoClient;
import com.taobao.api.TaobaoClient;
import com.taobao.api.request.AlibabaAliqinFcSmsNumSendRequest;
import com.taobao.api.response.AlibabaAliqinFcSmsNumSendResponse;

public class SendSMS {
	
	private static String  url="http://gw.api.taobao.com/router/rest";
	private static String appkey="23344018";
	private static String secret="dd377bc0938f44ee09a1386b7f715886"; 
	private static final String App_Name="朕以为";
	private static final String SMG_Auth="SMS_7456006";
	private static final String Auth_Sign_Nm="活动验证";
	//短信登陆验证
	
	public static void sendAuthCd(String phoneNm,String userId,String code) throws ApiException{
		TaobaoClient client = new DefaultTaobaoClient(url,appkey,secret);
		AlibabaAliqinFcSmsNumSendRequest req = new AlibabaAliqinFcSmsNumSendRequest();
		req.setExtend(userId);
		req.setSmsType("normal");
		req.setSmsFreeSignName(Auth_Sign_Nm);
		req.setSmsParamString("{\"code\":\""+code+"\",\"product\":\""+App_Name+"\"}");
		req.setRecNum(phoneNm);
		req.setSmsTemplateCode(SMG_Auth);
		AlibabaAliqinFcSmsNumSendResponse rsp = client.execute(req);
		System.out.println(rsp.getBody()); 
	}
	//活动结果通知
	/*public static void sendActResult(String phoneNm[],String name,String activityNm, String winner) throws ApiException{
		
			
			String phone=null;
			
			if(phoneNm.length>0&&phoneNm.length<=200){
				phone=phoneNm[0];
					for(int i=1;i<phoneNm.length;i++){
						phone=phone+","+phoneNm[i];
					}
				
					sendInfo(phone,name,activityNm,winner);
						
			}
			else if(phoneNm.length>200){
				int frequency=phoneNm.length/200;
				int index=0;
				for(int a=1;a<=frequency;a++){
					phone=phoneNm[index];
					for(int b=index+1;b<index+200;b++){
						phone=phone+","+phoneNm[b];
					}
					sendInfo(phone,name,activityNm,winner);
					index=a*200;
				}
				if(phoneNm.length%200!=0){
					phone=phoneNm[index];
					for(int c=index+1;c<phoneNm.length;c++){
						phone=phone+","+phoneNm[c];
					}
					
					sendInfo(phone,name,activityNm,winner);
				}
				
			}

	}*/
	
	//发送活动获胜通知
	@SuppressWarnings("unused")
	private static void sendWinnerInfo(String phone,String name,String activityNm, Boolean isSponsor) throws ApiException{
		TaobaoClient client = new DefaultTaobaoClient(url,appkey,secret);
		AlibabaAliqinFcSmsNumSendRequest req = new AlibabaAliqinFcSmsNumSendRequest();
		req.setExtend(name);
		req.setSmsType("normal");
		req.setSmsParamString("{\"name\":\""+name+"\",\"activityNm\":\""+activityNm+"\"}");
		//req.setSmsParamString("{\"name\":\""+name+"\",\"activityNm\":\""+activityNm+"\",\"winner\":\""+winner+"\"}");
		req.setRecNum(phone);
		if(isSponsor){
			req.setSmsTemplateCode("SMS_7750157");	
		}
		else{
			req.setSmsTemplateCode("SMS_7730143");
		}
		AlibabaAliqinFcSmsNumSendResponse rsp = client.execute(req);
		System.out.println(rsp.getBody()); 
		//"13617686298,17092360320"
	}
	//发送活动失败通知
		@SuppressWarnings("unused")
	private static void sendFailInfo(String phone,String name,String activityNm, Boolean isSponsor) throws ApiException{
		TaobaoClient client = new DefaultTaobaoClient(url,appkey,secret);
		AlibabaAliqinFcSmsNumSendRequest req = new AlibabaAliqinFcSmsNumSendRequest();
		req.setExtend(name);
		req.setSmsType("normal");
		req.setSmsParamString("{\"name\":\""+name+"\",\"activityNm\":\""+activityNm+"\"}");
		req.setRecNum(phone);
		if(isSponsor){
			req.setSmsTemplateCode("SMS_7750158");	
		}
		else{
			req.setSmsTemplateCode("SMS_7750156");
		}
		AlibabaAliqinFcSmsNumSendResponse rsp = client.execute(req);
		System.out.println(rsp.getBody()); 
		//"13617686298,17092360320"
	}
}