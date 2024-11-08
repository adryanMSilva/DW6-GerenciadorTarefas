<%@ page import="java.util.stream.Collectors"%>
<%@ page import="com.project.taskmanager.models.Task"%>
<%@ page import="java.util.List"%>
<%@ page import="java.time.LocalDateTime"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html>
<head>
<title>Lista de Tarefas</title>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f4f4f4;
	padding: 20px;
}

h1 {
	color: #333;
	text-align: center;
}

.container {
	max-width: 800px;
	margin: 0 auto;
	background-color: white;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
}

a {
	display: inline-block;
	margin-bottom: 20px;
	text-decoration: none;
	background-color: #007bff;
	color: white;
	padding: 10px 15px;
	border-radius: 5px;
	font-weight: bold;
}

a:hover {
	background-color: #0056b3;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 20px;
}

table, th, td {
	border: 1px solid #ccc;
}

th, td {
	padding: 10px;
	text-align: center;
}

th {
	background-color: #f8f8f8;
	font-weight: bold;
}

.action-btn {
	display: inline-block;
	padding: 8px 12px;
	border-radius: 5px;
	color: white;
	text-decoration: none;
	font-size: 14px;
}

.edit-btn {
	background-color: #007bff;
}

.edit-btn:hover {
	background-color: #0056b3;
}

.delete-btn {
	background-color: #dc3545;
	border: none;
	cursor: pointer;
}

.delete-btn:hover {
	background-color: #c82333;
}

.no-tasks {
	text-align: center;
	color: #666;
	font-size: 18px;
	margin-top: 20px;
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

input:checked+.slider {
	background-color: #007bff;
}

input:checked+.slider:before {
	transform: translateX(20px);
}

.switch-label {
	font-size: 16px;
	margin-left: 10px;
}

#tasksPerPage {
	margin-bottom: 10px;
}

.overdue {
	color: red;
	font-weight: bold;
}

.pagination {
	text-align: center;
	margin-top: 20px;
}

.pagination a {
	margin: 0 5px;
	padding: 8px 12px;
	border: 1px solid #007bff;
	color: white;
	text-decoration: none;
	border-radius: 5px;
}

.pagination a:hover {
	background-color: #0056b3;
	color: white;
}

.pagination .active {
	background-color: #004494;
	color: white;
}

.modal {
	display: none;
	position: fixed;
	z-index: 1;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.5);
	justify-content: center;
	align-items: center;
}

.modal-content {
	background-color: white;
	padding: 20px;
	border-radius: 10px;
	text-align: center;
	box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
	max-width: 400px;
	width: 100%;
}

.modal-content h2 {
	margin-bottom: 20px;
	font-size: 18px;
	color: #333;
}

.modal-buttons {
	display: flex;
	justify-content: space-between;
}

.modal-buttons button {
	padding: 10px 20px;
	border-radius: 5px;
	border: none;
	cursor: pointer;
	font-weight: bold;
}

.confirm-btn {
	background-color: #dc3545;
	color: white;
}

.cancel-btn {
	background-color: #007bff;
	color: white;
}

.confirm-btn:hover {
	background-color: #c82333;
}

.cancel-btn:hover {
	background-color: #0056b3;
}
</style>
<script>
        function showConfirmationModal(taskId) {
            document.getElementById("deleteModal").style.display = "flex";
            document.getElementById("confirmDeleteBtn").onclick = function() {
                document.getElementById("deleteForm_" + taskId).submit();
            };
        }

        function hideConfirmationModal() {
            document.getElementById("deleteModal").style.display = "none";
        }
        
        function toggleCompletedTasks() {
            document.getElementById("filterForm").submit();
        }
    </script>
