import 'package:flutter/cupertino.dart';
import 'package:pdf/pdf.dart';
import 'package:tesis/data/models/personas/personasModel.dart';
import 'package:tesis/domain/entities/personas/personasEntity.dart';
import 'package:tesis/domain/entities/tipoPersona/tipoPersonaEntity.dart';
import 'package:tesis/domain/uses%20cases/personas/personasGeneral.dart';
import 'package:tesis/domain/uses%20cases/tipoPersonas/tipoPersonaGeneral.dart';

class PersonasProvider extends ChangeNotifier {
  final PersonasGeneral _casosdeUsoPersona;
  final TipoPersonaGeneral _casosdeUsoTipoPersona;
  PersonasProvider(this._casosdeUsoPersona, this._casosdeUsoTipoPersona);
  List<PersonaEntity> listPersonas = [];
  List<TipoPersonaEntity> listTipoPersonas = [];

  TextEditingController ctrIdentificacion = TextEditingController();
  TextEditingController ctrNombres = TextEditingController();
  TextEditingController ctrDireccion = TextEditingController();
  TextEditingController ctrCorreo = TextEditingController();
  TextEditingController ctrCelular = TextEditingController();
  TextEditingController ctrTelefono = TextEditingController();
  int tipoPersona = 0;
  TipoPersonaEntity personaSelect = TipoPersonaEntity();

  void iniciar() {
    ctrIdentificacion = TextEditingController();
    ctrNombres = TextEditingController();
    ctrDireccion = TextEditingController();
    ctrCorreo = TextEditingController();
    ctrCelular = TextEditingController();
    ctrTelefono = TextEditingController();
  }

  void setPersona(PersonaEntity e) {
    try {
      ctrIdentificacion = TextEditingController(text: e.identificacion);
      ctrNombres = TextEditingController(text: e.nombres);
      ctrDireccion = TextEditingController(text: e.direccion);
      ctrCorreo = TextEditingController(text: e.correo);
      ctrCelular = TextEditingController(text: e.celular);
      ctrTelefono = TextEditingController(text: e.celular);
      tipoPersona = e.tipo;
      personaSelect =
          listTipoPersonas.firstWhere((element) => element.id == tipoPersona);
    } catch (e) {
      print(e.toString());
    }
  }

  Future anular(PersonaEntity e) async {
    try {
      // metodo anular
    } catch (e) {
      print(e.toString());
    }
  }

  Future getPersonas() async {
    try {
      var temp = await _casosdeUsoPersona.getAllPersonas();
      listPersonas = temp.getOrElse(() => []);
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future getTipoPersonas() async {
    try {
      var temp = await _casosdeUsoTipoPersona.getAllTipoPersonas();
      listTipoPersonas = temp.getOrElse(() => []);
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future guardar() async {
    try {
      PersonaModel model = new PersonaModel();

      model.estado = "A";
      var temp = await _casosdeUsoPersona.insertPersonas(model);
    } catch (e) {
      print(e.toString());
    }
  }
}
