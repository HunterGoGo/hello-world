package com.cho.dto;

import java.io.Serializable;
import java.sql.Date;

public class Round10_MemberDTO implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 7203391762151488876L;
	private int no;
	private String name;
	private Date birthday;
	private String address;

	private int start; // DB의 select 시작번호
	private int end; // 시작번호로 부터 가져올 select 개수

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public int getStart() {
		return start;
	}

	public void setStart(int start) {
		this.start = start;
	}

	public int getEnd() {
		return end;
	}

	public void setEnd(int end) {
		this.end = end;
	}
}
