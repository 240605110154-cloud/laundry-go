# LaundryGo — Aplikasi Layanan Laundry

LaundryGo adalah aplikasi mobile berbasis Flutter yang dikembangkan untuk memenuhi tugas Ujian Tengah Semester (UTS) mata kuliah Pemrograman Mobile. Aplikasi ini menyediakan informasi layanan laundry dan simulasi pemesanan secara sederhana.

## Identitas Proyek

- **Nama Aplikasi:** LaundryGo
- **Mata Kuliah:** Pemrograman Mobile
- **Platform:** Android
- **Framework:** Flutter
- **Bahasa Pemrograman:** Dart
- **Pengembang:** Muhammad Farras Mufadhdhal
- **NIM:** 240605110154

## Fitur Aplikasi

LaundryGo memiliki beberapa fitur utama berikut:

1. **Beranda** — Menampilkan informasi aplikasi, daftar layanan, dan pesanan terbaru.
3. **Daftar Layanan** — Menampilkan pilihan layanan laundry beserta harga per kilogram.
4. **Detail Layanan** — Memungkinkan pengguna memilih berat cucian dan melihat total harga secara otomatis.
5. **Simulasi Pemesanan** — Memungkinkan pengguna membuat pesanan dan melihat konfirmasi pemesanan.
6. **Daftar Pesanan** — Menampilkan informasi pesanan, berat cucian, total harga, dan status pesanan.
7. **Status Pesanan** — Menampilkan status pesanan, seperti Diproses dan Selesai.

## Pilihan Layanan

| Layanan      | Harga       |
| Cuci Kering  | Rp7.000/kg  |
| Cuci Setrika | Rp10.000/kg |
| Setrika Saja | Rp5.000/kg  |
| Cuci Express | Rp15.000/kg |

## Teknologi yang Digunakan

- **Flutter** untuk membangun antarmuka aplikasi mobile.
- **Dart** sebagai bahasa pemrograman.
- **Material Design Widgets** untuk menyusun tampilan aplikasi.
- **Navigator dan MaterialPageRoute** untuk navigasi antarhalaman.
- **ValueNotifier dan ValueListenableBuilder** untuk memperbarui tampilan data pesanan.
- **Dummy Data** untuk menyimpan contoh layanan dan pesanan selama aplikasi berjalan.

## Struktur Proyek

```text
laundry_go/
├── android/
├── ios/
├── lib/
│   └── main.dart
├── test/
│   └── widget_test.dart
├── analysis_options.yaml
├── pubspec.yaml
└── README.md
```

## Persyaratan

Sebelum menjalankan aplikasi, pastikan perangkat pengembangan telah memiliki:

- Flutter SDK.
- Dart SDK (umumnya sudah disertakan bersama Flutter).
- Android Studio atau Visual Studio Code.
- Emulator Android atau perangkat Android untuk menjalankan aplikasi.

## Cara Menjalankan Aplikasi

1. Buka terminal dan masuk ke direktori proyek:

   ```bash
   cd laundry_go
   ```

2. Unduh dependensi yang dibutuhkan:

   ```bash
   flutter pub get
   ```

3. Periksa konfigurasi Flutter:

   ```bash
   flutter doctor
   ```

4. Jalankan aplikasi pada emulator atau perangkat yang terhubung:

   ```bash
   flutter run
   ```

## Pengujian

Pengujian dilakukan dengan menjalankan aplikasi dan memeriksa fungsi-fungsi utama, meliputi:

- Navigasi antara halaman Beranda, Layanan, dan Pesanan.
- Membuka halaman detail layanan.
- Mengubah berat cucian dan memeriksa perubahan total harga.
- Membuat pesanan baru.
- Memeriksa apakah pesanan baru muncul pada halaman Pesanan dan Beranda.
- Memeriksa tampilan status pesanan.

## Catatan dan Batasan

LaundryGo merupakan aplikasi simulasi pemesanan laundry. Data layanan dan pesanan disimpan sementara di memori aplikasi. Oleh karena itu, data pesanan baru tidak dijamin tetap tersedia setelah aplikasi ditutup sepenuhnya.

Aplikasi ini belum menggunakan database permanen, backend server, sistem pembayaran digital, atau integrasi dengan penyedia layanan laundry sungguhan.

## Pengembangan Selanjutnya

Pengembangan berikutnya dapat mencakup:

- Integrasi database untuk menyimpan data secara permanen.
- Sistem registrasi dan login pengguna.
- Pelacakan status pesanan secara lebih lengkap.
- Integrasi pembayaran digital.
- Integrasi dengan layanan laundry yang sebenarnya.

---

Dikembangkan sebagai proyek Ujian Tengah Semester (UTS) mata kuliah Pemrograman Mobile.
