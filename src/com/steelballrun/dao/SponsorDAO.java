package com.steelballrun.dao;

import java.sql.*;
import java.util.*;
import com.steelballrun.model.Sponsor;
import com.steelballrun.util.DatabaseConnection;

public class SponsorDAO {

    public List<Sponsor> listSponsors() {
        List<Sponsor> list = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT id, name FROM sponsor ORDER BY id");
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(new Sponsor(rs.getInt("id"), rs.getString("name")));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public boolean insertSponsor(Sponsor s) {
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("INSERT INTO sponsor (name) VALUES (?)")) {
            ps.setString(1, s.getName());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    public boolean updateSponsor(Sponsor s) {
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("UPDATE sponsor SET name = ? WHERE id = ?")) {
            ps.setString(1, s.getName());
            ps.setInt(2, s.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    public boolean deleteSponsor(int id) {
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("DELETE FROM sponsor WHERE id = ?")) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }
}
