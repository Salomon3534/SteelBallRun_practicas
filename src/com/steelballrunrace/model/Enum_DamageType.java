package com.steelballrunrace.model;

public enum Enum_DamageType {
	PHYSICAL("Daño Físico"), STAND("Ataque de Stand"), DISEASE("Enfermedad"), ENVIRONMENTAL("Clima/Entorno"),
	NONE("Sin Daños");

	private final String description;

	private Enum_DamageType(String description) {
		this.description = description;
	}

	public String getDescription() {
		return description;
	}
}