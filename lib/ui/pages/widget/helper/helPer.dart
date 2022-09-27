import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Ayuda {
  static DateFormat _formatter = DateFormat('dd/MM/yyyy');
  static String soloNumeros = r'^(?:\+|-)?\d+$';
  static String decimales = r'^\d+\.?\d{0,2}';
  static String sololetras = r'(^[a-zA-Z ]*$)';
  static String alfanumerico = r'(^[a-zA-Z 0-9.-]*$)';
  static String parseFecha(DateTime? fecha) {
    try {
      return _formatter.format(fecha ?? DateTime.now());
    } catch (e) {
      return "";
    }
  }

  static Future<bool?>  alerta(BuildContext context, String titulo, String cuerpo) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("$titulo"),
          content: Text("$cuerpo"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context,true);
                },
                child: Text("OK"))
          ],
        );
      },
    );
  }
}
