<!DOCTYPE html>
<html>
<head>
    <title>Registrar Usuário</title>
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
        .register-container {
            background-color: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            text-align: center;
            width: 300px;
            box-sizing: border-box;
        }
        h1 {
            color: #333;
            margin-bottom: 20px;
        }
        input[type="text"],
        input[type="email"],
        input[type="password"],
        button {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
            box-sizing: border-box;
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
    <div class="register-container">
        <h1>Registrar Usuário</h1>
        
        <% 
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null) { 
        %>
            <div class="error-message"><%= errorMessage %></div>
        <% 
            } 
        %>
        
        <form action="users" method="post">
            <input type="hidden" name="action" value="register">
            <input type="text" name="username" placeholder="Nome de Usuário" required>
            <input type="email" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Senha" required>
            <button type="submit">Registrar</button>
        </form>
    </div>
</body>
</html>
