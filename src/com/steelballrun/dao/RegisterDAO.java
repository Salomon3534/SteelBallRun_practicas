package com.steelballrun.dao;

import java.sql.*;
import java.sql.Date;
import java.util.*;
import com.steelballrun.model.Register;
import com.steelballrun.util.DatabaseConnection;

public class RegisterDAO {

    public boolean insertRegister(Register reg) {
        String sql = "INSERT INTO register (runner_id, stage_id, saddle_number, registration_date) VALUES (?,?,?,?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            if (reg.getRunnerId() > 0) ps.setInt(1, reg.getRunnerId());
            else ps.setNull(1, Types.INTEGER);
            if (reg.getStageId() > 0) ps.setInt(2, reg.getStageId());
            else ps.setNull(2, Types.INTEGER);
            ps.setInt(3, reg.getSaddleNumber());
            Date d = (Date) reg.getRegistrationDate();
            ps.setTimestamp(4, d != null ? new Timestamp(d.getTime()) : new Timestamp(System.currentTimeMillis()));
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    public List<Register> listRegisters() {
        List<Register> list = new ArrayList<>();
        String sql = "SELECT id, runner_id, stage_id, saddle_number, registration_date FROM register ORDER BY registration_date DESC";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Register r = new Register();
                r.setId(rs.getInt("id"));
                r.setRunnerId(rs.getInt("runner_id"));
                r.setStageId(rs.getInt("stage_id"));
                r.setSaddleNumber(rs.getInt("saddle_number"));
                r.setRegistrationDate(rs.getTimestamp("registration_date"));
                list.add(r);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }
}
