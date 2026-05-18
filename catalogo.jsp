<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <title>Catálogo de Gafas</title>
    <style>
        body { 
            background-image: url('fon6.png'); 
            background-size: cover; 
            font-family: Arial, sans-serif; 
            color: #fff; 
            text-align: center; }
        h1 { 
            background-color: rgba(0,0,0,0.6); 
            padding: 15px; 
            border-radius: 10px; 
            display: inline-block; }
        .contenedor { 
            display: flex; 
            flex-wrap: wrap; 
            justify-content: center; 
            gap: 25px; 
            margin-top: 40px; }
        .card { 
            background-color: rgba(0, 255, 255, 0.8); 
            border-radius: 15px; padding: 15px; 
            width: 220px; 
            box-shadow: 0 0 10px #000; 
            color: #000; 
            font-weight: bold; }
        .card img { 
            width: 100%; 
            border-radius: 10px; }
        .boton { 
            background-color: #00aaff; 
            border: none; 
            padding: 8px 12px; 
            border-radius: 10px; 
            margin-top: 10px; 
            cursor: pointer; 
            font-weight: bold; 
            color: white; }
        .boton:hover { 
            background-color: #33ccff; }
        .carrito-btn { 
            position: fixed; 
            top: 20px; 
            right: 20px; 
            background-color: #ffc107; 
            color: black; 
            padding: 10px 18px; 
            border-radius: 20px; 
            text-decoration: none; 
            font-weight: bold; 
            box-shadow: 0 0 8px #000; }
        .carrito-btn:hover { 
            background-color: #ffda47; }
        .paginacion {
                margin-top: 170px; 
                text-align: center; 
         }

        .paginacion a { 
            text-decoration: none; 
            color: white; 
            background-color: #28a745; 
            padding: 10px 15px; 
            border-radius: 15px; 
            margin: 5px; 
            display: inline-block; }
        .paginacion a:hover { 
            background-color: #4dd964; }
        .btn {
            padding: 10px 20px;
            background-color: #3d2a23;
            border: none;
            border-radius: 20px;
            color: white;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <h1>Catálogo de Gafas</h1>
    <a href="carrito.jsp" class="carrito-btn">🛒 Ver Carrito</a>

    <div class="contenedor">
    <%
        String url = "jdbc:mysql://localhost:3306/OptiClinic?autoReconnect=true&useSSL=false";
        String user = "root";
        String password = "n0m3l0";

        int pagina = 1; 
        int itemsPorPagina = 5; 
        if(request.getParameter("pagina") != null){
            try { pagina = Integer.parseInt(request.getParameter("pagina")); } catch(Exception e) {}
        }
        int offset = (pagina - 1) * itemsPorPagina;

        Connection con = null;
        Statement st = null;
        ResultSet rs = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // driver actualizado
            con = DriverManager.getConnection(url, user, password);
            st = con.createStatement();
            rs = st.executeQuery("SELECT * FROM mod_arm LIMIT " + offset + "," + itemsPorPagina);

            boolean vacio = true;
            while(rs.next()){
                vacio = false;
                String modelo = rs.getString("modelo");
                String forma = rs.getString("forma");
                String color = rs.getString("color");
                double precio = rs.getDouble("precio");
    %>
        <div class="card">
            <img src="imagenes/<%= rs.getString("modelo").trim() %>.png" alt="Armazón">
            <p><strong><%= modelo %></strong></p>
            <p><%= forma %> | <%= color %></p>
            <p>$<%= precio %></p>
            <form action="detalle.jsp" method="get">
                <input type="hidden" name="modelo" value="<%= modelo %>">
                <button type="submit" class="boton">Ver detalles</button>
            </form>
        </div>
    <%  }
        if(vacio){
            out.println("<p>No hay productos en el catálogo aún.</p>");
        }

        // Paginación
        Statement stCount = con.createStatement();
        ResultSet rsCount = stCount.executeQuery("SELECT COUNT(*) FROM mod_arm");
        int totalItems = 0;
        if(rsCount.next()) totalItems = rsCount.getInt(1);
        int totalPaginas = (int)Math.ceil((double)totalItems/itemsPorPagina);

    %>
    </div>

    <div class="paginacion">
        <% if(pagina > 1){ %>
            <a href="catalogo.jsp?pagina=<%= pagina-1 %>">⬅</a>
        <% } %>
        <% if(pagina < totalPaginas){ %>
            <a href="catalogo.jsp?pagina=<%= pagina+1 %>">➡</a>
        <% } %>
    </div>

    <%
        rsCount.close();
        stCount.close();
    } catch(Exception e){
        out.println("<p>Error: "+e.getMessage()+"</p>");
    } finally {
        if(rs != null) rs.close();
        if(st != null) st.close();
        if(con != null) con.close();
    }
    %>
    <form action="passPaciente.html">
            <button class="btn">Regresar</button>
    </form>
</body>
</html>
