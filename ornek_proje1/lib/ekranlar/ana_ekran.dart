import 'package:flutter/material.dart';
import 'package:ornek_proje1/ekranlar/diyetler_sayfasi.dart';
import 'package:ornek_proje1/ekranlar/hedefler_sayfasi.dart';
import 'package:ornek_proje1/ekranlar/ilerleme_sayfasi.dart';
import 'package:ornek_proje1/ekranlar/profil_ekrani.dart';
import 'package:ornek_proje1/ekranlar/vucut_analizi_sayfasi.dart';
import 'egzersizler_sayfasi.dart';

class AnaEkran extends StatefulWidget {
  final void Function(String yeniEkran) ekranDegistir;

  const AnaEkran({super.key, required this.ekranDegistir});

  @override
  State<AnaEkran> createState() => _AnaEkranState();
}

class _AnaEkranState extends State<AnaEkran> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  final List<Color> _colors = [
    Colors.deepPurple,
    Colors.pink,
    Colors.amber,
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ana Ekran'),
        backgroundColor: const Color.fromARGB(255, 235, 235, 235),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            widget.ekranDegistir('giris-ekrani');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildAnimatedButton(label: 'Egzersizler', onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const EgzersizlerSayfasi()));
                }),
                _buildAnimatedButton(label: 'Diyetler', onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const DiyetlerSayfasi()));
                }),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildAnimatedButton(label: 'İlerleme', onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const IlerlemeSayfasi()));
                }),
                _buildAnimatedButton(label: 'Vücut Analizi', onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const VucutAnaliziSayfasi()));
                }),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildAnimatedButton(label: 'Hedefler', onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const HedeflerSayfasi()));
                }),
                _buildAnimatedButton(label: 'Profil', onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilEkrani()));
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedButton({required String label, required VoidCallback onPressed}) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: 180,
          height: 180,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: _colors,
              stops: [0.0, _controller.value, 1.0],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 6,
            ),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}