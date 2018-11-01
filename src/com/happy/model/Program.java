package com.happy.model;

import java.sql.Timestamp;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Table;

@Table("program")
public class Program {
	@Column("id")
	private int id;
	
	@Column("pgm_id")
	private String pgmId;
	
	@Column("pgm_title")
	private String pgmTitle;
	
	@Column("pgm_desc")
	private String pgmDesc;
	
	@Column("begin_time")
	private Timestamp beginTime;
	
	@Column("end_time")
	private Timestamp endTime;
	
	@Column("create_time")
	private Timestamp createTime;
	
	@Column("update_time")
	private Timestamp updateTime;
	
	@Column("pgm_points")
	private int pgmPoints;
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getPgmId() {
		return pgmId;
	}

	public void setPgmId(String pgmId) {
		this.pgmId = pgmId;
	}

	public String getPgmTitle() {
		return pgmTitle;
	}

	public void setPgmTitle(String pgmTitle) {
		this.pgmTitle = pgmTitle;
	}

	public String getPgmDesc() {
		return pgmDesc;
	}

	public void setPgmDesc(String pgmDesc) {
		this.pgmDesc = pgmDesc;
	}

	public Timestamp getBeginTime() {
		return beginTime;
	}

	public void setBeginTime(Timestamp beginTime) {
		this.beginTime = beginTime;
	}

	public Timestamp getEndTime() {
		return endTime;
	}

	public void setEndTime(Timestamp endTime) {
		this.endTime = endTime;
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

	public int getPgmPoints() {
		return pgmPoints;
	}

	public void setPgmPoints(int pgmPoints) {
		this.pgmPoints = pgmPoints;
	}

	
	
	
}
