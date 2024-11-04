package com.project.taskmanager.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBFactory {
	private static final String URL = "jdbc:mysql://localhost:3306/task_manager";
    private static final String USER = "root";
    private static final String PASSWORD = "root123";
    
    public static Connection getConnection() throws SQLException {
        try {
        	Class.forName("com.mysql.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (SQLException e) {
            throw new SQLException("Erro ao conectar ao banco de dados: " + e.getMessage());
        } catch (Exception e2) {
			throw new RuntimeException(e2);
		}
    }
}
