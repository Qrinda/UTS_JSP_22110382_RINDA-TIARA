<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.Film" %>

<%
    // Ambil parameter dari URL atau redirect
    String filmIndexStr = request.getParameter("filmIndex");
    String jamTayang = request.getParameter("jamTayang");
    String jumlahTiketStr = request.getParameter("jumlahTiket");

    int filmIndex = -1;
    int jumlahTiket = 0;

    try {
        filmIndex = Integer.parseInt(filmIndexStr);
        jumlahTiket = Integer.parseInt(jumlahTiketStr);
    } catch (Exception e) {
        out.println("<script>alert('Data tidak valid untuk struk!'); location='dashboard.jsp';</script>");
        return;
    }

    ArrayList<Film> filmList = (ArrayList<Film>) session.getAttribute("filmList");

    if (filmList == null || filmIndex < 0 || filmIndex >= filmList.size()) {
        out.println("<script>alert('Film tidak ditemukan!'); location='dashboard.jsp';</script>");
        return;
    }

    Film film = filmList.get(filmIndex);
    int hargaTiket = film.getHargaTiket();
    int total = hargaTiket * jumlahTiket;

    // Waktu cetak
    String waktuCetak = new java.text.SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new Date());
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Struk Pemesanan Tiket</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .struk-box {
            border: 2px dashed #444;
            padding: 25px 40px;
            max-width: 400px;
            margin: 40px auto;
            background: #fff;
            font-family: 'Courier New', Courier, monospace;
            color: #222;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .struk-logo {
            max-width: 120px;
            margin: 0 auto 15px auto;
            display: block;
        }
        h3 {
            letter-spacing: 2px;
            margin-bottom: 15px;
        }
        .info-label {
            float: left;
            font-weight: bold;
        }
        .info-value {
            float: right;
        }
        .info-row {
            overflow: hidden;
            padding: 6px 0;
            border-bottom: 1px dotted #bbb;
            font-size: 14px;
        }
        .total-row {
            font-size: 18px;
            font-weight: bold;
            padding: 10px 0;
        }
        .footer {
            margin-top: 20px;
            font-size: 12px;
            text-align: center;
            color: #666;
        }
        @media print {
            .no-print {
                display: none !important;
            }
            body {
                background: none !important;
                margin: 0 !important;
            }
            .struk-box {
                box-shadow: none !important;
                border: none !important;
                max-width: 100% !important;
                padding: 0 !important;
                margin: 0 !important;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="navbar.jsp"/>
    
<div class="struk-box">
    <!-- Logo bioskop -->
    <img src="assets/mtl.jpg" alt="Logo Bioskop" class="struk-logo">

    <h4>🎟️ TIKET BIOSKOP 🎟️</h4>

    <div class="info-row">
        <span class="info-label">Judul Film</span>
        <span class="info-value"><%= film.getJudul() %></span>
    </div>
    <div class="info-row">
        <span class="info-label">Jam Tayang</span>
        <span class="info-value"><%= jamTayang %></span>
    </div>
    <div class="info-row">
        <span class="info-label">Jumlah Tiket</span>
        <span class="info-value"><%= jumlahTiket %></span>
    </div>
    <div class="info-row">
        <span class="info-label">Harga per Tiket</span>
        <span class="info-value">Rp <%= String.format("%,d", hargaTiket) %></span>
    </div>
    <div class="total-row">
        <span class="info-label">Total Bayar</span>
        <span class="info-value">Rp <%= String.format("%,d", total) %></span>
    </div>

    <div class="footer">
        <p><em>Dicetak: <%= waktuCetak %></em></p>
        <p>Thx udah pesan tiket kami!</p>
    </div>

    <div class="text-center mt-3 no-print">
        <button class="btn btn-success" onclick="window.print()">🖨️ Cetak Tiket</button>
        <a href="index.jsp" class="btn btn-secondary ms-2">Kembali</a>
    </div>
</div>
</body>
</html>
