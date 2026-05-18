<%@page contentType="text/html" import="java.sql.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%
         String foli = session.getAttribute("folioPaciente").toString();
         Connection conectadita= null;
         Statement comanditoo= null;
         ResultSet resultado=null;
         try{
             Class.forName("com.mysql.cj.jdbc.Driver");
             conectadita = DriverManager.getConnection("jdbc:mysql://localhost:3306/OptiClinic?autoReconnect=true&useSSL=false", "root", "n0m3l0");
             comanditoo = conectadita.createStatement();
               
        }catch(SQLException error){
        out.print(error.toString());
        }
        try{
             resultado = comanditoo.executeQuery("select*from paciente where folio='" + foli + "';");
                 if(resultado.next()){
                    String ap= resultado.getString("apellido_pt");
                    String am= resultado.getString("apellido_pm");
                    String nom= resultado.getString("nombre");
                    int ed= resultado.getInt("edad");
                    
                    out.print("<script> alert('esta es la persona');</script>");
                        
    %>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            .principal{
                background-image: url('imagen.png');
            }
        </style>
    </head>
    <body class ="principal" style="display: flex; flex-direction: column; align-items: center; justify-content: center; min-height: 100vh;" >
        <h1 align="center">Consultar Historial</h1>
        <form name="consultaH" method="post" >
            <%--
            //resultado = comanditoo.executeQuery("select*from paciente where folio='" + foli + "';");
            /resultado = comanditoo.executeQuery("select*from hist_med where folio='" + foli + "';");
            --%>
            <div class ="cuadrito">
                <br><br><br><br><!-- comment -->
                <h3>Historial: </h3>
                <br><br>
                <%
                out.print("Nombre: "+nom+" "+ap+" "+am+"&nbsp;&nbsp;&nbsp;&nbsp;"+"Edad:"+ed+"&nbsp;&nbsp;&nbsp;&nbsp;");
                
                resultado = comanditoo.executeQuery("select*from hist_med where folio='" + foli + "';");
                
                if(resultado.next()){
                        String fech= resultado.getString("fecha");
                        String com= resultado.getString("comentarios");
                        String len= resultado.getString("lent_prueb");
                        String exp= resultado.getString("exp");
                        
                out.print("Fecha: "+fech+"&nbsp;&nbsp;&nbsp;&nbsp;"+"Exp:"+exp+"&nbsp;&nbsp;&nbsp;&nbsp;");
                out.println("Comentarios: "+com);
                
                resultado = comanditoo.executeQuery("select*from his_lent_cont where exp='" + exp + "';");
                    
                        if(resultado.next()){
                            String oi_cv= resultado.getString("oi_cv");
                            String od_cv= resultado.getString("od_cv");
                            String oi_av_crx= resultado.getString("oi_av_crx");
                            String od_av_crx= resultado.getString("od_av_crx");
                            String oi_add= resultado.getString("oi_add");
                            String od_add= resultado.getString("od_add");
                            String oi_av_crx_ant= resultado.getString("oi_av_crx_ant");
                            String od_av_crx_ant= resultado.getString("od_av_crx_ant");
                            String oi_rx= resultado.getString("oi_rx");
                            String od_rx= resultado.getString("od_rx");
                            String oi_av= resultado.getString("oi_av");
                            String od_av= resultado.getString("od_av");
                %>
                <br><br><br><br>
                <TABLE align="center">
                    <tr>
                        <td height= "50" width="100"> </td>
                        <td style="background-color: white; width: 100px; height: 50px; text-align:center; vertical-align: middle;">AV</td>
                        <td style="background-color: white; width: 100px; height: 50px; text-align:center; vertical-align: middle;"> CV </td>
                        <td style="background-color: white; width: 100px; height: 50px; text-align:center; vertical-align: middle;"> AV CRX ANTERIOR </td>
                    </tr>
                    <tr>
                        <td style="background-color: white; width: 100px; height: 50px; text-align:center; vertical-align: middle;"> OD </td>
                        <td style="background-color: white; width: 100px; height: 50px; text-align:center; vertical-align: middle;"> 
                        <%out.print(od_av);
                        %>
                        </td>
                        <td style="background-color: white; width: 100px; height: 50px; text-align:center; vertical-align: middle;">
                        <%out.print(od_cv);
                        %></td>
                        <td style="background-color: white; width: 100px; height: 50px; text-align:center; vertical-align: middle;">
                        <%out.print(od_av_crx_ant);
                        %>
                        </td>
                    </tr>
                    <tr>
                        <td style="background-color: white; width: 100px; height: 50px; text-align:center; vertical-align: middle;"> OI </td>
                        <td style="background-color: white; width: 100px; height: 50px; text-align:center; vertical-align: middle;">
                        <%out.print(oi_av);
                        %>
                        </td>
                        <td style="background-color: white; width: 100px; height: 50px; text-align:center; vertical-align: middle;">
                        <%out.print(oi_cv);
                        %>
                        </td>
                        <td style="background-color: white; width: 100px; height: 50px; text-align:center; vertical-align: middle;">
                        <%out.print(oi_av_crx_ant);
                        %>
                        </td>
                    </tr>
                </TABLE>
                <TABLE align="center">
                    <tr>
                        <td height= "50" width="100"> </td>
                        <td style="background-color: white; width: 100px; height: 50px; text-align:center; vertical-align: middle;">RX</td>
                        <td style="background-color: white; width: 100px; height: 50px; text-align:center; vertical-align: middle;"> AV CRX </td>
                        <td style="background-color: white; width: 100px; height: 50px; text-align:center; vertical-align: middle;"> ADD </td>
                    </tr>
                    <tr>
                        <td style="background-color: white; width: 100px; height: 50px; text-align:center; vertical-align: middle;"> OD </td>
                        <td style="background-color: white; width: 100px; height: 50px; text-align:center; vertical-align: middle;"> 
                        <%out.print(od_rx);
                        %>
                        </td>
                        <td style="background-color: white; width: 100px; height: 50px; text-align:center; vertical-align: middle;">
                        <%out.print(od_av_crx);
                        %></td>
                        <td style="background-color: white; width: 100px; height: 50px; text-align:center; vertical-align: middle;">
                        <%out.print(od_add);
                        %>
                        </td>
                    </tr>
                    <tr>
                        <td style="background-color: white; width: 100px; height: 50px; text-align:center; vertical-align: middle;"> OI </td>
                        <td style="background-color: white; width: 100px; height: 50px; text-align:center; vertical-align: middle;">
                        <%out.print(oi_rx);
                        %>
                        </td>
                        <td style="background-color: white; width: 100px; height: 50px; text-align:center; vertical-align: middle;">
                        <%out.print(oi_av_crx);
                        %>
                        </td>
                        <td style="background-color: white; width: 100px; height: 50px; text-align:center; vertical-align: middle;">
                        <%out.print(oi_add);
                        %>
                        </td>
                    </tr>
                </TABLE>
                <br><br><br><br>
                <%
                    resultado = comanditoo.executeQuery("select*from exploracion where exp='" + exp + "';");
                    
                        if(resultado.next()){
                            String parpados= resultado.getString("parpados");
                            String lagrima= resultado.getString("lagrima");
                            String apertura= resultado.getString("apertura");
                            String cornea= resultado.getString("cornea");
                            String hendidura= resultado.getString("hendidura");
                            String conjuntiva= resultado.getString("conjuntiva");
                            String iris_visi= resultado.getString("iris_visi");
                            
                            int blando= resultado.getInt("blando");
                            int torico= resultado.getInt("torico");
                            int rigido= resultado.getInt("rigido");
                            int esferico= resultado.getInt("esferico");
                            int escleral= resultado.getInt("escleral");
                            int reemplazo= resultado.getInt("reemplazo");
                %>
                <h3>▸EXPLORACIÓN</h3>
                <TABLE align="center">
                    <tr>
                        <td style="width: 250px; height: 500px; text-align:center; vertical-align: middle;">
                        <% out.println("Parpados: "+parpados+"<br><br>");
                        out.println("Apertura: "+apertura+"<br><br>");
                        out.println("Hendidura: "+hendidura+"<br><br>");
                        out.println("Iris visible: "+iris_visi+"<br><br>");
                        %></td>
                        <td style="width: 100px; height: 500px;"></td>
                        <td style="width: 250px; height: 500px; text-align:center; vertical-align: middle;">
                        <% out.println("Lagrima: "+lagrima+"<br><br>");
                        out.println("Conjuntiva: "+conjuntiva+"<br><br>");
                        out.println("Cornea: "+cornea+"<br><br>");
                        %></td>
                        <td style="width: 100px; height: 500px;"></td>
                        <td style="width: 250px; height: 500px; text-align:center; vertical-align: middle;"> 
                        <% out.println("Blando: "+blando+"<br><br>");
                        out.println("Torico: "+torico+"<br><br>");
                        out.println("Rigido: "+rigido+"<br><br>");
                        out.println("Esferico: "+esferico+"<br><br>");
                        out.println("Escleral: "+escleral+"<br><br>");
                        out.println("Reemplazo: "+reemplazo+"<br><br>");
                        %></td>
                    </tr>
                </TABLE>
                <br><br><br><br>
                <%
                    out.print( "Lente de prueba: "+ len);
                %>
            </div>
        </form>
        <%
            }}}
            conectadita.close();
            comanditoo.close();
            }else{
                out.print("<script> alert('no existe la persona');</script>");
    }
    }catch(SQLException error){
        out.print(error.toString());
    }
        %>
        <br><br>
            <a href="histoMenu.html"><button>Regresar</button></a>
    </body>
</html>
