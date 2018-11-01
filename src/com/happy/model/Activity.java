package com.happy.model;

import java.sql.Timestamp;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Table;

@Table("activity")
public class Activity {

	@Column("activity_id")
	private String activityId;
	@Column("user_id")
	private String userId;
	@Column("acitvity_type")
	private String acitvityType;
	@Column("activity_desc")
	private String activityDesc;
	@Column("activity_stake")
	private String activityStake;
	@Column("activity_deadline")
	private Timestamp activityDeadline;
	@Column("publish_date")
	private Timestamp publishDate;
	@Column("partici_limititation")
	private int particiLimititation;
	@Column("activity_status")
	private int activityStatus;
	@Column("activity_remark")
	private String activityRemark;
	@Column("create_time")
	private Timestamp createTime;
	@Column("result_status")
	private int resultStatus;
	@Column("execute_status")
	private int ExecuteStatus;
	@Column("result_date")
	private Timestamp resultDate;
	@Column("stake_points")
	private int stakePoints;
	@Column("tendency")
	private String tendency;
	@Column("original_url")
	private String originalUrl;
	@Column("img_back_news")
	private String imgBackBews;
	@Column("title_back_news")
	private String titleBackNews;
	@Column("template_id")
	private String templateId;
	
	
	
	public String getTemplateId() {
		return templateId;
	}
	public void setTemplateId(String templateId) {
		this.templateId = templateId;
	}
	public String getTypeId() {
		return templateId;
	}
	public void setTypeId(String templateId) {
		this.templateId = templateId;
	}
	public String getImgBackBews() {
		return imgBackBews;
	}
	public void setImgBackBews(String imgBackBews) {
		this.imgBackBews = imgBackBews;
	}
	public String getTitleBackNews() {
		return titleBackNews;
	}
	public void setTitleBackNews(String titleBackNews) {
		this.titleBackNews = titleBackNews;
	}
	public String getOriginalUrl() {
		return originalUrl;
	}
	public void setOriginalUrl(String originalUrl) {
		this.originalUrl = originalUrl;
	}
	public String getTendency() {
		return tendency;
	}
	public void setTendency(String tendency) {
		this.tendency = tendency;
	}
	public int getStakePoints() {
		return stakePoints;
	}
	public void setStakePoints(int stakePoints) {
		this.stakePoints = stakePoints;
	}
	public Timestamp getResultDate() {
		return resultDate;
	}
	public void setResultDate(Timestamp resultDate) {
		this.resultDate = resultDate;
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
	public String getAcitvityType() {
		return acitvityType;
	}
	public void setAcitvityType(String acitvityType) {
		this.acitvityType = acitvityType;
	}
	public String getActivityDesc() {
		return activityDesc;
	}
	public void setActivityDesc(String activityDesc) {
		this.activityDesc = activityDesc;
	}
	public String getActivityStake() {
		return activityStake;
	}
	public void setActivityStake(String activityStake) {
		this.activityStake = activityStake;
	}
	public Timestamp getActivityDeadline() {
		return activityDeadline;
	}
	public void setActivityDeadline(Timestamp activityDeadline) {
		this.activityDeadline = activityDeadline;
	}
	public int getParticiLimititation() {
		return particiLimititation;
	}
	public void setParticiLimititation(int particiLimititation) {
		this.particiLimititation = particiLimititation;
	}
	public int getActivityStatus() {
		return activityStatus;
	}
	public void setActivityStatus(int activityStatus) {
		this.activityStatus = activityStatus;
	}
	public String getActivityRemark() {
		return activityRemark==null ? "" : activityRemark;
	}
	public void setActivityRemark(String activityRemark) {
		this.activityRemark = activityRemark;
	}

	public int getExecuteStatus() {
		return ExecuteStatus;
	}
	public void setExecuteStatus(int executeStatus) {
		ExecuteStatus = executeStatus;
	}
	public Timestamp getPublishDate() {
		return publishDate;
	}
	public void setPublishDate(Timestamp publishDate) {
		this.publishDate = publishDate;
	}
	public Timestamp getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}
	public int getResultStatus() {
		return resultStatus;
	}
	public void setResultStatus(int resultStatus) {
		this.resultStatus = resultStatus;
	}
	
	
}
