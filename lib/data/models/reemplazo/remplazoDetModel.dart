import 'dart:convert';

import 'package:tesis/domain/entities/reemplazo/remplazoDetEntity.dart';

class ReemplazoDetModel extends ReemplazoDetEntity {
  ReemplazoDetModel({
    this.id = 0,
    this.idCab = 0,
    this.idProducto1 = 0,
    this.cantidad = 0,
    this.motivo = 0,
    this.idProducto2 = 0,
    this.cantidad2 = 0,
  }) : super(
          id: id,
          idCab: idCab,
          idProducto1: idProducto1,
          cantidad: cantidad,
          motivo: motivo,
          idProducto2: idProducto2,
          cantidad2: cantidad2,
        );

  int id;
  int idCab;
  int idProducto1;
  int cantidad;
  int motivo;
  int idProducto2;
  int cantidad2;

  factory ReemplazoDetModel.fromJson(String str) =>
      ReemplazoDetModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ReemplazoDetModel.fromMap(Map<String, dynamic> json) =>
      ReemplazoDetModel(
        id: json["id"],
        idCab: json["id_cab"],
        idProducto1: json["id_producto1"],
        cantidad: json["cantidad"],
        motivo: json["motivo"],
        idProducto2: json["id_producto2"],
        cantidad2: json["cantidad2"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "id_cab": idCab,
        "id_producto1": idProducto1,
        "cantidad": cantidad,
        "motivo": motivo,
        "id_producto2": idProducto2,
        "cantidad2": cantidad2,
      };
}
