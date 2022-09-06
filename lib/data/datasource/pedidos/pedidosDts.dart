import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tesis/data/datasource/url.dart';
import 'package:tesis/data/models/pedidos/pedidoModel.dart';
import 'package:tesis/domain/entities/pedidos/pedidosEntity.dart';

abstract class PedidosDts {
  Future<List<PedidoEntity>> getAllPedidos();
  Future<PedidoEntity> insertPedidos(PedidoModel model);
}

class PedidosDtsImp extends PedidosDts {
  final http.Client cliente;
  PedidosDtsImp(this.cliente);

  String urlBase = "${UrlBase.url}pedido";

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
      return pedido;
    }
  }

  List<PedidoModel> decodeMtv(String respuesta) {
    var parseo = jsonDecode(respuesta);
    return parseo
        .map<PedidoModel>((json) => PedidoModel.fromMap(json))
        .toList();
  }
}
