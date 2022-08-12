import 'dart:convert';
import 'package:tesis/data/datasource/url.dart';
import 'package:http/http.dart' as http;
import 'package:tesis/data/models/motivos/motivosModel.dart';
import 'package:tesis/domain/entities/motivos/motivosEntity.dart';

abstract class MotivosDTS {
  Future<List<MotivosEntity>> getAllMotivos();
  Future<MotivosEntity> insertMotivos(MotivosModel mtv);
}

class MotivosDTSImp extends MotivosDTS {
  final http.Client cliente;
  MotivosDTSImp(this.cliente);

  String urlBase = "${UrlBase.url}motivos";

  @override
  Future<List<MotivosModel>> getAllMotivos() async {
    try {
      List<MotivosModel> tem = [];
      final result = await cliente.get(Uri.parse(urlBase));
      if (result.statusCode == 200) {
        tem = decodeMtv(utf8.decode(result.bodyBytes));
      }

      return tem;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<MotivosModel> insertMotivos(MotivosModel mtv) async {
    MotivosModel departamento = MotivosModel();
    try {
      var grp = json.encode(mtv.toMap());

      final result = await cliente.post(Uri.parse(urlBase),
          body: grp, headers: {"Content-type": "application/json"});
      if (result.statusCode == 200) {
        return MotivosModel.fromMap(json.decode(result.body));
      }

      return departamento;
    } catch (e) {
      return departamento;
    }
  }

  List<MotivosModel> decodeMtv(String respuesta) {
    var parseo = jsonDecode(respuesta);
    return parseo
        .map<MotivosModel>((json) => MotivosModel.fromMap(json))
        .toList();
  }
}
