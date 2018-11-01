package com.happy.dao;

import com.happy.dao.common.BaseDao;
import com.happy.model.Activity;

public class ChallengeThemeDao extends BaseDao{

	
	public void insertChallengeTheme(Activity activity) throws Exception{

		dao.insert(activity);
	}
}
