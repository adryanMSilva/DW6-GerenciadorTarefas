package com.project.taskmanager.models;

import java.time.LocalDateTime;

public class Task {
	private int taskId;
    private int userId;
    private String title;
    private String description;
    private LocalDateTime dueDate;
    private boolean isCompleted;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    
	public Task(int taskId, int userId, String title, String description, LocalDateTime dueDate, boolean isCompleted,
			LocalDateTime createdAt, LocalDateTime updatedAt) {
		super();
		this.taskId = taskId;
		this.userId = userId;
		this.title = title;
		this.description = description;
		this.dueDate = dueDate;
		this.isCompleted = isCompleted;
		this.createdAt = createdAt;
		this.updatedAt = updatedAt;
	}

	public Task(int userId, String title, String description, LocalDateTime dueDate, boolean isCompleted,
			LocalDateTime createdAt, LocalDateTime updatedAt) {
		super();
		this.userId = userId;
		this.title = title;
		this.description = description;
		this.dueDate = dueDate;
		this.isCompleted = isCompleted;
		this.createdAt = createdAt;
		this.updatedAt = updatedAt;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public LocalDateTime getDueDate() {
		return dueDate;
	}

	public void setDueDate(LocalDateTime dueDate) {
		this.dueDate = dueDate;
	}

	public boolean isCompleted() {
		return isCompleted;
	}

	public void setCompleted(boolean isCompleted) {
		this.isCompleted = isCompleted;
	}

	public LocalDateTime getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}

	public LocalDateTime getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(LocalDateTime updatedAt) {
		this.updatedAt = updatedAt;
	}

	public int getTaskId() {
		return taskId;
	}

	public int getUserId() {
		return userId;
	}

	public void setTaskId(int taskId) {
		this.taskId = taskId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}
}
