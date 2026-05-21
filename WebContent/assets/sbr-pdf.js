/**
 * sbr-pdf.js — Steel Ball Run
 * Generación del certificado PDF de registro.
 *
 * Uso: llamar a generarPDF(nombre, username, passkey) desde cualquier página.
 * Requiere jsPDF cargado previamente:
 *   <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
 */

function generarPDF(nombre, username, passkey) {
    const { jsPDF } = window.jspdf;
    const doc = new jsPDF();

    // Fondo pergamino
    doc.setFillColor(253, 246, 227);
    doc.rect(0, 0, 210, 297, 'F');

    // Borde decorativo
    doc.setDrawColor(139, 105, 20);
    doc.setLineWidth(3);
    doc.rect(10, 10, 190, 277);

    // Título
    doc.setFontSize(22);
    doc.setTextColor(90, 58, 0);
    doc.setFont("times", "bold");
    doc.text("STEEL BALL RUN 1890", 105, 40, { align: "center" });

    doc.setFontSize(16);
    doc.setFont("times", "normal");
    doc.setTextColor(60, 30, 0);
    doc.text("Certificado de Registro", 105, 55, { align: "center" });

    // Línea separadora
    doc.setDrawColor(200, 160, 40);
    doc.setLineWidth(1);
    doc.line(20, 62, 190, 62);

    // Nombre del corredor
    doc.setFontSize(13);
    doc.setTextColor(30, 20, 0);
    doc.text("Corredor/a:", 30, 80);
    doc.setFont("times", "bold");
    doc.text(nombre, 80, 80);

    // Texto del certificado
    doc.setFont("times", "normal");
    doc.text("Este documento certifica que el participante ha sido", 30, 100);
    doc.text("registrado correctamente en la Steel Ball Run.", 30, 112);

    // Caja de credenciales
    doc.setFontSize(12);
    doc.text("Tu clave de acceso (passkey) y usuario:", 30, 135);

    doc.setFillColor(255, 248, 225);
    doc.setDrawColor(200, 162, 39);
    doc.roundedRect(25, 142, 160, 28, 4, 4, 'FD');

    doc.setFont("times", "bold");
    doc.setFontSize(11);
    doc.setTextColor(44, 26, 0);
    doc.text("Usuario: " + username, 105, 151, { align: "center" });
    doc.text("Passkey: " + passkey,  105, 162, { align: "center" });

    // Advertencia
    doc.setFont("times", "normal");
    doc.setFontSize(10);
    doc.setTextColor(139, 0, 0);
    doc.text("Conserva este documento. No se puede recuperar.", 105, 182, { align: "center" });

    // Pie de página
    doc.setDrawColor(200, 160, 40);
    doc.line(20, 250, 190, 250);
    doc.setFontSize(9);
    doc.setTextColor(100, 70, 20);
    doc.text("Steel Ball Run \u00A9 1890 \u2014 Organizado por Steven Steel", 105, 260, { align: "center" });

    const filePrefix = passkey ? passkey.substring(0, 8) : "sbr";
    doc.save("sbr_registro_" + filePrefix + ".pdf");
}
