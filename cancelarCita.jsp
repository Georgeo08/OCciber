<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Cancelar Cita</title>
    <style>
        body {
            font-family: "Segoe UI", sans-serif;
            background-image: url('fon5.png');
            background-size: cover; /* Para que se ajuste bien */
            background-repeat: no-repeat;
            background-position: center;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 80%;
            max-width: 700px;
            margin: 50px auto;
            background: #e6f0ff;
            border-radius: 20px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.2);
            padding: 30px;
            text-align: center;
        }

        h1 {
            background-color: #004e98;
            color: white;
            padding: 15px;
            border-radius: 15px;
            font-size: 24px;
            margin-top: 0;
        }

        .cancel-box {
            background-color: #00b050;
            color: white;
            font-weight: bold;
            padding: 20px;
            border-radius: 15px;
            margin-top: 30px;
            font-size: 18px;
        }

        .error-box {
            background-color: #e74c3c;
            color: white;
            font-weight: bold;
            padding: 20px;
            border-radius: 15px;
            margin-top: 30px;
            font-size: 18px;
        }

        .regresar {
            background-color: #a1bde6;
            color: #000;
            padding: 10px 25px;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            margin-top: 25px;
            font-size: 16px;
            box-shadow: 2px 3px 5px rgba(0,0,0,0.3);
        }

        .regresar:hover {
            background-color: #bcd6f5;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>CANCELAR CITA</h1>

    <%
        String folio = request.getParameter("folio"); // el folio llega por parámetro (por ejemplo cancelarC.jsp?folio=123)
        if (folio != null && !folio.trim().isEmpty()) {
            Connection con = null;
            PreparedStatement ps = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/OptiClinic?useSSL=false&allowPublicKeyRetrieval=true",
                    "root", "n0m3l0"
                );

                String sql = "DELETE FROM citas WHERE folio = ?";
                ps = con.prepareStatement(sql);
                ps.setString(1, folio);

                int filas = ps.executeUpdate();

                if (filas > 0) {
    %>
                    <div class="cancel-box">✅ CITA CANCELADA CORRECTAMENTE</div>
    <%
                } else {
    %>
                    <div class="error-box">⚠️ No se encontró ninguna cita con el folio especificado.</div>
    <%
                }
            } catch (Exception e) {
    %>
                <div class="error-box">❌ Error al cancelar: <%= e.getMessage() %></div>
    <%
            } finally {
                try { if (ps != null) ps.close(); } catch (SQLException ignored) {}
                try { if (con != null) con.close(); } catch (SQLException ignored) {}
            }
        } else {
    %>
            <div class="error-box">⚠️ No se proporcionó ningún folio.</div>
    <%
        }
    %>

    <button class="regresar" onclick="window.location.href='citaMenu.html'">Regresar</button>
</div>
</body>
</html>