</head>
<body>
	<div class="container">
		<h1>Minhas Tarefas</h1>
		<a href="create_task.jsp">Criar Nova Tarefa</a>

		<form id="filterForm" method="get">
			<label for="tasksPerPage">Tarefas por página:</label> <select
				name="tasksPerPage" id="tasksPerPage" onchange="this.form.submit()">
				<option value="5"
					<%= (request.getParameter("tasksPerPage") != null && Integer.parseInt(request.getParameter("tasksPerPage")) == 5) ? "selected" : "" %>>5</option>
				<option value="10"
					<%= (request.getParameter("tasksPerPage") != null && Integer.parseInt(request.getParameter("tasksPerPage")) == 10) ? "selected" : "" %>>10</option>
				<option value="15"
					<%= (request.getParameter("tasksPerPage") != null && Integer.parseInt(request.getParameter("tasksPerPage")) == 15) ? "selected" : "" %>>15</option>
				<option value="20"
					<%= (request.getParameter("tasksPerPage") != null && Integer.parseInt(request.getParameter("tasksPerPage")) == 20) ? "selected" : "" %>>20</option>
			</select>
			<br>
			<label>
                <div class="switch"  style="margin-bottom: 15px">
                    <input type="checkbox" id="hideCompleted" name="hideCompleted" onchange="toggleCompletedTasks()" <%= (request.getParameter("hideCompleted") != null) ? "checked" : "" %>>
                    <span class="slider"></span>
                </div>
                <span class="switch-label">Esconder tarefas concluídas</span>
            </label>
		</form>

		<table>
			<tr>
				<th>Título</th>
				<th>Descrição</th>
				<th>Data de Vencimento</th>
				<th>Concluída</th>
				<th>Ações</th>
			</tr>
			<%
                int tasksPerPage = 5;
                String tasksPerPageParam = request.getParameter("tasksPerPage");
                if (tasksPerPageParam != null) {
                    tasksPerPage = Integer.parseInt(tasksPerPageParam);
                }

                String pageParam = request.getParameter("page");
                int currentPage = (pageParam != null && !pageParam.isEmpty()) ? Integer.parseInt(pageParam) : 1;

                List<Task> tasks = (List<Task>) request.getAttribute("tasks");
                boolean hideCompleted = request.getParameter("hideCompleted") != null;

                List<Task> filteredTasks = tasks;
                if (hideCompleted) {
                    filteredTasks = tasks.stream().filter(task -> !task.isCompleted()).collect(Collectors.toList());
                }

                int totalTasks = filteredTasks.size();
                int totalPages = (int) Math.ceil((double) totalTasks / tasksPerPage);

                int startIndex = (currentPage - 1) * tasksPerPage;
                int endIndex = Math.min(startIndex + tasksPerPage, totalTasks);

                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
                LocalDateTime now = LocalDateTime.now();

                if (startIndex >= totalTasks) {
            %>
			<tr>
				<td colspan="5" class="no-tasks">Nenhuma tarefa disponível.</td>
			</tr>
			<%
                } else {
                    for (int i = startIndex; i < endIndex; i++) {
                        Task task = filteredTasks.get(i);
                        boolean isOverdue = task.getDueDate().isBefore(now);
            %>
			<tr>
				<td><%= task.getTitle() %></td>
				<td><%= task.getDescription() %></td>
				<td class="<%= isOverdue ? "overdue" : "" %>"><%= task.getDueDate().format(formatter) %></td>
				<td><%= task.isCompleted() ? "Sim" : "Não" %></td>
				<td><a href="edit_task.jsp?task_id=<%= task.getTaskId() %>"
					class="action-btn edit-btn">Editar</a>
					<button type="button" class="action-btn delete-btn"
						onclick="showConfirmationModal(<%= task.getTaskId() %>)">Excluir</button>
					<form id="deleteForm_<%= task.getTaskId() %>" action="tasks"
						method="post" style="display: none;">
						<input type="hidden" name="action" value="delete_task"> 
						<input type="hidden" name="task_id" value="<%= task.getTaskId() %>">
					</form></td>
			</tr>
			<%
                    }
                }
            %>
		</table>

		<div class="pagination">
			<%
                for (int i = 1; i <= totalPages; i++) {
                    String activeClass = (i == currentPage) ? "active" : "";
            %>
			<a
				href="?page=<%= i %>&tasksPerPage=<%= tasksPerPage %><%= hideCompleted ? "&hideCompleted=true" : "" %>"
				class="<%= activeClass %>"><%= i %></a>
			<%
                }
            %>
		</div>
	</div>

	<div id="deleteModal" class="modal">
		<div class="modal-content">
			<h2>Você tem certeza que deseja excluir esta tarefa?</h2>
			<div class="modal-buttons">
				<button id="confirmDeleteBtn" class="confirm-btn">Sim</button>
				<button onclick="hideConfirmationModal()" class="cancel-btn">Não</button>
			</div>
		</div>
	</div>
</body>
</html>
