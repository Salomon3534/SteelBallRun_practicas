package com.steelballrun.dao;

import java.sql.*;
import java.util.*;
import com.steelballrun.model.Runner;
import com.steelballrun.util.DatabaseConnection;

public class RunnerDAO {

	private static final String SELECT =
		"SELECT bib, id_person, id_mount, image, points, km, id_stage, status FROM runner";

	public List<Runner> listRunners() {
		List<Runner> list = new ArrayList<>();
		try (Connection conn = DatabaseConnection.getConnection();
				PreparedStatement ps = conn.prepareStatement(SELECT + " ORDER BY bib");
				ResultSet rs = ps.executeQuery()) {
			while (rs.next()) list.add(mapRow(rs));
		} catch (SQLException e) { e.printStackTrace(); }
		return list;
	}

	public List<Runner> listRunnersTop(int limit) {
		List<Runner> list = new ArrayList<>();
		try (Connection conn = DatabaseConnection.getConnection();
				PreparedStatement ps = conn.prepareStatement(SELECT + " ORDER BY points DESC LIMIT ?")) {
			ps.setInt(1, limit);
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) list.add(mapRow(rs));
			}
		} catch (SQLException e) { e.printStackTrace(); }
		return list;
	}

	public Runner getRunnerByBib(int bib) {
		try (Connection conn = DatabaseConnection.getConnection();
				PreparedStatement ps = conn.prepareStatement(SELECT + " WHERE bib = ?")) {
			ps.setInt(1, bib);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) return mapRow(rs);
			}
		} catch (SQLException e) { e.printStackTrace(); }
		return null;
	}

	public boolean insertRunner(Runner r, Connection conn) throws SQLException {
		String sql = "INSERT INTO runner (id_person, id_mount, image, points, km, id_stage, status) VALUES (?,?,?,?,?,?,?)";
		try (PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, r.getIdPerson());
			ps.setInt(2, r.getIdMount());
			ps.setBytes(3, r.getImage());
			setNullableInt(ps, 4, r.getPoints());
			setNullableInt(ps, 5, r.getKm());
			setNullableInt(ps, 6, r.getIdStage());
			ps.setString(7, r.getStatus() != null ? r.getStatus() : "active");
			return ps.executeUpdate() > 0;
		}
	}

	public boolean updateRunner(Runner r) {
		String sql = "UPDATE runner SET id_person=?, id_mount=?, image=?, points=?, km=?, id_stage=?, status=? WHERE bib=?";
		try (Connection conn = DatabaseConnection.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, r.getIdPerson());
			ps.setInt(2, r.getIdMount());
			ps.setBytes(3, r.getImage());
			setNullableInt(ps, 4, r.getPoints());
			setNullableInt(ps, 5, r.getKm());
			setNullableInt(ps, 6, r.getIdStage());
			ps.setString(7, r.getStatus() != null ? r.getStatus() : "active");
			ps.setInt(8, r.getBib());
			return ps.executeUpdate() > 0;
		} catch (SQLException e) { e.printStackTrace(); return false; }
	}

	public boolean updateStatus(int bib, String status) {
		try (Connection conn = DatabaseConnection.getConnection();
				PreparedStatement ps = conn.prepareStatement("UPDATE runner SET status=? WHERE bib=?")) {
			ps.setString(1, status);
			ps.setInt(2, bib);
			return ps.executeUpdate() > 0;
		} catch (SQLException e) { e.printStackTrace(); return false; }
	}

	public boolean dropout(int bib)    { return updateStatus(bib, "retired"); }
	public boolean disqualify(int bib) { return updateStatus(bib, "disqualified"); }

	public boolean deleteRunner(int bib) {
		try (Connection conn = DatabaseConnection.getConnection();
				PreparedStatement ps = conn.prepareStatement("DELETE FROM runner WHERE bib = ?")) {
			ps.setInt(1, bib);
			return ps.executeUpdate() > 0;
		} catch (SQLException e) { e.printStackTrace(); return false; }
	}

	private Runner mapRow(ResultSet rs) throws SQLException {
		Runner r = new Runner();
		r.setBib(rs.getInt("bib"));
		r.setIdPerson(rs.getInt("id_person"));
		r.setIdMount(rs.getInt("id_mount"));
		r.setImage(rs.getBytes("image"));
		r.setPoints(rs.getObject("points") != null ? rs.getInt("points") : null);
		r.setKm(rs.getObject("km") != null ? rs.getInt("km") : null);
		r.setIdStage(rs.getObject("id_stage") != null ? rs.getInt("id_stage") : null);
		String st = rs.getString("status");
		r.setStatus(st != null ? st : "active");
		return r;
	}

	private void setNullableInt(PreparedStatement ps, int idx, Integer val) throws SQLException {
		if (val != null) ps.setInt(idx, val);
		else ps.setNull(idx, Types.INTEGER);
	}
}
