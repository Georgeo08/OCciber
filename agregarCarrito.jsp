<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
    String modelo = request.getParameter("modelo");
    String forma = request.getParameter("forma");
    String color = request.getParameter("color");
    String precio = request.getParameter("precio");

    String url = "jdbc:mysql://localhost:3306/OptiClinic?autoReconnect=true&useSSL=false";
    String user = "root";
    String password = "n0m3l0";

    Connection con = null;
    PreparedStatement ps = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection(url, user, password);
        String sql = "INSERT INTO carrito (modelo, forma, color, precio) VALUES (?, ?, ?, ?)";
        ps = con.prepareStatement(sql);
        ps.setString(1, modelo);
        ps.setString(2, forma);
        ps.setString(3, color);
        ps.setDouble(4, Double.parseDouble(precio));
        ps.executeUpdate();

        // Redirige al carrito
        response.sendRedirect("carrito.jsp");
    } catch (Exception e) {
        out.println("<h3>Error al agregar al carrito: " + e.getMessage() + "</h3>");
    } finally {
        if (ps != null) ps.close();
        if (con != null) con.close();
    }
%>
