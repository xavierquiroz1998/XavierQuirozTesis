import 'dart:convert';
import 'package:tesis/data/datasource/url.dart';
import 'package:http/http.dart' as http;
import 'package:tesis/data/models/empresas/empresasModel.dart';
import 'package:tesis/domain/entities/empresas/empresasEntity.dart';

abstract class EmpresasDTS {
  Future<List<EmpresasEntity>> getAllEmpresa();
  Future<EmpresasEntity> insertEmpresas(EmpresasModel emp);
  Future<EmpresasEntity> anularEmpresas(EmpresasModel emp);
}

class EmpresasDTSImp extends EmpresasDTS {
  final http.Client cliente;
  EmpresasDTSImp(this.cliente);

  String urlBase = "${UrlBase.url}empresas";

  @override
  Future<List<EmpresasModel>> getAllEmpresa() async {
    try {
      List<EmpresasModel> tem = [];
      final result = await cliente.get(Uri.parse(urlBase));
      if (result.statusCode == 200) {
        tem = decodeEmp(utf8.decode(result.bodyBytes));
      }

      return tem;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<EmpresasModel> insertEmpresas(EmpresasModel emp) async {
    EmpresasModel departamento = EmpresasModel();
    try {
      var grp = json.encode(emp.toMap());

      final result = await cliente.post(Uri.parse(urlBase),
          body: grp, headers: {"Content-type": "application/json"});
      if (result.statusCode == 200) {
        return EmpresasModel.fromMap(json.decode(result.body));
      }

      return departamento;
    } catch (e) {
      return departamento;
    }
  }

  List<EmpresasModel> decodeEmp(String respuesta) {
    var parseo = jsonDecode(respuesta);
    return parseo
        .map<EmpresasModel>((json) => EmpresasModel.fromMap(json))
        .toList();
  }

  @override
  Future<EmpresasEntity> anularEmpresas(EmpresasModel emp) async {
    EmpresasModel departamento = EmpresasModel();
    try {
      var grp = json.encode(emp.toMap());

      final result = await cliente.post(Uri.parse("$urlBase/anular"),
          body: grp, headers: {"Content-type": "application/json"});
      if (result.statusCode == 200) {
        return EmpresasModel.fromMap(json.decode(result.body));
      }

      return departamento;
    } catch (e) {
      return departamento;
    }
  }
}
