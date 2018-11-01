package com.happy.utils;

import java.security.MessageDigest;
import java.util.Arrays;

/**
 * 请求校验工具类
 * @author Administrator
 *
 */
public class SignUtil {
	
	/** 微信公众开发平台中Token定义内容*/
	public static final String WEIXIN_TOKEN = "qiniugongzuoshi";
	
	/**
	 * 校验签名
	 * @param signature 微信加密签名，signature结合了开发者填写的token参数和请求中的timestamp参数、nonce参数
	 * @param timestamp 时间戳
	 * @param nonce 随机数
	 * @return
	 */
	public static boolean checkSignature(String signature, String timestamp, String nonce){
		String[] array = new String[]{WEIXIN_TOKEN, timestamp, nonce};
		//将token,timestamp,nonce进行字典序排序
		try{
			Arrays.sort(array);
		}catch(Exception e){
			return false;
		}
		StringBuffer sb = new StringBuffer();
		for(int i=0; i<array.length; i++){
			sb.append(array[i]);
		}
		MessageDigest md = null;
		String tempStr = null;
		try{
			md = MessageDigest.getInstance("SHA-1");
			//将token,timestamp,nonce三个参数字符串拼接成一个字符串进行sha1加密
			byte[] digest = md.digest(sb.toString().getBytes());
			tempStr = byteToString(digest);
		}catch(Exception e){
			e.printStackTrace();
		}
		sb = null;
		//将sha1加密后的字符串可与signature对比，标识该请求来源于微信
		return tempStr != null ?tempStr.equals(signature.toUpperCase()):false;
	}
	
	/**
	 * 将字节数组转化为十六进制字符串
	 * @param byteArray 字节数组
	 * @return String
	 */
	private static String byteToString(byte[] byteArray){
		String strDigest = "";
		for(int i=0; i<byteArray.length; i++){
			strDigest += byteToHexString(byteArray[i]);
		}
		return strDigest;
	}
	
	/**
	 * 将字节转化为十六进制字符串
	 * @param singleByte 单字节
	 * @return String
	 */
	private static String byteToHexString(byte singleByte){
		char[] digest = {'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'};
		char[] tempArray = new char[2];
		tempArray[0] = digest[(singleByte >>> 4) & 0X0F];
		tempArray[1] = digest[singleByte & 0X0F];
		String s = new String(tempArray);
		return s;
	}
}
