package com.project.taskmanager.controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.project.taskmanager.dto.UserDTO;
import com.project.taskmanager.models.User;
import com.project.taskmanager.utils.DBException;


@WebServlet("/users")
public class UserController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		UserDTO userDTO = new UserDTO();
		
		switch (action) {
		case "register": {
			User u = new User(request.getParameter("username"), request.getParameter("email"), request.getParameter("password"));
			
			try {
				userDTO.save(u);
			} catch (DBException e) {
				String errorMessage = "";
				if(e.getMessage().contains("Duplicate entry")) {
					errorMessage = "Erro: Email já cadastrado.";
				} else {
					errorMessage = "Erro ao cadastrar o usuario. Tente novamente mais tarde";
				}
				
				request.setAttribute("errorMessage", errorMessage);
				request.getRequestDispatcher("register.jsp").forward(request, response);
			} 
			
			break;
		}
		
		case "login": {
			String email = request.getParameter("email");
			String password = request.getParameter("password");
			
			try {
				User u = userDTO.login(email, password);
				HttpSession session = request.getSession();
				session.setAttribute("user_id", u.getId());
				response.sendRedirect("tasks?action=list_tasks");
			} catch(DBException e) {
				request.setAttribute("errorMessage", e.getMessage());
				request.getRequestDispatcher("login.jsp").forward(request, response);
			}
			break;
		}
		
		case "update": {
			response.getWriter().println("Update");
			break;
		}
		
		default:
			throw new IllegalArgumentException("Erro! Ação " + action + " não existe"); 
		}
	}

}
