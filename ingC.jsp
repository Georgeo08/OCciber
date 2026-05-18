<%@page contentType="text/html" import="java.sql.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            .principal{
                background-image: url('imagen.png');
            }
        </style>
    </head>
    <body class="principal" style="display: flex; flex-direction: column; align-items: center; justify-content: center; min-height: 100vh;">
        <%
             String foli = session.getAttribute("folioGuardado").toString();
             Connection conectadita= null;
             Statement comanditoo= null;
             ResultSet resultado=null;
             Statement sta = null;
             try{
                 Class.forName("com.mysql.cj.jdbc.Driver");
                 conectadita = DriverManager.getConnection("jdbc:mysql://localhost:3306/OptiClinic?autoReconnect=true&useSSL=false", "root", "n0m3l0");
                 comanditoo = conectadita.createStatement();
               
            }catch(SQLException error){
            out.print(error.toString());
            }
            try{
                 resultado = comanditoo.executeQuery("select*from citas where id_cit='" + foli + "';");
                 sta = conectadita.createStatement();
                     if(resultado.next()){
                     
                        String di= request.getParameter("dia");
                            if (di!= null && !di.trim().isEmpty()) {
                                int di1 = Integer.parseInt(di);
                                sta.executeUpdate("update citas set dia ="+di1+" where id_cit="+foli+";");
                            }
                            
                        String me= request.getParameter("mes");
                            if (me!= null && !me.trim().isEmpty()) {
                                try {
                                        int me1 = Integer.parseInt(me.trim());
                                        sta.executeUpdate("UPDATE citas SET mes = " + me1 + " WHERE id_cit = " + foli + ";");
                                    } catch (NumberFormatException e) {
                                        out.print("<script>alert('El valor de mes no es un número válido.');</script>");
                                            }
                            }

                        String an= request.getParameter("anio");
                            if (an!= null && !an.trim().isEmpty()) {
                                int an1 = Integer.parseInt(an);
                                sta.executeUpdate("update citas set año ="+an1+" where id_cit="+foli+";");
                            }
                            
                        String ho= request.getParameter("hora");
                            if (ho!= null && !ho.trim().isEmpty()) {
                                sta.executeUpdate("update citas set hora = '"+ho+"' where id_cit="+foli+";");
                            }
        %>
        <h1 align="center">Modificar Cita</h1>
        <form name="cambios" method="post" >

            <div class ="cuadrito">
                <br><br><br><br><!-- comment -->
                <h3>Cita actualizada: </h3>
                <br><br>
                <%
                   resultado = comanditoo.executeQuery("SELECT * FROM citas WHERE id_cit = " + foli + ";");
                   
                if(resultado.next()){
                        
                    int dia= resultado.getInt("dia");
                    int mes= resultado.getInt("mes");
                    int anio= resultado.getInt("año");
                    String hora= resultado.getString("hora");
                        
                out.print("Dia: "+dia+"<br><br>");
                out.print("Mes: "+mes+"<br><br>");
                out.print("Año: "+anio+"<br><br>");
                out.print("Hora: "+hora+"<br><br>");
                %>
            </div>
        </form>
        <%
            }
        conectadita.close();
        sta.close();
            }else{
                out.print("<script> alert('no existe la cita');</script>");
    }
    }catch(SQLException error){
        out.print(error.toString());
    }
        %>
        <br><br>
            <a href="citaMenu.html">
            <button type="button">Regresar</button>
        </a>
    </body>
</html>
