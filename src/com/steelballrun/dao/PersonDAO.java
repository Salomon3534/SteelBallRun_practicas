package com.steelballrun.dao;

import java.sql.*;
import java.util.*;
import com.steelballrun.model.Person;
import com.steelballrun.util.DatabaseConnection;

public class PersonDAO {

    public List<Person> listPersons() {
        List<Person> list = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT id, name, age, country, dni FROM person");
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public Person getPersonByID(int id) {
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT id, name, age, country, dni FROM person WHERE id = ?")) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public int insertPersonAndGetId(Person p, Connection conn) throws SQLException {
        try (PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO person (name, age, country, dni) VALUES (?,?,?,?)",
                Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, p.getName());
            ps.setInt(2, p.getAge());
            ps.setString(3, p.getCountry());
            ps.setString(4, p.getDni());
            ps.executeUpdate();
            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) return keys.getInt(1);
            }
        }
        return -1;
    }

    private Person mapRow(ResultSet rs) throws SQLException {
        return new Person(rs.getInt("id"), rs.getString("name"),
                rs.getInt("age"), rs.getString("country"), rs.getString("dni"));
    }
}
