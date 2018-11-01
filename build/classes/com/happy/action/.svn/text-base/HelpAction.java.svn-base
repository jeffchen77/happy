package com.happy.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.nutz.mvc.View;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Param;
import org.nutz.mvc.view.JspView;
import org.nutz.mvc.view.ViewWrapper;

public class HelpAction {
	private static Logger log = LogManager.getLogger(HelpAction.class);
	
	/*
	 *  跳到系统帮助文档
	 */
	@At("/toHelp")
	public View helpIndex(@Param("userId") String userId, @Param("status") String status,
			HttpServletRequest request,HttpServletResponse response) throws Exception
	{
			//直接返回静态系统帮助文档
			 return new ViewWrapper(new JspView("jsp.Help"),"");	
	}	
}
