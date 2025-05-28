import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'dart:io';

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
      padding: const EdgeInsets.fromLTRB(16, 64, 16, 16),
      child: Column(
        children: [
          TextField(
            decoration: const InputDecoration(labelText: 'Vücut Bölgesi'),
            controller: _controller,
          ),
          const SizedBox(height: 16),
          Row(children: [
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
          ]),
          const SizedBox(height: 16),
          Row(children: [
            const Icon(Icons.date_range),
            const SizedBox(width: 10),
            Text(_secilenTarih == null
                ? 'Tarih Seç'
                : bicim.format(_secilenTarih!)),
            const Spacer(),
            TextButton(
              onPressed: _tarihSec,
              child: const Text('Tarih Seç'),
            ),
          ]),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: _kaydet, child: const Text('Kaydet')),
        ],
      ),
    );
  }
}
