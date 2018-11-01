package com.happy.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.nutz.dao.Cnd;
import org.nutz.dao.Sqls;
import org.nutz.dao.sql.Criteria;
import org.nutz.dao.sql.Sql;
import org.nutz.dao.sql.SqlCallback;

import com.happy.dao.common.BaseDao;
import com.happy.model.BillDetail;
import com.happy.model.Goods;

public class PointsShopDao extends BaseDao {
	/*
	 * 此方法用于返回所有可兑换的商品
	 */
	public List<Map> getAllGoods(int hot) {
		Sql sql = Sqls
				.queryRecord("select id, good_name, good_desc, img_url, point_price, price, amount from goods where hot_good = "+hot+" order by point_price");
		sql.setCallback(new SqlCallback() {
			public Object invoke(Connection conn, ResultSet rs, Sql sql)
					throws SQLException {
				List<Map> list = new LinkedList<Map>();
				while (rs.next()) {
					Map<String, Object> temp = new HashMap<String, Object>();
					temp.put("id", rs.getInt("id"));
					temp.put("good_name", rs.getString("good_name"));
					temp.put("good_desc", rs.getString("good_desc"));
					temp.put("img_url", rs.getString("img_url"));
					temp.put("point_price", rs.getInt("point_price"));
					temp.put("price", rs.getInt("price"));
					temp.put("amount", rs.getInt("amount"));
					list.add(temp);
				}
				return list;
			}
		});
		dao.execute(sql);
		return sql.getList(Map.class);
	}

	/*
	 * 此方法用于返回某个商品
	 */
	public Goods getGoodsById(int goodId) {
		Goods good = null;
		Criteria cir = Cnd.cri();
		if (goodId>=0) {
			cir.where().andEquals("id", goodId);
			good = dao.fetch(Goods.class, cir);
		}
		return good;
	}
	
	/*
	 * 此方法用于插入订单
	 */
	public void insertBillDetail(BillDetail bd) {
		dao.insert(bd);
	}
	
	/*
	 * 此方法用于返回某个用户的所以交易记录
	 * */
	public List<BillDetail> getBillDetail(String usrId)
	{
		String sql = "bill_usrid='"+usrId+"' order by create_time desc";
		List<BillDetail> lbs = dao.query(BillDetail.class, Cnd.wrap(sql));
		
		if(lbs!=null && lbs.size()>0)
		{
			for(int i=0; i < lbs.size(); i++)
			{
				BillDetail bd = lbs.get(i);
				if(bd!=null)
				{
					dao.fetchLinks(bd, "good");
				}
				
				String ts = bd.getCreateTime().toString();
				ts = ts.substring(0, ts.length()-2);
				bd.setFomatTime(ts);
			}
		}
		return lbs;
	}
	
	/*
	 * 此方法用于返回某个商品已经被领取的个数
	 * */
	public int getUsedGoodCount(int goodId)
	{	
		return dao.count(BillDetail.class, Cnd.where("good_id", "=", goodId));
	}
}
