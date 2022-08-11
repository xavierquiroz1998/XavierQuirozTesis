import 'package:flutter/cupertino.dart';
import 'package:tesis/domain/uses%20cases/Departamento/DepartamentoGeneral.dart';

class DepartamentoProvider extends ChangeNotifier {
  final DepartamentosGeneral depGeneral;

  DepartamentoProvider(this.depGeneral);

  void cargar() async {
    try {
      var temp = await depGeneral.getDepartamentos();
      print(temp);
    } catch (e) {}
  }
}
