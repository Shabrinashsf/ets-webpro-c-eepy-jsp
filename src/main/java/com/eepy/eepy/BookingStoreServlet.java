package com.eepy.eepy;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/booking-store")
public class BookingStoreServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8"); // penting kalau ada karakter unik
        try {
            // Ambil semua data dari form
            String user_idStr = request.getParameter("user_id");
            //String room_idStr = request.getParameter("room_id");
            String name = request.getParameter("name");
            String phone = request.getParameter("phone_number");
            String checkin = request.getParameter("checkin");
            String priceStr = request.getParameter("price");
            String checkout = request.getParameter("checkout");
            String paymentMethod = request.getParameter("payment_method");

            int price = Integer.parseInt(priceStr);
            int user_id = Integer.parseInt(user_idStr);
            //int room_id = Integer.parseInt(room_idStr);

            // Simpan ke DB
            try (Connection conn = DBConnection.getConnection()) {
                String sql = "INSERT INTO bookings (user_id, room_id, name, phone_number, checkin, checkout, price, payment_method) " +
                        "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setInt(1, user_id);
                    stmt.setInt(2, 1);
                    stmt.setString(3, name);
                    stmt.setString(4, phone);
                    stmt.setString(5, checkin);
                    stmt.setString(6, checkout);
                    stmt.setInt(7, price);
                    stmt.setString(8, paymentMethod);

                    stmt.executeUpdate();
                }
            }

            // Redirect ke halaman konfirmasi / success
            response.sendRedirect(request.getContextPath() + "/booking-success.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            // kalau error, redirect ke halaman error
            //response.sendRedirect(request.getContextPath() + "/booking-error.jsp");

            response.setContentType("text/plain");
            response.setCharacterEncoding("UTF-8");

            response.getWriter().write("ERROR: " + e.getMessage());
        }
    }
}