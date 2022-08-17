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

  DepartamentosEntity entity = DepartamentosEntity();

  setDEpartamento() {
    try {
      ctrNombre = TextEditingController(text: entity.nombre);
      ctrDescripcion = TextEditingController(text: entity.descripcion);
      ctrEmpresa = TextEditingController(text: entity.idEmpresa.toString());
    } catch (e) {}
  }

  limpiar(){
    try {
      entity = DepartamentosEntity();
      ctrNombre = TextEditingController();
      ctrDescripcion = TextEditingController();
      ctrEmpresa = TextEditingController();
    } catch (e) {}
  }

  void cargarDepartamentos() async {
    try {
      var temp = await _depGeneral.getDepartamentos();
      listDepartamentos = temp.getOrElse(() => []);
      notifyListeners();
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
