import 'package:flutter/material.dart';
import 'package:ornek_proje1/ekranlar/secilen_egzersizler_sayfasi.dart';

class EgzersizlerSayfasi extends StatefulWidget {
  const EgzersizlerSayfasi({super.key});

  @override
  State<EgzersizlerSayfasi> createState() => _EgzersizlerSayfasiState();
}

class _EgzersizlerSayfasiState extends State<EgzersizlerSayfasi>
    with SingleTickerProviderStateMixin {
  final List<String> tumEgzersizler = [
    'Şınav',
    'Mekik',
    'Squat',
    'Koşu',
    'Bisiklet',
    'Plank',
    'Yüzme',
    'Yoga',
    'Pilates',
    'Ağırlık kaldırma',
    'Zumba',
  ];

  final Set<String> secilenEgzersizler = {};

  late final AnimationController _controller;

  final List<Color> _gradientColors = [
    Colors.deepPurple,
    Colors.pink,
    Colors.yellow,
  ];

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: _gradientColors,
                  stops: [0.0, _controller.value, 1.0],
                ),
              ),
              child: AppBar(
                title: const Text('Egzersiz Seç'),
                backgroundColor: const Color.fromARGB(0, 233, 231, 231),
                elevation: 0,
              ),
            );
          },
        ),
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: tumEgzersizler.length,
              itemBuilder: (context, index) {
                final egzersiz = tumEgzersizler[index];
                final secili = secilenEgzersizler.contains(egzersiz);

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Container(
                        decoration: BoxDecoration(
                          gradient: secili
                              ? LinearGradient(
                                  colors: _gradientColors,
                                  stops: [0.0, _controller.value, 1.0],
                                )
                              : null,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: secili
                                ? const Color.fromARGB(255, 5, 4, 4)
                                : const Color.fromARGB(0, 9, 6, 6),
                            width: 2,
                          ),
                        ),
                        child: CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          title: AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 300),
                            style: TextStyle(
                              color: secili
                                  ? const Color.fromARGB(255, 26, 19, 19)
                                  : const Color.fromARGB(255, 17, 14, 14),
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                            child: Text(egzersiz),
                          ),
                          value: secili,
                          onChanged: (bool? secildiMi) {
                            setState(() {
                              if (secildiMi == true) {
                                secilenEgzersizler.add(egzersiz);
                              } else {
                                secilenEgzersizler.remove(egzersiz);
                              }
                            });
                          },
                          activeColor: Colors.black,
                          checkColor: Colors.white,
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),

         //animasyonlu butonumuz 
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: _gradientColors,
                    stops: [0.0, _controller.value, 1.0],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SecilenEgzersizlerSayfasi(
                          egzersizler: secilenEgzersizler,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(0, 255, 255, 255),
                    shadowColor: Colors.transparent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Seçilenleri Gör'),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
