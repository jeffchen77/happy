package com.happy.utils;

import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.security.SecureRandom;
import java.text.DateFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.happy.weixin.app.App;

public class CommonUtil {
	
	public static boolean isEmpty(String str) {
		return (str == null) || (str.equals("")) || (str.equals("null")) || str.equals(" ") || str.equals("　");
	}

	public static boolean notEmpty(String str) {
		return (str != null && !str.equals("") && !str.equals("null") && !str.equals(" ") && !str.equals("　"));
	}
	/**
	 * Checks if specified link is full URL.
	 * 
	 * @param link
	 * @return True, if full URl, false otherwise.
	 */
	public static boolean isFullUrl(String link) {
		if (link == null) {
			return false;
		}
		link = link.trim().toLowerCase();
		return link.startsWith("http://") || link.startsWith("https://") || link.startsWith("file://");
	}
	
	public static String makeUrl(String pageUrl, String path) {
		try {
			URL base = new URL(pageUrl);
			StringBuilder sb = new StringBuilder();
			sb.append(base.getProtocol());
			sb.append("://");
			sb.append(base.getHost());
			if(base.getPort() != 80 && base.getPort() > 0) sb.append(":" + base.getPort());
			if(path.charAt(0) != '/') sb.append('/');
			sb.append(path);
			return sb.toString();
		} catch (Exception e) {
		}
		
		return "";
	}
	
	/**
	 * 考虑各种链接格式，构造正确的url地址
	 * @param pageUrl 当前页url地址
	 * @param link 链接属性 
	 * @author liupf@buge.cn
	 */
	public static String fullUrl(String pageUrl, String link) {
		if (link == null)
			return "";
		
		if (!isFullUrl(pageUrl)) {  //保证当前页链接是以http://开始
			pageUrl = "http://" + pageUrl;
		}
		
		if (isFullUrl(link)) { //link本来就是绝对地址
			return link;
		} else if (link != null && link.startsWith("?")) { //link是查询参数，"?name=lpf"
			int qindex = pageUrl.indexOf('?');
			if (qindex < 0) {  //pageUrl=http://www.test.com/user，返回"http://www.test.com/use?name=lpf"
				return pageUrl + link;
			} else {           //pageUrl=http://www.test.com/user?name=one，返回"http://www.test.com/use?name=lpf"
				return pageUrl.substring(0, qindex) + link;
			}
		} else if(link.startsWith("/")) { //link是从根目录开始的地址
			return makeUrl(pageUrl, link);
		} else if(link.startsWith("./")) { //link是从"./"开始的地址
			int lastSlashIndex = pageUrl.lastIndexOf('/');
			if(lastSlashIndex > 8) {
				return pageUrl.substring(0, lastSlashIndex) + link.substring(1);
			} else {
				return pageUrl + link.substring(1);
			}
		} else if(link.startsWith("../")) { //link是从"../"开始的地址，回退一级
			return makeAssembleUrl(pageUrl, link);
		} else {
			int lastSlashIndex = pageUrl.lastIndexOf('/');
			if(lastSlashIndex > 8) {
				return pageUrl.substring(0, lastSlashIndex) + "/" + link;
			} else {
				return pageUrl + "/" + link;
			}
		}
	}
	private static String makeAssembleUrl(String base, String multiOmission) {
		String OMISSION = "../";
		String relative = multiOmission;
		while(relative.startsWith(OMISSION)) {
			base = getParentUrl(base);
			relative = relative.substring(OMISSION.length());
		}
		return base + relative;
	}
	private static String getParentUrl(String url) {
		int lastSlashIndex = url.lastIndexOf('/');
		String rest = url.substring(0, lastSlashIndex);
		lastSlashIndex = rest.lastIndexOf('/');
		if(lastSlashIndex > 8) {
			return url.substring(0, lastSlashIndex+1);
		} else {
			return url + "/";
		}
	}
	
