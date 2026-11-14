import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../state/deteksi_bloc.dart';
import '../state/deteksi_event.dart';
import '../state/deteksi_state.dart';

class HalamanPengaturan extends StatelessWidget {
  const HalamanPengaturan({super.key});

  Future<void> konfirmasiHapus(BuildContext context) async {
    final hasil = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Hapus Semua Data?'),
        content: const Text('Semua riwayat deteksi akan dihapus.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (hasil == true && context.mounted) {
      context.read<DeteksiBloc>().add(const HapusSemuaDeteksi());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeteksiBloc, DeteksiState>(
      builder: (context, state) {
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            SwitchListTile(
              title: const Text('Mode Gelap'),
              value: state.modeGelap,
              onChanged: (value) => context
                  .read<DeteksiBloc>()
                  .add(ModeGelapDiubah(value)),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => context
                    .read<DeteksiBloc>()
                    .add(const MuatDataSimulasi()),
                child: const Text('Muat Data Simulasi'),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => konfirmasiHapus(context),
                child: const Text('Hapus Semua Data'),
              ),
            ),
          ],
        );
      },
    );
  }
}
