package com.happy.model;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Table;
import java.sql.Timestamp;

@Table("user_points")
public class UserPoints {
	@Column("id")
	private int Id;
	
	@Column("user_id")
	private String userId;
	
	@Column("all_points")
	private int allPoints;
	
	@Column("locked_points")
	private int lockedPoints;
	
	@Column("create_time")
	private Timestamp createTime;
	
	@Column("create_user")
	private String createUser;
	
	@Column("update_time")
	private Timestamp updateTime;
	
	@Column("update_user")
	private String updateUser;

	public int getId() {
		return Id;
	}

	public void setId(int id) {
		Id = id;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public int getAllPoints() {
		return allPoints;
	}

	public void setAllPoints(int allPoints) {
		this.allPoints = allPoints;
	}

	public int getLockedPoints() {
		return lockedPoints;
	}

	public void setLockedPoints(int lockedPoints) {
		this.lockedPoints = lockedPoints;
	}

	public Timestamp getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}

	public String getCreateUser() {
		return createUser;
	}

	public void setCreateUser(String createUser) {
		this.createUser = createUser;
	}

	public Timestamp getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Timestamp updateTime) {
		this.updateTime = updateTime;
	}

	public String getUpdateUser() {
		return updateUser;
	}

	public void setUpdateUser(String updateUser) {
		this.updateUser = updateUser;
	}
	
}
