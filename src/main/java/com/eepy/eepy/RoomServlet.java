package com.eepy.eepy;

import com.eepy.eepy.dao.RoomTypeDAO;
import com.eepy.eepy.model.RoomType;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet("/rooms")
public class RoomServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Connection conn = DBConnection.getConnection();
            RoomTypeDAO roomTypeDAO = new RoomTypeDAO(conn);

            List<RoomType> roomTypes = roomTypeDAO.getAllRoomTypes();
            request.setAttribute("roomTypes", roomTypes);

            conn.close();
            request.getRequestDispatcher("/room/room.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error.jsp");
        }
    }
}
