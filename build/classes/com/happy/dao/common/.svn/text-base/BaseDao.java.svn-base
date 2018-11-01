package com.happy.dao.common;

import org.nutz.dao.Dao;
import org.nutz.dao.impl.NutDao;

import com.alibaba.druid.pool.DruidDataSource;
import com.happy.datasource.mysql.DataManager;

public class BaseDao {
	protected Dao dao;
	public BaseDao() {
		DruidDataSource ds = DataManager.getDataSource();
		dao = new NutDao(ds);			
	}
		
}
