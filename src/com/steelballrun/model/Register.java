package com.steelballrun.model;

import java.util.Objects;

public class Register {
	private String characterDni;
	private int saddleNumber;

	public Register() {
	}

	public Register(String characterDni, int saddleNumber) {
		this.characterDni = characterDni;
		this.saddleNumber = saddleNumber;
	}

	public String getCharacterDni() {
		return characterDni;
	}

	public void setCharacterDni(String characterDni) {
		this.characterDni = characterDni;
	}

	public int getSaddleNumber() {
		return saddleNumber;
	}

	public void setSaddleNumber(int saddleNumber) {
		this.saddleNumber = saddleNumber;
	}

	@Override
	public int hashCode() {
		return Objects.hash(characterDni, Integer.valueOf(saddleNumber));
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Register other = (Register) obj;
		return Objects.equals(characterDni, other.characterDni) && saddleNumber == other.saddleNumber;
	}
}
