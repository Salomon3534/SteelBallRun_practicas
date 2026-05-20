package com.steelballrun.model;

public class Person {
    private int id;
    private String name;
    private int age;
    private String country;
    private String dni;

    public Person() {}

    public Person(int id, String name, int age, String country, String dni) {
        this.id = id; this.name = name; this.age = age;
        this.country = country; this.dni = dni;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public int getAge() { return age; }
    public void setAge(int age) { this.age = age; }

    public String getCountry() { return country; }
    public void setCountry(String country) { this.country = country; }

    public String getDni() { return dni; }
    public void setDni(String dni) { this.dni = dni; }
}
