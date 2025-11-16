package com.eepy.eepy;

import com.eepy.eepy.dao.RoomDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;

@WebServlet("/admin/rooms/delete")
public class RoomDeleteServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Connection conn = DBConnection.getConnection();
            RoomDAO roomDAO = new RoomDAO(conn);

            roomDAO.deleteRoom(id);

            response.sendRedirect(
                    request.getContextPath() + "/admin/admin_profile.jsp?active=rooms&delete=true"
            );
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/admin_profile.jsp?active=rooms&error=true");
        }
    }
}

