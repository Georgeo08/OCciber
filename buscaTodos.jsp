<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Listado de Pacientes</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 1000px;
            margin: 0 auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #333;
            text-align: center;
            margin-bottom: 30px;
        }
        .btn-container {
            margin-bottom: 20px;
            text-align: right;
        }
        .btn-regresar {
            background-color: #f44336;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }
        .btn-regresar:hover {
            opacity: 0.9;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #4CAF50;
            color: white;
            position: sticky;
            top: 0;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        .message {
            padding: 15px;
            margin: 20px 0;
            border-radius: 4px;
            text-align: center;
        }
        .info {
            background-color: #e7f3fe;
            color: #31708f;
        }
        .error {
            background-color: #f2dede;
            color: #a94442;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Listado Completo de Pacientes</h1>
        
        <div class="btn-container">
            <a href="paciDaoMenu.html" class="btn-regresar">Regresar al Menú</a>
        </div>

        <%
        // Conexión a la base de datos
        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;
        
        try {

            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/OptiClinic?useSSL=false&allowPublicKeyRetrieval=true",
                "root", "n0m3l0");
            

            stmt = con.createStatement();
            String sql = "SELECT folio, apellido_pt, apellido_pm, nombre, edad FROM paciente ORDER BY folio ASC";
            rs = stmt.executeQuery(sql);
            
            if (!rs.isBeforeFirst()) {
                out.println("<div class='message info'>No hay pacientes registrados en el sistema</div>");
            } else {
        %>
                <table>
                    <thead>
                        <tr>
                            <th>Folio</th>
                            <th>Apellido Paterno</th>
                            <th>Apellido Materno</th>
                            <th>Nombre</th>
                            <th>Edad</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% while (rs.next()) { %>
                        <tr>
                            <td><%= rs.getInt("folio") %></td>
                            <td><%= rs.getString("apellido_pt") %></td>
                            <td><%= rs.getString("apellido_pm") %></td>
                            <td><%= rs.getString("nombre") %></td>
                            <td><%= rs.getInt("edad") %></td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
        <%
            }
        } catch (Exception e) {
            out.println("<div class='message error'>Error al cargar los pacientes: " + e.getMessage() + "</div>");
        } finally {

            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                out.println("<div class='message error'>Error al cerrar conexiones: " + e.getMessage() + "</div>");
            }
        }
        %>
    </div>
</body>
</html>