package com.happy.model;

import java.sql.Timestamp;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.One;
import org.nutz.dao.entity.annotation.Table;

@Table("billdetail")
public class BillDetail {
	
	@Column("bill_num")
	private String billNum;
	@Column("bill_usrid")
	private String billUsrid;
	@Column("bill_status")
	private int billStatus;
	@Column("good_id")
	private int goodId;
	@Column("total_point")
	private int totalPoint;
	public int getTotalPoint() {
		return totalPoint;
	}
	public void setTotalPoint(int totalPoint) {
		this.totalPoint = totalPoint;
	}
	@Column("good_num")
	private int goodNum;
	@Column("create_time")
	private Timestamp createTime;
	@Column("update_time")
	private Timestamp updateTime;
	
	public String getBillNum() {
		return billNum;
	}
	public void setBillNum(String billNum) {
		this.billNum = billNum;
	}
	public String getBillUsrid() {
		return billUsrid;
	}
	public void setBillUsrid(String billUsrid) {
		this.billUsrid = billUsrid;
	}
	public int getBillStatus() {
		return billStatus;
	}
	public void setBillStatus(int billStatus) {
		this.billStatus = billStatus;
	}
	public int getGoodId() {
		return goodId;
	}
	public void setGoodId(int goodId) {
		this.goodId = goodId;
	}
	public int getGoodNum() {
		return goodNum;
	}
	public void setGoodNum(int goodNum) {
		this.goodNum = goodNum;
	}
	public Timestamp getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}
	public Timestamp getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(Timestamp updateTime) {
		this.updateTime = updateTime;
	}
	
	//自定义字段
	@One(target = Goods.class, field = "goodId")
	private Goods good;
	public Goods getGood() {
		return good;
	}
	public void setGood(Goods good) {
		this.good = good;
	}
	
	private String fomatTime;
	public String getFomatTime() {
		return fomatTime;
	}
	public void setFomatTime(String fomatTime) {
		this.fomatTime = fomatTime;
	}
}
