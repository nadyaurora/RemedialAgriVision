import 'package:flutter/material.dart';
import '../models/rekomendasi.dart';

class HalamanTentang extends StatelessWidget {
  const HalamanTentang({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tentang AgriVision')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Tujuan Aplikasi',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'AgriVision CNN merupakan aplikasi simulasi untuk mencatat hasil '
            'deteksi penyakit dan hama padi, melihat riwayat, serta memantau '
            'statistik deteksi pada Petak 1 dan Petak 2.',
          ),
          const SizedBox(height: 20),
          const Text(
            '5 Kelas Deteksi',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          ...daftarKelas.map(
            (kelas) => Card(
              child: ListTile(
                leading: const Icon(Icons.eco),
                title: Text(kelas),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
