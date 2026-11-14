import 'rekomendasi.dart';

class HasilDeteksi {
  final String petak;
  final String kelas;
  final int skor;
  final String namaPetugas;
  final DateTime waktu;

  const HasilDeteksi({
    required this.petak,
    required this.kelas,
    required this.skor,
    required this.namaPetugas,
    required this.waktu,
  });

  String get status {
    if (kelas == 'Normal / Sehat') return 'Sehat';
    if (skor < 50) return 'Tidak Pasti';
    return 'Perlu Tindakan';
  }

  String get rekomendasi {
    if (kelas == 'Normal / Sehat') {
      return 'Lanjutkan pemantauan rutin';
    }
    if (skor < 50) {
      return 'Cek ulang oleh petugas';
    }
    return rekomendasiPenanganan[kelas] ?? '-';
  }
}