	public static boolean isMobile(String mobile) {
        Pattern pattern = Pattern.compile("1[3-5|8]\\d{9}");
        Matcher matcher = pattern.matcher(mobile);
        return matcher.matches();
    }
	
	public static boolean isEmail(String email) {
        Pattern pattern = Pattern.compile("^([a-zA-Z0-9]*[-_]?[a-zA-Z0-9]+)*@([a-zA-Z0-9]*[-_]?[a-zA-Z0-9]+)+[\\.][A-Za-z]{2,3}([\\.][A-Za-z]{2})?$");
        Matcher matcher = pattern.matcher(email);
        return matcher.matches();
    }
	
	public static boolean isMobileOrTel(String mobile) {
        if (mobile.startsWith("13") || mobile.startsWith("15") || mobile.startsWith("18"))
            return isMobile(mobile);
        Pattern pattern = Pattern.compile("(\\d{3,4}[-_－—]?)?\\d{7,8}([-_－—]?\\d{1,7})?");
        Matcher matcher = pattern.matcher(mobile);
        return matcher.matches();
    }
	public static String trim(String source) {
		if(null == source) return "";
		
		int start=0, end=source.length()-1;
		for(int i=0; i<source.length(); i++) {
			int code = source.charAt(i);
			if (code != ' ' && code != '　' && code != '\n' && code != '\r' && code != '\t') {
				start = i;
				break;
			}
		}
		
		for(int i=source.length()-1; i>=0; i--) {
			int code = source.charAt(i);
			if (code != ' ' && code != '　' && code != '\n' && code != '\r' && code != '\t' && code != 160) {
				end = i+1;
				break;
			}
		}
		
		if (start < end) {
			return source.substring(start, end);
		} else {
			return source;
		}
	}
	/**
	 * 提取原始字符串nodeValue中prefix以后的子串
	 * 
	 * @param nodeValue
	 * @param prefix
	 * @return
	 */
	public static String stripAfter(String nodeValue, String prefix) {
		if (isEmpty(nodeValue))
			return "";

		String tmp = nodeValue.trim();
		int begin = 0;
		if (!isEmpty(prefix)) {
			int index = tmp.indexOf(prefix);
			if (index >= 0) {
				begin = index + prefix.length();
				return trim(tmp.substring(begin).trim());
			}
		}

		return trim(tmp);
	}
	/**
	 * 提取原始字符串nodeValue中suffix以前的子串
	 * 
	 * @param nodeValue
	 * @param prefix
	 * @return
	 */
	public static String stripBefore(String nodeValue, String suffix) {
		if (isEmpty(nodeValue))
			return "";

		String tmp = nodeValue.trim();
		int end = tmp.length();
		if (!isEmpty(suffix)) {
			int index = tmp.indexOf(suffix);
			if (index >= 0) {
				end = index;
				return trim(tmp.substring(0, end).trim());
			}
		}

		return trim(nodeValue);
	}
	/**
	 * 切分空格字符串
	 * 
	 * @return
	 */
	public static String[] splitBlankStr(String source) {
		if (isEmpty(source))
			return null;
		if (source.indexOf("　") >= 0)
			source = source.replace("　", " ");
		source = trim(source);
		return source.split(" ");
	}
	
	/**
	 * 在字符串nodeValue中找"prefix"以后，"suffix"以前的字符串<br/>
	 * 如果prefix为空，则找end以前的字符串；如果suffix为空，则找before以后的字符串
	 * 
	 * @param nodeValue
	 * @param prefix
	 * @param suffix
	 * @return
	 */
	public static String strip(String nodeValue, String prefix, String suffix) {
		if (isEmpty(nodeValue))
			return "";

		String tmp = nodeValue.trim();
		int begin = 0;
		int end = tmp.length();

		if (!isEmpty(prefix)) {
			int index = tmp.indexOf(prefix);
			if (index >= 0)
				begin = index + prefix.length();
			else
				return ""; // 不包含前缀
		}

		if (!isEmpty(suffix)) {
			int index = tmp.indexOf(suffix, begin);
			if (index > 0)
				end = index;
			else
				return ""; // 不包含后缀
		}

		return trim(end > begin ? tmp.substring(begin, end).trim() : tmp);
	}
	
