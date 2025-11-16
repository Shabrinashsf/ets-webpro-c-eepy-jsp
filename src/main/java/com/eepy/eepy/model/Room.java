package com.eepy.eepy.model;

public class Room {
    private int id;
    private String number;
    private String status;
    private int roomTypeId;
    private RoomType roomType; // relasi ke RoomType

    public Room() {}

    public Room(int id, String number, String status, int roomTypeId) {
        this.id = id;
        this.number = number;
        this.status = status;
        this.roomTypeId = roomTypeId;
    }

    // Getter & Setter
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getNumber() { return number; }
    public void setNumber(String number) { this.number = number; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public int getRoomTypeId() { return roomTypeId; }
    public void setRoomTypeId(int roomTypeId) { this.roomTypeId = roomTypeId; }

    public RoomType getRoomType() { return roomType; }
    public void setRoomType(RoomType roomType) { this.roomType = roomType; }
}
