<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.Film" %>

<%
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
    String waktuCetak = new java.text.SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new Date());
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Struk Pemesanan Tiket</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <link href="assets/css/style.css" rel="stylesheet"> <!-- Pastikan tersambung -->
    <style>
        body {
            background-color: #121212;
            color: #ffffff;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding-top: 80px;
        }

        .struk-box {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(6px);
            border: 1px dashed #00bfff;
            border-radius: 16px;
            padding: 30px 40px;
            max-width: 500px;
            margin: 40px auto;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.4);
        }

        .struk-logo {
            max-width: 100px;
            margin: 0 auto 20px;
            display: block;
            border-radius: 10px;
        }

        h4 {
            text-align: center;
            margin-bottom: 20px;
            font-weight: bold;
            color: #00bfff;
        }

        .info-row {
            display: flex;
            justify-content: space-between;
            padding: 6px 0;
            border-bottom: 1px dashed #444;
            font-size: 15px;
        }

        .total-row {
            font-size: 18px;
            font-weight: bold;
            color: #00ffcc;
            padding-top: 12px;
            border-top: 1px solid #666;
            margin-top: 10px;
        }

        .footer {
            margin-top: 25px;
            font-size: 13px;
            text-align: center;
            color: #bbb;
        }

        .btn-success {
            background-color: #00bfff;
            border: none;
        }

        .btn-success:hover {
            background-color: #009acd;
        }

        .btn-secondary:hover {
            background-color: #5a6268;
        }

        @media print {
            .no-print {
                display: none !important;
            }

            body {
                background: none !important;
                color: #000 !important;
                margin: 0;
            }

            .struk-box {
                box-shadow: none !important;
                border: none !important;
                max-width: 100% !important;
                background: #fff !important;
                color: #000 !important;
                backdrop-filter: none !important;
            }
        }
    </style>
</head>
<body>

<jsp:include page="navbar.jsp"/>

<div class="struk-box">
    <img src="assets/mtl.jpg" alt="Logo Bioskop" class="struk-logo">

    <h4>🎟️ STRUK PEMESANAN 🎟️</h4>

    <div class="info-row">
        <span>Judul Film</span>
        <span><%= film.getJudul() %></span>
    </div>
    <div class="info-row">
        <span>Jam Tayang</span>
        <span><%= jamTayang %></span>
    </div>
    <div class="info-row">
        <span>Jumlah Tiket</span>
        <span><%= jumlahTiket %></span>
    </div>
    <div class="info-row">
        <span>Harga / Tiket</span>
        <span>Rp <%= String.format("%,d", hargaTiket) %></span>
    </div>
    <div class="info-row total-row">
        <span>Total Bayar</span>
        <span>Rp <%= String.format("%,d", total) %></span>
    </div>

    <div class="footer">
        <p><em>Dicetak: <%= waktuCetak %></em></p>
        <p>Terima kasih telah memesan di <strong>myCinema</strong> 🎬</p>
    </div>

    <div class="text-center mt-4 no-print">
        <button class="btn btn-success"><i class="bi bi-printer-fill me-1"></i>Cetak Tiket</button>
        <a href="index.jsp" class="btn btn-secondary ms-2"><i class="bi bi-arrow-left-circle me-1"></i>Kembali</a>
    </div>
</div>

</body>
</html>
