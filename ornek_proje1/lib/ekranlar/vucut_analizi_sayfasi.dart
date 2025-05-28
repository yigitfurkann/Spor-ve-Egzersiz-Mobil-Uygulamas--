import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'dart:io';

const uuid = Uuid();

class VucutOlcumu {
  VucutOlcumu({required this.bolum, required this.puan, required this.tarih})
    : id = uuid.v4();
  final String id;
  final String bolum;
  final double puan;
  final DateTime tarih;
}

class VucutAnaliziSayfasi extends StatefulWidget {
  const VucutAnaliziSayfasi({super.key});

  @override
  State<VucutAnaliziSayfasi> createState() => _VucutAnaliziSayfasiState();
}

class _VucutAnaliziSayfasiState extends State<VucutAnaliziSayfasi> {
  final List<VucutOlcumu> olcumler = [
    VucutOlcumu(bolum: 'Bilek', puan: 4, tarih: DateTime.now()),
    VucutOlcumu(bolum: 'Bel', puan: 3.5, tarih: DateTime.now()),
    VucutOlcumu(bolum: 'Kol', puan: 5, tarih: DateTime.now()),
    VucutOlcumu(bolum: 'Bacak', puan: 2.5, tarih: DateTime.now()),
  ];

  void _olcumEkle(BuildContext context) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => const YeniVucutOlcumu(),
    );

    if (result == null) return;

    setState(() {
      olcumler.add(
        VucutOlcumu(
          bolum: result['bolum'],
          puan: result['puan'],
          tarih: result['tarih'],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vücut Analizi'),
        backgroundColor: const Color.fromARGB(255, 252, 252, 252),
      ),
      body: ListView.builder(// Derste gördüğümüz Dizileri silme işlemini burada body kısmaın uygulaadıkk.
        itemCount: olcumler.length,
        itemBuilder: (context, index) {
          final olcum = olcumler[index];
          return Dismissible(
            key: ValueKey(olcum.id),
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
                olcumler.removeAt(index);
              });
            },
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              elevation: 4,
              child: ListTile(
                leading: const Icon(Icons.fitness_center),
                title: Text(olcum.bolum),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RatingBarIndicator(
                      rating: olcum.puan,
                      itemBuilder:
                          (context, index) =>
                              const Icon(Icons.star, color: Colors.amber),
                      itemCount: 5,
                      itemSize: 20,
                    ),
                    Text(
                      DateFormat.yMd(Platform.localeName).format(olcum.tarih),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => _olcumEkle(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class YeniVucutOlcumu extends StatefulWidget {
  const YeniVucutOlcumu({super.key});

  @override
  State<YeniVucutOlcumu> createState() => _YeniVucutOlcumuState();
}

class _YeniVucutOlcumuState extends State<YeniVucutOlcumu> {
  final _controller = TextEditingController();
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

    setState(() => _secilenTarih = yeniTarih);
  }

  void _kaydet() {
    if (_controller.text.trim().isEmpty || _secilenTarih == null) return;

    Navigator.pop(context, {
      'bolum': _controller.text.trim(),
      'puan': _puan,
      'tarih': _secilenTarih,
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
            decoration: const InputDecoration(labelText: 'Vücut Bölgesi'),
            controller: _controller,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Puan'),
              const SizedBox(width: 10),
              RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                allowHalfRating: true,
                itemBuilder:
                    (_, __) =>
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
