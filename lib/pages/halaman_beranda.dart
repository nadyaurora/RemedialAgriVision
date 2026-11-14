import 'package:flutter/material.dart';
import '../app_routes.dart';

class HalamanBeranda extends StatelessWidget {
  const HalamanBeranda({super.key});

  @override
  Widget build(BuildContext context) {
    final warna = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Text(
            'Selamat Datang di AgriVision CNN',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                children: [
                  Icon(Icons.eco, size: 38, color: warna.primary),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Model: EfficientNet-B0',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 6),
                        Text('5 kelas (4 penyakit + 1 Normal / Sehat)'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, AppRoutes.tentang),
              child: const Text('Tentang Aplikasi'),
            ),
          ),
        ],
      ),
    );
  }
}
