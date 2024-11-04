package com.project.taskmanager.dto;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.project.taskmanager.models.User;
import com.project.taskmanager.utils.DBException;
import com.project.taskmanager.utils.DBFactory;

public class UserDTO implements IDTO<User>{
	
	private Connection conn;

	@Override
	public void save(User obj) {
		String sql = "INSERT INTO users(username, email, password) values(?, ?, ?)";
		
		try {
			conn = DBFactory.getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, obj.getUsername());
			stmt.setString(2, obj.getEmail());
			stmt.setString(3, obj.getPassword());
			stmt.executeUpdate();
		} catch (SQLException e) {
			throw new DBException("Erro ao inserir o user" + e);
		}
				
		
	}

	@Override
	public void update(User obj) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(User obj) {
		// TODO Auto-generated method stub
		
	}
	
	public User login(String email, String senha) {
		String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
		
		try {
			conn = DBFactory.getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, email);
			stmt.setString(2, senha);
			
			ResultSet set = stmt.executeQuery();
			
			if(set.next()) {
				User u = new User(set.getInt("user_id"), set.getString("username"), set.getString("email"), set.getString("password"));
				return u;
			} else {
				throw new DBException("Usuário não encontrado");
			}
		} catch (SQLException e) {
			throw new DBException("Erro ao buscar o usuário" + e);
		}
	}

}
