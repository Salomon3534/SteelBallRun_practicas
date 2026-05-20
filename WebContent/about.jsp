<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SBR - Acerca de</title>
    <link rel="stylesheet" href="sbrstyles.css">
    <link rel="icon" type="image/png" href="assets/web_images/sbr_logo.png">
</head>
<body>
    <%@ include file="WEB-INF/nav.jspf" %>

    <main class="about-page">
        <h1>Acerca de la Steel Ball Run</h1>

        <div class="about-card">
            <h2>¿Qué es la Steel Ball Run?</h2>
            <p>
                La <strong>Steel Ball Run</strong> es la carrera de caballos más grande y ambiciosa
                jamás organizada en la historia de los Estados Unidos. Celebrada en el año 1890,
                recorre el continente americano de costa a costa: desde la bahía de
                <em>San Diego, California</em> hasta el corazón de <em>Nueva York</em>,
                atravesando más de <strong>6.000 millas</strong> de terreno virgen.
            </p>
            <div class="prize-banner">
                <h3>Premio Total de la Competición</h3>
                <p>$50.000.000</p>
                <p style="font-size:1rem; margin-top:8px; color:#3a2a0a;">
                    Entregado en mano por el Presidente de los Estados Unidos al ganador en Central Park, Nueva York.
                </p>
            </div>
            <p>
                Organizada bajo el patrocinio personal del <strong>Presidente Steven Steel</strong>,
                la carrera reúne a los mejores jinetes y monturas del mundo entero.
            </p>
        </div>

        <div class="about-card">
            <h2>Reglamento General</h2>
            <ul>
                <li>Los participantes deben completar cada etapa dentro del tiempo límite establecido.</li>
                <li>Está prohibido el uso de vehículos motorizados o cualquier ayuda mecánica.</li>
                <li>Los jinetes son responsables de la salud de sus monturas durante toda la carrera.</li>
                <li>Cualquier acto de sabotaje o violencia hacia otros competidores supone la descalificación inmediata.</li>
                <li>Los chequeos médicos son obligatorios al inicio de cada etapa.</li>
                <li>Si una montura es declarada no apta, el jinete queda automáticamente descalificado.</li>
            </ul>
        </div>

        <div class="about-card">
            <h2>Organización</h2>
            <ul>
                <li>Presidente honorario: Steven Steel</li>
                <li>Director general de carrera: Benjamin Boom</li>
                <li>Comité médico: Dr. Ferdinand von Strohel</li>
                <li>Jefe de seguridad: Valentine Corps</li>
                <li>Comunicaciones: East and West Tribune</li>
                <li>Patrocinador principal: Speedwagon Oil Company</li>
            </ul>
        </div>

        <div class="about-card">
            <h2>Historia de la Carrera</h2>
            <p>
                La idea de Steel Ball Run fue imaginada por Steven Steel y Lucy Pendleton entre 1884 y 1888.
                El nombre proviene de las míticas <em>"Steel Balls"</em> — dos esferas de acero
                de valor histórico incalculable — cuya leyenda se entremezcla con los orígenes de la carrera.
            </p>
        </div>
    </main>

    <footer class="main-footer">
        <p>Steel Ball Run 1890</p>
        <div class="character-corner">
            <img src="assets/web_images/assistant_footer.png" alt="Personaje">
        </div>
    </footer>
</body>
</html>
