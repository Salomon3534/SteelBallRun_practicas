package com.steelballrun.model;

import java.util.Objects;

public class Person {
	private int id;
	private String name;
	private String surnames;
	private int age;
	private String dni;

	public Person(int id, String name, String surnames, int age, String dni) {
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

	@Override
	public boolean equals(Object o) {
		if (this == o) {
			return true;
		}
		if (!(o instanceof Person character)) {
			return false;
		}
		return id == character.id && age == character.age && Objects.equals(name, character.name)
				&& Objects.equals(surnames, character.surnames) && Objects.equals(dni, character.dni);
	}

	@Override
	public int hashCode() {
		return Objects.hash(id, name, surnames, age, dni);
	}

	@Override
	public String toString() {
		return "Character{" + "id=" + id + ", name='" + name + '\'' + ", surnames='" + surnames + '\'' + ", age=" + age
				+ ", dni='" + dni + '\'' + '}';
	}
}
