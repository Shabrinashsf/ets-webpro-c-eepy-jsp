package com.eepy.eepy;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Timestamp;
import java.time.LocalDateTime;

@WebServlet("/booking-store")
public class BookingStoreServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8"); // penting kalau ada karakter unik
        try {
            // Ambil semua data dari form
            String userId = request.getParameter("user_id");
            String roomTypeId = request.getParameter("room_type_id");
            //harusnya roomid
            String name = request.getParameter("name");
            String phone = request.getParameter("phone");
            int totalPrice = Integer.parseInt(request.getParameter("total_price"));
            String checkin = request.getParameter("checkin");
            String checkout = request.getParameter("checkout");
            String paymentMethod = request.getParameter("payment_method");

            // Simpan ke DB
            try (Connection conn = DBConnection.getConnection()) {
                String sql = "INSERT INTO bookings (user_id, room_id, name, phone, checkin, checkout, payment_method, total_price) " +
                        "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setString(1, userId);
                    stmt.setString(2, roomTypeId);
                    stmt.setString(3, name);
                    stmt.setString(4, phone);
                    stmt.setString(5, checkin);
                    stmt.setString(6, checkout);
                    stmt.setInt(7, totalPrice);
                    stmt.setString(8, paymentMethod);

                    stmt.executeUpdate();
                }
            }

            // Redirect ke halaman konfirmasi / success
            response.sendRedirect(request.getContextPath() + "/booking-success.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            // kalau error, redirect ke halaman error
            response.sendRedirect(request.getContextPath() + "/booking-error.jsp");
        }
    }
}