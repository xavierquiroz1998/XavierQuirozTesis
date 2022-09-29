import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:tesis/core/Errors/failure.dart';
import 'package:tesis/data/models/empresas/empresasModel.dart';
import 'package:tesis/domain/entities/empresas/empresasEntity.dart';
import 'package:tesis/domain/repositories/empresas/abtractEmpresas.dart';

class EmpresasProvider extends ChangeNotifier {
  final AbstractEmpresas _usesCasesEmpresa;
  EmpresasProvider(this._usesCasesEmpresa);
  List<EmpresasEntity> listEmpresas = [];

  TextEditingController ctrNombre = TextEditingController();
  TextEditingController ctrDescripcion = TextEditingController();

  EmpresasEntity entidad = EmpresasEntity();

  void setEmpresa() {
    try {
      ctrNombre = TextEditingController(text: entidad.nombre);
      ctrDescripcion = TextEditingController(text: entidad.descripcion);
    } catch (e) {}
  }

  Future anular(EmpresasEntity e) async {
    try {
      EmpresasModel model = EmpresasModel();
      model.id = e.id;

      var result = await _usesCasesEmpresa.anularEmpresas(model);
      try {
        var entity = result.getOrElse(() => EmpresasEntity());
        if (entity.id != 0) {
          await cargarEmpresas();
        }
      } catch (e) {}
    } catch (e) {}
  }

  void limpiar() {
    try {
      entidad = EmpresasEntity();
      ctrNombre = TextEditingController();
      ctrDescripcion = TextEditingController();
    } catch (e) {}
  }

  Future cargarEmpresas() async {
    try {
      var temp = await _usesCasesEmpresa.getAllEmpresas();
      listEmpresas = temp.getOrElse(() => []);
      notifyListeners();
    } catch (e) {
      print("Erro al cargar empresas $e");
    }
  }

  Future guardar() async {
    try {
      EmpresasModel emp = EmpresasModel();
      emp.nombre = ctrNombre.text;
      emp.descripcion = ctrDescripcion.text;
      emp.estado = "A";
      late Either<Failure, EmpresasEntity> temp;
      if (entidad.id == 0) {
        temp = await _usesCasesEmpresa.insertEmpresas(emp);
      } else {
        emp.id = entidad.id;
        temp = await _usesCasesEmpresa.updateEmpresas(emp);
      }
    } catch (e) {}
  }
}
