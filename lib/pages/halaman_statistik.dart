
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/rekomendasi.dart';
import '../state/deteksi_bloc.dart';
import '../state/deteksi_state.dart';

class HalamanStatistik extends StatelessWidget {
  const HalamanStatistik({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeteksiBloc, DeteksiState>(
      builder: (context, state) {
        final jumlahPerKelas = daftarKelas
            .map((kelas) => state.daftarDeteksi
                .where((data) => data.kelas == kelas)
                .length)
            .toList();

        final nilaiMaks = jumlahPerKelas.fold<int>(
              0,
              (nilai, jumlah) => jumlah > nilai ? jumlah : nilai,
            ) +
            1;

        const label = [
          'Hawar',
          'Blas',
          'Bercak',
          'Normal',
          'Tungro',
        ];

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              'Jumlah Deteksi per Kelas',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 320,
              child: BarChart(
                BarChartData(
                  maxY: nilaiMaks.toDouble(),
                  alignment: BarChartAlignment.spaceAround,
                  gridData: const FlGridData(show: true),
                  borderData: FlBorderData(show: true),
                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 28,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 48,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();

                          if (index < 0 || index >= label.length) {
                            return const SizedBox.shrink();
                          }

                          return SideTitleWidget(
                            meta: meta,
                            child: Text(
                              label[index],
                              style: const TextStyle(fontSize: 10),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  barGroups: List.generate(
                    daftarKelas.length,
                    (index) {
                      return BarChartGroupData(
                        x: index,
                        barRods: [
                          BarChartRodData(
                            toY: jumlahPerKelas[index].toDouble(),
                            width: 18,
                            borderRadius: BorderRadius.circular(4),
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
