import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:ornek_proje1/models/ilerleme.dart';

final List<Ilerleme> ornekIlerlemeler = [
  Ilerleme(
    baslik: '1. Hafta',
    tarih: DateTime.now().subtract(const Duration(days: 7)),
    puan: 3,
  ),
  Ilerleme(
    baslik: '2. Hafta',
    tarih: DateTime.now(),
    puan: 3,
  ),
];

class IlerlemeSayfasi extends StatefulWidget {
  const IlerlemeSayfasi({super.key});
  @override
  State<IlerlemeSayfasi> createState() => _IlerlemeSayfasiState();
}

class _IlerlemeSayfasiState extends State<IlerlemeSayfasi> {
  final List<Ilerleme> ilerlemeler = [...ornekIlerlemeler];

  void _ilerlemeEkle(BuildContext context) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => const YeniIlerleme(),
    );

    if (result == null) return;

    setState(() {
      ilerlemeler.add(
        Ilerleme(
          baslik: result['baslik'],
          tarih: result['tarih'],
          puan: result['puan'],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('İlerleme Takibi'),
        backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      ),
      body: ListView.builder(
        itemCount: ilerlemeler.length,
        itemBuilder: (context, index) {
          final item = ilerlemeler[index];
          return Dismissible(
            key: ValueKey(item.id),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Text(
                'Sil',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            onDismissed: (direction) {
              setState(() {
                ilerlemeler.removeAt(index);
              });
            },
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              elevation: 4,
              child: ListTile(
                leading: const Icon(Icons.timeline),
                title: Text(item.baslik),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RatingBarIndicator(
                      rating: item.puan,
                      itemBuilder: (context, index) =>
                          const Icon(Icons.star, color: Colors.amber),
                      itemCount: 5,
                      itemSize: 20,
                    ),
                    Text(
                      DateFormat.yMd(Platform.localeName).format(item.tarih),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _ilerlemeEkle(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class YeniIlerleme extends StatefulWidget {
  const YeniIlerleme({super.key});

  @override
  State<YeniIlerleme> createState() => _YeniIlerlemeState();
}

class _YeniIlerlemeState extends State<YeniIlerleme> {
  final _baslikController = TextEditingController();
  double _puan = 3;
  DateTime? _secilenTarih;

  void _tarihSec() async {
    final bugun = DateTime.now();
    final yeniTarih = await showDatePicker(
      context: context,
      initialDate: bugun,
      firstDate: DateTime(bugun.year - 1),
      lastDate: bugun,
    );

    setState(() {
      _secilenTarih = yeniTarih;
    });
  }

  void _kaydet() {
    if (_baslikController.text.trim().isEmpty ||
        _secilenTarih == null) {
      return;
    }

    Navigator.pop(context, {
      'baslik': _baslikController.text.trim(),
      'tarih': _secilenTarih,
      'puan': _puan,
    });
  }

  @override
  Widget build(BuildContext context) {
    final bicim = DateFormat.yMd(Platform.localeName);
    return Padding(
      padding: EdgeInsets.only(
        top: 64,
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _baslikController,
            decoration: const InputDecoration(labelText: 'Başlık'),
          ),
          const SizedBox(height: 16),   
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Puan'),
              const SizedBox(width: 10),
              RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                allowHalfRating: true,
                itemBuilder: (_, __) =>
                    const Icon(Icons.star_rounded, color: Colors.amber),
                onRatingUpdate: (value) => _puan = value,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.date_range),
              const SizedBox(width: 10),
              Text(
                _secilenTarih == null
                    ? 'Tarih Seç'
                    : bicim.format(_secilenTarih!),
              ),
              const Spacer(),
              TextButton(onPressed: _tarihSec, child: const Text('Tarih Seç')),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: _kaydet, child: const Text('Kaydet')),
        ],
      ),
    );
  }
}
