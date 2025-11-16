package com.eepy.eepy.dao;

import com.eepy.eepy.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    private Connection conn;

    public UserDAO(Connection conn) {
        this.conn = conn;
    }

    public List<User> searchUsers(String keyword, int page, int entries) throws SQLException {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE name LIKE ? OR email LIKE ? LIMIT ? OFFSET ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + (keyword != null ? keyword : "") + "%");
            ps.setString(2, "%" + (keyword != null ? keyword : "") + "%");
            ps.setInt(3, entries);
            ps.setInt(4, (page - 1) * entries);
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                User u = new User();
                u.setId(rs.getInt("id"));
                u.setName(rs.getString("name"));
                u.setEmail(rs.getString("email"));
                u.setPassword(rs.getString("password"));
                u.setTelpNumber(rs.getString("telp_number"));
                u.setRole(rs.getString("role"));
                list.add(u);
            }
        }
        return list;
    }

    public int countUsers(String keyword) throws SQLException {
        String sql = "SELECT COUNT(*) FROM users WHERE name LIKE ? OR email LIKE ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + (keyword != null ? keyword : "") + "%");
            ps.setString(2, "%" + (keyword != null ? keyword : "") + "%");
            ResultSet rs = ps.executeQuery();
            if(rs.next()) return rs.getInt(1);
        }
        return 0;
    }

    public void createUser(User user) throws SQLException {
        String sql = "INSERT INTO users (name, email, password, telp_number, role) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getTelpNumber());
            ps.setString(5, user.getRole());
            ps.executeUpdate();
        }
    }

    public void updateUser(User user) throws SQLException {
        String sql = "UPDATE users SET name=?, email=?, telp_number=?, role=? WHERE id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getTelpNumber());
            ps.setString(4, user.getRole());
            ps.setInt(5, user.getId());
            ps.executeUpdate();
        }
    }

    public void deleteUser(int id) throws SQLException {
        String sql = "DELETE FROM users WHERE id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    public User getUserById(int id) throws SQLException {
        String sql = "SELECT * FROM users WHERE id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                User u = new User();
                u.setId(rs.getInt("id"));
                u.setName(rs.getString("name"));
                u.setEmail(rs.getString("email"));
                u.setPassword(rs.getString("password"));
                u.setTelpNumber(rs.getString("telp_number"));
                u.setRole(rs.getString("role"));
                return u;
            }
        }
        return null;
    }
}