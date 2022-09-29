import 'dart:convert';

import 'package:tesis/domain/entities/facturas/facturaEntity.dart';

class FacturaModel extends FacturaEntity {
  FacturaModel({
    this.id = 0,
    this.idCliente = 0,
    this.observacion = "",
    this.fecha,
    this.estado = "",
    this.idUsuario = 0,
    this.idPedido = 0,
  }) : super(
            id: id,
            idCliente: idCliente,
            observacion: observacion,
            fecha: fecha,
            estado: estado,
            idUsuario: idUsuario,
            idPedido: idPedido);

  int id;
  int idCliente;
  String observacion;
  DateTime? fecha;
  String estado;
  int idUsuario;
  int idPedido;

  factory FacturaModel.fromJson(String str) =>
      FacturaModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FacturaModel.fromMap(Map<String, dynamic> json) => FacturaModel(
        id: json["id"],
        idCliente: json["id_cliente"],
        observacion: json["observacion"],
        fecha: DateTime.parse(json["fecha"]),
        estado: json["estado"],
        idUsuario: json["id_usuario"],
        idPedido: json["id_pedido"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "id_cliente": idCliente,
        "observacion": observacion,
        "fecha": fecha!.toIso8601String(),
        "estado": estado,
        "id_usuario": idUsuario,
        "id_pedido": idPedido,
      };
}

class FacturasClientesModel extends FacturasClientesEntity {
  FacturasClientesModel({
    this.nombres = "",
    this.cant = 0,
    this.totaldet = 0,
    this.estado = "",
  }) : super(nombres: nombres, cant: cant, totaldet: totaldet, estado: estado);

  String nombres;
  int cant;
  double totaldet;
  String estado;

  factory FacturasClientesModel.fromJson(String str) =>
      FacturasClientesModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FacturasClientesModel.fromMap(Map<String, dynamic> json) =>
      FacturasClientesModel(
        nombres: json["nombres"],
        cant: json["cant"],
        totaldet: json["totaldet"].toDouble(),
        estado: json["estado"],
      );

  Map<String, dynamic> toMap() => {
        "nombres": nombres,
        "cant": cant,
        "totaldet": totaldet,
        "estado": estado,
      };
}
