<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Verificar Folio</title>
    <style>
        body {
            background-color: #99D9EA;
            font-family: sans-serif;
            text-align: center;
            margin-top: 100px;
        }
        input[type="number"], input[type="submit"] {
            padding: 10px;
            font-size: 16px;
            margin-top: 10px;
            border-radius: 5px;
        }
        input[type="submit"] {
            background-color: #f9c74f;
            border: none;
            cursor: pointer;
            font-weight: bold;
        }
        input[type="submit"]:hover {
            background-color: #f9844a;
            color: white;
        }
    </style>
</head>
<body>
    <h2>Ingrese el Folio del Paciente</h2>

    <form method="post">
        <input type="number" name="folio" required placeholder="Folio del paciente">
        <br><br>
        <input type="submit" value="Verificar">
    </form>

<%
    String metodo = request.getMethod();
    if ("POST".equalsIgnoreCase(metodo)) {
        String url = "jdbc:mysql://localhost:3306/OptiClinic?autoReconnect=true&useSSL=false";
        String user = "root";
        String password = "n0m3l0";

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            int folio = Integer.parseInt(request.getParameter("folio"));

            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, password);

            String sql = "SELECT * FROM paciente WHERE folio = ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, folio);
            rs = ps.executeQuery();

            if (rs.next()) {
                // Si existe, redirige a añadirHistorial.jsp
%>
                <script>
                    window.location.href = "añadirHistorial.jsp?folio=<%=folio%>";
                </script>
<%
            } else {
%>
                <p style="color:red;">❌ Folio no encontrado. Verifique el número.</p>
<%
            }
        } catch (Exception e) {
            out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
    }
%>
</body>
</html>
