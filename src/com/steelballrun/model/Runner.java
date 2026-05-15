package com.steelballrun.model;

import java.util.Objects;

public class Runner {
	private int id;
	private String name;
	private String surnames;
	private int age;
	private String nationality;
	private int mountId;
	private int bib;
	private int currentPlace;
	private int totalPoints;

	public Runner() {
	}

	public Runner(int id, String name, String surnames, int age, String nationality, int mountId, int bib, int currentPlace, int totalPoints) {
		this.id = id;
		this.name = name;
		this.surnames = surnames;
		this.age = age;
		this.nationality = nationality;
		this.mountId = mountId;
		this.bib = bib;
		this.currentPlace = currentPlace;
		this.totalPoints = totalPoints;
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

	public String getSurnames() {
		return surnames;
	}

	public void setSurnames(String surnames) {
		this.surnames = surnames;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public String getNationality() {
		return nationality;
	}

	public void setNationality(String nationality) {
		this.nationality = nationality;
	}

	public int getMountId() {
		return mountId;
	}

	public void setMountId(int mountId) {
		this.mountId = mountId;
	}

	public int getBib() {
		return bib;
	}

	public void setBib(int bib) {
		this.bib = bib;
	}

	public int getCurrentPlace() {
		return currentPlace;
	}

	public void setCurrentPlace(int currentPlace) {
		this.currentPlace = currentPlace;
	}

	public int getTotalPoints() {
		return totalPoints;
	}

	public void setTotalPoints(int totalPoints) {
		this.totalPoints = totalPoints;
	}

	@Override
	public int hashCode() {
		return Objects.hash(id, name, surnames, age, nationality, mountId, bib, currentPlace, totalPoints);
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
		return id == other.id && age == other.age && mountId == other.mountId && bib == other.bib
				&& currentPlace == other.currentPlace && totalPoints == other.totalPoints
				&& Objects.equals(name, other.name) && Objects.equals(surnames, other.surnames)
				&& Objects.equals(nationality, other.nationality);
	}

	@Override
	public String toString() {
		return "Runner{" + "id=" + id + ", name='" + name + '\'' + ", surnames='" + surnames + '\''
				+ ", age=" + age + ", nationality='" + nationality + '\'' + ", mountId=" + mountId + ", bib=" + bib
				+ ", currentPlace=" + currentPlace + ", totalPoints=" + totalPoints + '}';
	}
}
