<%-- 
    Document   : verHist
    Created on : 2 jul. 2025, 07:49:24
    Author     : MariJo
--%>

<%@page contentType="text/html" import="java.sql.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
    <%
        int foli = 0;
        Connection conectadita = null;
        Statement comanditoo = null;
        ResultSet resultado = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conectadita = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/OptiClinic?autoReconnect=true&useSSL=false", 
                "root", 
                "n0m3l0"
            );
            comanditoo = conectadita.createStatement();
        } catch (SQLException error) {
            out.print("<p style='color:red;'>Error de conexión: " + error.toString() + "</p>");
        }

        try {
            String val = request.getParameter("his");
            String folioParam = request.getParameter("folio");

            if (folioParam != null && !folioParam.trim().isEmpty()) {
                try {
                    foli = Integer.parseInt(folioParam);
                    
                    resultado = comanditoo.executeQuery("SELECT * FROM hist_med WHERE folio=" + foli + ";");

                    if (resultado.next()) {
                        session.setAttribute("folioPaciente", foli);

                        if ("tres".equals(val)) {
    %>
                            <script>window.location.href = "con_His.jsp";</script>
    <%
                        } else {
    %>
                            <script>window.location.href = "mod_His.jsp";</script>
    <%
                        }
                    } else {
                        out.print("<script>alert('No existe historial para el folio ingresado');</script>");
                    }
                } catch (NumberFormatException e) {
                    out.print("<script>alert('El folio debe ser un número válido');</script>");
                }
            } else {
                out.print("<script>alert('Debe ingresar un folio');</script>");
            }
        } catch (SQLException error) {
            out.print("<p style='color:red;'>Error al consultar la base de datos: " + error.toString() + "</p>");
        } finally {
            try { if (resultado != null) resultado.close(); } catch (Exception e) {}
            try { if (comanditoo != null) comanditoo.close(); } catch (Exception e) {}
            try { if (conectadita != null) conectadita.close(); } catch (Exception e) {}
        }
    %>
</body>
    
</html>
