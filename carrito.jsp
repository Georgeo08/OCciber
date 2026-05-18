<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <title>Carrito de Compras</title>
    <style>
        body {
            background-image: url('fon6.png');
            background-size: cover;
            background-repeat: no-repeat;
            font-family: Arial, sans-serif;
            color: white;
            text-align: center;
        }

        h1 {
            background-color: rgba(0, 0, 0, 0.6);
            padding: 10px;
            border-radius: 12px;
            display: inline-block;
        }

        .caja {
            background-color: rgba(0, 0, 0, 0.6);
            margin: 50px auto;
            padding: 20px;
            border-radius: 20px;
            width: 60%;
        }

        .producto {
            background-color: rgba(255, 255, 255, 0.8);
            color: #000;
            border-radius: 15px;
            margin: 10px;
            padding: 15px;
            font-weight: bold;
        }

        .boton {
            background-color: #00aaff;
            border: none;
            padding: 10px 20px;
            border-radius: 15px;
            color: white;
            cursor: pointer;
            margin: 10px;
        }

        .boton:hover {
            background-color: #33ccff;
        }

        a {
            text-decoration: none;
            color: white;
            background-color: #28a745;
            padding: 10px 15px;
            border-radius: 15px;
        }

        a:hover {
            background-color: #4dd964;
        }
        
    </style>
</head>
<body>
    <h1>Carrito de Compras</h1>

    <div class="caja">
        <%
            String url = "jdbc:mysql://localhost:3306/OptiClinic?autoReconnect=true&useSSL=false";
            String user = "root";
            String password = "n0m3l0";
            Connection con = null;
            Statement st = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.jdbc.Driver");
                con = DriverManager.getConnection(url, user, password);
                st = con.createStatement();
                rs = st.executeQuery("SELECT * FROM carrito");

                boolean vacio = true;

                while (rs.next()) {
                    vacio = false;
        %>
            <div class="producto">
                <p><strong><%= rs.getString("modelo") %></strong></p>
                <p>Forma: <%= rs.getString("forma") %></p>
                <p>Color: <%= rs.getString("color") %></p>
                <p>Precio: $<%= rs.getDouble("precio") %></p>
            </div>
        <%  }
            if (vacio) {
                out.println("<p>No hay productos en el carrito aún.</p>");
            }
            } catch (Exception e) {
                out.println("<p>Error al cargar el carrito: " + e.getMessage() + "</p>");
            } finally {
                if (rs != null) rs.close();
                if (st != null) st.close();
                if (con != null) con.close();
            }
        %>
    </div>

    <a href="catalogo.jsp">Regresar al catálogo</a>
    <button class="boton">Finalizar compra</button>
</body>
</html>
