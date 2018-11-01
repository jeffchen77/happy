package com.happy.filter;

import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.nutz.mvc.ActionContext;
import org.nutz.mvc.ActionFilter;
import org.nutz.mvc.View;
/**
 * 过滤器登陆验证
 * @author hsh
 *
 */
public class LogFilter implements ActionFilter {
    private static Log log = LogFactory.getLog(LogFilter.class);
    public LogFilter() {}
    
	/**
	 * 登陆验证
	 * 只拦截filterPackage
	 */
	@Override
	public View match(ActionContext actionContext) {
	    HttpServletRequest request = actionContext.getRequest();
	    
	    Map<String,String[]> parametersMap = request.getParameterMap();
	    StringBuffer paramString = null;
        if(!parametersMap.isEmpty()){
            paramString = new StringBuffer(" params:");
            Set<String> paramSet = parametersMap.keySet();
            for(String key:paramSet){
                String[] valueString = parametersMap.get(key);
                for(String value:valueString){
                    if(!"".equals(value)){
                        paramString.append(key+":"+value);  
                        paramString.append("|");
                    }
                }
            }
            paramString.deleteCharAt(paramString.length()-1);
            log.info("the request info : " + "method-->" + actionContext.getMethod().toString() + " form--> " + paramString.toString());
        }
	    return null;
	}
}
