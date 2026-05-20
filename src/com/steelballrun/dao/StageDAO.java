package com.steelballrun.dao;

import java.sql.*;
import java.util.*;
import com.steelballrun.model.Stage;
import com.steelballrun.util.DatabaseConnection;

public class StageDAO {

    public List<Stage> listStages() {
        List<Stage> list = new ArrayList<>();
        String sql = "SELECT id, name, location, completed, image FROM stage ORDER BY id";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public Stage getStageByID(int id) {
        String sql = "SELECT id, name, location, completed, image FROM stage WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    private Stage mapRow(ResultSet rs) throws SQLException {
        Stage s = new Stage();
        s.setId(rs.getInt("id"));
        s.setName(rs.getString("name"));
        s.setLocation(rs.getString("location"));
        s.setCompleted(rs.getBoolean("completed"));
        s.setImage(rs.getBytes("image"));
        return s;
    }
}
