package com.steelballrun.dao;

import java.sql.*;
import java.util.*;
import com.steelballrun.model.Mount;
import com.steelballrun.util.DatabaseConnection;

public class MountDAO {

    public List<Mount> listMounts() {
        List<Mount> list = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT id, name, type FROM mount ORDER BY id");
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public Mount getMountByID(int id) {
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT id, name, type FROM mount WHERE id = ?")) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public int insertMountAndGetId(Mount m, Connection conn) throws SQLException {
        try (PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO mount (name, type) VALUES (?,?)",
                Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, m.getName());
            ps.setString(2, m.getType());
            ps.executeUpdate();
            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) return keys.getInt(1);
            }
        }
        return -1;
    }

    private Mount mapRow(ResultSet rs) throws SQLException {
        return new Mount(rs.getInt("id"), rs.getString("name"), rs.getString("type"));
    }
}
