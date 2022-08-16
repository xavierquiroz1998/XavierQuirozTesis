import 'package:flutter/cupertino.dart';
import 'package:tesis/data/models/motivos/motivosModel.dart';
import 'package:tesis/domain/entities/motivos/motivosEntity.dart';
import 'package:tesis/domain/uses%20cases/motivos/motivosGeneral.dart';

class MotivosProvider extends ChangeNotifier {
  final MotivosGeneral _usesCasesMotivos;

  MotivosProvider(this._usesCasesMotivos);

  List<MotivosEntity> listMotivos = [];

  TextEditingController ctrNombre = TextEditingController();
  TextEditingController ctrDescripcion = TextEditingController();

  void cargarMotivos() async {
    try {
      var temp = await _usesCasesMotivos.getAllMotivos();
      listMotivos = temp.getOrElse(() => []);
      notifyListeners();
    } catch (e) {
      print("Erro al cargar motivos $e");
    }
  }

  Future guardar() async {
    try {
      MotivosModel mtv = MotivosModel();
      mtv.nombre = ctrNombre.text;
      mtv.descipcion = ctrDescripcion.text;
      mtv.estado = "A";
      var tempResul = _usesCasesMotivos.insertMotivos(mtv);
    } catch (e) {}
  }
}
