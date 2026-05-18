<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Registrar Cita - OptiClinic</title>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #007BFF, #00BFFF);
            background-image: url('fon5.png');
            background-size: cover; /* Para que se ajuste bien */
            background-repeat: no-repeat;
            background-position: center;
            margin: 0;
            padding: 0;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
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
    <h2>Registrar Nueva Cita</h2>
    <form method="post">
        <input type="number" name="dia" placeholder="Día" required>
        <input type="number" name="mes" placeholder="Mes" required>
        <input type="number" name="anio" placeholder="Año" required>
        <input type="text" name="hora" placeholder="Hora (ejemplo: 10:30)" required>
        <input type="number" name="folio" placeholder="Folio del paciente" required>
        <div>
            <button type="submit" name="registrar">Registrar</button>
            <button type="button" class="btn-back" onclick="window.location='citaMenu.html'">Regresar</button>
        </div>
    </form>

<%
    if (request.getParameter("registrar") != null) {
        int dia = Integer.parseInt(request.getParameter("dia"));
        int mes = Integer.parseInt(request.getParameter("mes"));
        int anio = Integer.parseInt(request.getParameter("anio"));
        String hora = request.getParameter("hora");
        int folio = Integer.parseInt(request.getParameter("folio"));

        Connection con = null;
        PreparedStatement ps = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/OptiClinic?useSSL=false&allowPublicKeyRetrieval=true",
                "root", "n0m3l0");

            ps = con.prepareStatement("INSERT INTO citas (dia, mes, año, hora, folio) VALUES (?, ?, ?, ?, ?)");
            ps.setInt(1, dia);
            ps.setInt(2, mes);
            ps.setInt(3, anio);
            ps.setString(4, hora);
            ps.setInt(5, folio);

            int result = ps.executeUpdate();
            if (result > 0) {
                out.println("<p class='msg'>✅ Cita registrada correctamente.</p>");
            } else {
                out.println("<p class='error'>❌ No se pudo registrar la cita.</p>");
            }

        } catch (Exception e) {
            out.println("<p class='error'>Error: " + e.getMessage() + "</p>");
        } finally {
            try { if (ps != null) ps.close(); } catch(Exception ex) {}
            try { if (con != null) con.close(); } catch(Exception ex) {}
        }
    }
%>
</div>
</body>
</html>
