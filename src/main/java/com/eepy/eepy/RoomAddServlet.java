package com.eepy.eepy;

import com.eepy.eepy.dao.RoomDAO;
import com.eepy.eepy.model.Room;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;

@WebServlet("/admin/rooms/add")
public class RoomAddServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Connection conn = DBConnection.getConnection();
            RoomDAO roomDAO = new RoomDAO(conn);

            String number = request.getParameter("number");
            int typeId = Integer.parseInt(request.getParameter("room_type_id"));
            String status = request.getParameter("status");

            Room room = new Room();
            room.setNumber(number);
            room.setRoomTypeId(typeId);
            room.setStatus(status);

            roomDAO.createRoom(room);

            response.sendRedirect(
                    request.getContextPath() + "/admin/admin_profile.jsp?active=rooms&add=true"
            );
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/admin_profile.jsp?active=rooms&error=true");
        }
    }
}

