package com.steelballrunrace.model;

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
}
