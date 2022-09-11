import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tesis/data/datasource/url.dart';
import 'package:tesis/data/models/pedidos/pedidoDetModel.dart';
import 'package:tesis/data/models/pedidos/pedidoModel.dart';
import 'package:tesis/domain/entities/pedidos/pedidosDetEntity.dart';
import 'package:tesis/domain/entities/pedidos/pedidosEntity.dart';

abstract class PedidosDts {
  Future<List<PedidoEntity>> getAllPedidos();
  Future<PedidoEntity> insertPedidos(PedidoModel entity);
  Future<PedidoEntity> anularPedidos(PedidoModel entity);
  Future<List<PedidoDetEntity>> getPedidosById(int idPedido);
}

class PedidosDtsImp extends PedidosDts {
  final http.Client cliente;
  PedidosDtsImp(this.cliente);

  String urlBase = "${UrlBase.url}pedidos";

  @override
  Future<List<PedidoEntity>> getAllPedidos() async {
    try {
      List<PedidoModel> tem = [];
      final result = await cliente.get(Uri.parse(urlBase));
      if (result.statusCode == 200) {
        tem = decodeMtv(utf8.decode(result.bodyBytes));
      }

      return tem;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  @override
  Future<PedidoEntity> insertPedidos(PedidoModel model) async {
    PedidoModel pedido = PedidoModel();
    try {
      var grp = json.encode(model.toMap());

      final result = await cliente.post(Uri.parse(urlBase),
          body: grp, headers: {"Content-type": "application/json"});
      if (result.statusCode == 200) {
        return PedidoModel.fromMap(json.decode(result.body));
      }

      return pedido;
    } catch (e) {
      print(e.toString());

      return pedido;
    }
  }

  @override
  Future<PedidoEntity> anularPedidos(PedidoModel model) async {
    PedidoModel pedido = PedidoModel();
    try {
      var grp = json.encode(model.toMap());

      final result = await cliente.post(Uri.parse("$urlBase/anular"),
          body: grp, headers: {"Content-type": "application/json"});
      if (result.statusCode == 200) {
        return PedidoModel.fromMap(json.decode(result.body));
      }

      return pedido;
    } catch (e) {
      print(e.toString());
      return pedido;
    }
  }

  List<PedidoModel> decodeMtv(String respuesta) {
    var parseo = jsonDecode(respuesta);
    return parseo
        .map<PedidoModel>((json) => PedidoModel.fromMap(json))
        .toList();
  }

  List<PedidoDetModel> decodePedidosDet(String respuesta) {
    var parseo = jsonDecode(respuesta);
    return parseo
        .map<PedidoDetModel>((json) => PedidoDetModel.fromMap(json))
        .toList();
  }

  @override
  Future<List<PedidoDetEntity>> getPedidosById(int idPedido) async {
    try {
      List<PedidoDetModel> tem = [];
      final result =
          await cliente.get(Uri.parse("$urlBase/pedidoDet/$idPedido"));
      if (result.statusCode == 200) {
        tem = decodePedidosDet(utf8.decode(result.bodyBytes));
      }

      return tem;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
