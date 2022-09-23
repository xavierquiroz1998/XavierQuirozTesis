import 'package:flutter/cupertino.dart';
import 'package:tesis/data/models/reemplazo/remplazoModel.dart';
import 'package:tesis/domain/entities/departamentosEntity.dart';
import 'package:tesis/domain/entities/empresas/empresasEntity.dart';
import 'package:tesis/domain/entities/personas/personasEntity.dart';
import 'package:tesis/domain/entities/productos/productosEntity.dart';
import 'package:tesis/domain/entities/reemplazo/remplazoEntity.dart';
import 'package:tesis/domain/uses%20cases/Departamento/DepartamentoGeneral.dart';
import 'package:tesis/domain/uses%20cases/empresas/empresasGeneral.dart';
import 'package:tesis/domain/uses%20cases/personas/personasGeneral.dart';
import 'package:tesis/domain/uses%20cases/productos/productosGeneral.dart';
import 'package:tesis/domain/uses%20cases/remplazo/reemplazosGenera.dart';

class RemplazoProvider extends ChangeNotifier {
  final ReemplazoGeneral _usesCases;
  final ProductosGeneral _casosUsesProductos;
  final DepartamentosGeneral _casoUsoDepartamento;
  final EmpresasGeneral _casoUsoEmpresa;
  final PersonasGeneral _casosdeUsoPersona;

  RemplazoProvider(this._usesCases, this._casosUsesProductos,
      this._casoUsoEmpresa, this._casoUsoDepartamento, this._casosdeUsoPersona);

  List<ProductosEntity> listProducto = [];
  List<PersonaEntity> listPersonas = [];
  List<EmpresasEntity> listEmpresas = [];
  List<DepartamentosEntity> listDepartamento = [];

  PersonaEntity personaSelect = PersonaEntity();
  EmpresasEntity empresaSelect = EmpresasEntity();
  DepartamentosEntity departamentoSelect = DepartamentosEntity();

  void inicio() {
    personaSelect = PersonaEntity();
    empresaSelect = EmpresasEntity();
    departamentoSelect = DepartamentosEntity();
  }

  Future getProductos() async {
    try {
      var temp = await _casosUsesProductos.getAll();
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

  Future setReemplazo() async {
    try {} catch (e) {
      print("metodo cargar reemplazo${e.toString()}");
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

      var result = await _usesCases.insertReemplazos(model);
      var temp = result.getOrElse(() => ReemplazoEntity());

      return true;
    } catch (e) {
      print("metodo guardar ${e.toString()}");
      return false;
    }
  }
}
