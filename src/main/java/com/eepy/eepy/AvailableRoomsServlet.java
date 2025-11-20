package com.eepy.eepy;

import com.eepy.eepy.dao.BookingDAO;
import com.eepy.eepy.model.RoomType;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/available-rooms")
public class AvailableRoomsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String checkinStr = request.getParameter("checkin");
        String checkoutStr = request.getParameter("checkout");

        Map<Integer, List<Integer>> availableRoomsMap = new HashMap<>();
        Map<Integer, Integer> randomPickMap = new HashMap<>();

        try (Connection conn = DBConnection.getConnection()) {
            BookingDAO bookingDAO = new BookingDAO(conn);
            List<RoomType> roomTypes = bookingDAO.getAllRoomTypes(conn);

            for (RoomType roomType : roomTypes) {
                List<Integer> bookedIds = bookingDAO.getBookedRoomIdsByRoomType(
                        roomType.getId(),
                        java.sql.Date.valueOf(checkinStr),
                        java.sql.Date.valueOf(checkoutStr)
                );

                List<Integer> allRoomIds = bookingDAO.getAllRoomIdsByRoomType(roomType.getId());
                allRoomIds.removeAll(bookedIds);

                int selectedRoomId = -1;
                if (!allRoomIds.isEmpty()) {
                    selectedRoomId = allRoomIds.get(new java.util.Random().nextInt(allRoomIds.size()));
                }

                availableRoomsMap.put(roomType.getId(), allRoomIds);
                randomPickMap.put(roomType.getId(), selectedRoomId);
            }

            Map<String, Object> responseData = new HashMap<>();
            responseData.put("availableRooms", availableRoomsMap);
            responseData.put("randomPick", randomPickMap);

            response.setContentType("application/json");
            response.getWriter().write(new Gson().toJson(responseData));

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Server error");
        }
    }
}


