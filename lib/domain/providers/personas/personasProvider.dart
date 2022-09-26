import 'package:flutter/cupertino.dart';
import 'package:pdf/pdf.dart';
import 'package:tesis/data/models/personas/personasModel.dart';
import 'package:tesis/domain/entities/departamentosEntity.dart';
import 'package:tesis/domain/entities/empresas/empresasEntity.dart';
import 'package:tesis/domain/entities/personas/personasEntity.dart';
import 'package:tesis/domain/entities/tipoPersona/tipoPersonaEntity.dart';
import 'package:tesis/domain/uses%20cases/Departamento/DepartamentoGeneral.dart';
import 'package:tesis/domain/uses%20cases/empresas/empresasGeneral.dart';
import 'package:tesis/domain/uses%20cases/personas/personasGeneral.dart';
import 'package:tesis/domain/uses%20cases/tipoPersonas/tipoPersonaGeneral.dart';

class PersonasProvider extends ChangeNotifier {
  final PersonasGeneral _casosdeUsoPersona;
  final TipoPersonaGeneral _casosdeUsoTipoPersona;
  final EmpresasGeneral _casoUsoEmpresa;
  final DepartamentosGeneral _casoUsoDepartamento;

  PersonasProvider(this._casosdeUsoPersona, this._casosdeUsoTipoPersona,
      this._casoUsoEmpresa, this._casoUsoDepartamento);

  List<PersonaEntity> listPersonas = [];
  List<TipoPersonaEntity> listTipoPersonas = [];
  List<EmpresasEntity> listEmpresas = [];
  List<DepartamentosEntity> listDepartamento = [];
  List<TipoTrassaccion> listTransaccion = [];

  TextEditingController ctrIdentificacion = TextEditingController();
  TextEditingController ctrNombres = TextEditingController();
  TextEditingController ctrDireccion = TextEditingController();
  TextEditingController ctrCorreo = TextEditingController();
  TextEditingController ctrCelular = TextEditingController();
  TextEditingController ctrEmpresaProveedor = TextEditingController();

  int tipoPersona = 0;
  int idempresa = 0;
  int idDepartamento = 0;

  TipoPersonaEntity personaSelect = TipoPersonaEntity();
  EmpresasEntity empresaSelect = EmpresasEntity();
  DepartamentosEntity departamentoSelect = DepartamentosEntity();

  Future getTipoTansaccion() async {
    try {
      var temp = await _casosdeUsoTipoPersona.getAllTipoTansaccion();
      listTransaccion = temp.getOrElse(() => []);
      notifyListeners();
    } catch (e) {}
  }

  void iniciar() {
    ctrIdentificacion = TextEditingController();
    ctrNombres = TextEditingController();
    ctrDireccion = TextEditingController();
    ctrCorreo = TextEditingController();
    ctrCelular = TextEditingController();
    ctrEmpresaProveedor = TextEditingController();
    tipoPersona = 0;
    idempresa = 0;
    idDepartamento = 0;

    personaSelect = TipoPersonaEntity();
    empresaSelect = EmpresasEntity();
    departamentoSelect = DepartamentosEntity();
  }

  Future setPersona(PersonaEntity e) async {
    try {
      ctrIdentificacion = TextEditingController(text: e.identificacion);
      ctrNombres = TextEditingController(text: e.nombres);
      ctrDireccion = TextEditingController(text: e.direccion);
      ctrCorreo = TextEditingController(text: e.correo);
      ctrCelular = TextEditingController(text: e.celular);
      ctrEmpresaProveedor = TextEditingController(text: e.empresaproveedor);
      tipoPersona = e.tipo;
      personaSelect =
          listTipoPersonas.firstWhere((element) => element.id == tipoPersona);

      if (tipoPersona == 1) {
        if (listEmpresas.length == 0) {
          await getEmpresas();
        }
        if (listDepartamento.length == 0) {
          await getDepartamentos();
        }

        idempresa = e.idempresa;
        idDepartamento = e.iddepartamento;

        empresaSelect = listEmpresas.firstWhere((emp) => emp.id == e.idempresa);
        departamentoSelect = listDepartamento.firstWhere((emp) =>
            emp.idEmpresa == e.idempresa && emp.id == e.iddepartamento);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future anular(PersonaEntity e) async {
    try {
      PersonaModel model = PersonaModel();
      model.id = e.id;
      model.identificacion = e.identificacion;
      var result = await _casosdeUsoPersona.anularPersonas(model);
      try {
        var personaEntity = result.getOrElse(() => PersonaEntity());
        if (personaEntity.id != 0) {
          e.estado = "I";
          notifyListeners();
        }
      } catch (e) {}
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

  Future getEmpresas() async {
    try {
      var temp = await _casoUsoEmpresa.getAllEmpresas();
      listEmpresas = temp.getOrElse(() => []);
      notifyListeners();
    } catch (e) {
      print("Erro al cargar empresas $e");
    }
  }

  Future getDepartamentos() async {
    try {
      var temp = await _casoUsoDepartamento.getDepartamentos();
      listDepartamento = temp.getOrElse(() => []);
      notifyListeners();
    } catch (e) {
      print("Erro en carga Departamentos $e");
    }
  }

  Future<bool> guardar() async {
    try {
      PersonaModel model = new PersonaModel();
      model.identificacion = ctrIdentificacion.text;
      model.nombres = ctrNombres.text;
      model.direccion = ctrDireccion.text;
      model.correo = ctrCorreo.text;
      model.celular = ctrCelular.text;
      model.empresaproveedor = ctrEmpresaProveedor.text;
      model.idempresa = idempresa;
      model.iddepartamento = idDepartamento;
      model.tipo = tipoPersona;
      model.telefono = "";
      model.estado = "A";
      var temp = await _casosdeUsoPersona.insertPersonas(model);
      try {
        var result = temp.getOrElse(() => PersonaEntity());
        if (result.id != 0) {
          listPersonas.add(result);
          notifyListeners();
        }
        return true;
      } catch (e) {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
