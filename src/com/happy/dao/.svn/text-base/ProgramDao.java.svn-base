package com.happy.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.nutz.dao.Chain;
import org.nutz.dao.Cnd;
import org.nutz.dao.Sqls;
import org.nutz.dao.sql.Criteria;
import org.nutz.dao.sql.Sql;
import org.nutz.dao.sql.SqlCallback;

import com.happy.dao.common.BaseDao;
import com.happy.model.Program;

public class ProgramDao extends BaseDao {
	protected Log LOG = LogFactory.getLog(this.getClass());
		//根据条件查询活动
		public List<Program> getAllPrograms()throws Exception{
			
			Sql sql = null;
			sql = Sqls.create(
					"select p.pgm_id, p.pgm_title, p.pgm_desc,p.begin_time, p.end_time,p.pgm_points from program p  where"
					+ " p.begin_time<=CURRENT_TIMESTAMP() Order By p.begin_time Desc");
					
			LOG.debug("sys message sql="+sql.getSourceSql());
			sql.setCallback(new SqlCallback() {
				@Override
		        public Object invoke(Connection conn, ResultSet rs, Sql sql) throws SQLException {
		            List<Program> list = new LinkedList<Program>();
		            while (rs.next())
		            {
		            	Program pgm = new Program();
		            	pgm.setPgmId(rs.getString("pgm_id"));
		            	pgm.setPgmTitle(rs.getString("pgm_title"));
		            	pgm.setPgmDesc(rs.getString("pgm_desc"));
		            	pgm.setBeginTime(rs.getTimestamp("begin_time"));
		            	pgm.setEndTime(rs.getTimestamp("end_time"));
		            	pgm.setPgmPoints(rs.getInt("pgm_points"));
		                list.add(pgm);
		            }
		            return list;
		            
		        }			
		    });
		    dao.execute(sql);
		    return sql.getList(Program.class);
		}
		
		//根据条件查询活动
		public Program getProgramById(String pgmid)throws Exception{
			String sql = "begin_time<=CURRENT_TIMESTAMP() and pgm_id='"+pgmid+"'";
			Program pg = dao.fetch(Program.class, Cnd.wrap(sql));
			return pg;
		}

}
