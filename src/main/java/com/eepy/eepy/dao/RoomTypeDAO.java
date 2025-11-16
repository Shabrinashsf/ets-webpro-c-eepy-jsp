package com.eepy.eepy.dao;

import com.eepy.eepy.model.RoomType;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class RoomTypeDAO {

    private final Connection conn;

    public RoomTypeDAO(Connection conn) {
        this.conn = conn;
    }

    public List<RoomType> getAllRoomTypes() throws Exception {
        List<RoomType> roomTypes = new ArrayList<>();

        // Ambil semua room types
        String sql = "SELECT * FROM room_types";
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            RoomType rt = new RoomType();
            rt.setId(rs.getInt("id"));
            rt.setName(rs.getString("name"));
            rt.setPrice(rs.getInt("price"));
            rt.setDescription(rs.getString("description"));
            rt.setArea(rs.getString("area"));
            rt.setCapacity(rs.getString("capacity"));

            // Facilities
            String fSql = "SELECT f.name FROM facilities f " +
                    "JOIN room_type_facilities rtf ON f.id = rtf.facility_id " +
                    "WHERE rtf.room_type_id=?";
            PreparedStatement fps = conn.prepareStatement(fSql);
            fps.setInt(1, rt.getId());
            ResultSet frs = fps.executeQuery();
            List<String> facilities = new ArrayList<>();
            while (frs.next()) {
                facilities.add(frs.getString("name"));
            }
            rt.setFacilities(facilities);

            roomTypes.add(rt);
        }

        return roomTypes;
    }
}