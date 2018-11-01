package com.happy.action;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.nutz.json.JsonFormat;
import org.nutz.mvc.View;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Param;
import org.nutz.mvc.view.JspView;
import org.nutz.mvc.view.UTF8JsonView;
import org.nutz.mvc.view.ViewWrapper;

import com.happy.model.BillDetail;
import com.happy.model.Goods;
import com.happy.model.UserPoints;
import com.happy.service.PointsShopService;
import com.happy.service.UserPointsService;
import com.happy.utils.CommonUtil;

public class PointsShopAction {

	private static Logger log = LogManager.getLogger(PointsShopAction.class);
	private PointsShopService pointsShopService = new PointsShopService();
	private UserPointsService userPointsService = new UserPointsService();

	/*
	 * 跳到兑换奖品页面
	 */
	@At("/awardShop")
	public View getAwardShop(HttpServletRequest request,
			HttpServletResponse response, @Param("userId") String userId)
			throws Exception {
		List<Map> goods = null;
		request.setAttribute("openId", userId);
		int point = this.getAvailablePoints(userId);
		request.setAttribute("points", point);
		goods = pointsShopService.getAllGoods(0);
		request.setAttribute("goods", goods);
		return new ViewWrapper(new JspView("jsp.pointShopMain"), null);
	}

	/*
	 * 跳到兑换奖品详情页面
	 */
	@At("/awardShopDetail")
	public View getAwardShopDetail(HttpServletRequest request,
			HttpServletResponse response, @Param("userId") String userId,
			@Param("goodId") int goodId) throws Exception {
		request.setAttribute("openId", userId);
		Goods good = pointsShopService.getGoodsById(goodId);
		if (good != null) {
			int used = pointsShopService.getUsedGoodCount(goodId);
			request.setAttribute("goodId", goodId);
			request.setAttribute("goodurl", good.getImgUrl());
			request.setAttribute("goodmoney", good.getPrice());
			request.setAttribute("goodpoint", good.getPointPrice());
			request.setAttribute("goodused", used);
			request.setAttribute("goodhave", good.getAmount() - used);
			request.setAttribute("goodname", good.getGoodName());
			request.setAttribute("gooddesc", good.getGoodDesc());
		}
		return new ViewWrapper(new JspView("jsp.pointShopDetail"), null);
	}

	/*
	 * 动态加载城池数量
	 */
	@At("mypoint/getpoint")
	public View getLastPoint(HttpServletRequest request,
			HttpServletResponse response, @Param("userId") String userId)
			throws Exception {
		int point = this.getAvailablePoints(userId);
		return new ViewWrapper(new UTF8JsonView(new JsonFormat()), point);
	}

	/*
	 * 提交订单
	 */
	@At("mypoint/submitbill")
	public View submitBill(HttpServletRequest request,
			HttpServletResponse response, @Param("userId") String userId,
			@Param("num") int num, @Param("goodId") int goodId)
			throws Exception {
		if(CommonUtil.isEmpty(userId) || num<0 || goodId<0)
		{
			return new ViewWrapper(new UTF8JsonView(new JsonFormat()), 0);
		}
		int needpoint = 0;
		try
		{
			Goods good = pointsShopService.getGoodsById(goodId);
			int availablePoints = this.getAvailablePoints(userId);
			needpoint = num * good.getPointPrice();
			
			//检查城池数量是否够
			if(needpoint > availablePoints)
			{
				//城池数量不够，返回-1
				return new ViewWrapper(new UTF8JsonView(new JsonFormat()), -1);
			}
			
			//检查商品是否还有
			int used = pointsShopService.getUsedGoodCount(goodId);
			int keep = good.getAmount() - used;
			if(keep - num < 0)
			{
				//商品数量不够，返回-2
				return new ViewWrapper(new UTF8JsonView(new JsonFormat()), -2);
			}
		}catch(Exception e)
		{
			e.printStackTrace();
			return new ViewWrapper(new UTF8JsonView(new JsonFormat()), 0);
		}
		
		//开始兑换
		try
		{
			//减城池
			UserPoints userPoints = userPointsService.getUserpointsByUserId(userId);
			pointsShopService.minusPoint(userPoints, needpoint, userId);
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return new ViewWrapper(new UTF8JsonView(new JsonFormat()), 0);
		}
		
		//生成订单
		String preFix = "";
		if(userId.length() > 5)
		{
			preFix = userId.substring(userId.length()-4);
		}
		else
		{
			preFix = "bill";
		}
		
		preFix = preFix.toUpperCase();
		String time=CommonUtil.formatDateTimeToYYYYMMDDHHMMSSExt(new Date());
		String billNum = preFix + time;
		BillDetail bd = new BillDetail();
		bd.setBillNum(billNum);
		bd.setBillUsrid(userId);
		bd.setBillStatus(0);
		bd.setGoodId(goodId);
		bd.setTotalPoint(needpoint);
		bd.setGoodNum(num);
		bd.setCreateTime(new Timestamp(System.currentTimeMillis()));
		bd.setUpdateTime(new Timestamp(System.currentTimeMillis()));
		
		//插入订单表
		pointsShopService.insertBillDetail(bd);
		
		return new ViewWrapper(new UTF8JsonView(new JsonFormat()), 1);
	}
	
	/*
	 * 计算可用的城池数量
	 * */
	private int getAvailablePoints(String usrId)
	{
		UserPoints userPoints = userPointsService.getUserpointsByUserId(usrId);
		if(userPoints == null)
		{
			return 0;
		}
		int availablePoints = userPoints.getAllPoints()
				- userPoints.getLockedPoints() - 50;
		int point = 0;
		if (availablePoints >= 0) {
			point = availablePoints;
		}
		return point;
	}
	
	/*
	 * 加载交易流水列表
	 */
	@At("/billdetail")
	public View listBillDetail(HttpServletRequest request,
			HttpServletResponse response, @Param("userId") String userId)
			throws Exception {
		List<BillDetail> listBd = pointsShopService.getBillDetail(userId);
		request.setAttribute("listbd", listBd);
		return new ViewWrapper(new JspView("jsp.exchangeRecords"), null);
	}
}
