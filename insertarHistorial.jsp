<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Insertar Historial</title>
    <style>
        body {
            background-color: #99D9EA;
            font-family: sans-serif;
            text-align: center;
            padding: 50px;
        }
        .msg {
            background-color: #fff;
            padding: 20px;
            display: inline-block;
            border-radius: 10px;
            border: 2px solid #f9c74f;
        }
        a {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #f9c74f;
            color: #000;
            text-decoration: none;
            border-radius: 8px;
            font-weight: bold;
        }
        a:hover {
            background-color: #f9844a;
            color: white;
        }
    </style>
</head>
<body>
<%
        String url = "jdbc:mysql://localhost:3306/OptiClinic?autoReconnect=true&useSSL=false";
        String user = "root";
        String password = "n0m3l0";

    Connection conn = null;
    PreparedStatement psHist = null, psExplora = null, psLent = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);

        // 1. Insertar en hist_med
        String sqlHist = "INSERT INTO hist_med (fecha, comentarios, lent_prueb, folio) VALUES (?, ?, ?, ?)";
        psHist = conn.prepareStatement(sqlHist, Statement.RETURN_GENERATED_KEYS);
        psHist.setString(1, request.getParameter("fecha"));
        psHist.setString(2, request.getParameter("comentarios"));
        psHist.setString(3, request.getParameter("lent_prueb"));
        psHist.setInt(4, Integer.parseInt(request.getParameter("folio")));
        psHist.executeUpdate();

        rs = psHist.getGeneratedKeys();
        int expGenerado = 0;
        if (rs.next()) {
            expGenerado = rs.getInt(1);
        }

        // 2. Insertar en exploracion
        String sqlExplora = "INSERT INTO exploracion (parpados, lagrima, apertura, cornea, hendidura, conjuntiva, iris_visi, blando, torico, rigido, esferico, escleral, reemplazo, exp) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        psExplora = conn.prepareStatement(sqlExplora);
        psExplora.setString(1, request.getParameter("parpados"));
        psExplora.setString(2, request.getParameter("lagrima"));
        psExplora.setString(3, request.getParameter("apertura"));
        psExplora.setString(4, request.getParameter("cornea"));
        psExplora.setString(5, request.getParameter("hendidura"));
        psExplora.setString(6, request.getParameter("conjuntiva"));
        psExplora.setString(7, request.getParameter("iris_visi"));
        psExplora.setInt(8, Integer.parseInt(request.getParameter("blando")));
        psExplora.setInt(9, Integer.parseInt(request.getParameter("torico")));
        psExplora.setInt(10, Integer.parseInt(request.getParameter("rigido")));
        psExplora.setInt(11, Integer.parseInt(request.getParameter("esferico")));
        psExplora.setInt(12, Integer.parseInt(request.getParameter("escleral")));
        psExplora.setInt(13, Integer.parseInt(request.getParameter("reemplazo")));
        psExplora.setInt(14, expGenerado);
        psExplora.executeUpdate();

        // 3. Insertar en his_lent_cont
        String sqlLent = "INSERT INTO his_lent_cont (oi_queratometrias, od_queratometrias, oi_esfera, oi_cilindro, oi_eje, od_esfera, od_cilindro, od_eje, dp, oi_cv, od_cv, oi_av_crx, od_av_crx, oi_add, od_add, oi_av_crx_ant, od_av_crx_ant, oi_rx, od_rx, oi_av, od_av, exp) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        psLent = conn.prepareStatement(sqlLent);
        psLent.setString(1, request.getParameter("oi_queratometrias"));
        psLent.setString(2, request.getParameter("od_queratometrias"));
        psLent.setString(3, request.getParameter("oi_esfera"));
        psLent.setString(4, request.getParameter("oi_cilindro"));
        psLent.setString(5, request.getParameter("oi_eje"));
        psLent.setString(6, request.getParameter("od_esfera"));
        psLent.setString(7, request.getParameter("od_cilindro"));
        psLent.setString(8, request.getParameter("od_eje"));
        psLent.setString(9, request.getParameter("dp"));
        psLent.setString(10, request.getParameter("oi_cv"));
        psLent.setString(11, request.getParameter("od_cv"));
        psLent.setString(12, request.getParameter("oi_av_crx"));
        psLent.setString(13, request.getParameter("od_av_crx"));
        psLent.setString(14, request.getParameter("oi_add"));
        psLent.setString(15, request.getParameter("od_add"));
        psLent.setString(16, request.getParameter("oi_av_crx_ant"));
        psLent.setString(17, request.getParameter("od_av_crx_ant"));
        psLent.setString(18, request.getParameter("oi_rx"));
        psLent.setString(19, request.getParameter("od_rx"));
        psLent.setString(20, request.getParameter("oi_av"));
        psLent.setString(21, request.getParameter("od_av"));
        psLent.setInt(22, expGenerado);
        psLent.executeUpdate();
%>

<div class="msg">
    <h2>✅ Historial guardado exitosamente</h2>
    <p>Expediente generado: <strong><%=expGenerado%></strong></p>
    <a href="añadirHistorial.jsp?folio=<%=request.getParameter("folio")%>">Añadir otro historial</a><br>
    <a href="histoMenu.html">Volver al Menú</a>
</div>

<%
    } catch (Exception e) {
%>
    <p style="color:red;">❌ Error: <%=e.getMessage()%></p>
<%
    } finally {
        if (rs != null) rs.close();
        if (psHist != null) psHist.close();
        if (psExplora != null) psExplora.close();
        if (psLent != null) psLent.close();
        if (conn != null) conn.close();
    }
%>
</body>
</html>
