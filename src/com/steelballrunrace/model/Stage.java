package com.steelballrunrace.model;

public class Stage {
	private int id;
	private String name;
	private String start;
	private String end;
	private double distance;

	public Stage() {
	}

	public Stage(int id, String name, String start, String end, double distance) {
		this.id = id;
		this.name = name;
		this.start = start;
		this.end = end;
		this.distance = distance;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getStart() {
		return start;
	}

	public void setStart(String start) {
		this.start = start;
	}

	public String getEnd() {
		return end;
	}

	public void setEnd(String end) {
		this.end = end;
	}

	public double getDistance() {
		return distance;
	}

	public void setDistance(double distance) {
		this.distance = distance;
	}
}
