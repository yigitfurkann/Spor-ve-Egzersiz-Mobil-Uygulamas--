import 'package:uuid/uuid.dart';

const uuid = Uuid();

class VucutOlcumu {
  VucutOlcumu({
    required this.bolum,
    required this.puan,
    required this.tarih,
  }) : id = uuid.v4();

  final String id;
  final String bolum;
  final double puan;
  final DateTime tarih;
}
