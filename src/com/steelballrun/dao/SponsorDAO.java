package com.steelballrun.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.steelballrun.model.Sponsor;
import com.steelballrun.util.DatabaseConnection;

public class SponsorDAO {

	public List<Sponsor> listSponsors() {
		List<Sponsor> list = new ArrayList<>();
		String sql = "SELECT id, name FROM sponsor ORDER BY id";

		try (Connection conn = DatabaseConnection.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {

			while (rs.next()) {
				Sponsor sponsor = new Sponsor();
				sponsor.setId(rs.getInt("id"));
				sponsor.setName(rs.getString("name"));
				list.add(sponsor);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	public Sponsor getSponsorByID(int id) {
		String sql = "SELECT id, name FROM sponsor WHERE id = ?";

		try (Connection conn = DatabaseConnection.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setInt(1, id);

			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					Sponsor sponsor = new Sponsor();
					sponsor.setId(rs.getInt("id"));
					sponsor.setName(rs.getString("name"));
					return sponsor;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public boolean insertSponsor(Sponsor sponsor) {
		String sql = "INSERT INTO sponsor (id, name) VALUES (?, ?)";

		try (Connection conn = DatabaseConnection.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setInt(1, sponsor.getId());
			pstmt.setString(2, sponsor.getName());

			return pstmt.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	public boolean updateSponsor(Sponsor sponsor) {
		String sql = "UPDATE sponsor SET name = ? WHERE id = ?";

		try (Connection conn = DatabaseConnection.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setString(1, sponsor.getName());
			pstmt.setInt(2, sponsor.getId());

			return pstmt.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	public boolean deleteSponsor(int id) {
		String sql = "DELETE FROM sponsor WHERE id = ?";

		try (Connection conn = DatabaseConnection.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setInt(1, id);
			return pstmt.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	public int getNextId() {
		String sql = "SELECT MAX(id) FROM sponsor";

		try (Connection conn = DatabaseConnection.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {

			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 1;
	}
}
