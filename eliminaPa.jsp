<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Eliminar Paciente</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f5f5f5;
                margin: 0;
                padding: 20px;
            }
            .container {
                max-width: 800px;
                margin: 0 auto;
                background: white;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 0 15px rgba(0,0,0,0.1);
            }
            h1 {
                color: #2c3e50;
                text-align: center;
                margin-bottom: 30px;
                border-bottom: 2px solid #3498db;
                padding-bottom: 10px;
            }
            .search-box {
                background: #f8f9fa;
                padding: 25px;
                border-radius: 8px;
                margin-bottom: 30px;
                box-shadow: 0 2px 5px rgba(0,0,0,0.05);
            }
            .results-box {
                background: #fff;
                padding: 25px;
                border-radius: 8px;
                border: 1px solid #e1e4e8;
                margin-bottom: 25px;
            }
            label {
                display: block;
                margin-bottom: 8px;
                font-weight: bold;
                color: #34495e;
            }
            input[type="number"] {
                width: 100%;
                padding: 12px;
                margin-bottom: 20px;
                border: 1px solid #ddd;
                border-radius: 6px;
                font-size: 16px;
                box-sizing: border-box;
            }
            .btn {
                display: inline-block;
                padding: 12px 25px;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                font-size: 16px;
                font-weight: bold;
                transition: all 0.3s ease;
                text-decoration: none;
                margin-right: 15px;
            }
            .btn-primary {
                background-color: #3498db;
                color: white;
            }
            .btn-primary:hover {
                background-color: #2980b9;
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            }
            .btn-danger {
                background-color: #e74c3c;
                color: white;
            }
            .btn-danger:hover {
                background-color: #c0392b;
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            }
            .patient-info {
                margin: 25px 0;
                padding: 20px;
                background-color: #f8fafc;
                border-radius: 8px;
                border-left: 5px solid #3498db;
            }
            .info-row {
                display: flex;
                margin-bottom: 12px;
            }
            .info-label {
                font-weight: bold;
                color: #2c3e50;
                min-width: 150px;
            }
            .info-value {
                color: #34495e;
            }
            .message {
                padding: 15px;
                margin: 20px 0;
                border-radius: 6px;
                text-align: center;
            }
            .success {
                background-color: #d4edda;
                color: #155724;
                border: 1px solid #c3e6cb;
            }
            .error {
                background-color: #f8d7da;
                color: #721c24;
                border: 1px solid #f5c6cb;
            }
            .warning {
                background-color: #fff3cd;
                color: #856404;
                border: 1px solid #ffeeba;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Eliminar Paciente</h1>
            
            <div class="search-box">
                <h2 style="color: #3498db; margin-top: 0;">Buscar Paciente</h2>
                <form method="get" action="">
                    <label for="folio">Ingrese el Folio del Paciente:</label>
                    <input type="number" name="folio" id="folio" required min="1" placeholder="Ej: 1001">
                    <div style="margin-top: 20px;">
                        <button type="submit" class="btn btn-primary">Buscar Paciente</button>
                        <a href="paciDaoMenu.html" class="btn btn-danger">Regresar al Menú</a>
                    </div>
                </form>
            </div>

            <%
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            Statement stmt = null;
            
            String folioStr = request.getParameter("folio");
            int folio = 0;
            if (folioStr != null && !folioStr.isEmpty()) {
                folio = Integer.parseInt(folioStr);
            }
            
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/OptiClinic?useSSL=false",
                    "root", "n0m3l0");
                
                if (folio > 0) {
                    String sqlSelect = "SELECT * FROM paciente WHERE folio = ?";
                    ps = con.prepareStatement(sqlSelect);
                    ps.setInt(1, folio);
                    rs = ps.executeQuery();
                    
                    if (rs.next()) {
                        %>
                        <div class="results-box">
                            <h2 style="color: #3498db; margin-top: 0;">Datos del Paciente</h2>
                            
                            <div class="patient-info">
                                <div class="info-row">
                                    <span class="info-label">Folio:</span>
                                    <span class="info-value"><%= rs.getInt("folio") %></span>
                                </div>
                                <div class="info-row">
                                    <span class="info-label">Nombre:</span>
                                    <span class="info-value"><%= rs.getString("nombre") %></span>
                                </div>
                                <div class="info-row">
                                    <span class="info-label">Apellido Paterno:</span>
                                    <span class="info-value"><%= rs.getString("apellido_pt") %></span>
                                </div>
                                <div class="info-row">
                                    <span class="info-label">Apellido Materno:</span>
                                    <span class="info-value"><%= rs.getString("apellido_pm") %></span>
                                </div>
                                <div class="info-row">
                                    <span class="info-label">Edad:</span>
                                    <span class="info-value"><%= rs.getInt("edad") %></span>
                                </div>
                            </div>
                            
                            <form method="post" action="">
                                <input type="hidden" name="folioEliminar" value="<%=folio%>">
                                <button type="submit" class="btn btn-danger" 
                                        onclick="return confirm('¿Está seguro que desea eliminar permanentemente este paciente?')">
                                    <i class="fas fa-trash-alt"></i> Confirmar Eliminación
                                </button>
                                <a href="eliminarPaciente.jsp" class="btn btn-primary">Cancelar</a>
                            </form>
                        </div>
                        <%
                    } else {
                        out.println("<div class='message warning'>No se encontró ningún paciente con el folio " + folio + "</div>");
                    }
                }
                
                if ("POST".equalsIgnoreCase(request.getMethod())) {
                    int folioEliminar = Integer.parseInt(request.getParameter("folioEliminar"));
                    con.setAutoCommit(false);
                    
                    try {

                        String[] tablasRelacionadas = {"citas", "hist_med"};
                        for (String tabla : tablasRelacionadas) {
                            ps = con.prepareStatement("DELETE FROM " + tabla + " WHERE folio = ?");
                            ps.setInt(1, folioEliminar);
                            ps.executeUpdate();
                        }
                        
 
                        ps = con.prepareStatement("DELETE FROM paciente WHERE folio = ?");
                        ps.setInt(1, folioEliminar);
                        int rowsAffected = ps.executeUpdate();
                        
                        if (rowsAffected > 0) {

                            stmt = con.createStatement();
                            stmt.execute("SET @count = 0");
                            stmt.execute("UPDATE paciente SET folio = @count:= @count + 1");
                            stmt.execute("ALTER TABLE paciente AUTO_INCREMENT = 1");
                            
                            con.commit();
                            out.println("<div class='message success'>"
                                    + "<strong>¡Operación exitosa!</strong> "
                                    + "El paciente ha sido eliminado y los folios han sido reorganizados."
                                    + "</div>");
                        } else {
                            con.rollback();
                            out.println("<div class='message error'>"
                                    + "No se pudo eliminar el paciente. Verifique el folio e intente nuevamente."
                                    + "</div>");
                        }
                    } catch (SQLException e) {
                        con.rollback();
                        out.println("<div class='message error'>"
                                + "<strong>Error en la transacción:</strong> " + e.getMessage()
                                + "</div>");
                    } finally {
                        con.setAutoCommit(true);
                    }
                }
            } catch (Exception e) {
                out.println("<div class='message error'>"
                        + "<strong>Error de conexión:</strong> " + e.getMessage()
                        + "</div>");
            } finally {

                try { if (rs != null) rs.close(); } catch (Exception e) {}
                try { if (ps != null) ps.close(); } catch (Exception e) {}
                try { if (stmt != null) stmt.close(); } catch (Exception e) {}
                try { if (con != null) con.close(); } catch (Exception e) {}
            }
            %>
        </div>
        
        <script>

            function confirmarEliminacion() {
                return confirm("¿Está completamente seguro de eliminar este paciente?\nEsta acción no se puede deshacer.");
            }
        </script>
    </body>
</html>