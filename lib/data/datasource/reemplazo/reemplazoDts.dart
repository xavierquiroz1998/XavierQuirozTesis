import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tesis/data/datasource/url.dart';
import 'package:tesis/data/models/reemplazo/remplazoDetModel.dart';
import 'package:tesis/data/models/reemplazo/remplazoModel.dart';
import 'package:tesis/domain/entities/reemplazo/remplazoDetEntity.dart';
import 'package:tesis/domain/entities/reemplazo/remplazoEntity.dart';

abstract class RemplazoDTS {
  Future<List<ReemplazoEntity>> getAllReemplazos();
  Future<ReemplazoEntity> insertReemplazos(ReemplazoModel model);
  Future<ReemplazoEntity> anularReemplazos(ReemplazoModel model);
  Future<List<ReemplazoDetEntity>> getDetalleReemplazos(int idcab);
  Future<ReemplazoDetEntity> insertDetReemplazos(ReemplazoDetModel model);
}

class ReemplazoDtsImp extends RemplazoDTS {
  final http.Client cliente;
  ReemplazoDtsImp(this.cliente);

  String urlBase = "${UrlBase.url}reemplazo";

  List<ReemplazoModel> decodePrd(String respuesta) {
    var parseo = jsonDecode(respuesta);
    return parseo
        .map<ReemplazoModel>((json) => ReemplazoModel.fromMap(json))
        .toList();
  }

  @override
  Future<ReemplazoEntity> anularReemplazos(ReemplazoModel model) async {
    ReemplazoModel producto = ReemplazoModel();
    try {
      var grp = json.encode(model.toMap());

      final result = await cliente.post(Uri.parse("$urlBase/anular"),
          body: grp, headers: {"Content-type": "application/json"});
      if (result.statusCode == 200) {
        return ReemplazoModel.fromMap(json.decode(result.body));
      }

      return producto;
    } catch (e) {
      return producto;
    }
  }

  @override
  Future<List<ReemplazoEntity>> getAllReemplazos() async {
    try {
      List<ReemplazoEntity> tem = [];
      final result = await cliente.get(Uri.parse(urlBase));
      if (result.statusCode == 200) {
        tem = decodePrd(utf8.decode(result.bodyBytes));
      }

      return tem;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<ReemplazoEntity> insertReemplazos(ReemplazoModel model) async {
    ReemplazoModel producto = ReemplazoModel();
    try {
      var grp = json.encode(model.toMap());

      final result = await cliente.post(Uri.parse(urlBase),
          body: grp, headers: {"Content-type": "application/json"});
      if (result.statusCode == 200) {
        return ReemplazoModel.fromMap(json.decode(result.body));
      }

      return producto;
    } catch (e) {
      return producto;
    }
  }

  @override
  Future<List<ReemplazoDetEntity>> getDetalleReemplazos(int idcab) async {
    try {
      List<ReemplazoDetEntity> tem = [];
      final result = await cliente.get(Uri.parse("$urlBase/detalles/$idcab"));
      if (result.statusCode == 200) {
        tem = decodedetalle(utf8.decode(result.bodyBytes));
      }

      return tem;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<ReemplazoDetEntity> insertDetReemplazos(
      ReemplazoDetModel model) async {
    ReemplazoDetModel detalle = ReemplazoDetModel();
    try {
      var grp = json.encode(model.toMap());

      final result = await cliente.post(Uri.parse("$urlBase/remplazoDet"),
          body: grp, headers: {"Content-type": "application/json"});
      if (result.statusCode == 200) {
        return ReemplazoDetModel.fromMap(json.decode(result.body));
      }

      return detalle;
    } catch (e) {
      return detalle;
    }
  }

  List<ReemplazoDetModel> decodedetalle(String respuesta) {
    var parseo = jsonDecode(respuesta);
    return parseo
        .map<ReemplazoDetModel>((json) => ReemplazoDetModel.fromMap(json))
        .toList();
  }
}
