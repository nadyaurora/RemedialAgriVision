import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app_routes.dart';
import '../main.dart';
import '../state/deteksi_bloc.dart';
import '../state/deteksi_event.dart';
import '../state/deteksi_state.dart';
import '../widgets/deteksi_card.dart';
import '../widgets/stat_card.dart';

class HalamanDeteksi extends StatelessWidget {
  const HalamanDeteksi({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeteksiBloc, DeteksiState>(
      builder: (context, state) {
        final data = state.dataTerfilter;
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Riwayat Deteksi',
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  children: ['Semua', 'Petak 1', 'Petak 2'].map((filter) {
                    return ChoiceChip(
                      label: Text(filter),
                      selected: state.filterPetak == filter,
                      onSelected: (_) => context
                          .read<DeteksiBloc>()
                          .add(FilterPetakDiubah(filter)),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    StatCard(judul: 'Total', jumlah: state.total,
                        ikon: Icons.list_alt),
                    StatCard(judul: 'Sehat', jumlah: state.jumlahSehat,
                        ikon: Icons.check_circle_outline),
                    StatCard(judul: 'Perlu Tindakan',
                        jumlah: state.jumlahPerluTindakan,
                        ikon: Icons.warning_amber),
                  ],
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: data.isEmpty
                      ? const Center(child: Text('Belum ada data'))
                      : ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            final item = data[index];
                            return DeteksiCard(
                              data: item,
                              onHapus: () => context
                                  .read<DeteksiBloc>()
                                  .add(HapusDeteksi(item)),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () =>
                Navigator.pushNamed(context, AppRoutes.inputDeteksi),
            icon: const Icon(Icons.add),
            label: const Text('Deteksi Baru'),
          ),
        );
      },
    );
  }
}
