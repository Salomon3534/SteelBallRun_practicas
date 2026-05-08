package com.steelballrunrace.model;

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
}
