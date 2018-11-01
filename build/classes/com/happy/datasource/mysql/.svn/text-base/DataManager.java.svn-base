package com.happy.datasource.mysql;

import com.alibaba.druid.pool.DruidDataSource;
import com.happy.conf.ConfFactory;
/**
 * 连接数据库
 * @author fei
 *
 */
public class DataManager {
	/** 数据库驱动地址*/
	public static final String DriverClassName = "com.mysql.jdbc.Driver";
	/** 数据库地址*/
//	public static String Url = ConfFactory.getConf().get("jdbcUrl","jdbc:mysql://115.28.165.184:3306/happy");
//	public static String Username = ConfFactory.getConf().get("jdbc.username","happy");
//	public static String Password = ConfFactory.getConf().get("jdbc.password","qiniuno.1");
	public static String Url = ConfFactory.getConf().get("jdbcUrl","jdbc:mysql://16.187.105.52:3306/happy");
	public static String Username = ConfFactory.getConf().get("jdbc.username","root");
	public static String Password = ConfFactory.getConf().get("jdbc.password","123456");
	
	public static DruidDataSource ds = null;
	    
	public static String getUrl() {
		return Url;
	}
	/**
	 * 数据库驱动
	 */
	public static DruidDataSource getDataSource(){
		if(ds == null) {
			ds = new DruidDataSource();
			ds.setDriverClassName(DriverClassName);
			ds.setUrl(Url);
			ds.setTestOnBorrow(false);
			ds.setUsername(Username);
			ds.setPassword(Password);
			ds.setTestWhileIdle(true);
		}
		return ds;
	}
}
