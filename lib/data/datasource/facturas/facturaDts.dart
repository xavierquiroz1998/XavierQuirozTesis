import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tesis/data/datasource/url.dart';
import 'package:tesis/data/models/facturas/facturaModel.dart';
import 'package:tesis/domain/entities/facturas/facturaEntity.dart';

abstract class FacturaDts {
  Future<List<FacturaEntity>> getAllFacturas();
  Future<FacturaEntity> insertFacturas(FacturaModel model);
}

class FacturaDtsImp extends FacturaDts {
  final http.Client cliente;
  FacturaDtsImp(this.cliente);

  String urlBase = "${UrlBase.url}facturas";

  @override
  Future<List<FacturaEntity>> getAllFacturas() async {
    try {
      List<FacturaModel> tem = [];
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
  Future<FacturaEntity> insertFacturas(FacturaModel model) async {
    FacturaModel facturaModel = FacturaModel();
    try {
      var grp = json.encode(model.toMap());

      final result = await cliente.post(Uri.parse(urlBase),
          body: grp, headers: {"Content-type": "application/json"});
      if (result.statusCode == 200) {
        return FacturaModel.fromMap(json.decode(result.body));
      }

      return facturaModel;
    } catch (e) {
      return facturaModel;
    }
  }

  List<FacturaModel> decodeMtv(String respuesta) {
    var parseo = jsonDecode(respuesta);
    return parseo
        .map<FacturaModel>((json) => FacturaModel.fromMap(json))
        .toList();
  }
}
