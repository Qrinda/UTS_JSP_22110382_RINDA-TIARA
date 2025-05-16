<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.Film" %>

<%
    String filmIndexStr = request.getParameter("filmIndex");
    int filmIndex = -1;
    try {
        filmIndex = Integer.parseInt(filmIndexStr);
    } catch (NumberFormatException e) {
        response.sendRedirect("index.jsp");
        return;
    }

    ArrayList<Film> filmList = (ArrayList<Film>) session.getAttribute("filmList");
    if (filmList == null || filmIndex < 0 || filmIndex >= filmList.size()) {
        response.sendRedirect("index.jsp");
        return;
    }

    Film selectedFilm = filmList.get(filmIndex);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Form Pemesanan Tiket</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2 class="mb-4">Form Pemesanan Tiket</h2>
    <form action="struk.jsp" method="post">
        <div class="mb-3">
            <label class="form-label">Judul Film</label>
            <input type="text" class="form-control" value="<%= selectedFilm.getJudul() %>" readonly>
            <input type="hidden" name="filmIndex" value="<%= filmIndex %>">
        </div>

        <div class="mb-3">
            <label for="jamTayang" class="form-label">Jam Tayang</label>
            <select name="jamTayang" id="jamTayang" class="form-select" required>
                <% for (String jam : selectedFilm.getJamTayang()) { %>
                    <option value="<%= jam %>"><%= jam %></option>
                <% } %>
            </select>
        </div>

        <div class="mb-3">
            <label for="jumlahTiket" class="form-label">Jumlah Tiket</label>
            <input type="number" class="form-control" id="jumlahTiket" name="jumlahTiket" min="1" required>
        </div>

        <button type="submit" class="btn btn-primary">Pesan</button>
        <a href="index.jsp" class="btn btn-secondary">Kembali</a>
    </form>
</div>
</body>
</html>
