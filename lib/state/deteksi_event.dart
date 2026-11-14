import 'package:equatable/equatable.dart';
import '../models/hasil_deteksi.dart';

abstract class DeteksiEvent extends Equatable {
  const DeteksiEvent();

  @override
  List<Object?> get props => [];
}

class MuatDataAwal extends DeteksiEvent {
  const MuatDataAwal();
}

class TambahDeteksi extends DeteksiEvent {
  final HasilDeteksi data;
  const TambahDeteksi(this.data);

  @override
  List<Object?> get props => [data];
}

class HapusDeteksi extends DeteksiEvent {
  final HasilDeteksi data;
  const HapusDeteksi(this.data);

  @override
  List<Object?> get props => [data];
}

class HapusSemuaDeteksi extends DeteksiEvent {
  const HapusSemuaDeteksi();
}

class FilterPetakDiubah extends DeteksiEvent {
  final String filter;
  const FilterPetakDiubah(this.filter);

  @override
  List<Object?> get props => [filter];
}

class MuatDataSimulasi extends DeteksiEvent {
  const MuatDataSimulasi();
}

class ModeGelapDiubah extends DeteksiEvent {
  final bool aktif;
  const ModeGelapDiubah(this.aktif);

  @override
  List<Object?> get props => [aktif];
}
