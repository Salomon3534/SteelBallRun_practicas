package com.steelballrunrace.dao;

import com.steelballrunrace.model.Person;
import com.steelballrunrace.util.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class PersonDAO {

	public List<Person> listPersons() {
		
		List<Person> list = new ArrayList<>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = DatabaseConnection.getConnection();
			String sql = "SELECT p.id, p.nombre, p.edad, p.dni, e.carrera, e.promedio_notas "
					+ "FROM persona p INNER JOIN estudiante e ON p.id = e.persona_id";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				Person p = new Person(rs.getInt("id"), rs.getString("nombre"), sql, rs.getInt("edad"),
						rs.getString("dni"));

				Estudiante estudiante = new Estudiante(rs.getInt("id"), rs.getString("carrera"),
						rs.getDouble("promedio_notas"));
				estudiante.setPersona(persona);

				lista.add(estudiante);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return lista;
	}

	public Estudiante obtenerEstudiantePorId(int id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Estudiante estudiante = null;

		try {
			conn = DatabaseConnection.getConnection();
			String sql = "SELECT p.id, p.nombre, p.edad, p.dni, e.carrera, e.promedio_notas "
					+ "FROM persona p INNER JOIN estudiante e ON p.id = e.persona_id " + "WHERE p.id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				Persona persona = new Persona(rs.getInt("id"), rs.getString("nombre"), rs.getInt("edad"),
						rs.getString("dni"));
				estudiante = new Estudiante(rs.getInt("id"), rs.getString("carrera"), rs.getDouble("promedio_notas"));
				estudiante.setPersona(persona);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return estudiante;
	}

	public boolean actualizarEstudiante(Persona persona, Estudiante estudiante) {
		Connection conn = null;
		PreparedStatement pstmtPersona = null;
		PreparedStatement pstmtEstudiante = null;

		try {
			conn = DatabaseConnection.getConnection();
			conn.setAutoCommit(false);

			String sqlPersona = "UPDATE persona SET nombre = ?, edad = ?, dni = ? WHERE id = ?";
			pstmtPersona = conn.prepareStatement(sqlPersona);
			pstmtPersona.setString(1, persona.getNombre());
			pstmtPersona.setInt(2, persona.getEdad());
			pstmtPersona.setString(3, persona.getDni());
			pstmtPersona.setInt(4, persona.getId());
			pstmtPersona.executeUpdate();

			String sqlEstudiante = "UPDATE estudiante SET carrera = ?, promedio_notas = ? WHERE persona_id = ?";
			pstmtEstudiante = conn.prepareStatement(sqlEstudiante);
			pstmtEstudiante.setString(1, estudiante.getCarrera());
			pstmtEstudiante.setDouble(2, estudiante.getPromedioNotas());
			pstmtEstudiante.setInt(3, persona.getId());
			pstmtEstudiante.executeUpdate();

			conn.commit();
			return true;

		} catch (SQLException e) {
			if (conn != null) {
				try {
					conn.rollback();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}
			}
			e.printStackTrace();
			return false;
		} finally {
			try {
				if (pstmtPersona != null)
					pstmtPersona.close();
				if (pstmtEstudiante != null)
					pstmtEstudiante.close();
				if (conn != null) {
					conn.setAutoCommit(true);
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	public boolean eliminarEstudiante(int id) {
		Connection conn = null;
		PreparedStatement pstmtEstudiante = null;
		PreparedStatement pstmtPersona = null;

		try {
			conn = DatabaseConnection.getConnection();
			conn.setAutoCommit(false);

			String sqlEstudiante = "DELETE FROM estudiante WHERE persona_id = ?";
			pstmtEstudiante = conn.prepareStatement(sqlEstudiante);
			pstmtEstudiante.setInt(1, id);
			pstmtEstudiante.executeUpdate();

			String sqlPersona = "DELETE FROM persona WHERE id = ?";
			pstmtPersona = conn.prepareStatement(sqlPersona);
			pstmtPersona.setInt(1, id);
			pstmtPersona.executeUpdate();

			conn.commit();
			return true;

		} catch (SQLException e) {
			if (conn != null) {
				try {
					conn.rollback();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}
			}
			e.printStackTrace();
			return false;
		} finally {
			try {
				if (pstmtEstudiante != null)
					pstmtEstudiante.close();
				if (pstmtPersona != null)
					pstmtPersona.close();
				if (conn != null) {
					conn.setAutoCommit(true);
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	public boolean insertarEstudiante(Persona persona, Estudiante estudiante) {
		Connection conn = null;
		PreparedStatement pstmtPersona = null;
		PreparedStatement pstmtEstudiante = null;
		ResultSet rs = null;

		try {
			conn = DatabaseConnection.getConnection();
			conn.setAutoCommit(false);

			String sqlPersona = "INSERT INTO persona (nombre, edad, dni) VALUES (?, ?, ?)";
			pstmtPersona = conn.prepareStatement(sqlPersona, Statement.RETURN_GENERATED_KEYS);
			pstmtPersona.setString(1, persona.getNombre());
			pstmtPersona.setInt(2, persona.getEdad());
			pstmtPersona.setString(3, persona.getDni());

			int rowsPersona = pstmtPersona.executeUpdate();

			if (rowsPersona > 0) {
				rs = pstmtPersona.getGeneratedKeys();
				if (rs.next()) {
					int personaId = rs.getInt(1);

					String sqlEstudiante = "INSERT INTO estudiante (persona_id, carrera, promedio_notas) VALUES (?, ?, ?)";
					pstmtEstudiante = conn.prepareStatement(sqlEstudiante);
					pstmtEstudiante.setInt(1, personaId);
					pstmtEstudiante.setString(2, estudiante.getCarrera());
					pstmtEstudiante.setDouble(3, estudiante.getPromedioNotas());

					int rowsEstudiante = pstmtEstudiante.executeUpdate();

					if (rowsEstudiante > 0) {
						conn.commit();
						return true;
					}
				}
			}

			conn.rollback();
			return false;

		} catch (SQLException e) {
			if (conn != null) {
				try {
					conn.rollback();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}
			}
			e.printStackTrace();
			return false;
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmtPersona != null)
					pstmtPersona.close();
				if (pstmtEstudiante != null)
					pstmtEstudiante.close();
				if (conn != null) {
					conn.setAutoCommit(true);
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}
