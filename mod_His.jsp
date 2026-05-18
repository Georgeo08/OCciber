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
    <body class ="principal" style="display: flex; flex-direction: column; align-items: center; justify-content: center; min-height: 100vh;">
        <h1 align="center">Modificar Historial</h1>
        <form name="cambios" method="post" action="con_His.jsp">

            <div class ="cuadrito">
                <br><br><br><br><!-- comment -->
                <h3>▸Ingrese los datos que desea modificar </h3>
                <br><br>
                Nombre: <input type="text" name="nombre">
                <br><br><br><br>
                Apellido Paterno: <input type="text" name="ap_p">
                <br><br><br><br>
                Apellido Materno: <input type="text" name="ap_m">
                <br><br><br><br>
                Edad: <input type="text" name="edad">
                <br><br><br><br>
                Fecha: <input type="text" name="fech">
                <br><br><br><br>
                Comentarios: <input type="text" name="comentarios">
                <br><br><br><br>
                Lente de prueba: <input type="text" name="lent_prueb">
                <br><br><br><br>

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

                    String ap= request.getParameter("ap_p");
                        if (ap!= null && !ap.trim().isEmpty()) {
                            comanditoo.executeUpdate("update paciente set apellido_pt ='"+ap+"' where folio="+foli+";");
                            }
                            
                    String am= request.getParameter("ap_m");
                        if (am!= null && !am.trim().isEmpty()) {
                            comanditoo.executeUpdate("update paciente set apellido_pm ='"+am+"' where folio="+foli+";");
                            }
                            
                    String nom= request.getParameter("nombre");
                        if (nom!= null && !nom.trim().isEmpty()) {
                            comanditoo.executeUpdate("update paciente set nombre ='"+nom+"' where folio="+foli+";");
                            }
                            
                    String ed= request.getParameter("edad");
                    if (ed != null && !ed.trim().isEmpty()) {
                    int edi = Integer.parseInt(ed);
                    comanditoo.executeUpdate("update paciente set edad = "+edi+" where folio="+foli+";");
                    } 
                %>
            </div>
            <div>
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
                            <input type="text" name="od_av" style="width: 100px; height: 50px;">
                        </td>
                        <td style="background-color: white; width: 100px; height: 50px; text-align:center; vertical-align: middle;">
                            <input type="text" name="od_cv" style="width: 100px; height: 50px;"></td>
                        <td style="background-color: white; width: 100px; height: 50px; text-align:center; vertical-align: middle;">
                            <input type="text" name="od_av_crx_ant" style="width: 100px; height: 50px;">
                        </td>
                    </tr>
                    <tr>
                        <td style="background-color: white; width: 100px; height: 50px; text-align:center; vertical-align: middle;"> OI </td>
                        <td style="background-color: white; width: 100px; height: 50px; text-align:center; vertical-align: middle;">
                            <input type="text" name="oi_av" style="width: 100px; height: 50px;">
                        </td>
                        <td style="background-color: white; width: 100px; height: 50px; text-align:center; vertical-align: middle;">
                            <input type="text" name="oi_cv" style="width: 100px; height: 50px;">
                        </td>
                        <td style="background-color: white; width: 100px; height: 50px; text-align:center; vertical-align: middle;">
                            <input type="text" name="od_av_crx_ant" style="width: 100px; height: 50px;">
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
                            <input type="text" name="od_rx" style="width: 100px; height: 50px;">
                        </td>
                        <td style="background-color: white; width: 100px; height: 50px; text-align:center; vertical-align: middle;">
                            <input type="text" name="od_av_crx" style="width: 100px; height: 50px;"></td>
                        <td style="background-color: white; width: 100px; height: 50px; text-align:center; vertical-align: middle;">
                            <input type="text" name="od_add" style="width: 100px; height: 50px;">
                        </td>
                    </tr>
                    <tr>
                        <td style="background-color: white; width: 100px; height: 50px; text-align:center; vertical-align: middle;"> OI </td>
                        <td style="background-color: white; width: 100px; height: 50px; text-align:center; vertical-align: middle;">
                            <input type="text" name="oi_rx" style="width: 100px; height: 50px;">
                        </td>
                        <td style="background-color: white; width: 100px; height: 50px; text-align:center; vertical-align: middle;">
                            <input type="text" name="oi_av_crx" style="width: 100px; height: 50px;">
                        </td>
                        <td style="background-color: white; width: 100px; height: 50px; text-align:center; vertical-align: middle;">
                            <input type="text" name="oi_add" style="width: 100px; height: 50px;">
                        </td>
                    </tr>
                </TABLE>
                <%
                    resultado = comanditoo.executeQuery("select*from hist_med where folio='" + foli + "';");
                   
                if(resultado.next()){
                    int exp = resultado.getInt("exp");
                     
                        String fech= request.getParameter("fecha");
                            if (fech!= null && !fech.trim().isEmpty()) {
                            comanditoo.executeUpdate("update hist_med set fecha ='"+fech+"' where folio="+foli+";");
                            }
                        String com= request.getParameter("comentarios");
                            if (com!= null && !com.trim().isEmpty()) {
                            comanditoo.executeUpdate("update hist_med set comentarios ='"+com+" 'where folio="+foli+";");
                            }
                        String len= request.getParameter("lent_prueb");    
                            if (len!= null && !len.trim().isEmpty()) {
                            comanditoo.executeUpdate("update hist_med set lent_prueb ='"+len+"'where folio="+foli+";");
                            }

                resultado = comanditoo.executeQuery("select*from his_lent_cont where exp=" + exp + ";");
                    
                        if(resultado.next()){
                            String oi_cv= request.getParameter("oi_cv");
                                if (oi_cv!= null && !oi_cv.trim().isEmpty()) {
                            comanditoo.executeUpdate("update his_lent_cont set oi_cv = '"+oi_cv+"' where exp="+exp+";");
                            }
                            
                            String od_cv= request.getParameter("od_cv");
                            if (od_cv!= null && !od_cv.trim().isEmpty()) {
                            comanditoo.executeUpdate("update his_lent_cont set od_cv = '"+od_cv+"' where exp="+exp+";");
                            }
                            
                            String oi_av_crx= request.getParameter("oi_av_crx");
                            if (oi_av_crx!= null && !oi_av_crx.trim().isEmpty()) {
                            comanditoo.executeUpdate("update his_lent_cont set oi_av_crx = '"+oi_av_crx+"' where exp="+exp+";");
                            }
                            
                            String od_av_crx= request.getParameter("od_av_crx");
                            if (od_av_crx!= null && !od_av_crx.trim().isEmpty()) {
                            comanditoo.executeUpdate("update his_lent_cont set od_av_crx = '"+od_av_crx+"' where exp="+exp+";");
                            }
                            
                            String oi_add= request.getParameter("oi_add");
                            if (oi_add!= null && !oi_add.trim().isEmpty()) {
                            comanditoo.executeUpdate("update his_lent_cont set oi_add = '"+oi_add+"' where exp="+exp+";");
                            }
                            
                            String od_add= request.getParameter("od_add");
                            if (od_add!= null && !od_add.trim().isEmpty()) {
                            comanditoo.executeUpdate("update his_lent_cont set od_add = '"+od_add+"' where exp="+exp+";");
                            }
                            
                            String oi_av_crx_ant= request.getParameter("oi_av_crx_ant");
                            if (oi_av_crx_ant!= null && !oi_av_crx_ant.trim().isEmpty()) {
                            comanditoo.executeUpdate("update his_lent_cont set oi_av_crx_ant = '"+oi_av_crx_ant+"' where exp="+exp+";");
                            }
                            
                            String od_av_crx_ant= request.getParameter("od_av_crx_ant");
                            if (od_av_crx_ant!= null && !od_av_crx_ant.trim().isEmpty()) {
                            comanditoo.executeUpdate("update his_lent_cont set od_av_crx_ant = '"+od_av_crx_ant+"' where exp="+exp+";");
                            }
                            
                            String oi_rx= request.getParameter("oi_rx");
                            if (oi_rx!= null && !oi_rx.trim().isEmpty()) {
                            comanditoo.executeUpdate("update his_lent_cont set oi_rx = '"+oi_rx+"' where exp="+exp+";");
                            }
                            
                            String od_rx= request.getParameter("od_rx");
                            if (od_rx!= null && !od_rx.trim().isEmpty()) {
                            comanditoo.executeUpdate("update his_lent_cont set od_rx = '"+od_rx+"' where exp="+exp+";");
                            }
                            
                            String oi_av= request.getParameter("oi_av");
                            if (oi_av!= null && !oi_av.trim().isEmpty()) {
                            comanditoo.executeUpdate("update his_lent_cont set oi_av = '"+oi_av+"' where exp="+exp+";");
                            }
                            
                            String od_av= request.getParameter("od_av");
                            if (od_av!= null && !od_av.trim().isEmpty()) {
                            comanditoo.executeUpdate("update his_lent_cont set od_av = '"+od_av+"' where exp="+exp+";");
                            }
                        
                %>
                <h3>▸EXPLORACIÓN</h3>
                <TABLE align="center">
                    <tr>
                        <td style="width: 500px; height: 500px; text-align:center; vertical-align: middle;">
                            Parpados: <input type="text" name="parpados"><br>
                            Apertura: <input type="text" name="apertura"><br>
                            Hendidura: <input type="text" name="hendidura"><br>
                            Iris visible: <input type="text" name="iris_visi">
                            </td>
                        <td style="width: 100px; height: 500px;"></td>
                        <td style="width: 500px; height: 500px; text-align:center; vertical-align: middle;">
                            Lagrima: <input type="text" name="lagrima"><br>
                            Conjuntiva: <input type="text" name="conjuntiva"><br>
                            Cornea: <input type="text" name="cornea">
                            </td>
                        <td style="width: 100px; height: 500px;"></td>
                        <td style="width: 500px; height: 500px; text-align:center; vertical-align: middle;"> 
                            Blando: <input type="text" name="blando"><br>
                            Torico: <input type="text" name="torico"><br>
                            Rigido: <input type="text" name="rigido"><br>
                            Esferico: <input type="text" name="esferico"><br>
                            Escleral: <input type="text" name="escleral"><br>
                            Reemplazo: <input type="text" name="reemplazo">
                            </td>
                    </tr>
                </TABLE>
                <%
                    resultado = comanditoo.executeQuery("select*from exploracion where exp=" + exp + ";");
                    
                        if(resultado.next()){
                            String parpados= request.getParameter("parpados");
                            if (parpados!= null && !parpados.trim().isEmpty()) {
                            comanditoo.executeUpdate("update exploracion set parpados = '"+parpados+"' where exp="+exp+";");
                            }
                            
                            String lagrima= request.getParameter("lagrima");
                            if (lagrima!= null && !lagrima.trim().isEmpty()) {
                            comanditoo.executeUpdate("update exploracion set lagrima = '"+lagrima+"' where exp="+exp+";");
                            }
                            
                            String apertura= request.getParameter("apertura");
                            if (apertura!= null && !apertura.trim().isEmpty()) {
                            comanditoo.executeUpdate("update exploracion set apertura = '"+apertura+"' where exp="+exp+";");
                            }
                            
                            String cornea= request.getParameter("cornea");
                            if (cornea!= null && !cornea.trim().isEmpty()) {
                            comanditoo.executeUpdate("update exploracion set cornea = '"+cornea+"' where exp="+exp+";");
                            }
                            
                            String hendidura= request.getParameter("hendidura");
                            if (hendidura!= null && !hendidura.trim().isEmpty()) {
                            comanditoo.executeUpdate("update exploracion set hendidura = '"+hendidura+"' where exp="+exp+";");
                            }
                            
                            String conjuntiva= request.getParameter("conjuntiva");
                            if (conjuntiva!= null && !conjuntiva.trim().isEmpty()) {
                            comanditoo.executeUpdate("update exploracion set conjuntiva = '"+conjuntiva+"' where exp="+exp+";");
                            }
                            
                            String iris_visi= request.getParameter("iris_visi");
                            if (iris_visi!= null && !iris_visi.trim().isEmpty()) {
                            comanditoo.executeUpdate("update exploracion set iris_visi = '"+iris_visi+"' where exp="+exp+";");
                            }
                            
                            
                            String blando= request.getParameter("blando");
                            if (blando != null && !blando.trim().isEmpty()) {
                            int blando1 = Integer.parseInt(blando);
                            comanditoo.executeUpdate("update exploracion set blando = "+blando1+" where exp="+exp+";");
                            }
                            
                            String torico= request.getParameter("torico");
                            if (torico != null && !torico.trim().isEmpty()) {
                            int torico1 = Integer.parseInt(torico);
                            comanditoo.executeUpdate("update exploracion set torico = "+torico1+" where exp="+exp+";");
                            }
                            
                            String rigido= request.getParameter("rigido");
                            if (rigido != null && !rigido.trim().isEmpty()) {
                            int rigido1= Integer.parseInt(rigido);
                            comanditoo.executeUpdate("update exploracion set rigido = "+rigido1+" where exp="+exp+";");
                            }
                            
                            String esferico= request.getParameter("esferico");
                            if (esferico != null && !esferico.trim().isEmpty()) {
                            int esferico1= Integer.parseInt(esferico);
                            comanditoo.executeUpdate("update exploracion set esferico = "+esferico1+" where exp="+exp+";");
                            }
                            
                            String escleral= request.getParameter("escleral");
                            if (escleral != null && !escleral.trim().isEmpty()) {
                            int escleral1 = Integer.parseInt(escleral);
                            comanditoo.executeUpdate("update exploracion set escleral = "+escleral1+" where exp="+exp+";");
                            }
                            
                            String reemplazo= request.getParameter("reemplazo");
                            if (reemplazo != null && !reemplazo.trim().isEmpty()) {
                            int reemplazo1 = Integer.parseInt(reemplazo);
                            comanditoo.executeUpdate("update exploracion set reemplazo = "+reemplazo1+" where exp="+exp+";");
                            }
                %>
                
                <%
                    
                 }}}}
            }catch(SQLException error){
                out.print(error.toString());
                }
                %>
            </div>
            
            <input type="submit" name="cambios" value="validar">
        </form>
            <br><br>
            <a href="histoMenu.html"><button>Regresar</button></a>
    </body>
</html>
