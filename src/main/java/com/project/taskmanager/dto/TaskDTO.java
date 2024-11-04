package com.project.taskmanager.dto;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import com.project.taskmanager.models.Task;
import com.project.taskmanager.utils.DBException;
import com.project.taskmanager.utils.DBFactory;

public class TaskDTO implements IDTO<Task> {

	private Connection conn;

	@Override
	public void save(Task obj) {
		String sql = "INSERT INTO tasks (user_id, title, description, due_date, is_completed, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?)";

		try {
			conn = DBFactory.getConnection();
			PreparedStatement statement = conn.prepareStatement(sql);
			statement.setInt(1, obj.getUserId());
			statement.setString(2, obj.getTitle());
			statement.setString(3, obj.getDescription());
			statement.setTimestamp(4, Timestamp.valueOf(obj.getDueDate()));
			statement.setBoolean(5, obj.isCompleted());
			statement.setTimestamp(6, Timestamp.valueOf(obj.getCreatedAt()));
			statement.setTimestamp(7, Timestamp.valueOf(obj.getUpdatedAt()));
			statement.executeUpdate();
		} catch (SQLException e) {
			throw new DBException("Erro ao inserir task" + e);
		}
	}

	@Override
	public void update(Task obj) {
		String sql = "UPDATE tasks SET title = ?, description = ?, due_date = ?, is_completed = ? WHERE task_id = ? AND user_id = ?";

	    try {
	        conn = DBFactory.getConnection();
	        PreparedStatement statement = conn.prepareStatement(sql);
	        
	        statement.setString(1, obj.getTitle());
	        statement.setString(2, obj.getDescription());
	        statement.setTimestamp(3, Timestamp.valueOf(obj.getDueDate())); 
	        statement.setBoolean(4, obj.isCompleted());
	        statement.setInt(5, obj.getTaskId());
	        statement.setInt(6, obj.getUserId());

	        int rowsAffected = statement.executeUpdate();
	        if (rowsAffected == 0) {
	            throw new DBException("Nenhuma task encontrada para atualização.");
	        }

	    } catch (SQLException e) {
	        throw new DBException("Erro ao editar task: " + e);
	    }
	}

	@Override
	public void delete(Task obj) {
		String sql = "DELETE FROM tasks WHERE task_id = ? AND user_id = ?";
		
		try {
			conn = DBFactory.getConnection();
			PreparedStatement statement = conn.prepareStatement(sql);
			statement.setInt(1, obj.getTaskId());
			statement.setInt(2, obj.getUserId());
			statement.executeUpdate();
		} catch (SQLException e) {
			throw new DBException("Erro ao deletar task" + e);
		}

	}

	public List<Task> listTasksByUser(Integer userId) {
		List<Task> tasks = new ArrayList<>();
		String sql = "SELECT * FROM tasks WHERE user_id = ?";
		try {
			conn = DBFactory.getConnection();
			PreparedStatement statement = conn.prepareStatement(sql);
			statement.setInt(1, userId);

			ResultSet set = statement.executeQuery();

			while (set.next()) {
				tasks.add(new Task(set.getInt("task_id"), userId, set.getString("title"), set.getString("description"),
						set.getTimestamp("due_date").toLocalDateTime(), set.getBoolean("is_completed"),
						set.getTimestamp("created_at").toLocalDateTime(),
						set.getTimestamp("updated_at").toLocalDateTime()));
			}

			return tasks;
		} catch (SQLException e) {
			throw new DBException("Erro ao recuperar tasks" + e);
		}
	}
	
	public Task getTaskById(int taskId) {
		String sql = "SELECT * FROM tasks WHERE task_id = ?";
		Task task = null;
		
		try {
			conn = DBFactory.getConnection();
			PreparedStatement statement = conn.prepareStatement(sql);
			statement.setInt(1, taskId);
			ResultSet set = statement.executeQuery();
			
			if(set.next()) {
				task = new Task(set.getInt("task_id"), set.getInt("user_id"), set.getString("title"), set.getString("description"),
						set.getTimestamp("due_date").toLocalDateTime(), set.getBoolean("is_completed"),
						set.getTimestamp("created_at").toLocalDateTime(),
						set.getTimestamp("updated_at").toLocalDateTime());
			}
			
			return task;
		} catch (SQLException e) {
			throw new DBException("Erro ao obter task " + e);
		}
	}

}
