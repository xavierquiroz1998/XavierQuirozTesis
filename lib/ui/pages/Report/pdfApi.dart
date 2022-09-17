import 'dart:convert';
import 'package:pdf/widgets.dart';
import "package:universal_html/html.dart";

class PdfApi {
  static Future saveDocument({
    required String name,
    required Document pdf,
  }) async {
    try {
      final bytes = await pdf.save();
      final anchor =AnchorElement(
          href:
              "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
        ..setAttribute("download", name)
        ..click();

      // return f;
    } catch (ex) {
      print("***** Erro en ${ex.toString()}");
      //return File('');
    }
  }
}
