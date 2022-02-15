package com.alj.dream.home.domain;

public class HomeInfo {
	
	private int memberCount;
	private int postCount;
	private int matchingCount;
	
	
	public HomeInfo() {
		// TODO Auto-generated constructor stub
	}


	public HomeInfo(int memberCount, int postCount, int matchingCount) {
		this.memberCount = memberCount;
		this.postCount = postCount;
		this.matchingCount = matchingCount;
	}


	public int getMemberCount() {
		return memberCount;
	}


	public void setMemberCount(int memberCount) {
		this.memberCount = memberCount;
	}


	public int getPostCount() {
		return postCount;
	}


	public void setPostCount(int postCount) {
		this.postCount = postCount;
	}


	public int getMatchingCount() {
		return matchingCount;
	}


	public void setMatchingCount(int matchingCount) {
		this.matchingCount = matchingCount;
	}
	
	
	
	
	
	

}
