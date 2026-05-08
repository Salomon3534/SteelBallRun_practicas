package com.steelballrunrace.model;

public class Horse {
	private int id;
	private String horseName;
	private String race;

	public Horse() {
	}

	public Horse(int id, String horseName, String race) {
		this.id = id;
		this.horseName = horseName;
		this.race = race;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getHorseName() {
		return horseName;
	}

	public void setHorseName(String horseName) {
		this.horseName = horseName;
	}

	public String getRace() {
		return race;
	}

	public void setRace(String race) {
		this.race = race;
	}
}
