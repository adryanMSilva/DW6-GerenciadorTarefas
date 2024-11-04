package com.project.taskmanager.controllers;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.project.taskmanager.dto.TaskDTO;
import com.project.taskmanager.models.Task;
import com.project.taskmanager.utils.DBException;

@WebServlet("/tasks")
public class TaskController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		TaskDTO taskDTO = new TaskDTO();
		HttpSession session = request.getSession();
		List<Task> tasks = taskDTO.listTasksByUser((Integer) session.getAttribute("user_id"));
		request.setAttribute("tasks", tasks);
		request.getRequestDispatcher("task_list.jsp").forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    String action = request.getParameter("action");
	    TaskDTO taskDTO = new TaskDTO();
	    HttpSession session = request.getSession();
	    Integer userId = (Integer) session.getAttribute("user_id");

	    switch (action) {
	        case "add_task": {
	            String dueDateTimeString = request.getParameter("due_date");
	            LocalDateTime dueDateTime = dueDateTimeString != null ? LocalDateTime.parse(dueDateTimeString) : null;
	            Task task = new Task(userId, request.getParameter("title"), request.getParameter("description"), dueDateTime, false, LocalDateTime.now(), LocalDateTime.now());
	            try {
	                taskDTO.save(task);
	                response.sendRedirect("tasks?action=list_tasks");
	            } catch (DBException e) {
	                request.setAttribute("errorMessage", e.getMessage());
	                request.getRequestDispatcher("create_task.jsp").forward(request, response);
	            }
	            break;
	        }

	        case "delete_task": {
	            try {
	                taskDTO.delete(taskDTO.getTaskById(Integer.parseInt(request.getParameter("task_id"))));
	                response.sendRedirect("tasks?action=list_tasks");
	            } catch (DBException e) {
	                request.setAttribute("errorMessage", e.getMessage());
	                request.getRequestDispatcher("task_list.jsp").forward(request, response);
	            }
	            break;
	        }

	        case "update_task": {
	            int taskId = Integer.parseInt(request.getParameter("task_id"));
	            String title = request.getParameter("title");
	            String description = request.getParameter("description");
	            String dueDateStr = request.getParameter("due_date");
	            LocalDateTime dueDate = dueDateStr != null && !dueDateStr.isEmpty() ? LocalDateTime.parse(dueDateStr) : null;
	            boolean isCompleted = request.getParameter("is_completed") != null;

	            Task task = taskDTO.getTaskById(taskId);
	            task.setTitle(title);
	            task.setDescription(description);
	            task.setDueDate(dueDate);
	            task.setCompleted(isCompleted);
	            task.setUpdatedAt(LocalDateTime.now());

	            try {
	                taskDTO.update(task);
	                response.sendRedirect("tasks?action=list_tasks");
	            } catch (DBException e) {
	                request.setAttribute("errorMessage", e.getMessage());
	                request.getRequestDispatcher("edit_task.jsp").forward(request, response);
	            }
	            break;
	        }

	        default:
	            throw new IllegalArgumentException("Erro! Ação " + action + " não existe"); 
	    }
	}

}
