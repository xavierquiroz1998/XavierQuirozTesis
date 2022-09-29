import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tesis/data/datasource/url.dart';
import 'package:tesis/data/models/facturas/facturaDetModel.dart';
import 'package:tesis/data/models/facturas/facturaModel.dart';
import 'package:tesis/domain/entities/facturas/facturaDetEntity.dart';
import 'package:tesis/domain/entities/facturas/facturaEntity.dart';

abstract class FacturaDts {
  Future<List<FacturaEntity>> getAllFacturas();
  Future<FacturaEntity> insertFacturas(FacturaModel model);
  Future<FacturaDetEntity> insertDetFacturas(FacturaDetModel entity);
  Future<List<FacturaDetEntity>> getFacturaById(int idPedido);
  Future<FacturaEntity> anularFacturas(FacturaModel model);
  Future<List<FacturasClientesEntity>> getFacturaClientes();
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

  @override
  Future<FacturaEntity> anularFacturas(FacturaModel model) async {
    FacturaModel facturaModel = FacturaModel();
    try {
      var grp = json.encode(model.toMap());

      final result = await cliente.post(Uri.parse("$urlBase/anular"),
          body: grp, headers: {"Content-type": "application/json"});
      if (result.statusCode == 200) {
        return FacturaModel.fromMap(json.decode(result.body));
      }

      return facturaModel;
    } catch (e) {
      return facturaModel;
    }
  }

  List<FacturaDetModel> decodePedidosDet(String respuesta) {
    var parseo = jsonDecode(respuesta);
    return parseo
        .map<FacturaDetModel>((json) => FacturaDetModel.fromMap(json))
        .toList();
  }

  List<FacturasClientesModel> decodefacturasClientes(String respuesta) {
    var parseo = jsonDecode(respuesta);
    return parseo
        .map<FacturasClientesModel>(
            (json) => FacturasClientesModel.fromMap(json))
        .toList();
  }

  @override
  Future<List<FacturaDetEntity>> getFacturaById(int idPedido) async {
    try {
      List<FacturaDetModel> tem = [];
      final result =
          await cliente.get(Uri.parse("$urlBase/detalles/$idPedido"));
      if (result.statusCode == 200) {
        tem = decodePedidosDet(utf8.decode(result.bodyBytes));
      }

      return tem;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  @override
  Future<FacturaDetEntity> insertDetFacturas(FacturaDetModel model) async {
    FacturaDetModel pedido = FacturaDetModel();
    try {
      var grp = json.encode(model.toMap());

      final result = await cliente.post(Uri.parse("$urlBase/facturaDet"),
          body: grp, headers: {"Content-type": "application/json"});
      if (result.statusCode == 200) {
        return FacturaDetModel.fromMap(json.decode(result.body));
      }

      return pedido;
    } catch (e) {
      print(e.toString());

      return pedido;
    }
  }

  @override
  Future<List<FacturasClientesEntity>> getFacturaClientes() async {
    try {
      List<FacturasClientesModel> tem = [];
      final result = await cliente.get(Uri.parse("$urlBase/clientes"));
      if (result.statusCode == 200) {
        tem = decodefacturasClientes(utf8.decode(result.bodyBytes));
      }

      return tem;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
