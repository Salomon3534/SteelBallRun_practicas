package com.gestionescuela.model;

public enum Enum_Status {
	DEAD("Muerto"), INJURED("Lesionado"), MEDIUM_HEALTH("Salud Media"), HEALTHY("Saludable");

	private final String description;

	private Enum_Status(String description) {
		this.description = description;
	}

	public String getDescription() {
		return description;
	}
}
