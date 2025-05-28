import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Ilerleme {
  Ilerleme({
    required this.baslik,
    required this.tarih,
    required this.puan,
  }) : id = uuid.v4();

  final String id;
  final String baslik;
  final DateTime tarih;
  final double puan;
}
