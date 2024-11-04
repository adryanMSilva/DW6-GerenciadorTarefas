<%@ page import="com.project.taskmanager.models.Task" %> 
<%@ page import="com.project.taskmanager.dto.TaskDTO" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    int taskId = Integer.parseInt(request.getParameter("task_id"));
    TaskDTO taskDAO = new TaskDTO();
    Task task = taskDAO.getTaskById(taskId);
%>
<!DOCTYPE html>
<html>
<head>
    <title>Editar Tarefa</title>
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
        .edit-task-container {
            background-color: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            width: 400px;
            box-sizing: border-box;
        }
        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
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
        label {
            display: inline-block;
            margin-top: 10px;
            font-size: 16px;
        }

        .switch {
            position: relative;
            display: inline-block;
            width: 40px;
            height: 20px;
        }

        .switch input {
            opacity: 0;
            width: 0;
            height: 0;
        }

        .slider {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: #ccc;
            transition: .4s;
            border-radius: 20px;
        }

        .slider:before {
            position: absolute;
            content: "";
            height: 14px;
            width: 14px;
            left: 3px;
            bottom: 3px;
            background-color: white;
            transition: .4s;
            border-radius: 50%;
        }

        input:checked + .slider {
            background-color: #007bff;
        }

        input:checked + .slider:before {
            transform: translateX(20px); 
        }

        .strikethrough {
            text-decoration: line-through;
            color: #666;
        }

        .switch-label {
            font-size: 16px;
            margin-left: 10px;
            transition: color 0.4s, text-decoration 0.4s;
        }
    </style>
</head>
<body>
    <div class="edit-task-container">
        <h1>Editar Tarefa</h1>
        <form action="tasks" method="post">
            <input type="hidden" name="action" value="update_task">
            <input type="hidden" name="task_id" value="<%= task.getTaskId() %>">
            <input type="text" name="title" value="<%= task.getTitle() %>" placeholder="Título" required>
            <textarea name="description" placeholder="Descrição"><%= task.getDescription() %></textarea>
            <input type="datetime-local" name="due_date" value="<%= task.getDueDate() %>" required>
            <br>
            <label>
                <div class="switch">
                    <input type="checkbox" id="isCompleted" name="is_completed" <%= task.isCompleted() ? "checked" : "" %>>
                    <span class="slider"></span>
                </div>
                <span id="statusLabel" class="switch-label <%= task.isCompleted() ? "strikethrough" : "" %>">Concluída</span>
            </label>
            <button type="submit">Atualizar Tarefa</button>
        </form>
    </div>

    <script>
        const checkbox = document.getElementById('isCompleted');
        const statusLabel = document.getElementById('statusLabel');

        if (checkbox.checked) {
            statusLabel.classList.add('strikethrough');
        }

        checkbox.addEventListener('change', function() {
            if (this.checked) {
                statusLabel.classList.add('strikethrough');
            } else {
                statusLabel.classList.remove('strikethrough');
            }
        });
    </script>
</body>
</html>
