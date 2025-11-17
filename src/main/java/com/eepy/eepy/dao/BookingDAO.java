package com.eepy.eepy.dao;

import com.eepy.eepy.model.Booking;
import com.eepy.eepy.model.RoomType;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {

    private final Connection conn;

    public BookingDAO(Connection conn) {
        this.conn = conn;
    }

    /**
     * Mendapatkan daftar ID kamar fisik yang sudah dipesan dalam periode check-in/out yang diberikan.
     * Logika ini meniru query ketersediaan kamar di BookingController.php Anda.
     */
    public List<Integer> getBookedRoomIds(Date checkin, Date checkout) throws Exception {
        List<Integer> bookedRoomIds = new ArrayList<>();

        String sql = "SELECT roomid FROM bookings WHERE " +
                // Konflik 1: Existing booking starts during the period
                "checkin BETWEEN ? AND ? OR " +
                // Konflik 2: Existing booking ends during the period
                "checkout BETWEEN ? AND ? OR " +
                // Konflik 3: New period is entirely within an existing booking
                "(checkin < ? AND checkout > ?)";

        PreparedStatement ps = conn.prepareStatement(sql);

        // Parameter untuk Konflik 1: q.whereBetween('checkin', [checkin, checkout])
        ps.setDate(1, checkin);
        ps.setDate(2, checkout);

        // Parameter untuk Konflik 2: orWhereBetween('checkout', [checkin, checkout])
        ps.setDate(3, checkin);
        ps.setDate(4, checkout);

        // Parameter untuk Konflik 3: orWhere(checkin < checkin AND checkout > checkout)
        ps.setDate(5, checkin);
        ps.setDate(6, checkout);

        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            bookedRoomIds.add(rs.getInt("roomid"));
        }

        return bookedRoomIds;
    }

    /**
     * Menyimpan objek Booking baru ke database.
     */
    public int createBooking(Booking booking) throws Exception {
        String sql = "INSERT INTO bookings (userid, roomid, name, checkin, checkout, price, paymentMethod) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";

        PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

        ps.setInt(1, booking.getUserId());
        ps.setInt(2, booking.getRoomId());
        ps.setString(3, booking.getName());
        ps.setDate(4, booking.getCheckin());
        ps.setDate(5, booking.getCheckout());
        ps.setInt(6, booking.getPrice());
        ps.setString(7, booking.getPaymentMethod());

        int rowAffected = ps.executeUpdate();

        if (rowAffected > 0) {
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1); // Mengembalikan ID booking yang baru dibuat
            }
        }
        return -1; // Gagal
    }

    public List<RoomType> getAllRoomTypes(Connection conn) throws SQLException {
        List<RoomType> roomTypes = new ArrayList<>();
        String sql = "SELECT id, name, price, description, area, capacity FROM room_types";
        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                RoomType roomType = new RoomType();
                roomType.setId(rs.getInt("id"));
                roomType.setName(rs.getString("name"));
                roomType.setPrice(rs.getInt("price"));
                roomType.setDescription(rs.getString("description"));
                roomType.setArea(rs.getString("area"));
                roomType.setCapacity(rs.getString("capacity"));
                roomTypes.add(roomType);
            }
        }
        return roomTypes;
    }

    public List<Integer> getAllRoomIdsByRoomType(int roomTypeId) throws SQLException {
        List<Integer> roomIds = new ArrayList<>();
        String sql = "SELECT id FROM rooms WHERE room_type_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, roomTypeId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    roomIds.add(rs.getInt("id"));
                }
            }
        }
        return roomIds;
    }

    public List<Integer> getBookedRoomIdsByRoomType(int roomTypeId, Date checkin, Date checkout) throws SQLException {
        List<Integer> bookedIds = new ArrayList<>();
        String sql = "SELECT room_id FROM bookings b JOIN rooms r ON b.room_id = r.id " +
                "WHERE r.room_type_id = ? AND " +
                "((b.checkin BETWEEN ? AND ?) OR " +
                "(b.checkout BETWEEN ? AND ?) OR " +
                "(b.checkin < ? AND b.checkout > ?))";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, roomTypeId);
            stmt.setDate(2, checkin);
            stmt.setDate(3, checkout);
            stmt.setDate(4, checkin);
            stmt.setDate(5, checkout);
            stmt.setDate(6, checkin);
            stmt.setDate(7, checkout);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    bookedIds.add(rs.getInt("roomid"));
                }
            }
        }
        return bookedIds;
    }
}
