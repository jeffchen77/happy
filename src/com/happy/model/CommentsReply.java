package com.happy.model;

import java.sql.Timestamp;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Id;
import org.nutz.dao.entity.annotation.Table;

@Table("comments_reply")
public class CommentsReply {
	@Id
	private long id;
	
	@Column("user_id")
	private String userId;
	
	@Column("comment_id")
	private int commentId;
	
	@Column("touser_id")
	private String touserId;
	
	@Column("comments")
	private String comments;
	
	@Column("create_time")
	private Timestamp createTime;
	
	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public int getCommentId() {
		return commentId;
	}

	public void setCommentId(int commentId) {
		this.commentId = commentId;
	}

	public String getTouserId() {
		return touserId;
	}

	public void setTouserId(String touserId) {
		this.touserId = touserId;
	}

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}

	public Timestamp getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}

	
}
