import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/hasil_deteksi.dart';
import '../models/rekomendasi.dart';
import '../state/deteksi_bloc.dart';
import '../state/deteksi_event.dart';

class HalamanInputDeteksi extends StatefulWidget {
  const HalamanInputDeteksi({super.key});

  @override
  State<HalamanInputDeteksi> createState() => _HalamanInputDeteksiState();
}

class _HalamanInputDeteksiState extends State<HalamanInputDeteksi> {
  final _formKey = GlobalKey<FormState>();
  final _skorController = TextEditingController();
  final _petugasController = TextEditingController();

  String petak = 'Petak 1';
  String kelas = daftarKelas.first;
  bool dataBenar = false;

  @override
  void dispose() {
    _skorController.dispose();
    _petugasController.dispose();
    super.dispose();
  }

  Future<void> simpanData() async {
    if (!_formKey.currentState!.validate()) return;

    if (!dataBenar) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Centang Data sudah benar terlebih dahulu')),
      );
      return;
    }

    final konfirmasi = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Konfirmasi Data'),
        content: const Text('Apakah data deteksi sudah sesuai dan ingin disimpan?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Simpan'),
          ),
        ],
      ),
    );

    if (konfirmasi != true || !mounted) return;

    final data = HasilDeteksi(
      petak: petak,
      kelas: kelas,
      skor: int.parse(_skorController.text),
      namaPetugas: _petugasController.text.trim(),
      waktu: DateTime.now(),
    );

    context.read<DeteksiBloc>().add(TambahDeteksi(data));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Data tersimpan')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Input Deteksi')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text('Petak', style: TextStyle(fontWeight: FontWeight.bold)),
            RadioListTile<String>(
              title: const Text('Petak 1'),
              value: 'Petak 1',
              groupValue: petak,
              onChanged: (value) => setState(() => petak = value!),
            ),
            RadioListTile<String>(
              title: const Text('Petak 2'),
              value: 'Petak 2',
              groupValue: petak,
              onChanged: (value) => setState(() => petak = value!),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: kelas,
              decoration: const InputDecoration(
                labelText: 'Kelas Deteksi',
                border: OutlineInputBorder(),
              ),
              items: daftarKelas
                  .map((item) => DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      ))
                  .toList(),
              onChanged: (value) => setState(() => kelas = value!),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _skorController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Skor Deteksi (%)',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                final skor = int.tryParse(value ?? '');
                if (skor == null || skor < 0 || skor > 100) {
                  return 'Skor harus berupa angka 0–100';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _petugasController,
              decoration: const InputDecoration(
                labelText: 'Nama Petugas',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Nama petugas wajib diisi';
                }
                return null;
              },
            ),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Data sudah benar'),
              value: dataBenar,
              onChanged: (value) =>
                  setState(() => dataBenar = value ?? false),
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: dataBenar ? simpanData : null,
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