	/**
	 * 截取字符串，从开始索引到结束索引
	 * @param nodeValue 字符串
	 * @param start 开始索引
	 * @param end 结束索引
	 * @param length 所需要限制长度
	 * @return
	 */
	public static String subStrip(String nodeValue, int start, int end){
		if(isEmpty(nodeValue)){
			return "";
		}else{
			if(nodeValue.length() > end){
				return nodeValue.substring(start, end);
			}else{
				return nodeValue;
			}
		}
	}
	
	public static String encodeUTF8(String text){
		if(notEmpty(text)){
			try {
				return URLEncoder.encode(text, "utf-8");
			} catch (UnsupportedEncodingException e) {
				return "";
			}
		}else{
			return "";
		}
	}
	
	public static String decodeUTF8(String text){
		if(notEmpty(text)){
			try {
				return URLDecoder.decode(text, "utf-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		}
		return ""; 
	}
	
	/**
	 * 根据类型，推算时间
	 * 
	 * @param type
	 *            0:天数，1:月数
	 * @param number
	 *            数量
	 * @param asc
	 *            升序
	 * @param now
	 *            当前时间
	 * @return
	 */
	public static Date getNeedDate(int type, int number, boolean asc, Date now) {
		Date fromDate = null;
		Calendar cal = Calendar.getInstance();
		cal.setTime(now);
		cal.set(Calendar.HOUR_OF_DAY, 0);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.SECOND, 0);
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH);
		int date = cal.get(Calendar.DATE);
		if (asc) {
			if (type == 0) {
				date = date + number + 1;
			} else if (type == 1) {
				month = month + number;
			}
		} else {
			if (type == 0) {
				date = date - number - 1;

			} else if (type == 1) {
				month = month + number;
			}
		}
		cal.set(year, month, date);
		fromDate = cal.getTime();
		return fromDate;
	}
	
	/**
	 * 判断字符串是否是A~Z中的一个
	 * @param str
	 * @return true:是字母 false:不是字母
	 */
	public static boolean isChar(String str) {
		if (str.length() == 1 && str.charAt(0) >= 'A' && str.charAt(0) <= 'Z') {
			return true;
		} else {
			return false;
		}
	}
	
	/**
	 * 正则匹配获取字符串
	 * @param source 来源
	 * @param regex 正则
	 * @return String
	 */
	public static String regexText(String source, String regex) {
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(source);
		boolean b = matcher.find();
		if (b) {
			return matcher.group();
		}
		return null;
	}
	
	public static String regexText(String source, String regex, int group) {
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(source);
		boolean b = matcher.find();
		if (b) {
			return matcher.group(group);
		}
		return null;
	}
	
	/**
	 * 清空特殊符号
	 * @param text 字符串
	 * @return String
	 */
	public static String clearFuHao(String text){
		if(CommonUtil.notEmpty(text)){
			String regex = "[`~!@#$%^&*()+=|{}':;',\\[\\].<>/?~！@#￥%……&*（）——+|{}【】‘；：”“’。，、？]";
			Pattern p = Pattern.compile(regex);     
	        Matcher m = p.matcher(text);     
	        return m.replaceAll("").trim();
		}
		return "";
	}
	
	/**
	 * 文本字符串是否纯数字
	 * @param text 字符串
	 * @return Boolean
	 */
	public static boolean isNumber(String text){
		if(CommonUtil.notEmpty(text)){
			return text.matches("[0-9]+");
		}
		return false;
	}
	
	/**
	 * 文本字符串是否纯英文
	 * @param text 字符串
	 * @return Boolean
	 */
	public static boolean isAlpha(String text){
		if(CommonUtil.notEmpty(text)){
			return text.matches("[a-zA-Z]+");
		}
		return false;
	}
	
	/**
	 * 文本字符串是否纯数字+字母+符号
	 * @param text 字符串
	 * @return Boolean
	 */
	public static boolean isNumberAndAlpha(String text){
		if(CommonUtil.notEmpty(text)){
			return text.matches("[\\w]+");
		}
		return false;
	}
	
	/**
	 * 文本字符是否纯中文
	 * @param text 字符串
	 * @return Boolean
	 */
	public static boolean isChinese(String text){
		if(CommonUtil.notEmpty(text)){
			return text.matches("[\u4e00-\u9fa5]+");
		}
		return false;
	}

	/**
	 * 切分关键词字符串为字符串集合
	 * @param keyword 关键词文本
	 * @return String[]
	 */
	public static String[] splitKeyword(String keyword){
		if(CommonUtil.notEmpty(keyword)){
			return keyword.split(",|，| |　|\\s");
		}
		return null;
	}
	
	/**
	 * 格式化double类型的值，去除结尾".0"
	 * @param value
	 * @return
	 */
	public static String formatDoubleAsInt(Double value){
		if(null == value) return "0";
		NumberFormat nf = NumberFormat.getInstance();
		nf.setGroupingUsed(false);
		String str = String.valueOf(nf.format(value));
		if(str.endsWith(".0")) str = str.substring(0, str.indexOf(".0"));
		return str;
	}
	
	/**
	 * 格式化float类型的值，去除结尾".0"
	 * @param value
	 * @return
	 */
	public static String formatFloatAsInt(Float value){
		if(null == value) return "0";
		NumberFormat nf = NumberFormat.getInstance();
		nf.setGroupingUsed(false);
		String str = String.valueOf(nf.format(value));
		if(str.endsWith(".0")) str = str.substring(0, str.indexOf(".0"));
		return str;
	}
	
	/**
	 * 格式化double类型的值，等于0时设置为空字符串
	 * @param value
	 * @return
	 */
	public static String formatDoubleAsString(Double value){
		if(null == value) return "";
		String str = formatDoubleAsInt(value);
		if(str.equals("0")) return "";
		else return str;
	}
	
	/**
	 * 格式化int类型值，等于0时设置为空字符串
	 * @param value
	 * @return
	 */
	public static String formatIntAsString(Integer value){
		if(null == value) return "";
		if(0 == value) return "";
		else return String.valueOf(value);
	}
	
	/***
	 *格式化时间 为“yyyy-MM-dd HH:mm”
	 */
	
	public static String formatDateTimeToYYYYMMDDHHMM( Date date){
		DateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm");
		String formatDateTime =  format.format(date);
		return formatDateTime;
	}
	
	/***
	 *格式化时间 为“yyyy-MM-dd HH:mm:ss”
	 */
	
	public static String formatDateTimeToYYYYMMDDHHMMSS( Date date){
		DateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String formatDateTime =  format.format(date);
		return formatDateTime;
	}
	
	/***
	 *格式化时间 为“yyyyMMddHHmmss”
	 */
	
	public static String formatDateTimeToYYYYMMDDHHMMSSExt( Date date){
		DateFormat format=new SimpleDateFormat("yyyyMMddHHmmss");
		String formatDateTime =  format.format(date);
		return formatDateTime;
	}
	
	private static char[] ca = new char[] { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
	     'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' };
	private static char[] num = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'};
	
	//随机生成n位的字母
	public static String randStr(int n) {
       char[] cr = new char[n];
       SecureRandom random = new SecureRandom();
       random.setSeed(System.nanoTime());
       for (int i = 0; i < n; i++) {
           int x = (int) random.nextLong() % 26;
           if (x < 0)
               x = -x;
           cr[i] = ca[x];
       }
       return (new String(cr));
   }
	
	//随机生成n位的数字
	public static String randNum(int n) {
       char[] cr = new char[n];
       SecureRandom random = new SecureRandom();
       random.setSeed(System.nanoTime());
       for (int i = 0; i < n; i++) {
           int x = (int) random.nextLong() % 10;
           if (x < 0)
               x = -x;
           cr[i] = num[x];
       }
       return (new String(cr));
   }
	
	//随机生成微信表情图标
	public static String getRandEmoji() {
	       SecureRandom random = new SecureRandom();
	       random.setSeed(System.nanoTime());	       
	       int x = (int) random.nextLong() % App.APP_EMOJI_LIST.length;
           if (x < 0) x = -x;
	       return  App.APP_EMOJI_LIST[x];
	   }
	
	//随机生成支持语句
	public static String getSupportComments() {
	       SecureRandom random = new SecureRandom();
	       random.setSeed(System.nanoTime());	       
	       int x = (int) random.nextLong() % App.APP_SUPPORT_LIST.length;
           if (x < 0) x = -x;
	       return  App.APP_SUPPORT_LIST[x];
	   }
	
	//随机生成反对语句
	public static String getAgainstComments() {
	       SecureRandom random = new SecureRandom();
	       random.setSeed(System.nanoTime());	       
	       int x = (int) random.nextLong() % App.APP_AGAINST_LIST.length;
           if (x < 0) x = -x;
	       return  App.APP_AGAINST_LIST[x];
	   }
	/**
	 * @param args
	 */
	public static void main(String[] args) {

		try 
		{
//			Timestamp ts=new Timestamp(new Date().getTime());
//			System.out.println(CommonUtil.formatDateTimeToYYYYMMDDHHMM(ts));
			Map mp1= new HashMap();
			mp1.put("actid", "2");
			mp1.put("actdesc", "22eerewrwe");
			mp1.put("comid", "c2");
			mp1.put("comment", "c2ererew");
			Map mp2= new HashMap();
			mp2.put("actid", "3");
			mp2.put("actdesc", "3eerewrwe");
			mp2.put("comid", "c3");
			mp2.put("comment", "c3ererew");
			Map mp3= new HashMap();
			mp3.put("actid", "2");
			mp3.put("actdesc", "22eerewrwe");
			mp3.put("comid", "c22222");
			mp3.put("comment", "c2222ererew");
			Map mp4= new HashMap();
			mp4.put("actid", "1");
			mp4.put("actdesc", "11eerewrwe");
			mp4.put("comid", "c1");
			mp4.put("comment", "c1ererew");
			Map mp5= new HashMap();
			mp5.put("actid", "1");
			mp5.put("actdesc", "11eerewrwe");
			mp5.put("comid", "c11111");
			mp5.put("comment", "c11111111ererew");
			List ls= new ArrayList();
			ls.add(mp1);ls.add(mp2);ls.add(mp3);ls.add(mp4);ls.add(mp5);
			List ls1= new ArrayList();
			ls1.add(mp1);ls1.add(mp2);ls1.add(mp3);ls1.add(mp4);ls1.add(mp5);
			
			List list=new ArrayList();
			List list1=new ArrayList();
			for(int i=0;i<ls.size();i++)
			{
				List list2=new ArrayList();
				Map mp=(Map)ls.get(i);
				String actid=(String)mp.get("actid");
				list2.add(mp);					
				if(!list1.contains(i)){
				list1.add(i);
				
				for(int j=0;j<ls.size();j++)
				{
					if(i!=j){
					Map mpp=(Map)ls.get(j);
					String actid1=(String)mpp.get("actid");
					if(actid.equals(actid1)){
						list2.add(mpp);
						list1.add(j);
					}}
				}
				System.out.println("list2 commentid:"+list2);
				list.add(list2);
				System.out.println("list commentid:"+list);
				}		
				
				
			}
			
			System.out.println("list size:"+list.size());
			for(int m=0;m<list.size();m++)
			{
//				System.out.println("list size:"+list.size());
				List list3=(List)list.get(m);
				
				System.out.println("mpp commentid:"+list3);
			}
			
		} 
		catch (Exception e)
		{
			e.printStackTrace();
		}
	}
}
