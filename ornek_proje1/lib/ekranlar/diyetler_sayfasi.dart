import 'package:flutter/material.dart';

class DiyetlerSayfasi extends StatefulWidget {
  const DiyetlerSayfasi({super.key});

  @override
  State<DiyetlerSayfasi> createState() => _DiyetlerSayfasiState();
}

class _DiyetlerSayfasiState extends State<DiyetlerSayfasi> {
  final List<Map<String, String>> _diyetler = [
    {
      'baslik': 'Ketojenik Diyet',
      'aciklama': 'Yüksek yağ, düşük karbonhidrat.',
      'resim': 'assets/images/ketojenik.png',
    },
    {
      'baslik': 'Akdeniz Diyeti',
      'aciklama': 'Zeytinyağı, sebze ve balık ağırlıklı.',
      'resim': 'assets/images/akdeniz.png',
    },
    {
      'baslik': 'Paleo Diyeti',
      'aciklama': 'Doğal gıdalar, işlenmiş gıdalardan kaçınma.',
      'resim': 'assets/images/paleo.png',
    },
    {
      'baslik': 'Düşük Kalorili Diyet',
      'aciklama': 'Kalori alımını azaltma.',
      'resim': 'assets/images/dusukkalorili.png',
    },
    {
      'baslik': 'Vejetaryen Diyet',
      'aciklama': 'Et tüketiminden kaçınma.',
      'resim': 'assets/images/vejeteryan.png',
    }
  ];

  void _diyetEkle(BuildContext context) async {
    final yeniDiyet = await showModalBottomSheet<Map<String, String>>(
      context: context,
      isScrollControlled: true,
      builder: (_) => const YeniDiyetEkle(),
    );

    if (yeniDiyet != null) {
      setState(() {
        _diyetler.add(yeniDiyet);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diyetlerim'),
        backgroundColor: const Color.fromARGB(255, 252, 252, 252),
      ),
      body: ListView.builder(
        itemCount: _diyetler.length,
        itemBuilder: (context, index) {
          final diyet = _diyetler[index];
          return Dismissible(
            key: ValueKey(diyet['baslik']),
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
                _diyetler.removeAt(index);
              });
            },
            child: Card(
              margin: const EdgeInsets.all(12),
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: Image.asset(
                  diyet['resim'] ?? 'assets/images/placeholder.png',
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
                title: Text(diyet['baslik']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(diyet['aciklama']!),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _diyetEkle(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class YeniDiyetEkle extends StatefulWidget {
  const YeniDiyetEkle({super.key});

  @override
  State<YeniDiyetEkle> createState() => _YeniDiyetEkleState();
}

class _YeniDiyetEkleState extends State<YeniDiyetEkle> {
  final _baslikController = TextEditingController();
  final _aciklamaController = TextEditingController();

  final List<String> _ornekResimler = [
    'assets/images/ketojenik.png',
    'assets/images/akdeniz.png',
    'assets/images/paleo.png',
    'assets/images/dusukkalorili.png',
    'assets/images/vejeteryan.png',
  ];

  String? _secilenResim;

  void _kaydet() {
    if (_baslikController.text.trim().isEmpty || _aciklamaController.text.trim().isEmpty) return;

    Navigator.pop(context, {
      'baslik': _baslikController.text.trim(),
      'aciklama': _aciklamaController.text.trim(),
      'resim': _secilenResim ?? 'assets/images/placeholder.png',// örnek seçilen resim seçenği sunuyuroz ve diyet ekleyınce resımde beraberınde gelıyor.
    });
  }

  @override
  Widget build(BuildContext context) {
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
            decoration: const InputDecoration(labelText: 'Diyet Başlığı'),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _aciklamaController,
            decoration: const InputDecoration(labelText: 'Açıklama'),
          ),
          const SizedBox(height: 16),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text('Bir resim seç:', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _ornekResimler.length,
              itemBuilder: (context, index) {
                final resimYolu = _ornekResimler[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _secilenResim = resimYolu;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _secilenResim == resimYolu ? Colors.blue : Colors.transparent,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        resimYolu,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _kaydet,
            child: const Text('Kaydet'),
          ),
        ],
      ),
    );
  }
}