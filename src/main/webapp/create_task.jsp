<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Criar Nova Tarefa</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .task-container {
            background-color: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            width: 400px;
            box-sizing: border-box;
        }
        h1 {
            color: #333;
            margin-bottom: 20px;
            text-align: center;
        }
        input[type="text"],
        textarea,
        input[type="date"],
        button {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
            box-sizing: border-box;
        }
        textarea {
            height: 100px;
            resize: vertical;
        }
        button {
            background-color: #007bff;
            color: white;
            border: none;
            cursor: pointer;
        }
        button:hover {
            background-color: #0056b3;
        }
        .error-message {
            color: red;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="task-container">
        <h1>Criar Nova Tarefa</h1>
        <% 
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null) { 
        %>
            <div class="error-message"><%= errorMessage %></div>
        <% 
            } 
        %>
        <form action="tasks" method="post">
            <input type="hidden" name="action" value="add_task">
            <input type="text" name="title" placeholder="Título" required>
            <textarea name="description" placeholder="Descrição" required></textarea>
            <input type="datetime-local" name="due_date" required>
            <button type="submit">Criar Tarefa</button>
        </form>
    </div>
</body>
</html>
