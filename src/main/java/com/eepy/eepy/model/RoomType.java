package com.eepy.eepy.model;

import java.util.List;

public class RoomType {
    private int id;
    private String name;
    private int price;
    private String description;
    private String area;
    private String capacity;
    private List<String> facilities;

    public RoomType() {}

    public RoomType(int id, String name, int price, String description, String area, String capacity, List<String> facilities) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.description = description;
        this.area = area;
        this.capacity = capacity;
        this.facilities = facilities;
    }

    // Getter & Setter
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public int getPrice() { return price; }
    public void setPrice(int price) { this.price = price; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getArea() { return area; }
    public void setArea(String area) { this.area = area; }

    public String getCapacity() { return capacity; }
    public void setCapacity(String capacity) { this.capacity = capacity; }

    public List<String> getFacilities() { return facilities; }
    public void setFacilities(List<String> facilities) { this.facilities = facilities; }
}
