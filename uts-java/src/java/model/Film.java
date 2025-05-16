/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

public class Film {
    private String judul;
    private String genre;
    private int durasi;
    private int hargaTiket;
    private String[] jamTayang;
    private String gambar;  // menambahkan atribut gambar

    // Constructor
    public Film(String judul, String genre, int durasi, int hargaTiket, String[] jamTayang, String gambar) {
        this.judul = judul;
        this.genre = genre;
        this.durasi = durasi;
        this.hargaTiket = hargaTiket;
        this.jamTayang = jamTayang;
        this.gambar = gambar; // set gambar
    }

    // Getter untuk gambar
    public String getGambar() {
        return gambar;
    }

    // Getter lainnya
    public String getJudul() { return judul; }
    public String getGenre() { return genre; }
    public int getDurasi() { return durasi; }
    public int getHargaTiket() { return hargaTiket; }
    public String[] getJamTayang() { return jamTayang; }
}

