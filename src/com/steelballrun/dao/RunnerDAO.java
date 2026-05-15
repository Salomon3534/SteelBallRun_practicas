package com.steelballrun.dao;

import com.steelballrun.model.Runner;
import com.steelballrun.util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RunnerDAO {

	public List<Runner> listRunners() {
		List<Runner> list = new ArrayList<>();
		String sql = "SELECT id, name, surnames, age, nationality, mount_id, bib, current_place, total_points FROM runner";

		try (Connection conn = DatabaseConnection.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {

			while (rs.next()) {
				Runner runner = new Runner();
				runner.setId(rs.getInt("id"));
				runner.setName(rs.getString("name"));
				runner.setSurnames(rs.getString("surnames"));
				runner.setAge(rs.getInt("age"));
				runner.setNationality(rs.getString("nationality"));
				runner.setMountId(rs.getInt("mount_id"));
				runner.setBib(rs.getInt("bib"));
				runner.setCurrentPlace(rs.getInt("current_place"));
				runner.setTotalPoints(rs.getInt("total_points"));
				list.add(runner);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	public Runner getRunnerByID(int id) {
		String sql = "SELECT id, name, surnames, age, nationality, mount_id, bib, current_place, total_points FROM runner WHERE id = ?";

		try (Connection conn = DatabaseConnection.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setInt(1, id);

			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					Runner runner = new Runner();
					runner.setId(rs.getInt("id"));
					runner.setName(rs.getString("name"));
					runner.setSurnames(rs.getString("surnames"));
					runner.setAge(rs.getInt("age"));
					runner.setNationality(rs.getString("nationality"));
					runner.setMountId(rs.getInt("mount_id"));
					runner.setBib(rs.getInt("bib"));
					runner.setCurrentPlace(rs.getInt("current_place"));
					runner.setTotalPoints(rs.getInt("total_points"));
					return runner;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public boolean insertRunner(Runner runner) {
		String sql = "INSERT INTO runner (id, name, surnames, age, nationality, mount_id, current_place, total_points) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

		try (Connection conn = DatabaseConnection.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setInt(1, runner.getId());
			pstmt.setString(2, runner.getName());
			pstmt.setString(3, runner.getSurnames());
			pstmt.setInt(4, runner.getAge());
			pstmt.setString(5, runner.getNationality());
			pstmt.setInt(6, runner.getMountId());
			pstmt.setInt(7, runner.getCurrentPlace());
			pstmt.setInt(8, runner.getTotalPoints());

			return pstmt.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	public boolean updateRunner(Runner runner) {
		String sql = "UPDATE runner SET name = ?, surnames = ?, age = ?, nationality = ?, mount_id = ?, current_place = ?, total_points = ? WHERE id = ?";

		try (Connection conn = DatabaseConnection.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setString(1, runner.getName());
			pstmt.setString(2, runner.getSurnames());
			pstmt.setInt(3, runner.getAge());
			pstmt.setString(4, runner.getNationality());
			pstmt.setInt(5, runner.getMountId());
			pstmt.setInt(6, runner.getCurrentPlace());
			pstmt.setInt(7, runner.getTotalPoints());
			pstmt.setInt(8, runner.getId());

			return pstmt.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	public boolean deleteRunner(int id) {
		String sql = "DELETE FROM runner WHERE id = ?";

		try (Connection conn = DatabaseConnection.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setInt(1, id);
			return pstmt.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}
}
