# AgriVision CNN - BLoC

Aplikasi Flutter simulasi pencatatan deteksi penyakit dan hama padi sesuai soal Asesmen Praktikum PPBL Kode A.

## Cara menjalankan

1. Buat proyek Flutter:
   ```bash
   flutter create agrivision_cnn_nim
   ```
2. Salin folder `lib/` dari paket ini ke folder proyek Flutter.
3. Ganti isi `pubspec.yaml` proyek dengan `pubspec.yaml` dari paket ini.
4. Jalankan:
   ```bash
   flutter pub get
   flutter run
   ```

## Paket
- flutter_bloc: pengelolaan state dengan BLoC
- fl_chart: grafik statistik

## Catatan
- Tema terang dan gelap diatur melalui `AppTheme` dan state BLoC.
- Data disimpan sementara di memori, sehingga akan kembali kosong ketika aplikasi dimulai ulang.
- Tombol Muat Data Simulasi menghasilkan 10 data acak.
- Statistik grafik dihitung otomatis dari data BLoC.
