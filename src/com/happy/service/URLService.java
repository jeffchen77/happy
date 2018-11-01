package com.happy.service;

import javax.servlet.http.HttpServletRequest;

public class URLService {
	public static String getFullUrl(HttpServletRequest request) {
		// java 获取请求 URL
		String url = request.getScheme() + "://"; // 请求协议 http 或 https
		url += request.getHeader("host"); // 请求服务器
		url += request.getRequestURI(); // 工程名
		if (request.getQueryString() != null) // 判断请求参数是否为空
			url += "?" + request.getQueryString(); // 参数
		System.out.println(url);
		return url;
	}
}
