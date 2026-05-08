package com.steelballrunrace.dao;

import com.steelballrunrace.model.Person;
import com.steelballrunrace.util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PersonDAO {

	public List<Person> listPersons() {
		List<Person> list = new ArrayList<>();
		String sql = "SELECT id, name, surnames, age, dni FROM person";

		try (Connection conn = DatabaseConnection.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {

			while (rs.next()) {
				list.add(new Person(rs.getInt("id"), rs.getString("name"), rs.getString("surnames"), rs.getInt("age"),
						rs.getString("dni")));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	public Person getPersonByID(int id) {
		String sql = "SELECT id, name, surnames, age, dni FROM person WHERE id = ?";

		try (Connection conn = DatabaseConnection.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setInt(1, id);
			
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					return new Person(rs.getInt("id"), rs.getString("name"), rs.getString("surnames"), rs.getInt("age"),
							rs.getString("dni"));
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public boolean insertPerson(Person person) {
		String sql = "INSERT INTO person (id, name, surnames, age, dni) VALUES (?, ?, ?, ?, ?)";

		try (Connection conn = DatabaseConnection.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setInt(1, person.getId());
			pstmt.setString(2, person.getName());
			pstmt.setString(3, person.getSurnames());
			pstmt.setInt(4, person.getAge());
			pstmt.setString(5, person.getDni());

			return pstmt.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	public boolean updatePerson(Person person) {
		String sql = "UPDATE person SET name = ?, surnames = ?, age = ?, dni = ? WHERE id = ?";

		try (Connection conn = DatabaseConnection.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setString(1, person.getName());
			pstmt.setString(2, person.getSurnames());
			pstmt.setInt(3, person.getAge());
			pstmt.setString(4, person.getDni());
			pstmt.setInt(5, person.getId());

			return pstmt.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	public boolean deletePerson(int id) {
		String sql = "DELETE FROM person WHERE id = ?";

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