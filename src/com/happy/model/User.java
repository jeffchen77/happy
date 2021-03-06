package com.happy.model;

import java.sql.Timestamp;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Table;

@Table("user")
public class User {
	
	@Column("id")
	private int Id;
	
	@Column("user_id")
	private String userId;
	
	@Column("user_name")
	private String userName;
	
	@Column("nick_name")
	private String nickName;
	
	@Column("email_address")
	private String emailAddress;
	
	@Column("phone_number")
	private String phoneNumber;
	
	@Column("remark")
	private String remark;

	@Column("moral_rank")
	private String moralRank;
	
	@Column("integrityl_rank")
	private String integritylRank;
	
	@Column("create_time")
	private Timestamp createTime;
	
	@Column("update_time")
	private Timestamp updateTime;
	
	@Column("create_user")
	private String createUser;
	
	@Column("update_user")
	private String update_user;
	
	@Column("forecast_accuracy")
	private String forecastAccuracy;

	@Column("limit_flag")
	private int limitFlag;
	
	@Column("gz_flag")
	private int gzFlag;
	
	@Column("act_password")
	private String actPassword;
	
	
	public int getGzFlag() {
		return gzFlag;
	}

	public void setGzFlag(int gzFlag) {
		this.gzFlag = gzFlag;
	}

	public String getActPassword() {
		return actPassword;
	}

	public void setActPassword(String actPassword) {
		this.actPassword = actPassword;
	}

	public String getIntegritylRank() {
		return integritylRank;
	}

	public void setIntegritylRank(String integritylRank) {
		this.integritylRank = integritylRank;
	}

	public int getLimitFlag() {
		return limitFlag;
	}

	public void setLimitFlag(int limitFlag) {
		this.limitFlag = limitFlag;
	}

	public String getForecastAccuracy() {
		return forecastAccuracy;
	}

	public void setForecastAccuracy(String forecastAccuracy) {
		this.forecastAccuracy = forecastAccuracy;
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

	public String getCreateUser() {
		return createUser;
	}

	public void setCreateUser(String createUser) {
		this.createUser = createUser;
	}

	public String getUpdate_user() {
		return update_user;
	}

	public void setUpdate_user(String update_user) {
		this.update_user = update_user;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public String getEmailAddress() {
		return emailAddress;
	}

	public void setEmailAddress(String emailAddress) {
		this.emailAddress = emailAddress;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getMoralRank() {
		return moralRank;
	}

	public void setMoralRank(String moralRank) {
		this.moralRank = moralRank;
	}
	
	public int getId() {
		return Id;
	}

	public void setId(int id) {
		Id = id;
	}
	
}
