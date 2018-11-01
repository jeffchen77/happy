package com.happy.model;

import java.sql.Timestamp;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Table;

@Table("unread_message")
public class UnreadMessage {
	
	@Column("activity_id")
	private String activityId;
	@Column("participate_user_id")
	private String participateUserId;
	@Column("reply_user_id")
	private String replyUserId;
	@Column("unread")
	private int unread;
	@Column("create_time")
	private Timestamp createTime;
	@Column("comment_id")
	private int commentId;
	@Column("remark_id")
	private int remarkId;
	
	
	public int getRemarkId() {
		return remarkId;
	}
	public void setRemarkId(int remarkId) {
		this.remarkId = remarkId;
	}
	public int getCommentId() {
		return commentId;
	}
	public void setCommentId(int commentId) {
		this.commentId = commentId;
	}
	public String getActivityId() {
		return activityId;
	}
	public void setActivityId(String activityId) {
		this.activityId = activityId;
	}
	public String getParticipateUserId() {
		return participateUserId;
	}
	public void setParticipateUserId(String participateUserId) {
		this.participateUserId = participateUserId;
	}
	public String getReplyUserId() {
		return replyUserId;
	}
	public void setReplyUserId(String replyUserId) {
		this.replyUserId = replyUserId;
	}
	public int getUnread() {
		return unread;
	}
	public void setUnread(int unread) {
		this.unread = unread;
	}
	public Timestamp getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}
}
