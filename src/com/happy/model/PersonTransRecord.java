package com.happy.model;

import java.sql.Timestamp;

public class PersonTransRecord {
	
	private String actId;
	
	private String actOwnerId;

	private String headImgUrl;

	private String recordOwnerId;

	private String befTransPoints;

	private String transPoints;

	private String aftTransPoints;

	private Timestamp transTime;

	public String getActId() {
		return actId;
	}

	public void setActId(String actId) {
		this.actId = actId;
	}

	public String getActOwnerId() {
		return actOwnerId;
	}

	public void setActOwnerId(String actOwnerId) {
		this.actOwnerId = actOwnerId;
	}

	public String getHeadImgUrl() {
		return headImgUrl;
	}

	public void setHeadImgUrl(String headImgUrl) {
		this.headImgUrl = headImgUrl;
	}

	public String getRecordOwnerId() {
		return recordOwnerId;
	}

	public void setRecordOwnerId(String recordOwnerId) {
		this.recordOwnerId = recordOwnerId;
	}

	public String getBefTransPoints() {
		return befTransPoints;
	}

	public void setBefTransPoints(String befTransPoints) {
		this.befTransPoints = befTransPoints;
	}

	public String getTransPoints() {
		return transPoints;
	}

	public void setTransPoints(String transPoints) {
		this.transPoints = transPoints;
	}

	public String getAftTransPoints() {
		return aftTransPoints;
	}

	public void setAftTransPoints(String aftTransPoints) {
		this.aftTransPoints = aftTransPoints;
	}

	public Timestamp getTransTime() {
		return transTime;
	}

	public void setTransTime(Timestamp transTime) {
		this.transTime = transTime;
	}
	
}
