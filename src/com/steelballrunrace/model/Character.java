package com.steelballrunrace.model;

public class Character {
	private int id;
	private String name;
	private String surnames;
	private int age;
	private String dni;
	
	public Character() {
	}
	
	public Character(int id, String name, String surnames, int age, String dni) {
		this.id = id;
		this.name = name;
		this.surnames = surnames;
		this.age = age;
		this.dni = dni;
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
	
	public String getDni() {
		return dni;
	}
	
	public void setDni(String dni) {
		this.dni = dni;
	}
}
