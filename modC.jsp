<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Modificar Cita</title>
    <style>
        body {
            font-family: "Segoe UI", sans-serif;
            background: #cce5ff url('fon5.png');
            background-size: cover; /* Para que se ajuste bien */
            background-repeat: no-repeat;
            background-position: center;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 80%;
            max-width: 700px;
            margin: 50px auto;
            background: #e6f0ff;
            border-radius: 20px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.2);
            padding: 30px;
            text-align: center;
        }

        h1 {
            background-color: #004e98;
            color: white;
            padding: 15px;
            border-radius: 15px;
            font-size: 24px;
            margin-top: 0;
        }

        form {
            margin-top: 20px;
            text-align: left;
        }

        label {
            font-weight: bold;
            display: block;
            margin-top: 10px;
            color: #004e98;
        }

        input[type="text"], textarea {
            width: 100%;
            padding: 10px;
            border-radius: 10px;
            border: 1px solid #004e98;
            margin-top: 5px;
        }

        textarea {
            resize: none;
            height: 80px;
        }

        .btn {
            background-color: #004e98;
            color: white;
            border: none;
            border-radius: 15px;
            padding: 10px 25px;
            font-size: 16px;
            margin-top: 20px;
            cursor: pointer;
            box-shadow: 2px 3px 5px rgba(0,0,0,0.3);
        }

        .btn:hover {
            background-color: #0068d9;
        }

        .success-box {
            background-color: #00b050;
            color: white;
            font-weight: bold;
            padding: 15px;
            border-radius: 10px;
            margin-top: 20px;
        }

        .regresar {
            background-color: #a1bde6;
            color: #000;
            padding: 8px 20px;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            margin-top: 15px;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>MODIFICAR CITAS</h1>

    <form action="modificarCita" method="post">
        <label for="folio">Ingrese el folio de la cita:</label>
        <input type="text" id="folio" name="folio" required>

        <label for="anio">Año:</label>
        <input type="text" id="anio" name="anio" required>

        <label for="mes">Mes:</label>
        <input type="text" id="mes" name="mes" required>

        <label for="dia">Día:</label>
        <input type="text" id="dia" name="dia" required>

        <label for="hora">Hora:</label>
        <input type="text" id="hora" name="hora" required>

        <label for="motivos">Motivos:</label>
        <textarea id="motivos" name="motivos"></textarea>

        <button type="submit" class="btn">Modificar</button>
    </form>

    <div class="success-box" style="display:none;" id="mensajeExito">
        LA CITA SE HA MODIFICADO:<br>
        Paciente: xxxx<br>
        Cita: xx/xx/xx
    </div>

    <button class="regresar" onclick="window.location.href='citaMenu.html'">Regresar</button>
</div>

</body>
</html>
