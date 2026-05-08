package com.steelballrunrace.model;

public class MedicalCheck {
	private int characterId;
	private String grade;
	private String comments;
	private String damageType;

	public MedicalCheck() {
	}

	public MedicalCheck(int characterId, String grade, String comments, String damageType) {
		this.characterId = characterId;
		this.grade = grade;
		this.comments = comments;
		this.damageType = damageType;
	}

	public int getCharacterId() {
		return characterId;
	}

	public void setCharacterId(int characterId) {
		this.characterId = characterId;
	}

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}

	public String getDamageType() {
		return damageType;
	}

	public void setDamageType(String damageType) {
		this.damageType = damageType;
	}
}
