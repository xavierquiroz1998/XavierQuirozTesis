import 'package:flutter/cupertino.dart';
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

  void limpiar() {
    try {
      entidad = EmpresasEntity();
      ctrNombre = TextEditingController();
      ctrDescripcion = TextEditingController();
    } catch (e) {}
  }

  void cargarEmpresas() async {
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
      var temp = await _usesCasesEmpresa.insertEmpresas(emp);
    } catch (e) {}
  }
}
