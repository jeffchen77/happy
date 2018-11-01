package com.happy.model;

import java.util.Date;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Id;
import org.nutz.dao.entity.annotation.Table;

@Table("complaint")
public class Complaint {
	@Id
	private int id;
	@Column("activity_id")
	private String activity_id;
	@Column("excute_status")
	private String excute_status;
	@Column("complaint_content")
	private String complaint_content;
	@Column("create_time")
	private Date create_time;
	@Column("create_user")
	private String create_user;
	
	@Column("update_time")
	private Date update_time;
	@Column("update_user")
	private String update_user;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getActivity_id() {
		return activity_id;
	}
	public void setActivity_id(String activity_id) {
		this.activity_id = activity_id;
	}
	public String getExcute_status() {
		return excute_status;
	}
	public void setExcute_status(String excute_status) {
		this.excute_status = excute_status;
	}
	public String getComplaint_content() {
		return complaint_content;
	}
	public void setComplaint_content(String complaint_content) {
		this.complaint_content = complaint_content;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	public String getCreate_user() {
		return create_user;
	}
	public void setCreate_user(String create_user) {
		this.create_user = create_user;
	}
	public Date getUpdate_time() {
		return update_time;
	}
	public void setUpdate_time(Date update_time) {
		this.update_time = update_time;
	}
	public String getUpdate_user() {
		return update_user;
	}
	public void setUpdate_user(String update_user) {
		this.update_user = update_user;
	}
	
	
	
}
