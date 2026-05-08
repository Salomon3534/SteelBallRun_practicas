package com.steelballrunrace.model;

import java.util.Objects;

public class Runner {
	private int characterId;
	private int horseId;
	private int points;
	private int place;
	private String statueCarrera;

	public Runner() {
	}

	public Runner(int characterId, int horseId, int points, int place, String statueCarrera) {
		this.characterId = characterId;
		this.horseId = horseId;
		this.points = points;
		this.place = place;
		this.statueCarrera = statueCarrera;
	}

	public int getCharacterId() {
		return characterId;
	}

	public void setCharacterId(int characterId) {
		this.characterId = characterId;
	}

	public int getHorseId() {
		return horseId;
	}

	public void setHorseId(int horseId) {
		this.horseId = horseId;
	}

	public int getPoints() {
		return points;
	}

	public void setPoints(int points) {
		this.points = points;
	}

	public int getPlace() {
		return place;
	}

	public void setPlace(int place) {
		this.place = place;
	}

	public String getStatueCarrera() {
		return statueCarrera;
	}

	public void setStatueCarrera(String statueCarrera) {
		this.statueCarrera = statueCarrera;
	}

	@Override
	public int hashCode() {
		return Objects.hash(Integer.valueOf(characterId), Integer.valueOf(horseId), Integer.valueOf(place),
				Integer.valueOf(points), statueCarrera);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Runner other = (Runner) obj;
		return characterId == other.characterId && horseId == other.horseId && place == other.place
				&& points == other.points && Objects.equals(statueCarrera, other.statueCarrera);
	}
}
