import 'package:flutter/cupertino.dart';
import 'package:tesis/data/models/departamento/departamentoModel.dart';
import 'package:tesis/domain/entities/departamentosEntity.dart';
import 'package:tesis/domain/uses%20cases/Departamento/DepartamentoGeneral.dart';

class DepartamentoProvider extends ChangeNotifier {
  final DepartamentosGeneral _depGeneral;
  DepartamentoProvider(this._depGeneral);

  List<DepartamentosEntity> listDepartamentos = [];

  TextEditingController ctrNombre = TextEditingController();
  TextEditingController ctrDescripcion = TextEditingController();
  TextEditingController ctrEmpresa = TextEditingController();

  void cargarDepartamentos() async {
    try {
      var temp = await _depGeneral.getDepartamentos();
      listDepartamentos = temp.getOrElse(() => []);
      print(temp);
    } catch (e) {
      print("Erro en carga Departamentos $e");
    }
  }

  Future guardar() async {
    try {
      ModelDepartamento dep = ModelDepartamento();
      dep.nombre = ctrNombre.text;
      dep.descripcion = ctrDescripcion.text;
      dep.estado = "A";
      dep.idEmpresa = int.parse(ctrEmpresa.text);
      await _depGeneral.insertMDep(dep);
    } catch (e) {}
  }
}
