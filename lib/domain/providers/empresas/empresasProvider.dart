import 'package:flutter/cupertino.dart';
import 'package:tesis/domain/entities/empresas/empresasEntity.dart';
import 'package:tesis/domain/repositories/empresas/abtractEmpresas.dart';

class EmpresasProvider extends ChangeNotifier {
  final AbstractEmpresas _usesCasesEmpresa;
  EmpresasProvider(this._usesCasesEmpresa);
  List<EmpresasEntity> listEmpresas = [];

  void cargarEmpresas() async {
    try {
      var temp = await _usesCasesEmpresa.getAllEmpresas();
      listEmpresas = temp.getOrElse(() => []);
      notifyListeners();
    } catch (e) {
      print("Erro al cargar empresas $e");
    }
  }
}
