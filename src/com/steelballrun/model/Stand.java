package com.steelballrun.model;

import java.util.Objects;

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

	@Override
	public int hashCode() {
		return Objects.hash(ability, Integer.valueOf(characterId), standName);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj) {
			return true;
		}
		if ((obj == null) || (getClass() != obj.getClass())) {
			return false;
		}
		Stand other = (Stand) obj;
		return Objects.equals(ability, other.ability) && characterId == other.characterId
				&& Objects.equals(standName, other.standName);
	}
}
