import 'package:equatable/equatable.dart';
import '../models/hasil_deteksi.dart';

class DeteksiState extends Equatable {
  final List<HasilDeteksi> daftarDeteksi;
  final String filterPetak;
  final bool modeGelap;

  const DeteksiState({
    this.daftarDeteksi = const [],
    this.filterPetak = 'Semua',
    this.modeGelap = false,
  });

  List<HasilDeteksi> get dataTerfilter {
    if (filterPetak == 'Semua') return daftarDeteksi;
    return daftarDeteksi.where((data) => data.petak == filterPetak).toList();
  }

  int get total => daftarDeteksi.length;
  int get jumlahSehat =>
      daftarDeteksi.where((data) => data.status == 'Sehat').length;
  int get jumlahPerluTindakan =>
      daftarDeteksi.where((data) => data.status == 'Perlu Tindakan').length;

  DeteksiState copyWith({
    List<HasilDeteksi>? daftarDeteksi,
    String? filterPetak,
    bool? modeGelap,
  }) {
    return DeteksiState(
      daftarDeteksi: daftarDeteksi ?? this.daftarDeteksi,
      filterPetak: filterPetak ?? this.filterPetak,
      modeGelap: modeGelap ?? this.modeGelap,
    );
  }

  @override
  List<Object?> get props => [daftarDeteksi, filterPetak, modeGelap];
}
