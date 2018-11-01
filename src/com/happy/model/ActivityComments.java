package com.happy.model;

import java.sql.Timestamp;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Id;
import org.nutz.dao.entity.annotation.Table;

@Table("activity_comments")
public class ActivityComments {
	
	@Id
	private long id;

	
	@Column("activity_id")
	private String activityId;
	
	@Column("user_id")
	private String userId;
	
	@Column("comments")
	private String comments;
	
	@Column("comment_status")
	private int commentStatus;
	
	@Column("create_time")
	private Timestamp createTime;
	
	@Column("zan")
	private int zan;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}


	public String getActivityId() {
		return activityId;
	}

	public void setActivityId(String activityId) {
		this.activityId = activityId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}

	public int getCommentStatus() {
		return commentStatus;
	}

	public void setCommentStatus(int commentStatus) {
		this.commentStatus = commentStatus;
	}

	public Timestamp getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}

	public int getZan() {
		return zan;
	}

	public void setZan(int zan) {
		this.zan = zan;
	}
	
	
	
}
