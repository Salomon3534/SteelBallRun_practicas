package com.steelballrunrace.model;

public class Stand {
	private int characterId;
	private String standName;
	private String ability;

	public Stand() {
	}

	public Stand(int characterId, String standName, String ability) {
		this.characterId = characterId;
		this.standName = standName;
		this.ability = ability;
	}

	public int getCharacterId() {
		return characterId;
	}

	public void setCharacterId(int characterId) {
		this.characterId = characterId;
	}

	public String getStandName() {
		return standName;
	}

	public void setStandName(String standName) {
		this.standName = standName;
	}

	public String getAbility() {
		return ability;
	}

	public void setAbility(String ability) {
		this.ability = ability;
	}
}
