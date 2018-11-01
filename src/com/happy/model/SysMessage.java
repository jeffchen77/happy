package com.happy.model;
import java.util.Date;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Id;
import org.nutz.dao.entity.annotation.Table;

@Table("sys_message")
public class SysMessage {
	    @Column("id")
		private int id;
		@Column("activity_id")
		private String activityId;
		@Column("from_user_id")
		private String fromUserId;
		@Column("to_user_id")
		private String toUserId;
		public String getToUserId() {
			return toUserId;
		}
		public void setToUserId(String toUserId) {
			this.toUserId = toUserId;
		}
		@Column("title")
		private String title;
		@Column("send_time")
		private Date sendTime;
		
		@Column("body")
		private String body;
		@Column("status")
		private int status;
		
		@Column("read_time")
		private Date reaTime;
		@Column("expired_time")
		private Date expiredTime;
		public int getId() {
			return id;
		}
		public void setId(int id) {
			this.id = id;
		}
		public String getActivityId() {
			return activityId;
		}
		public void setActivityId(String activityId) {
			this.activityId = activityId;
		}
		public String getFromUserId() {
			return fromUserId;
		}
		public void setFromUserId(String fromUserId) {
			this.fromUserId = fromUserId;
		}
		public String getTitle() {
			return title;
		}
		public void setTitle(String title) {
			this.title = title;
		}
		public Date getSendTime() {
			return sendTime;
		}
		public void setSendTime(Date sendTime) {
			this.sendTime = sendTime;
		}
		public String getBody() {
			return body;
		}
		public void setBody(String body) {
			this.body = body;
		}
		public int getStatus() {
			return status;
		}
		public void setStatus(int status) {
			this.status = status;
		}
		public Date getReaTime() {
			return reaTime;
		}
		public void setReaTime(Date reaTime) {
			this.reaTime = reaTime;
		}
		public Date getExpiredTime() {
			return expiredTime;
		}
		public void setExpiredTime(Date expiredTime) {
			this.expiredTime = expiredTime;
		}
		
		
		
		private String activityDesc;
		private int points;
		private String particiType;
		private String perCent;
		
		public String getPerCent() {
			return perCent;
		}
		public void setPerCent(String perCent) {
			this.perCent = perCent;
		}
		public String getParticiType() {
			return particiType;
		}
		public void setParticiType(String particiType) {
			this.particiType = particiType;
		}
		public String getActivityDesc() {
			return activityDesc;
		}
		public void setActivityDesc(String activityDesc) {
			this.activityDesc = activityDesc;
		}
		public int getPoints() {
			return points;
		}
		public void setPoints(int points) {
			this.points = points;
		}
			
	
}
