import 'dart:convert';
import 'package:tesis/data/datasource/url.dart';
import 'package:http/http.dart' as http;
import 'package:tesis/data/models/tipoPersona/tipoPersonaModel.dart';
import 'package:tesis/domain/entities/tipoPersona/tipoPersonaEntity.dart';

abstract class TipoPersonaDTS {
  Future<List<TipoPersonaEntity>> getAllTipoPersona();
  Future<TipoPersonaEntity> insertTipoPersona(TipoPersonaModel tp);
}

class TipoPersonaDTSImp extends TipoPersonaDTS {
  final http.Client cliente;
  TipoPersonaDTSImp(this.cliente);

  String urlBase = "${UrlBase.url}tipoPersona";

  @override
  Future<List<TipoPersonaModel>> getAllTipoPersona() async {
    try {
      List<TipoPersonaModel> tem = [];
      final result = await cliente.get(Uri.parse(urlBase));
      if (result.statusCode == 200) {
        tem = decodeTp(utf8.decode(result.bodyBytes));
      }

      return tem;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<TipoPersonaModel> insertTipoPersona(TipoPersonaModel tp) async {
    TipoPersonaModel departamento = TipoPersonaModel();
    try {
      var grp = json.encode(tp.toMap());

      final result = await cliente.post(Uri.parse(urlBase),
          body: grp, headers: {"Content-type": "application/json"});
      if (result.statusCode == 200) {
        return TipoPersonaModel.fromMap(json.decode(result.body));
      }

      return departamento;
    } catch (e) {
      return departamento;
    }
  }

    List<TipoPersonaModel> decodeTp(String respuesta) {
      var parseo = jsonDecode(respuesta);
      return parseo
          .map<TipoPersonaModel>((json) => TipoPersonaModel.fromMap(json))
          .toList();
    }
}
