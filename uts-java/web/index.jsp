<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, model.Film" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Cinema</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet"> 
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="navbar.jsp"/>

<%
    ArrayList<Film> filmList = (ArrayList<Film>) session.getAttribute("filmList");
    
    if (filmList == null) {
        filmList = new ArrayList<>();
        filmList.add(new Film("The Last Of Us", "Action, Adventure", 180, 50000, new String[]{"10:00", "13:00", "16:00", "19:00"}, "tlo.jpg"));
        filmList.add(new Film("JUMBO", "Animation, Culture", 148, 45000, new String[]{"09:30", "12:30", "15:30", "18:30"}, "jumbo.jpg"));
        filmList.add(new Film("Mencuri Raden Saleh", "Action, Crime, Drama", 176, 55000, new String[]{"11:00", "14:30", "18:00", "21:30"}, "mrs.jpg"));
        filmList.add(new Film("One Day", "Adventure, Drama, Sci-Fi", 155, 48000, new String[]{"10:15", "13:45", "17:15", "20:45"}, "1day.jpg"));
        filmList.add(new Film("One Piece", "Anime, Adventure, Thriller", 163, 52000, new String[]{"09:00", "12:30", "16:00", "19:30"}, "wanpis.jpg"));
        filmList.add(new Film("Kimetsu No Yaiba", "Anime, Adventure, Sci-Fi", 134, 47000, new String[]{"11:30", "14:15", "17:00", "20:00"}, "kny.jpg"));
        session.setAttribute("filmList", filmList);
    }
%>

<div class="container mt-4">
    <h1 class="text-center mb-5 text-neon">🎬 My Cinema</h1>
    <div class="row row-cols-1 row-cols-md-3 g-4">
    <% for(int i = 0; i < filmList.size(); i++) {
        Film film = filmList.get(i);
    %>
        <div class="col" data-aos="fade-up" data-aos-delay="<%= i * 100 %>">
            <div class="card h-100">
                <img src="assets/<%= film.getGambar() %>" class="card-img-top" style="height: 350px; object-fit: cover;" alt="<%= film.getJudul() %>">
                <div class="card-body">
                    <h5 class="card-title"><%= film.getJudul() %></h5>
                    <p class="card-text"><strong>Genre:</strong> <%= film.getGenre() %></p>
                    <p class="card-text"><strong>Durasi:</strong> <%= film.getDurasi() %> menit</p>
                    <p class="card-text"><strong>Harga:</strong> Rp <%= String.format("%,d", film.getHargaTiket()) %></p>
                    <button 
                        class="btn btn-primary w-100 mt-2"
                        data-bs-toggle="modal"
                        data-bs-target="#formModal"
                        data-film-index="<%= i %>">Pesan Tiket
                    </button>
                </div>
            </div>
        </div>
    <% } %>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="formModal" tabindex="-1" aria-labelledby="formModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <form action="struk.jsp" method="post">
        <div class="modal-header">
          <h5 class="modal-title" id="formModalLabel">🎬 Form Pemesanan Tiket</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">

          <input type="hidden" name="filmIndex" id="filmIndexInput">

          <div class="mb-3">
            <label class="form-label">Judul Film</label>
            <input type="text" class="form-control" id="judulFilmInput" readonly>
          </div>

          <div class="mb-3">
            <label class="form-label">Harga Tiket</label>
            <input type="text" class="form-control" id="hargaTiketInput" readonly>
            <input type="hidden" name="hargaTiket" id="hargaTiketHidden">
          </div>

          <div class="mb-3">
            <label for="jamTayang" class="form-label">Jam Tayang</label>
            <select name="jamTayang" id="jamTayangSelect" class="form-select" required></select>
          </div>

          <div class="mb-3">
            <label for="jumlahTiket" class="form-label">Jumlah Tiket</label>
            <input type="number" class="form-control" id="jumlahTiket" name="jumlahTiket" min="1" required>
          </div>

        </div>
        <div class="modal-footer">
          <button type="submit" class="btn btn-success">Pesan</button>
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
        </div>
      </form>
    </div>
  </div>
</div>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.js"></script>
<script>
  AOS.init();

  const filmData = [
    <% for (int i = 0; i < filmList.size(); i++) {
         model.Film f = filmList.get(i);
    %>
    {
      judul: "<%= f.getJudul().replace("\"", "\\\"") %>",
      hargaTiket: <%= f.getHargaTiket() %>,
      jamTayang: [<% 
        String[] jams = f.getJamTayang();
        for (int j = 0; j < jams.length; j++) {
            out.print("\"" + jams[j] + "\"");
            if (j < jams.length - 1) out.print(", ");
        } %>]
    }<%= (i < filmList.size() - 1) ? "," : "" %>
    <% } %>
  ];

  const modal = document.getElementById('formModal');
  modal.addEventListener('show.bs.modal', function (event) {
    const button = event.relatedTarget;
    const index = button.getAttribute('data-film-index');
    const film = filmData[index];

    document.getElementById('filmIndexInput').value = index;
    document.getElementById('judulFilmInput').value = film.judul;
    document.getElementById('hargaTiketInput').value = 'Rp ' + film.hargaTiket.toLocaleString();
    document.getElementById('hargaTiketHidden').value = film.hargaTiket;

    const jamSelect = document.getElementById('jamTayangSelect');
    jamSelect.innerHTML = '';
    film.jamTayang.forEach(jam => {
      const option = document.createElement('option');
      option.value = jam;
      option.textContent = jam;
      jamSelect.appendChild(option);
    });
  });
</script>

</body>
</html>
