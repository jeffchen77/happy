package com.happy.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.dao.Sqls;
import org.nutz.dao.impl.NutDao;
import org.nutz.dao.sql.Criteria;
import org.nutz.dao.sql.Sql;
import org.nutz.dao.sql.SqlCallback;

import com.alibaba.druid.pool.DruidDataSource;
import com.happy.dao.common.BaseDao;
import com.happy.datasource.mysql.DataManager;
import com.happy.model.SysMessage;
import com.happy.model.User;
import com.happy.model.WechatUser;
import com.happy.utils.CommonUtil;

public class MessageDao extends BaseDao{
	
	protected Log LOG = LogFactory.getLog(this.getClass());
	
	public SysMessage getSysTip(String userId,String tipId)throws Exception{
		SysMessage mess = null;
		Criteria cir = Cnd.cri();
		if(CommonUtil.notEmpty(userId) && CommonUtil.notEmpty(tipId)){
			cir.where().andEquals("from_user_id", userId).andEquals("activity_id", tipId);
			mess = dao.fetch(SysMessage.class, cir);
		}					
		return mess;
	}
	//获取用户的系统信息
			public List<SysMessage> getSysMessageById(String userId,String status) 
			{
				
				Sql sql = null;
				if(status == null)
				{
					sql = Sqls.create(
							"select s.from_user_id, s.body, s.send_time,s.status, s.to_user_id,s.title from sys_message s  where"
							+ " s.to_user_id='"+userId+"' Order By s.send_time Desc");
				}
				else
				{
					sql = Sqls.create(
							"select s.from_user_id, s.body, s.send_time, s.status, s.to_user_id,s.title from sys_message s  where"
							+ " s.to_user_id='"+userId+"' and s.status='"+status+"' Order By s.send_time Desc");
				}
						
				LOG.debug("sys message sql="+sql.getSourceSql());
				sql.setCallback(new SqlCallback() {
					@Override
			        public Object invoke(Connection conn, ResultSet rs, Sql sql) throws SQLException {
			            List<SysMessage> list = new LinkedList<SysMessage>();
			            while (rs.next())
			            {
			            	SysMessage mes = new SysMessage();
			            	mes.setBody(rs.getString("body"));
			            	
			            	mes.setSendTime(rs.getDate("send_time"));
			            	mes.setFromUserId(rs.getString("from_user_id"));
			            	mes.setStatus(rs.getInt("status"));
			            	mes.setToUserId(rs.getString("to_user_id"));
			            	mes.setTitle(rs.getString("title")); 
			                list.add(mes);
			            }
			            return list;
			            
			        }			
			    });
			    dao.execute(sql);
			    return sql.getList(SysMessage.class);
			}
	//发送系统信息	
		public String sendSysMessage(SysMessage mes)throws Exception
		{
			dao.insert(mes);
			return "SUCCESS";
		}	
	//更新用户系统信息
		public String readUserSysMes(Integer messageId,String userId)
		{
			Sql sql = Sqls.create("UPDATE sys_message SET status=@status $condition");
			sql.params().set("status", true);
			sql.setCondition(Cnd.wrap(" where to_user_id = '" + userId +"'" ));
			dao.execute(sql);
			return "";
		}
		
}
