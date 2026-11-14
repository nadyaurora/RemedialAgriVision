import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  final String judul;
  final int jumlah;
  final IconData ikon;

  const StatCard({
    super.key,
    required this.judul,
    required this.jumlah,
    required this.ikon,
  });

  @override
  Widget build(BuildContext context) {
    final warna = Theme.of(context).colorScheme;
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 6),
          child: Column(
            children: [
              Icon(ikon, color: warna.primary),
              const SizedBox(height: 8),
              Text(
                '$jumlah',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(judul, textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}
