<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String folioParam = request.getParameter("folio");
    if (folioParam == null || folioParam.trim().isEmpty()) {
%>
    <p style="color:red; text-align:center;">⚠️ No se proporcionó un folio válido. Regrese y verifique.</p>
    <div style="text-align:center;">
        <a href="verificarFolio.jsp">Volver</a>
    </div>
<%
    return;
    }
%>
<html>
<head>
    <title>Añadir Historial Médico</title>
    <style>
        body {
            background-color: #99D9EA;
            font-family: sans-serif;
            padding: 20px;
        }
        h2 {
            text-align: center;
        }
        form {
            max-width: 800px;
            margin: auto;
            background-color: #ffffff;
            padding: 20px;
            border-radius: 10px;
        }
        label {
            display: block;
            margin-top: 10px;
            font-weight: bold;
        }
        input, textarea {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        input[type="submit"] {
            background-color: #f9c74f;
            color: #000;
            font-weight: bold;
            margin-top: 20px;
            cursor: pointer;
            border: none;
        }
        input[type="submit"]:hover {
            background-color: #f9844a;
            color: white;
        }
    </style>
</head>
<body>
<h2>Añadir Nuevo Historial Médico</h2>

<form action="insertarHistorial.jsp" method="post">

    <!-- FOLIO DEL PACIENTE (no editable) -->
    <input type="hidden" name="folio" value="<%=folioParam%>">
    <p><strong>Folio del Paciente:</strong> <%=folioParam%></p>

    <!-- HIST_MED -->
    <label>Fecha (dd/mm/aaaa):</label>
    <input type="text" name="fecha" required>

    <label>Comentarios:</label>
    <textarea name="comentarios" required></textarea>

    <label>Lente de Prueba:</label>
    <input type="text" name="lent_prueb" required>

    <!-- EXPLORACION -->
    <h3>Exploración</h3>
    <label>Parpados:</label>
    <input type="text" name="parpados">

    <label>Lágrima:</label>
    <input type="text" name="lagrima">

    <label>Apertura:</label>
    <input type="text" name="apertura">

    <label>Córnea:</label>
    <input type="text" name="cornea">

    <label>Hendidura:</label>
    <input type="text" name="hendidura">

    <label>Conjuntiva:</label>
    <input type="text" name="conjuntiva">

    <label>Iris y Visión:</label>
    <input type="text" name="iris_visi">

    <label>Tipo de lente (1 o 0):</label><br>
    Blando <input type="number" name="blando" min="0" max="1">
    Tórico <input type="number" name="torico" min="0" max="1">
    Rígido <input type="number" name="rigido" min="0" max="1">
    Esférico <input type="number" name="esferico" min="0" max="1">
    Escleral <input type="number" name="escleral" min="0" max="1">
    Reemplazo <input type="number" name="reemplazo" min="0" max="1">

    <!-- HIS_LENT_CONT -->
    <h3>Lentes de Contacto</h3>
    <label>OI Queratometrías:</label>
    <input type="text" name="oi_queratometrias">

    <label>OD Queratometrías:</label>
    <input type="text" name="od_queratometrias">

    <label>OI Esfera:</label>
    <input type="text" name="oi_esfera">

    <label>OI Cilindro:</label>
    <input type="text" name="oi_cilindro">

    <label>OI Eje:</label>
    <input type="text" name="oi_eje">

    <label>OD Esfera:</label>
    <input type="text" name="od_esfera">

    <label>OD Cilindro:</label>
    <input type="text" name="od_cilindro">

    <label>OD Eje:</label>
    <input type="text" name="od_eje">

    <label>Distancia Pupilar (DP):</label>
    <input type="text" name="dp">

    <label>OI CV:</label>
    <input type="text" name="oi_cv">

    <label>OD CV:</label>
    <input type="text" name="od_cv">

    <label>OI AV CRX:</label>
    <input type="text" name="oi_av_crx">

    <label>OD AV CRX:</label>
    <input type="text" name="od_av_crx">

    <label>OI ADD:</label>
    <input type="text" name="oi_add">

    <label>OD ADD:</label>
    <input type="text" name="od_add">

    <label>OI AV CRX Anterior:</label>
    <input type="text" name="oi_av_crx_ant">

    <label>OD AV CRX Anterior:</label>
    <input type="text" name="od_av_crx_ant">

    <label>OI RX:</label>
    <input type="text" name="oi_rx">

    <label>OD RX:</label>
    <input type="text" name="od_rx">

    <label>OI AV:</label>
    <input type="text" name="oi_av">

    <label>OD AV:</label>
    <input type="text" name="od_av">

    <input type="submit" value="Guardar Historial">
</form>
</body>
</html>
