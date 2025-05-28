import 'package:flutter/material.dart';
import 'package:ornek_proje1/ekranlar/ana_ekran.dart';
import 'giris_ekrani.dart';

class SporUygulamasi extends StatefulWidget {
  const SporUygulamasi({super.key});

  @override
  State<SporUygulamasi> createState() => _SporUygulamasiState();
}

class _SporUygulamasiState extends State<SporUygulamasi> {
  String aktifEkran = 'giris-ekrani';

  void ekranDegistir(String yeniEkran) {
    setState(() {
      aktifEkran = yeniEkran;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget ekran = const SizedBox();

    if (aktifEkran == 'giris-ekrani') {
      ekran = GirisEkrani(ekranDegistir);
    } else if (aktifEkran == 'ana-ekran') { // Giriş ekranından ana ekrana geçiş için kontrol ekledik .
      ekran = AnaEkran(ekranDegistir: ekranDegistir);
    }


    return Scaffold(
      body: ekran,
    );
  }
}
