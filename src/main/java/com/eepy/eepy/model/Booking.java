package com.eepy.eepy.model;

import java.sql.Date;

public class Booking {
    private int id;
    private int userId;
    private int roomId;
    private String name;
    private String phone_number;
    private Date checkin;
    private Date checkout;
    private int price;
    private String paymentMethod;

    public Booking() {}

    public Booking(int id, int userId, int roomId, String name, String phone_number, Date checkin, Date checkout, int price, String paymentMethod) {
        this.id = id;
        this.userId = userId;
        this.roomId = roomId;
        this.name = name;
        this.phone_number = phone_number;
        this.checkin = checkin;
        this.checkout = checkout;
        this.price = price;
        this.paymentMethod = paymentMethod;
    }

    // --- Getter dan Setter ---
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getRoomId() { return roomId; }
    public void setRoomId(int roomId) { this.roomId = roomId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getPhone_number() { return phone_number; }
    public void setPhone_number(String phone_number) { this.phone_number = phone_number; }

    public Date getCheckin() { return checkin; }
    public void setCheckin(Date checkin) { this.checkin = checkin; }

    public Date getCheckout() { return checkout; }
    public void setCheckout(Date checkout) { this.checkout = checkout; }

    public int getPrice() { return price; }
    public void setPrice(int price) { this.price = price; }

    public String getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }
}