package com.steelballrun.dao;

import java.sql.*;
import java.util.*;
import com.steelballrun.util.DatabaseConnection;

public class MedicalCheckDAO {

	/**
	 * Insert a medical check. If passed=false, also sets runner status to 'retired'
	 * in the same transaction (Java-side complement to the DB trigger).
	 */
	public boolean insertCheck(int runnerId, boolean passed, String notes, java.util.Date checkDate) {
		String sql = "INSERT INTO medical_check (runner_id, check_date, passed, notes) VALUES (?,?,?,?)";
		try (Connection conn = DatabaseConnection.getConnection()) {
			conn.setAutoCommit(false);
			try (PreparedStatement ps = conn.prepareStatement(sql)) {
				ps.setInt(1, runnerId);
				ps.setTimestamp(2,
					checkDate != null ? new Timestamp(checkDate.getTime()) : new Timestamp(System.currentTimeMillis()));
				ps.setBoolean(3, passed);
				ps.setString(4, notes);
				ps.executeUpdate();
			}
			// If failed, retire the runner (Java-side fallback; DB trigger also does this)
			if (!passed) {
				try (PreparedStatement ps2 = conn.prepareStatement(
						"UPDATE runner SET status='retired' WHERE bib=? AND status='active'")) {
					ps2.setInt(1, runnerId);
					ps2.executeUpdate();
				}
			}
			conn.commit();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	public boolean deleteCheck(int id) {
		String sql = "DELETE FROM medical_check WHERE id=?";
		try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, id);
			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	public List<Map<String, Object>> listByRunner(int runnerId) {
		List<Map<String, Object>> list = new ArrayList<>();
		String sql = "SELECT id, check_date, passed, notes FROM medical_check WHERE runner_id = ? ORDER BY check_date DESC";
		try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, runnerId);
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					Map<String, Object> row = new LinkedHashMap<>();
					row.put("id", rs.getInt("id"));
					row.put("checkDate", rs.getTimestamp("check_date"));
					row.put("passed", rs.getBoolean("passed"));
					row.put("notes", rs.getString("notes"));
					list.add(row);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	public List<Map<String, Object>> listAll() {
		List<Map<String, Object>> list = new ArrayList<>();
		String sql = "SELECT mc.id, mc.runner_id, mc.check_date, mc.passed, mc.notes "
				+ "FROM medical_check mc ORDER BY mc.check_date DESC";
		try (Connection conn = DatabaseConnection.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			while (rs.next()) {
				Map<String, Object> row = new LinkedHashMap<>();
				row.put("id", rs.getInt("id"));
				row.put("runnerId", rs.getInt("runner_id"));
				row.put("checkDate", rs.getTimestamp("check_date"));
				row.put("passed", rs.getBoolean("passed"));
				row.put("notes", rs.getString("notes"));
				list.add(row);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
}
