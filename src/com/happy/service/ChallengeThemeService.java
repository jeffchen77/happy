package com.happy.service;

import com.happy.dao.ChallengeThemeDao;
import com.happy.model.Activity;

public class ChallengeThemeService {
	
	ChallengeThemeDao challengeThemeDao = new ChallengeThemeDao();
	
	//保存挑战内容信息
	public void insertChallengeTheme(Activity activity) throws Exception{
		challengeThemeDao.insertChallengeTheme(activity);
	}
}
