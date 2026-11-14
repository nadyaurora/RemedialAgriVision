import 'package:flutter/material.dart';
import '../models/hasil_deteksi.dart';

class DeteksiCard extends StatelessWidget {
  final HasilDeteksi data;
  final VoidCallback onHapus;

  const DeteksiCard({
    super.key,
    required this.data,
    required this.onHapus,
  });

  Color warnaStatus(BuildContext context) {
    switch (data.status) {
      case 'Sehat':
        return Colors.green;
      case 'Tidak Pasti':
        return Colors.orange;
      default:
        return Colors.red;
    }
  }

  IconData ikonStatus() {
    switch (data.status) {
      case 'Sehat':
        return Icons.check_circle;
      case 'Tidak Pasti':
        return Icons.help;
      default:
        return Icons.warning;
    }
  }

  @override
  Widget build(BuildContext context) {
    final warna = warnaStatus(context);
    final waktu = data.waktu;
    final formatWaktu =
        '${waktu.day.toString().padLeft(2, '0')}/'
        '${waktu.month.toString().padLeft(2, '0')}/'
        '${waktu.year} ${waktu.hour.toString().padLeft(2, '0')}:'
        '${waktu.minute.toString().padLeft(2, '0')}';

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.grass),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '${data.petak} - ${data.kelas}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  tooltip: 'Hapus data',
                  onPressed: onHapus,
                  icon: const Icon(Icons.delete_outline),
                ),
              ],
            ),
            Row(
              children: [
                Icon(ikonStatus(), color: warna, size: 18),
                const SizedBox(width: 6),
                Text(
                  data.status,
                  style: TextStyle(color: warna, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Text('Skor: ${data.skor}%'),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: data.skor / 100,
              minHeight: 7,
              color: warna,
            ),
            const SizedBox(height: 10),
            Text('Rekomendasi: ${data.rekomendasi}'),
            const SizedBox(height: 6),
            Text(
              'Petugas: ${data.namaPetugas} • $formatWaktu',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
