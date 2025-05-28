import 'package:flutter/material.dart';

class SecilenEgzersizlerSayfasi extends StatefulWidget {
  final Set<String> egzersizler;

  const SecilenEgzersizlerSayfasi({super.key, required this.egzersizler});

  @override
  State<SecilenEgzersizlerSayfasi> createState() =>
      _SecilenEgzersizlerSayfasiState();
}

class _SecilenEgzersizlerSayfasiState
    extends State<SecilenEgzersizlerSayfasi> with SingleTickerProviderStateMixin {
  int? selectedItemIndex;
  late final AnimationController _controller;

  final List<Color> _gradientColors = [const Color.fromARGB(255, 112, 74, 179), Colors.pink, Colors.yellow];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
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
    final egzersizListesi = widget.egzersizler.toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Seçilen Egzersizler')),
      body: ListView.builder(
        itemCount: egzersizListesi.length,
        itemBuilder: (context, i) {
          final isSelected = selectedItemIndex == i;
          final egzersiz = egzersizListesi[i];

          return GestureDetector(// 	Tıklanabilir liste elemanları oluşturma 
            onTap: () {
              setState(() {
                selectedItemIndex = i;
              });
            },
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: isSelected
                        ? LinearGradient(
                            colors: _gradientColors,
                            stops: [0.0, _controller.value, 1.0],
                          )
                        : null,
                    color: isSelected ? null : const Color.fromARGB(255, 250, 250, 250),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? const Color.fromARGB(255, 16, 15, 15) : const Color.fromARGB(0, 3, 2, 2),
                      width: 2,
                    ),
                  ),
                  child: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.black : const Color.fromARGB(255, 11, 10, 10),
                    ),
                    child: Text(egzersiz),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
