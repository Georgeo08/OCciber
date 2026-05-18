<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registro de Paciente</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
                position: relative;
                overflow-x: hidden;
            }
            
            #video-background {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                object-fit: cover;
                z-index: -1;
            }
            
            .container {
                background-color: rgba(255, 255, 255, 0.9);
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
                width: 90%;
                max-width: 600px;
                position: relative;
            }
            
            h1 {
                text-align: center;
                color: #333;
                margin-bottom: 25px;
            }
            
            .form-group {
                margin-bottom: 20px;
                display: flex;
                align-items: center;
            }
            
            label {
                width: 150px;
                text-align: right;
                margin-right: 15px;
                font-weight: bold;
            }
            
            input[type="text"] {
                padding: 10px;
                flex: 1;
                border: 1px solid #ddd;
                border-radius: 4px;
                font-size: 16px;
            }
            
            .btn-submit {
                background-color: #4CAF50;
                color: white;
                padding: 12px 25px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 16px;
                display: block;
                margin: 25px auto 15px;
                transition: background-color 0.3s;
            }
            
            .btn-submit:hover {
                background-color: #45a049;
            }
            
            .btn-back {
                display: inline-block;
                padding: 8px 15px;
                background-color: #f44336;
                color: white;
                text-decoration: none;
                border-radius: 4px;
                font-size: 14px;
                transition: background-color 0.3s;
            }
            
            .btn-back:hover {
                background-color: #d32f2f;
            }
            
            .message {
                margin-top: 20px;
                padding: 15px;
                border-radius: 4px;
                text-align: center;
            }
            
            .success {
                background-color: #dff0d8;
                color: #3c763d;
                border: 1px solid #d6e9c6;
            }
            
            .error {
                background-color: #f2dede;
                color: #a94442;
                border: 1px solid #ebccd1;
            }
        </style>
        <script>
            function valnum(event){
                var numeros = "1234567890";
                var x = event.which || event.keyCode;
                var numero = String.fromCharCode(x);
                var n = numeros.indexOf(numero);
                if(n === -1 && event.keyCode !== 8 && event.keyCode !== 9 && event.keyCode !== 46){
                    event.preventDefault();
                    alert("Por favor ingrese únicamente números");
                    return false;
                }
            }
            
            function validar(){
                var apPat = document.getElementById("paterno").value.trim();
                var apMat = document.getElementById("materno").value.trim();
                var nombre = document.getElementById("nombre").value.trim();
                var edad1 = document.getElementById("Edad").value.trim();
                var edad2 = parseInt(edad1);
                
                if(apPat === ''){
                    alert("Por favor ingrese el apellido paterno");
                    document.getElementById("paterno").focus();
                    return false;
                }
                if(apMat === ''){
                    alert("Por favor ingrese el apellido materno");
                    document.getElementById("materno").focus();
                    return false;
                }
                if(nombre === ''){
                    alert("Por favor ingrese el nombre");
                    document.getElementById("nombre").focus();
                    return false;
                }
                if(edad1 === '' || isNaN(edad2) || edad2 <= 0 || edad2 > 120){
                    alert("Por favor ingrese una edad válida (entre 1 y 120 años)");
                    document.getElementById("Edad").focus();
                    return false;
                }
                return true;
            }
        </script>
    </head>
    <body>
        <video autoplay muted id="video-background">
            <source src="agregaPa.mp4" type="video/mp4">
            Tu navegador no soporta videos HTML5.
        </video>
        
        <div class="container">
            <h1>Registro de Paciente</h1>
            <form method="post" action="" onsubmit="return validar()">
                <div class="form-group">
                    <label for="paterno">Apellido Paterno:</label>
                    <input type="text" name="apPat" id="paterno" required maxlength="20">
                </div>
                
                <div class="form-group">
                    <label for="materno">Apellido Materno:</label>
                    <input type="text" name="apMat" id="materno" required maxlength="20">
                </div>
                
                <div class="form-group">
                    <label for="nombre">Nombre:</label>
                    <input type="text" name="nom" id="nombre" required maxlength="20">
                </div>
                
                <div class="form-group">
                    <label for="Edad">Edad:</label>
                    <input type="text" name="edad" id="Edad" onkeypress="return valnum(event)" required maxlength="3">
                </div>
                
                <input type="submit" value="Registrar Paciente" class="btn-submit">
                <a href="paciDaoMenu.html" class="btn-back">REGRESAR</a>
            </form>

            <%-- Procesamiento del formulario --%>
            <%
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                String apPat = request.getParameter("apPat");
                String apMat = request.getParameter("apMat");
                String nombre = request.getParameter("nom");
                String edadStr = request.getParameter("edad");

                if (apPat != null && apMat != null && nombre != null && edadStr != null &&
                    !apPat.isEmpty() && !apMat.isEmpty() && !nombre.isEmpty() && !edadStr.isEmpty()) {

                    Connection con = null;
                    PreparedStatement ps = null;
                    ResultSet rs = null;

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        con = DriverManager.getConnection(
                                "jdbc:mysql://localhost:3306/OptiClinic?useSSL=false&allowPublicKeyRetrieval=true",
                                "root", "n0m3l0");

                        String sql = "INSERT INTO paciente (apellido_pt, apellido_pm, nombre, edad) VALUES (?, ?, ?, ?)";
                        ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                        ps.setString(1, apPat);
                        ps.setString(2, apMat);
                        ps.setString(3, nombre);
                        ps.setInt(4, Integer.parseInt(edadStr));
                        
                        int rowsAffected = ps.executeUpdate();
                        
                        if (rowsAffected > 0) {
                            rs = ps.getGeneratedKeys();
                            if (rs.next()) {
                                int folio = rs.getInt(1);
                                out.println("<div class='message success'>");
                                out.println("Paciente registrado exitosamente. Folio asignado: " + folio);
                                out.println("</div>");
                            }
                        } else {
                            out.println("<div class='message error'>");
                            out.println("Error al registrar paciente. No se pudo completar la operación.");
                            out.println("</div>");
                        }
                    } catch (SQLException e) {
                        out.println("<div class='message error'>");
                        out.println("Error de base de datos: " + e.getMessage());
                        out.println("</div>");
                    } catch (ClassNotFoundException e) {
                        out.println("<div class='message error'>");
                        out.println("Error: Driver JDBC no encontrado.");
                        out.println("</div>");
                    } catch (NumberFormatException e) {
                        out.println("<div class='message error'>");
                        out.println("Error: La edad debe ser un número válido.");
                        out.println("</div>");
                    } finally {
                        try {
                            if (rs != null) rs.close();
                            if (ps != null) ps.close();
                            if (con != null) con.close();
                        } catch (SQLException e) {
                            out.println("<div class='message error'>");
                            out.println("Error al cerrar conexiones: " + e.getMessage());
                            out.println("</div>");
                        }
                    }
                } else {
                    out.println("<div class='message error'>");
                    out.println("Error: Todos los campos son obligatorios.");
                    out.println("</div>");
                }
            }
            %>
        </div>
    </body>
</html>