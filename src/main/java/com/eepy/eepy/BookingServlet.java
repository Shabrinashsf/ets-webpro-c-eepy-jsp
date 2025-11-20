package com.eepy.eepy;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.HashMap;
import java.util.Map;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@WebServlet("/booking")
public class BookingServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // ambil data dari query string
            String checkinStr = request.getParameter("checkin");
            String checkoutStr = request.getParameter("checkout");
            String roomName = request.getParameter("room_name");
            String roomID = request.getParameter("room_id");
            String priceStr = request.getParameter("price");
            String userIdStr = request.getParameter("user_id");

            int price = Integer.parseInt(priceStr);
            int userId = Integer.parseInt(userIdStr);

            // hitung jumlah malam
            LocalDate checkinDate = LocalDate.parse(checkinStr);
            LocalDate checkoutDate = LocalDate.parse(checkoutStr);
            long nights = ChronoUnit.DAYS.between(checkinDate, checkoutDate);

            // buat map data untuk dikirim ke JSP (mirip $data di Laravel)
            Map<String, Object> data = new HashMap<>();
            data.put("user_id", userId);
            data.put("room_name", roomName);
            data.put("checkin", checkinStr);
            data.put("checkout", checkoutStr);
            data.put("price_per_night", price);
            data.put("nights", nights);
            data.put("total_price", price * nights);
            data.put("room_id", roomID);

            // set attribute dan forward ke booking.jsp
            request.setAttribute("data", data);
            request.getRequestDispatcher("/booking/booking.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid price or date format.");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error.jsp");
        }
    }

    // protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { ... }
}