// To parse this JSON data, do
//
//     final pedidoModel = pedidoModelFromMap(jsonString);

import 'dart:convert';

import 'package:tesis/domain/entities/pedidos/pedidosEntity.dart';

class PedidoModel extends PedidoEntity {
  PedidoModel({
    this.id = 0,
    this.idCliente = 0,
    this.observacion = "",
    this.fecha,
    this.estado = "",
    this.idUsuario = 0,
  }) : super(
            id: id,
            idCliente: idCliente,
            observacion: observacion,
            fecha: fecha,
            estado: estado,
            idUsuario: idUsuario);

  int id;
  int idCliente;
  String observacion;
  DateTime? fecha;
  String estado;
  int idUsuario;

  factory PedidoModel.fromJson(String str) =>
      PedidoModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PedidoModel.fromMap(Map<String, dynamic> json) => PedidoModel(
        id: json["id"],
        idCliente: json["id_cliente"],
        observacion: json["observacion"],
        fecha: DateTime.parse(json["fecha"]),
        estado: json["estado"],
        idUsuario: json["id_usuario"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "id_cliente": idCliente,
        "observacion": observacion,
        "fecha": fecha!.toIso8601String(),
        "estado": estado,
        "id_usuario": idUsuario,
      };
}
