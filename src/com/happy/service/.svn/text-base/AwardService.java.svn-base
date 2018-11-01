package com.happy.service;

import java.util.List;

import org.nutz.dao.Cnd;

import com.happy.dao.ProgramDao;
import com.happy.model.Program;

public class AwardService {

	
	ProgramDao pgmDao = null;
	public AwardService()
	{
		pgmDao = new ProgramDao();
	}
	
	//获取所有奖励活动
		public List<Program> getAllPrograms() throws Exception
		{
			List<Program> pgmList =  pgmDao.getAllPrograms();
			return pgmList;
		}
		
		public Program getProgramById(String pgmid)throws Exception{
			return pgmDao.getProgramById(pgmid);
		}
	
}
