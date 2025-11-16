package com.eepy.eepy;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.mindrot.jbcrypt.BCrypt;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String telpNumber = request.getParameter("telp_number");

        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

        try (Connection conn = DBConnection.getConnection()) {
            String checkSql = "SELECT id FROM users WHERE email = ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkSql);
            checkStmt.setString(1, email);

            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                // email sudah dipakai
                response.sendRedirect("register/register.jsp?error=email_used");
                return;
            }

            String insertSql  = "INSERT INTO users (name, email, password, telp_number, role) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(insertSql);
            stmt.setString(1, name);
            stmt.setString(2, email);
            stmt.setString(3, hashedPassword);
            stmt.setString(4, telpNumber);
            stmt.setString(5, "user");

            int result = stmt.executeUpdate();

            if (result > 0) {
                response.sendRedirect("login/login.jsp");
            } else {
                response.sendRedirect("register/register.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp");
        }
    }
}
