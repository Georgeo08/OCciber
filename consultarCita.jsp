<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Consultar Cita - OptiClinic</title>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #007BFF, #00BFFF);
            margin: 0;
            padding: 0;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background-image: url('fon5.png');
            background-size: cover; /* Para que se ajuste bien */
            background-repeat: no-repeat;
            background-position: center;
        }
        .container {
            background-color: white;
            width: 400px;
            border-radius: 20px;
            box-shadow: 0 0 20px rgba(0,0,0,0.3);
            padding: 30px;
            text-align: center;
        }
        h2 {
            color: #007BFF;
            margin-bottom: 20px;
        }
        input {
            width: 90%;
            padding: 10px;
            margin: 10px 0;
            border-radius: 10px;
            border: 1px solid #ccc;
            font-size: 15px;
            outline: none;
            transition: 0.3s;
        }
        input:focus {
            border-color: #007BFF;
        }
        button {
            background-color: #007BFF;
            color: white;
            border: none;
            padding: 12px 20px;
            border-radius: 10px;
            cursor: pointer;
            margin: 10px 5px;
            font-size: 15px;
        }
        button:hover {
            background-color: #0056b3;
        }
        .btn-back {
            background-color: #6c757d;
        }
        .btn-back:hover {
            background-color: #5a6268;
        }
        .result {
            text-align: left;
            background: #f8f9fa;
            border-radius: 10px;
            padding: 15px;
            margin-top: 15px;
        }
        .msg {
            color: green;
            font-weight: bold;
            margin-top: 15px;
        }
        .error {
            color: red;
            font-weight: bold;
            margin-top: 15px;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Consultar Cita</h2>
    <form method="post">
        <input type="number" name="id_cit" placeholder="Ingrese ID de cita" required>
        <div>
            <button type="submit" name="consultar">Consultar</button>
            <button type="button" class="btn-back" onclick="window.location='citaMenu.html'">Regresar</button>
        </div>
    </form>

<%
    if (request.getParameter("consultar") != null) {
        String id = request.getParameter("id_cit");
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/OptiClinic?useSSL=false&allowPublicKeyRetrieval=true",
                "root", "n0m3l0");

            String sql = "SELECT * FROM citas WHERE id_cit = ?";
            ps = con.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(id));
            rs = ps.executeQuery();

            if (rs.next()) {
                out.println("<div class='result'>");
                out.println("<p><strong>ID Cita:</strong> " + rs.getInt("id_cit") + "</p>");
                out.println("<p><strong>Año:</strong> " + rs.getInt("año") + "</p>");
                out.println("<p><strong>Mes:</strong> " + rs.getInt("mes") + "</p>");
                out.println("<p><strong>Día:</strong> " + rs.getInt("dia") + "</p>");
                out.println("<p><strong>Hora:</strong> " + rs.getString("hora") + "</p>");
                out.println("<p><strong>Folio Paciente:</strong> " + rs.getInt("folio") + "</p>");
                out.println("</div>");
            } else {
                out.println("<p class='error'>❌ No se encontró ninguna cita con ese ID.</p>");
            }

        } catch (Exception e) {
            out.println("<p class='error'>Error: " + e.getMessage() + "</p>");
        } finally {
            try { if (rs != null) rs.close(); } catch(Exception ex) {}
            try { if (ps != null) ps.close(); } catch(Exception ex) {}
            try { if (con != null) con.close(); } catch(Exception ex) {}
        }
    }
%>
</div>
</body>
</html>
