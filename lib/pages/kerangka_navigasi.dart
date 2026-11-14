import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../state/deteksi_bloc.dart';
import '../state/deteksi_event.dart';
import '../state/deteksi_state.dart';
import 'halaman_beranda.dart';
import 'halaman_deteksi.dart';
import 'halaman_pengaturan.dart';
import 'halaman_statistik.dart';

class KerangkaNavigasi extends StatefulWidget {
  const KerangkaNavigasi({super.key});

  @override
  State<KerangkaNavigasi> createState() => _KerangkaNavigasiState();
}

class _KerangkaNavigasiState extends State<KerangkaNavigasi> {
  int indeksAktif = 0;

  final List<Widget> halaman = const [
    HalamanBeranda(),
    HalamanDeteksi(),
    HalamanStatistik(),
    HalamanPengaturan(),
  ];

  final List<String> judulTab = [
    'Beranda',
    'Deteksi',
    'Statistik',
    'Pengaturan',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeteksiBloc, DeteksiState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('AgriVision - ${judulTab[indeksAktif]}'),
          ),
          body: IndexedStack(
            index: indeksAktif,
            children: halaman,
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: indeksAktif,
            onDestinationSelected: (index) {
              setState(() => indeksAktif = index);
            },
            destinations: [
              const NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'Beranda',
              ),
              NavigationDestination(
                icon: Badge(
                  isLabelVisible: state.jumlahPerluTindakan > 0,
                  label: Text('${state.jumlahPerluTindakan}'),
                  child: const Icon(Icons.search),
                ),
                selectedIcon: Badge(
                  isLabelVisible: state.jumlahPerluTindakan > 0,
                  label: Text('${state.jumlahPerluTindakan}'),
                  child: const Icon(Icons.search),
                ),
                label: 'Deteksi',
              ),
              const NavigationDestination(
                icon: Icon(Icons.bar_chart_outlined),
                selectedIcon: Icon(Icons.bar_chart),
                label: 'Statistik',
              ),
              const NavigationDestination(
                icon: Icon(Icons.settings_outlined),
                selectedIcon: Icon(Icons.settings),
                label: 'Pengaturan',
              ),
            ],
          ),
        );
      },
    );
  }
}
