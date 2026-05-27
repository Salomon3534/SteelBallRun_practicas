package com.steelballrun.dao;

import java.io.InputStream;
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
			while (rs.next())
				list.add(mapRow(rs));
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	public Stage getStageByID(int id) {
		String sql = "SELECT id, name, location, completed, image FROM stage WHERE id = ?";
		try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, id);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next())
					return mapRow(rs);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public boolean insertStage(Stage s) {
		String sql = "INSERT INTO stage (name, location, completed, image) VALUES (?,?,?,?)";
		try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, s.getName());
			ps.setString(2, s.getLocation());
			ps.setBoolean(3, s.isCompleted());
			if (s.getImage() != null)
				ps.setBytes(4, s.getImage());
			else
				ps.setNull(4, Types.BLOB);
			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	public boolean updateStage(Stage s) {
		String sql = "UPDATE stage SET name=?, location=?, completed=? WHERE id=?";
		try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, s.getName());
			ps.setString(2, s.getLocation());
			ps.setBoolean(3, s.isCompleted());
			ps.setInt(4, s.getId());
			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	public boolean updateStageWithImage(Stage s) {
		String sql = "UPDATE stage SET name=?, location=?, completed=?, image=? WHERE id=?";
		try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, s.getName());
			ps.setString(2, s.getLocation());
			ps.setBoolean(3, s.isCompleted());
			if (s.getImage() != null)
				ps.setBytes(4, s.getImage());
			else
				ps.setNull(4, Types.BLOB);
			ps.setInt(5, s.getId());
			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	public boolean deleteStage(int id) {
		String sql = "DELETE FROM stage WHERE id=?";
		try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, id);
			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
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
