import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_routes.dart';
import 'app_theme.dart';
import 'pages/halaman_input_deteksi.dart';
import 'pages/halaman_tentang.dart';
import 'pages/kerangka_navigasi.dart';
import 'state/deteksi_bloc.dart';
import 'state/deteksi_event.dart';
import 'state/deteksi_state.dart';

void main() {
  runApp(
    BlocProvider(
      create: (_) => DeteksiBloc()..add(const MuatDataAwal()),
      child: const AgriVisionApp(),
    ),
  );
}

class AgriVisionApp extends StatelessWidget {
  const AgriVisionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeteksiBloc, DeteksiState>(
      buildWhen: (previous, current) => previous.modeGelap != current.modeGelap,
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'AgriVision CNN',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: state.modeGelap ? ThemeMode.dark : ThemeMode.light,
          initialRoute: AppRoutes.beranda,
          routes: {
            AppRoutes.beranda: (_) => const KerangkaNavigasi(),
            AppRoutes.tentang: (_) => const HalamanTentang(),
            AppRoutes.inputDeteksi: (_) => const HalamanInputDeteksi(),
          },
        );
      },
    );
  }
}
