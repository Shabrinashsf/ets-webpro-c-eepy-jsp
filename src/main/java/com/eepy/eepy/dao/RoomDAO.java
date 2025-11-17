package com.eepy.eepy.dao;

import com.eepy.eepy.model.Room;
import com.eepy.eepy.model.RoomType;
import com.eepy.eepy.model.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RoomDAO {

    private Connection conn;

    public RoomDAO(Connection conn) {
        this.conn = conn;
    }

    public List<Room> searchRooms(String keyword, int page, int entries) throws SQLException {
        List<Room> list = new ArrayList<>();
        String sql = "SELECT r.id, r.number, r.status, r.room_type_id, rt.name AS type_name " +
                "FROM rooms r LEFT JOIN room_types rt ON r.room_type_id = rt.id " +
                "WHERE r.number LIKE ? OR rt.name LIKE ? " +
                "LIMIT ? OFFSET ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + (keyword != null ? keyword : "") + "%");
            ps.setString(2, "%" + (keyword != null ? keyword : "") + "%");
            ps.setInt(3, entries);
            ps.setInt(4, (page - 1) * entries);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                RoomType type = new RoomType();
                type.setId(rs.getInt("room_type_id"));
                type.setName(rs.getString("type_name"));

                Room r = new Room();
                r.setId(rs.getInt("id"));
                r.setNumber(rs.getString("number"));
                r.setStatus(rs.getString("status"));
                r.setRoomTypeId(rs.getInt("room_type_id"));
                r.setRoomType(type);

                list.add(r);
            }
        }
        return list;
    }

    public int countRooms(String keyword) throws SQLException {
        String sql = "SELECT COUNT(*) FROM rooms r LEFT JOIN room_types rt ON r.room_type_id = rt.id " +
                "WHERE r.number LIKE ? OR rt.name LIKE ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + (keyword != null ? keyword : "") + "%");
            ps.setString(2, "%" + (keyword != null ? keyword : "") + "%");
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        }
        return 0;
    }

    public void createRoom(Room room) throws SQLException {
        String sql = "INSERT INTO rooms (number, status, room_type_id) VALUES (?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, room.getNumber());
            ps.setString(2, room.getStatus());
            ps.setInt(3, room.getRoomTypeId());
            ps.executeUpdate();
        }
    }

    public void updateRoom(Room room) throws SQLException {
        String sql = "UPDATE rooms SET number=?, status=?, room_type_id=? WHERE id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, room.getNumber());
            ps.setString(2, room.getStatus());
            ps.setInt(3, room.getRoomTypeId());
            ps.setInt(4, room.getId());
            ps.executeUpdate();
        }
    }

    public void deleteRoom(int id) throws SQLException {
        String sql = "DELETE FROM rooms WHERE id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    public List<RoomType> getAllRoomTypes() throws SQLException {
        List<RoomType> list = new ArrayList<>();
        String sql = "SELECT id, name, price, description FROM room_types";
        try (Statement st = conn.createStatement()) {
            ResultSet rs = st.executeQuery(sql);
            while(rs.next()) {
                RoomType rt = new RoomType();
                rt.setId(rs.getInt("id"));
                rt.setName(rs.getString("name"));
                rt.setPrice(rs.getInt("price"));
                list.add(rt);
            }
        }
        return list;
    }

    public Integer getRoomTypeIdByName(String name) throws SQLException {
        String sql = "SELECT id FROM room_types WHERE name = ? LIMIT 1";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, name);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("id");
            }
        }
        return null; // kalau gak ketemu
    }

    public static class UserDAO {
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

        public Integer getAvailableRoomId(int roomTypeId, Date checkin, Date checkout, List<Integer> bookedRoomIds) throws Exception {
            Integer availableRoomId = null;

            // Query untuk mencari kamar fisik berdasarkan room_type_id
            // dan yang ID-nya TIDAK ADA dalam daftar bookedRoomIds
            String sql = "SELECT id FROM rooms WHERE room_type_id = ? AND id NOT IN (?)";

            // Catatan: Statement 'id NOT IN (?)' dengan PreparedStatement bisa jadi tricky
            // jika List bookedRoomIds kosong atau besar. Kita akan memparsingnya secara dinamis.

            StringBuilder sqlBuilder = new StringBuilder("SELECT id FROM rooms WHERE room_type_id = ?");

            if (!bookedRoomIds.isEmpty()) {
                sqlBuilder.append(" AND id NOT IN (");
                for (int i = 0; i < bookedRoomIds.size(); i++) {
                    sqlBuilder.append("?");
                    if (i < bookedRoomIds.size() - 1) {
                        sqlBuilder.append(",");
                    }
                }
                sqlBuilder.append(")");
            }

            // Menambahkan ORDER BY RAND() untuk mengambil secara acak, seperti di Laravel
            sqlBuilder.append(" ORDER BY RAND() LIMIT 1");

            PreparedStatement ps = conn.prepareStatement(sqlBuilder.toString());

            int paramIndex = 1;
            ps.setInt(paramIndex++, roomTypeId);

            if (!bookedRoomIds.isEmpty()) {
                for (int roomId : bookedRoomIds) {
                    ps.setInt(paramIndex++, roomId);
                }
            }

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                availableRoomId = rs.getInt("id");
            }

            return availableRoomId;
        }
    }
}
