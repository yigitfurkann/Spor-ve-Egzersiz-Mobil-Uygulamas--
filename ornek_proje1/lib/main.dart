import 'package:flutter/material.dart';
import 'package:ornek_proje1/ekranlar/spor_uygulamasi.dart';
 // SporUygulamasi widget'ını import ettik

void main() {
  runApp(const SporVeEgzersizTakipUygulamasi());
}

// Uygulamanın ana widget'ı
class SporVeEgzersizTakipUygulamasi extends StatelessWidget {
  const SporVeEgzersizTakipUygulamasi({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spor ve Egzersiz Takip Uygulaması', // Uygulama başlığı
      theme: ThemeData(
        primarySwatch: Colors.green, // Tema rengi: Yeşil tonları
        fontFamily: 'Times New Roman', // Yazı tipi: Times New Roman 
      ),
      home: const SporUygulamasi(), 
    );
  }
}
