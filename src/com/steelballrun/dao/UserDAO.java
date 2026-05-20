package com.steelballrun.dao;

import java.sql.*;
import java.util.*;
import com.steelballrun.model.User;
import com.steelballrun.util.DatabaseConnection;

public class UserDAO {

    private static final String SELECT = "SELECT id, username, passkey, role, runner_id FROM user";

    public User findByCredentials(String username, String passkeyHash) {
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(
                     SELECT + " WHERE username = ? AND passkey = ?")) {
            ps.setString(1, username);
            ps.setString(2, passkeyHash);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public User findByUsername(String username) {
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT + " WHERE username = ?")) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public User findByRunnerId(int runnerId) {
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT + " WHERE runner_id = ?")) {
            ps.setInt(1, runnerId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public List<User> listAll() {
        List<User> list = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT + " ORDER BY id");
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    /** Insert inside an existing transaction (conn managed externally). */
    public int insertAndGetId(User u, Connection conn) throws SQLException {
        String sql = "INSERT INTO user (username, passkey, role, runner_id) VALUES (?,?,?,?)";
        try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, u.getUsername());
            ps.setString(2, u.getPasskey());
            ps.setString(3, u.getRole());
            if (u.getRunnerId() != null) ps.setInt(4, u.getRunnerId());
            else ps.setNull(4, Types.INTEGER);
            ps.executeUpdate();
            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) return keys.getInt(1);
            }
        }
        return -1;
    }

    public boolean insert(User u) {
        try (Connection conn = DatabaseConnection.getConnection()) {
            conn.setAutoCommit(true);
            return insertAndGetId(u, conn) > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    public boolean update(User u) {
        String sql = "UPDATE user SET username=?, passkey=?, role=?, runner_id=? WHERE id=?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, u.getUsername());
            ps.setString(2, u.getPasskey());
            ps.setString(3, u.getRole());
            if (u.getRunnerId() != null) ps.setInt(4, u.getRunnerId());
            else ps.setNull(4, Types.INTEGER);
            ps.setInt(5, u.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    public boolean delete(int id) {
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("DELETE FROM user WHERE id=?")) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    private User mapRow(ResultSet rs) throws SQLException {
        Integer runnerId = rs.getObject("runner_id") != null ? rs.getInt("runner_id") : null;
        return new User(rs.getInt("id"), rs.getString("username"),
                rs.getString("passkey"), rs.getString("role"), runnerId);
    }
}
