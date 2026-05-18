<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Guardar Tipos de LC</title>
</head>
<body>
<%
    String[] tiposLC = request.getParameterValues("tiposLC");
    int blando = 0, torico = 0, rigido = 0, esferico = 0, escleral = 0;

    if (tiposLC != null) {
        for (String tipo : tiposLC) {
            switch (tipo) {
                case "blando": blando = 1; break;
                case "torico": case "torico2": torico = 1; break;
                case "rigido": rigido = 1; break;
                case "esferico": case "esferico2": esferico = 1; break;
                case "escleral": escleral = 1; break;
            }
        }
    }

    String expParam = request.getParameter("exp");
    int exp = expParam != null ? Integer.parseInt(expParam) : 0;

    String url = "jdbc:mysql://localhost:3306/OptiClinic?autoReconnect=true&useSSL=false";
    String user = "root";
    String password = "n0m3l0";

    Connection con = null;
    PreparedStatement ps = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(url, user, password);

        String sql = "UPDATE exploracion SET blando = ?, torico = ?, rigido = ?, esferico = ?, escleral = ? WHERE exp = ?";
        ps = con.prepareStatement(sql);
        ps.setInt(1, blando);
        ps.setInt(2, torico);
        ps.setInt(3, rigido);
        ps.setInt(4, esferico);
        ps.setInt(5, escleral);
        ps.setInt(6, exp);

        int rowsUpdated = ps.executeUpdate();

        if (rowsUpdated > 0) {
            out.print("<p>Los tipos de LC se guardaron correctamente.</p>");
        } else {
            out.print("<p>No se encontró el registro de exploración para exp=" + exp + "</p>");
        }

    } catch (Exception e) {
        out.print("Error: " + e.toString());
    } finally {
        if (ps != null) ps.close();
        if (con != null) con.close();
    }
%>

<a href="index.html?folio=1">Volver a receta</a>

</body>
</html>
