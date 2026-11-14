import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/hasil_deteksi.dart';
import '../models/rekomendasi.dart';
import 'deteksi_event.dart';
import 'deteksi_state.dart';

class DeteksiBloc extends Bloc<DeteksiEvent, DeteksiState> {
  DeteksiBloc() : super(const DeteksiState()) {
    on<MuatDataAwal>((event, emit) {});
    on<TambahDeteksi>((event, emit) {
      emit(state.copyWith(
        daftarDeteksi: [event.data, ...state.daftarDeteksi],
      ));
    });
    on<HapusDeteksi>((event, emit) {
      final dataBaru = List<HasilDeteksi>.from(state.daftarDeteksi)
        ..remove(event.data);
      emit(state.copyWith(daftarDeteksi: dataBaru));
    });
    on<HapusSemuaDeteksi>((event, emit) {
      emit(state.copyWith(daftarDeteksi: []));
    });
    on<FilterPetakDiubah>((event, emit) {
      emit(state.copyWith(filterPetak: event.filter));
    });
    on<MuatDataSimulasi>((event, emit) {
      emit(state.copyWith(daftarDeteksi: buatDataSimulasi()));
    });
    on<ModeGelapDiubah>((event, emit) {
      emit(state.copyWith(modeGelap: event.aktif));
    });
  }

  List<HasilDeteksi> buatDataSimulasi() {
    final random = Random();
    return List.generate(10, (index) {
      final kelas = daftarKelas[random.nextInt(daftarKelas.length)];
      return HasilDeteksi(
        petak: random.nextBool() ? 'Petak 1' : 'Petak 2',
        kelas: kelas,
        skor: 30 + random.nextInt(70),
        namaPetugas: 'Petugas ${index + 1}',
        waktu: DateTime.now().subtract(Duration(hours: index * 2)),
      );
    });
  }
}
