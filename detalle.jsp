<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <title>Detalles del Modelo</title>
    <style>
        body {
            background-image: url('fon6.png');
            background-size: cover;
            font-family: Arial, sans-serif;
            color: white;
            text-align: center;
        }

        .contenedor {
            background-color: rgba(0, 0, 0, 0.6);
            width: 50%;
            margin: 80px auto;
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 0 15px #000;
        }

        img {
            width: 200px;
            border-radius: 15px;
        }

        .boton {
            background-color: #00aaff;
            border: none;
            padding: 10px 20px;
            border-radius: 10px;
            color: white;
            font-weight: bold;
            cursor: pointer;
            margin-top: 15px;
        }

        .boton:hover {
            background-color: #33ccff;
        }

        a {
            color: white;
            background-color: #28a745;
            padding: 10px 15px;
            border-radius: 10px;
            text-decoration: none;
            margin-top: 20px;
            display: inline-block;
        }

        a:hover {
            background-color: #4dd964;
        }
    </style>
</head>
<body>
    <%
        String modelo = request.getParameter("modelo");

        String url = "jdbc:mysql://localhost:3306/OptiClinic?autoReconnect=true&useSSL=false";
        String user = "root";
        String password = "n0m3l0";

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection(url, user, password);
            ps = con.prepareStatement("SELECT * FROM mod_arm WHERE modelo = ?");
            ps.setString(1, modelo);
            rs = ps.executeQuery();

            if (rs.next()) {
    %>
    <div class="contenedor">
        <h1>Detalles del modelo: <%= rs.getString("modelo") %></h1>
        <img src="imagenes/<%= rs.getString("modelo").trim() %>.png" alt="Armazón">
        <p><strong>Forma:</strong> <%= rs.getString("forma") %></p>
        <p><strong>Color:</strong> <%= rs.getString("color") %></p>
        <p><strong>Precio:</strong> $<%= rs.getDouble("precio") %></p>

        <form action="agregarCarrito.jsp" method="post">
            <input type="hidden" name="modelo" value="<%= rs.getString("modelo") %>">
            <input type="hidden" name="forma" value="<%= rs.getString("forma") %>">
            <input type="hidden" name="color" value="<%= rs.getString("color") %>">
            <input type="hidden" name="precio" value="<%= rs.getDouble("precio") %>">
            <button type="submit" class="boton">Agregar al carrito</button>
        </form>

        <a href="catalogo.jsp">⬅ Volver al catálogo</a>
    </div>
    <%
            } else {
                out.println("<h2>Modelo no encontrado</h2>");
            }
        } catch (Exception e) {
            out.println("<h3>Error al mostrar detalles: " + e.getMessage() + "</h3>");
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        }
    %>
</body>
</html>
