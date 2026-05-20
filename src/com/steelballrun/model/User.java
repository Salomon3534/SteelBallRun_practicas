package com.steelballrun.model;

public class User {
    private int id;
    private String username;
    private String passkey;   // stored as SHA-256 hex
    private String role;      // "admin" | "user"
    private Integer runnerId; // null for admin

    public User() {}

    public User(int id, String username, String passkey, String role, Integer runnerId) {
        this.id = id; this.username = username; this.passkey = passkey;
        this.role = role; this.runnerId = runnerId;
    }

    public int getId()             { return id; }
    public void setId(int id)      { this.id = id; }

    public String getUsername()               { return username; }
    public void setUsername(String username)  { this.username = username; }

    public String getPasskey()                { return passkey; }
    public void setPasskey(String passkey)    { this.passkey = passkey; }

    public String getRole()                   { return role; }
    public void setRole(String role)          { this.role = role; }

    public Integer getRunnerId()                   { return runnerId; }
    public void setRunnerId(Integer runnerId)      { this.runnerId = runnerId; }
}
