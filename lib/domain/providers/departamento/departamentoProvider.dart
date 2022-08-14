import 'package:flutter/cupertino.dart';
import 'package:tesis/domain/entities/departamentosEntity.dart';
import 'package:tesis/domain/uses%20cases/Departamento/DepartamentoGeneral.dart';

class DepartamentoProvider extends ChangeNotifier {
  final DepartamentosGeneral _depGeneral;
  DepartamentoProvider(this._depGeneral);

  List<DepartamentosEntity> listDepartamentos = [];

  void cargarDepartamentos() async {
    try {
      var temp = await _depGeneral.getDepartamentos();
      listDepartamentos = temp.getOrElse(() => []);
      print(temp);
    } catch (e) {
      print("Erro en carga Departamentos $e");
    }
  }
}
