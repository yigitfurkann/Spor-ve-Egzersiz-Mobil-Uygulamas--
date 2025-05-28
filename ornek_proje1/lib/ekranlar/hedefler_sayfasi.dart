import 'package:flutter/material.dart';

class Hedef {
  Hedef({
    required this.baslik,
    required this.aciklama,
    this.tamamlandi = false,
  });

  final String baslik;
  final String aciklama;
  bool tamamlandi;
}

class HedeflerSayfasi extends StatefulWidget {
  const HedeflerSayfasi({super.key});

  @override
  State<HedeflerSayfasi> createState() => _HedeflerSayfasiState();
}

class _HedeflerSayfasiState extends State<HedeflerSayfasi> {
  final List<Hedef> hedefler = [
    Hedef(baslik: 'Haftada 3 gün spor', aciklama: 'Pazartesi, Çarşamba, Cuma'),
    Hedef(baslik: 'Günde 2 litre su', aciklama: '8 bardak su iç'),
    Hedef(baslik: 'Daha az şeker', aciklama: 'Günlük şeker alımını azalt'),
    Hedef(baslik: 'Daha fazla uyku', aciklama: 'Geceleri en az 7 saat uyku'),
    Hedef(
      baslik: 'Daha fazla yürüyüş',
      aciklama: 'Günde en az 30 dakika yürüyüş',
    ),
    Hedef(
      baslik: 'Daha fazla kitap okuma',
      aciklama: 'Aylık en az 2 kitap oku',
    ),
    Hedef(
      baslik: 'Daha fazla meditasyon',
      aciklama: 'Günde en az 10 dakika meditasyon yap',
    ),
    Hedef(baslik: 'Daha fazla spor', aciklama: 'Haftada en az 3 gün spor yap'),
    Hedef(baslik: '100 tane şınav çekme', aciklama: 'Günde 20 şınav çek'),
  ];

  final TextEditingController _baslikController = TextEditingController();
  final TextEditingController _aciklamaController = TextEditingController();

  bool _eklemeAlaniAcik = true;

  void _hedefEkle() {
    final baslik = _baslikController.text.trim();
    final aciklama = _aciklamaController.text.trim();

    if (baslik.isEmpty || aciklama.isEmpty) return;

    setState(() {
      hedefler.add(Hedef(baslik: baslik, aciklama: aciklama));
      _baslikController.clear();
      _aciklamaController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hedefler'),
        backgroundColor: const Color.fromARGB(255, 252, 252, 252),
        actions: [
          IconButton(
            icon: Icon(_eklemeAlaniAcik ? Icons.close : Icons.add),
            onPressed: () {
              setState(() {
                _eklemeAlaniAcik = !_eklemeAlaniAcik;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child:
                hedefler.isEmpty
                    ? const Center(child: Text('Henüz bir hedef eklenmedi.'))
                    : ListView.builder(
                      itemCount: hedefler.length,
                      itemBuilder: (BuildContext context, int index) {
                        final hedef = hedefler[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          elevation: 4,
                          child: ListTile(
                            leading: Icon(
                              hedef.tamamlandi
                                  ? Icons.check_circle
                                  : Icons.circle_outlined,
                              color:
                                  hedef.tamamlandi ? Colors.green : Colors.grey,
                            ),
                            title: Text(hedef.baslik),
                            subtitle: Text(hedef.aciklama),
                            trailing: Switch(
                              value: hedef.tamamlandi,
                              onChanged: (bool val) {
                                setState(() {
                                  hedef.tamamlandi = val;
                                });
                              },
                            ),
                          ),
                        );
                      },
                    ),
          ),
          if (_eklemeAlaniAcik)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    controller: _baslikController,
                    decoration: const InputDecoration(
                      labelText: 'Hedef Başlığı',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _aciklamaController,
                    decoration: const InputDecoration(labelText: 'Açıklama'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _hedefEkle,
                    child: const Text('Hedefi Ekle'),
                  ),
                ],
              ),
            ), 
        ],
      ),
    );
  }
}
