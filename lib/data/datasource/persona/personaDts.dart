import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tesis/data/datasource/url.dart';
import 'package:tesis/data/models/personas/personasModel.dart';
import 'package:tesis/domain/entities/personas/personasEntity.dart';

abstract class PersonaDts {
  Future<List<PersonaEntity>> getAllPersonas();
  Future<PersonaEntity> insertPersonas(PersonaModel mtv);
  Future<PersonaEntity> anularPersonas(PersonaModel model);
}

class PersonaDtsImp extends PersonaDts {
  final http.Client cliente;
  PersonaDtsImp(this.cliente);

  String urlBase = "${UrlBase.url}personas";

  @override
  Future<List<PersonaEntity>> getAllPersonas() async {
    try {
      List<PersonaModel> tem = [];
      final result = await cliente.get(Uri.parse(urlBase));
      if (result.statusCode == 200) {
        tem = decodePersona(utf8.decode(result.bodyBytes));
      }

      return tem;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<PersonaEntity> insertPersonas(PersonaModel mtv) async {
    PersonaModel departamento = PersonaModel();
    try {
      var grp = json.encode(mtv.toMap());

      final result = await cliente.post(Uri.parse(urlBase),
          body: grp, headers: {"Content-type": "application/json"});
      if (result.statusCode == 200) {
        return PersonaModel.fromMap(json.decode(result.body));
      }

      return departamento;
    } catch (e) {
      return departamento;
    }
  }

  List<PersonaModel> decodePersona(String respuesta) {
    var parseo = jsonDecode(respuesta);
    return parseo
        .map<PersonaModel>((json) => PersonaModel.fromMap(json))
        .toList();
  }
  
  @override
  Future<PersonaEntity> anularPersonas(PersonaModel model) async{
    PersonaModel departamento = PersonaModel();
    try {
      var grp = json.encode(model.toMap());

      final result = await cliente.post(Uri.parse("$urlBase/anular"),
          body: grp, headers: {"Content-type": "application/json"});
      if (result.statusCode == 200) {
        return PersonaModel.fromMap(json.decode(result.body));
      }

      return departamento;
    } catch (e) {
      return departamento;
    }
  }
}
