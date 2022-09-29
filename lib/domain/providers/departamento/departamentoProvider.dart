import 'package:flutter/cupertino.dart';
import 'package:tesis/data/models/departamento/departamentoModel.dart';
import 'package:tesis/domain/entities/departamentosEntity.dart';
import 'package:tesis/domain/entities/empresas/empresasEntity.dart';
import 'package:tesis/domain/uses%20cases/Departamento/DepartamentoGeneral.dart';
import 'package:tesis/domain/uses%20cases/empresas/empresasGeneral.dart';

class DepartamentoProvider extends ChangeNotifier {
  final DepartamentosGeneral _depGeneral;
  final EmpresasGeneral _casoUsoEmpresa;

  DepartamentoProvider(this._depGeneral, this._casoUsoEmpresa);

  List<DepartamentosEntity> listDepartamentos = [];
  List<EmpresasEntity> listEmpresas = [];
  int idempresa = 0;

  TextEditingController ctrNombre = TextEditingController();
  TextEditingController ctrDescripcion = TextEditingController();

  DepartamentosEntity entity = DepartamentosEntity();
  EmpresasEntity empEntity = EmpresasEntity();

  setDEpartamento() async {
    try {
      ctrNombre = TextEditingController(text: entity.nombre);
      ctrDescripcion = TextEditingController(text: entity.descripcion);
      if (listEmpresas.length == 0) {
        await getEmpresas();
      }
      idempresa = entity.idEmpresa;
      empEntity =
          listEmpresas.firstWhere((element) => element.id == entity.idEmpresa);
    } catch (e) {}
  }

  limpiar() {
    try {
      entity = DepartamentosEntity();
      ctrNombre = TextEditingController();
      ctrDescripcion = TextEditingController();
      idempresa = 0;
      empEntity = EmpresasEntity();
    } catch (e) {}
  }

  Future anular(DepartamentosEntity e) async {
    try {
      ModelDepartamento model = ModelDepartamento();
      model.id = e.id;

      var result = await _depGeneral.anularDepartamento(model);

      try {
        var enti = result.getOrElse(() => DepartamentosEntity());
        if (enti.id != 0) {
          e.estado = "I";
          notifyListeners();
        }
      } catch (e) {
        print("Erro en carga Departamentos ${e.toString()}");
      }
    } catch (e) {
      print("Erro en carga Departamentos ${e.toString()}");
    }
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

  Future getEmpresas() async {
    try {
      var temp = await _casoUsoEmpresa.getAllEmpresas();
      listEmpresas = temp.getOrElse(() => []);
      notifyListeners();
    } catch (e) {
      print("Erro al cargar empresas $e");
    }
  }

  Future guardar() async {
    try {
      ModelDepartamento dep = ModelDepartamento();
      dep.nombre = ctrNombre.text;
      dep.descripcion = ctrDescripcion.text;
      dep.estado = "A";
      dep.idEmpresa = idempresa;
      if (entity.id == 0) {
        await _depGeneral.insertMDep(dep);
      } else {
        dep.id = entity.id;
        await _depGeneral.updateDepartamento(dep);
      }
    } catch (e) {}
  }
}
