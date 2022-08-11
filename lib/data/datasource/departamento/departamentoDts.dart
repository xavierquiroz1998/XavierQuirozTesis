import 'dart:convert';

import 'package:tesis/data/datasource/url.dart';
import 'package:tesis/data/models/departamento/departamentoModel.dart';
import 'package:http/http.dart' as http;

abstract class DepartamentoDTS {
  Future<List<ModelDepartamento>> getAllDepartamentos();
  Future<ModelDepartamento> insertDepartamento(ModelDepartamento dep);
}

class DepartamentoDTSImp extends DepartamentoDTS {
  final http.Client cliente;
  DepartamentoDTSImp(this.cliente);

  String urlBase = "${UrlBase.url}departamentos";

  @override
  Future<List<ModelDepartamento>> getAllDepartamentos() async {
    try {
      List<ModelDepartamento> tem = [];
      final result = await cliente.get(Uri.parse(urlBase));
      if (result.statusCode == 200) {
        tem = decodeDepartamentos(utf8.decode(result.bodyBytes));
      }

      return tem;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<ModelDepartamento> insertDepartamento(ModelDepartamento dep) async {
    ModelDepartamento departamento = ModelDepartamento();
    try {
      var grp = json.encode(dep.toMap());

      final result = await cliente.post(Uri.parse(urlBase),
          body: grp, headers: {"Content-type": "application/json"});
      if (result.statusCode == 200) {
        return ModelDepartamento.fromMap(json.decode(result.body));
      }

      return departamento;
    } catch (e) {
      return departamento;
    }
  }

  List<ModelDepartamento> decodeDepartamentos(String respuesta) {
    var parseo = jsonDecode(respuesta);
    return parseo
        .map<ModelDepartamento>((json) => ModelDepartamento.fromMap(json))
        .toList();
  }
}