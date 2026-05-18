<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Módulo Paciente: Visualizar receta</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-image: url('fondo_receta.jpg');
            background-size: cover;
            color: #000;
        }
        .container {
            padding: 20px;
            background-color: rgba(0, 0, 0, 0.6);
            color: white;
            width: 90%;
            margin: auto;
            border-radius: 10px;
        }
        input, table {
            background-color: #3d3737;
            color: white;
            border: none;
            padding: 5px;
        }
        .btn {
            background-color: #3d2a23;
            color: white;
            padding: 10px;
            border-radius: 20px;
            cursor: pointer;
            text-align: center;
            width: 100px;
            margin-top: 20px;
        }
        table, th, td {
            border: 1px solid white;
            border-collapse: collapse;
            padding: 5px;
        }
    </style>
</head>
<body>
<%
    String folioParam = request.getParameter("folio");
    if (folioParam == null) folioParam = "1";

    String url = "jdbc:mysql://localhost:3306/OptiClinic?autoReconnect=true&useSSL=false";
    String user = "root";
    String password = "n0m3l0";

    Connection con = null;
    PreparedStatement ps = null;
    Statement sta = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(url, user, password);

        sta = con.createStatement();
        String query = "SELECT * FROM paciente p " +
                       "JOIN hist_med h ON p.folio = h.folio " +
                       "JOIN exploracion e ON h.exp = e.exp " +
                       "JOIN his_lent_cont l ON h.exp = l.exp " +
                       "WHERE p.folio = " + folioParam + ";";

        rs = sta.executeQuery(query);

        if (rs.next()) {
%>
<div class="container">
    <h2>Módulo Paciente:<br>Visualizar receta</h2>
    <p><b>Nombre:</b> <%= rs.getString("nombre") + " " + rs.getString("apellido_pt") + " " + rs.getString("apellido_pm") %></p>
    <p><b>Folio:</b> <%= rs.getInt("folio") %> &nbsp;&nbsp; <b>Edad:</b> <%= rs.getInt("edad") %></p>
    <p><b>Fecha:</b> <%= rs.getString("fecha") %></p>

    <table>
        <tr><th></th><th>Esfera</th><th>Cilindro</th><th>Eje</th><th>AV</th></tr>
        <tr>
            <td>OD</td>
            <td><%= rs.getString("od_esfera") %></td>
            <td><%= rs.getString("od_cilindro") %></td>
            <td><%= rs.getString("od_eje") %>°</td>
            <td><%= rs.getString("od_av") %></td>
        </tr>
        <tr>
            <td>OS</td>
            <td><%= rs.getString("oi_esfera") %></td>
            <td><%= rs.getString("oi_cilindro") %></td>
            <td><%= rs.getString("oi_eje") %>°</td>
            <td><%= rs.getString("oi_av") %></td>
        </tr>
        <tr>
            <td>DP</td>
            <td colspan="4"><%= rs.getString("dp") %></td>
        </tr>
    </table>

    <h3>Exploración:</h3>
    <p>Párpados: <%= rs.getString("parpados") %> &nbsp; Lágrima: <%= rs.getString("lagrima") %></p>
    <p>Apertura: <%= rs.getString("apertura") %> &nbsp; Conjuntiva: <%= rs.getString("conjuntiva") %></p>
    <p>Iris Visible: <%= rs.getString("iris_visi") %> &nbsp; Córnea: <%= rs.getString("cornea") %></p>
    <p>Hendidura: <%= rs.getString("hendidura") %></p>

    <h3>Tipos de LC:</h3>
    <ul>
        <% if (rs.getInt("blando") == 1) { %><li>Blando</li><% } %>
        <% if (rs.getInt("torico") == 1) { %><li>Tórico</li><% } %>
        <% if (rs.getInt("rigido") == 1) { %><li>Rígido</li><% } %>
        <% if (rs.getInt("esferico") == 1) { %><li>Esférico</li><% } %>
        <% if (rs.getInt("escleral") == 1) { %><li>Escleral</li><% } %>
    </ul>

    <h3>Lentes de prueba:</h3>
    <p>Lente 1: <%= rs.getString("od_rx") %> SRX</p>
    <p>Lente 2: <%= rs.getString("oi_rx") %> SRX</p>
    <p>Lente Final: <%= rs.getString("od_add") %> / <%= rs.getString("oi_add") %></p>

    <form action="passPaciente.html">
        <button class="btn">Regresar</button>
    </form>
</div>
<%
        } else {
            out.print("<div class='container'><h2>No se encontró información para el folio: " + folioParam + "</h2></div>");
        }
    } catch (SQLException error) {
        out.print("Error de SQL: " + error.toString());
    } catch (Exception e) {
        out.print("Error: " + e.toString());
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception ignore) {}
        if (sta != null) try { sta.close(); } catch (Exception ignore) {}
        if (ps != null) try { ps.close(); } catch (Exception ignore) {}
        if (con != null) try { con.close(); } catch (Exception ignore) {}
    }
%>
</body>
</html>
