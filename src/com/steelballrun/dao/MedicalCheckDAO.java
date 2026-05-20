package com.steelballrun.dao;

import java.sql.*;
import java.util.Date;
import com.steelballrun.util.DatabaseConnection;

public class MedicalCheckDAO {

    public boolean insertCheck(int runnerId, boolean passed, String notes, Date checkDate) {
        String sql = "INSERT INTO medical_check (runner_id, check_date, passed, notes) VALUES (?,?,?,?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, runnerId);
            ps.setTimestamp(2, checkDate != null ? new Timestamp(checkDate.getTime()) : new Timestamp(System.currentTimeMillis()));
            ps.setBoolean(3, passed);
            ps.setString(4, notes);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }
}
