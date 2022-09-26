import 'package:flutter/cupertino.dart';
import 'package:tesis/data/models/reemplazo/remplazoDetModel.dart';
import 'package:tesis/data/models/reemplazo/remplazoModel.dart';
import 'package:tesis/domain/entities/departamentosEntity.dart';
import 'package:tesis/domain/entities/empresas/empresasEntity.dart';
import 'package:tesis/domain/entities/personas/personasEntity.dart';
import 'package:tesis/domain/entities/productos/productosEntity.dart';
import 'package:tesis/domain/entities/reemplazo/remplazoDetEntity.dart';
import 'package:tesis/domain/entities/reemplazo/remplazoEntity.dart';
import 'package:tesis/domain/uses%20cases/Departamento/DepartamentoGeneral.dart';
import 'package:tesis/domain/uses%20cases/empresas/empresasGeneral.dart';
import 'package:tesis/domain/uses%20cases/personas/personasGeneral.dart';
import 'package:tesis/domain/uses%20cases/productos/productosGeneral.dart';
import 'package:tesis/domain/uses%20cases/remplazo/reemplazosGenera.dart';

class RemplazoProvider extends ChangeNotifier {
  final ReemplazoGeneral _usesCasesRemplazo;
  final ProductosGeneral _casosUsesProductos;
  final DepartamentosGeneral _casoUsoDepartamento;
  final EmpresasGeneral _casoUsoEmpresa;
  final PersonasGeneral _casosdeUsoPersona;

  RemplazoProvider(this._usesCasesRemplazo, this._casosUsesProductos,
      this._casoUsoEmpresa, this._casoUsoDepartamento, this._casosdeUsoPersona);

  List<ProductosEntity> listProducto = [];
  List<PersonaEntity> listPersonas = [];
  List<EmpresasEntity> listEmpresas = [];
  List<DepartamentosEntity> listDepartamento = [];
  List<ReemplazoEntity> listRemplazos = [];
  List<ReemplazoDetEntity> listRemplazosDetalle = [];

  PersonaEntity personaSelect = PersonaEntity();
  EmpresasEntity empresaSelect = EmpresasEntity();
  DepartamentosEntity departamentoSelect = DepartamentosEntity();
  ReemplazoEntity remplazoSelect = ReemplazoEntity();

  void inicio() {
    remplazoSelect = ReemplazoEntity();
    personaSelect = PersonaEntity();
    empresaSelect = EmpresasEntity();
    departamentoSelect = DepartamentosEntity();
    listRemplazosDetalle = [];
    agregar();
  }

  void agregar() {
    listRemplazosDetalle.add(ReemplazoDetEntity());
    notifyListeners();
  }

  Future getRemplazos() async {
    try {
      var temp = await _usesCasesRemplazo.getAllReemplazos();
      listRemplazos = temp.getOrElse(() => []);
      if (listPersonas.isEmpty) {
        await getPersonas();
      }

      for (var item in listRemplazos) {
        item.nomPersona =
            listPersonas.firstWhere((e) => e.id == item.idPersona).nombres;
      }

      notifyListeners();
    } catch (e) {}
  }

  Future getProductos() async {
    try {
      var temp = await _casosUsesProductos.getAllActivos();
      listProducto = temp.getOrElse(() => []);

      notifyListeners();
    } catch (e) {}
  }

  Future getPersonas() async {
    try {
      var temp = await _casosdeUsoPersona.getAllPersonas();
      listPersonas = temp.getOrElse(() => []);
      // tipo 3 proveedor
      listPersonas =
          listPersonas.where((element) => element.tipo == 1).toList();
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future cargarEmpresa_x_departamento() async {
    try {
      if (listEmpresas.isEmpty) {
        await getEmpresas();
      }
      if (listDepartamento.isEmpty) {
        await getDepartamentos();
      }
      if (personaSelect.id != 0) {
        empresaSelect =
            listEmpresas.firstWhere((e) => e.id == personaSelect.idempresa);
        departamentoSelect = listDepartamento.firstWhere((e) =>
            e.idEmpresa == personaSelect.idempresa &&
            e.id == personaSelect.iddepartamento);
        notifyListeners();
      }
    } catch (e) {}
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

  Future setReemplazo(ReemplazoEntity entity) async {
    try {
      remplazoSelect = entity;

      if (listProducto.isEmpty) {
        await getProductos();
      }
      if (listPersonas.isEmpty) {
        await getPersonas();
      }

      personaSelect =
          listPersonas.firstWhere((e) => e.id == remplazoSelect.idPersona);

      cargarEmpresa_x_departamento();

// detalle

      var detalleResult =
          await _usesCasesRemplazo.getDetalleReemplazos(remplazoSelect.id);

      listRemplazosDetalle = detalleResult.getOrElse(() => []);

      for (var item in listRemplazosDetalle) {
        item.prd = listProducto.firstWhere((e) => e.id == item.idProducto1);
        item.prd2 = listProducto.firstWhere((e) => e.id == item.idProducto2);
      }
    } catch (e) {
      print("metodo cargar reemplazo${e.toString()}");
    }
  }

  Future<bool> anular(ReemplazoEntity entity) async {
    try {
      //remplazoSelect = entity;
      ReemplazoModel model = ReemplazoModel();
      model.id = entity.id;
      model.fecha = entity.fecha;

      var result = await _usesCasesRemplazo.anularReemplazos(model);
      var entityResult = result.getOrElse(() => ReemplazoEntity());
      if (entityResult.estado == "I") {
        entity.estado = "I";
        notifyListeners();
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> guardar() async {
    try {
      ReemplazoModel model = ReemplazoModel();

      model.idPersona = personaSelect.id;
      model.fecha = DateTime.now();
      model.estado = "A";
      model.idMotivo = 0;
      model.observacion = "";

      var result = await _usesCasesRemplazo.insertReemplazos(model);
      var temp = result.getOrElse(() => ReemplazoEntity());
      if (temp.id != 0) {
        // guardar detalle;
        for (var item in listRemplazosDetalle) {
          ReemplazoDetModel model = ReemplazoDetModel();
          model.idCab = temp.id;
          model.idProducto1 = item.idProducto1;
          model.idProducto2 = item.idProducto2;
          model.cantidad = item.cantidad;
          model.cantidad2 = item.cantidad2;
          model.motivo = 0;

          var resultDet = await _usesCasesRemplazo.insertDetReemplazos(model);
        }
        listRemplazos.add(temp);
      }

      return true;
    } catch (e) {
      print("metodo guardar ${e.toString()}");
      return false;
    }
  }
}
