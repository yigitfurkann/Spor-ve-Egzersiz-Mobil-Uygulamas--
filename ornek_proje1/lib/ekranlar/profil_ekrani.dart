import 'package:flutter/material.dart';


class ProfilEkrani extends StatelessWidget {
  const ProfilEkrani({super.key});

  @override
  Widget build(BuildContext context) {
    double boy = 182;
    double kilo = 80;
    double bmi = kilo / ((boy / 100) * (boy / 100));
    int tamamlananGun = 3;
    int hedefGun = 5;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        backgroundColor: const Color.fromARGB(255, 253, 253, 253),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    // Profil fotoğrafı büyütme / düzenleme alanı
                  },
                  child: const CircleAvatar(
                    radius: 45,
                    backgroundColor: Color.fromARGB(255, 240, 240, 240),
                    backgroundImage: AssetImage('assets/images/pp_resim.png'),
                  ),
                ),
                const SizedBox(width: 20),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kullanıcı Adı: fygt',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'E-posta: furkanyıgıt@gmail.com',
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),

            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Fiziksel Bilgiler',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('Boy: ${boy.toInt()} cm'),
                    Text('Kilo: ${kilo.toInt()} kg'),
                    const Text('Yaş: 25'),
                    const Text('Cinsiyet: Erkek'),
                    const SizedBox(height: 8),
                    Text('BMI: ${bmi.toStringAsFixed(1)}'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Haftalık Spor Hedefi',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text('$tamamlananGun / $hedefGun gün tamamlandı'),
                    const SizedBox(height: 6),
                    LinearProgressIndicator(value: tamamlananGun / hedefGun),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            ExpansionTile(
              title: const Text(
                'Diğer Bilgiler',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              children: const [
                ListTile(title: Text('Favori Egzersiz: Koşu')),
                ListTile(title: Text('Beslenme Tipi: Protein Ağırlıklı')),
              ],
            ),

            const SizedBox(height: 16),

            
          ],
        ),
      ),
    );
  }
}
