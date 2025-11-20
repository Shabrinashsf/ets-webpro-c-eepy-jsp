package com.eepy.eepy.model;

import java.sql.Date;

public class Booking {
    private int id;
    private int user_id;
    private int room_id;
    private String name;
    private String phone_number;
    private Date checkin;
    private Date checkout;
    private int price;
    private String payment_method;

    public Booking() {}

    public Booking(int id, int user_id, int room_id, String name, String phone_number, Date checkin, Date checkout, int price, String payment_method) {
        this.id = id;
        this.user_id = user_id;
        this.room_id = room_id;
        this.name = name;
        this.phone_number = phone_number;
        this.checkin = checkin;
        this.checkout = checkout;
        this.price = price;
        this.payment_method = payment_method;
    }

    // --- Getter dan Setter ---
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return user_id; }
    public void setUserId(int userId) { this.user_id = userId; }

    public int getRoomId() { return room_id; }
    public void setRoomId(int roomId) { this.room_id = roomId; }

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

    public String getPaymentMethod() { return payment_method; }
    public void setPaymentMethod(String paymentMethod) { this.payment_method = paymentMethod; }
}