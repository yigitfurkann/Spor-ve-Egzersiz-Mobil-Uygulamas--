import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class GirisEkrani extends StatefulWidget {
  final void Function(String yeniEkran) ekranDegistir;

  const GirisEkrani(this.ekranDegistir, {super.key});

  @override
  State<GirisEkrani> createState() => _GirisEkraniState();
}

class _GirisEkraniState extends State<GirisEkrani>
    with SingleTickerProviderStateMixin {
  final _kullaniciAdiController = TextEditingController();
  final _sifreController = TextEditingController();

  late final AnimationController _controller;

  // Gradient renkler
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
    _kullaniciAdiController.dispose();
    _sifreController.dispose();
    _controller.dispose();
    super.dispose();
  }

 void _girisYap() {// derste gördüğümüz CupertinoAlertDialog ve AlertDialog kullanarak hata mesajı gösteriyoruz
  // Kullanıcı adı ve şifre kontrolü Cupertino ile güncellendi 
  //Cupertion.dart import ettik
  final kullaniciAdi = _kullaniciAdiController.text;
  final sifre = _sifreController.text;

  if (kullaniciAdi == 'fygt' && sifre == '123') {
    widget.ekranDegistir('ana-ekran');
  } else {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text('Hata'),
          content: const Text('Kullanıcı adı veya şifre hatalı!'),
          actions: [
            CupertinoDialogAction(
              child: const Text('Kapat'),
              onPressed: () => Navigator.pop(ctx),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Hata'),
          content: const Text('Kullanıcı adı veya şifre hatalı!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Kapat'),
            ),
          ],
        ),
      );
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 253, 253, 253),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/fitness.png',
                width: 200,
              ),
              const SizedBox(height: 40),
              TextField(
                controller: _kullaniciAdiController,
                decoration: const InputDecoration(
                  labelText: 'Kullanıcı Adı',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: _sifreController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Şifre',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 32),

              // Giriş Yap butonu Animasyonlu şekilde  https://medium.com/flutter-community/flutter-animations-comprehensive-guide-cb93b246ca5d Buradan aldım ve uyguladım 
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: _colors,
                        stops: [0.0, _controller.value, 1.0],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ElevatedButton.icon(
                      onPressed: _girisYap,
                      icon: const Icon(Icons.login, color: Colors.white),
                      label: const Text('Giriş Yap'),
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.transparent,
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                        textStyle: const TextStyle(fontSize: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
