<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Consultar Paciente</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #333;
            text-align: center;
        }
        .search-form, .result-container {
            margin-bottom: 30px;
            padding: 20px;
            background: #f9f9f9;
            border-radius: 5px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        input[type="text"], input[type="number"] {
            width: 100%;
            padding: 8px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .btn {
            background-color: #4CAF50;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-right: 10px;
            text-decoration: none;
            display: inline-block;
        }
        .btn:hover {
            background-color: #45a049;
        }
        .btn-regresar {
            background-color: #f44336;
        }
        .btn-regresar:hover {
            background-color: #d32f2f;
        }
        .message {
            padding: 10px;
            margin: 10px 0;
            border-radius: 4px;
        }
        .success {
            background-color: #dff0d8;
            color: #3c763d;
        }
        .error {
            background-color: #f2dede;
            color: #a94442;
        }
        .patient-info {
            margin-top: 20px;
        }
        .patient-info p {
            margin: 10px 0;
            padding: 8px;
            background-color: #fff;
            border-radius: 4px;
            border-left: 4px solid #4CAF50;
        }
        .info-label {
            font-weight: bold;
            color: #2c3e50;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Consultar Paciente</h1>
        
        <div class="search-form">
            <h2>Buscar Paciente por Folio</h2>
            <form method="get" action="">
                <label for="folio">Folio del Paciente:</label>
                <input type="number" name="folio" id="folio" required min="1">
                <button type="submit" class="btn">Buscar</button>
                <a href="paciDaoMenu.html" class="btn btn-regresar">Regresar</a>
            </form>
        </div>

        <%

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        

        String folioStr = request.getParameter("folio");
        int folio = 0;
        if (folioStr != null && !folioStr.isEmpty()) {
            folio = Integer.parseInt(folioStr);
        }
        

        String apellidoPt = "";
        String apellidoPm = "";
        String nombre = "";
        int edad = 0;
        boolean pacienteEncontrado = false;
        
        try {

            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/OptiClinic?useSSL=false&allowPublicKeyRetrieval=true",
                "root", "n0m3l0");
            
 
            if (folio > 0) {
                String sqlSelect = "SELECT apellido_pt, apellido_pm, nombre, edad FROM paciente WHERE folio = ?";
                ps = con.prepareStatement(sqlSelect);
                ps.setInt(1, folio);
                rs = ps.executeQuery();
                
                if (rs.next()) {
                    pacienteEncontrado = true;
                    apellidoPt = rs.getString("apellido_pt");
                    apellidoPm = rs.getString("apellido_pm");
                    nombre = rs.getString("nombre");
                    edad = rs.getInt("edad");
                } else {
                    out.println("<div class='message error'>No se encontró un paciente con el folio " + folio + "</div>");
                }
            }
        } catch (Exception e) {
            out.println("<div class='message error'>Error: " + e.getMessage() + "</div>");
        } finally {

            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                out.println("<div class='message error'>Error al cerrar conexiones: " + e.getMessage() + "</div>");
            }
        }
        %>
        

        <% if (pacienteEncontrado) { %>
        <div class="result-container">
            <h2>Información del Paciente</h2>
            <div class="patient-info">
                <p><span class="info-label">Folio:</span> <%= folio %></p>
                <p><span class="info-label">Apellido Paterno:</span> <%= apellidoPt %></p>
                <p><span class="info-label">Apellido Materno:</span> <%= apellidoPm %></p>
                <p><span class="info-label">Nombre:</span> <%= nombre %></p>
                <p><span class="info-label">Edad:</span> <%= edad %></p>
            </div>
            <a href="paciDaoMenu.html" class="btn btn-regresar">Regresar</a>
        </div>
        <% } %>
    </div>
</body>
</html>