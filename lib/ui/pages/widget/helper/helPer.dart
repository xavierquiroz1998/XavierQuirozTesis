import 'package:intl/intl.dart';

class Ayuda {
  static DateFormat _formatter = DateFormat('dd/MM/yyyy');

  static String parseFecha(DateTime? fecha) {
    try {
    return _formatter.format(fecha?? DateTime.now());
    } catch (e) {
      return "";
    }
  }
}
