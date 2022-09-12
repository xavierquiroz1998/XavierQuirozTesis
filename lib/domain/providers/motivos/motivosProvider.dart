import 'package:flutter/cupertino.dart';
import 'package:tesis/data/models/departamento/departamentoModel.dart';
import 'package:tesis/data/models/motivos/motivosModel.dart';
import 'package:tesis/domain/entities/motivos/motivosEntity.dart';
import 'package:tesis/domain/uses%20cases/motivos/motivosGeneral.dart';

class MotivosProvider extends ChangeNotifier {
  final MotivosGeneral _usesCasesMotivos;

  MotivosProvider(this._usesCasesMotivos);

  List<MotivosEntity> listMotivos = [];

  TextEditingController ctrNombre = TextEditingController();
  TextEditingController ctrDescripcion = TextEditingController();

  MotivosEntity entidad = MotivosEntity();

  setMotivos() {
    try {
      ctrNombre = TextEditingController(text: entidad.nombre);
      ctrDescripcion = TextEditingController(text: entidad.descipcion);
    } catch (e) {}
  }

  limpiar() {
    try {
      entidad = MotivosEntity();
      ctrNombre = TextEditingController();
      ctrDescripcion = TextEditingController();
    } catch (e) {}
  }

  Future cargarMotivos() async {
    try {
      var temp = await _usesCasesMotivos.getAllMotivos();
      listMotivos = temp.getOrElse(() => []);
      notifyListeners();
    } catch (e) {
      print("Erro al cargar motivos $e");
    }
  }

  Future anular(MotivosEntity en) async {
    try {
      MotivosModel model = MotivosModel();
      model.id = en.id;

      var result = await _usesCasesMotivos.anularMotivos(model);
      try {
        var entities = result.getOrElse(() => MotivosEntity());
        if (entities.id != 0) {
          en.estado = "I";
          notifyListeners();
          //await cargarMotivos();
        }
      } catch (e) {}
    } catch (e) {
      print(e.toString());
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
