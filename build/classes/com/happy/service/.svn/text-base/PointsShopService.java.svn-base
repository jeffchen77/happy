package com.happy.service;

import java.util.List;
import java.util.Map;

import com.happy.dao.PointsShopDao;
import com.happy.dao.UserPointsDao;
import com.happy.model.BillDetail;
import com.happy.model.Goods;
import com.happy.model.UserPoints;

public class PointsShopService {
	private PointsShopDao pointsShopDao = new PointsShopDao();
	private UserPointsDao userPointsDao = new UserPointsDao();
	/*
	 * 此方法用于返回所有可兑换的商品
	 * */
	public List<Map> getAllGoods(int hot)
	{
		return pointsShopDao.getAllGoods(hot);
	}
	
	/*
	 * 此方法用于返回某个商品
	 * */
	public Goods getGoodsById(int goodId)
	{
		return pointsShopDao.getGoodsById(goodId);
	}
	
	/*
	 * 此方法用于减掉城池
	 * */
	public void minusPoint(UserPoints pointObj, int points, String userId) throws Exception
	{
		if(pointObj == null)
		{
			throw new Exception();
		}
		
		int allPoint = pointObj.getAllPoints();
		int stillPoint = allPoint - points;
		userPointsDao.updateTotalPointsByUserId(stillPoint, userId);
	}
	
	/*
	 * 此方法用于插入订单表
	 * */
	public void insertBillDetail(BillDetail bd)
	{
		pointsShopDao.insertBillDetail(bd);
	}
	
	/*
	 * 此方法用于返回某个用户的所以交易记录
	 * */
	public List<BillDetail> getBillDetail(String usrId)
	{
		return pointsShopDao.getBillDetail(usrId);
	}
	
	/*
	 * 此方法用于返回某个商品已经被领取的个数
	 * */
	public int getUsedGoodCount(int goodId)
	{
		return pointsShopDao.getUsedGoodCount(goodId);
	}
}
