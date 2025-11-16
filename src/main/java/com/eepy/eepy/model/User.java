package com.eepy.eepy.model;

public class User {
    private int id;
    private String name;
    private String email;
    private String password;
    private String telpNumber;
    private String role;

    public User() {}

    public User(int id, String name, String email, String password, String telpNumber, String role) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.password = password;
        this.telpNumber = telpNumber;
        this.role = role;
    }

    // Getter & Setter
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getTelpNumber() { return telpNumber; }
    public void setTelpNumber(String telpNumber) { this.telpNumber = telpNumber; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
}