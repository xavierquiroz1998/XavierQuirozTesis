import 'dart:convert';

import 'package:tesis/domain/entities/facturas/facturaDetEntity.dart';
import 'package:tesis/domain/entities/pedidos/pedidosDetEntity.dart';

class FacturaDetModel extends FacturaDetEntity {
  FacturaDetModel({
    this.id = 0,
    this.idCab = 0,
    this.idProducto = 0,
    this.cantidad = 0,
    this.idMotivo = 0,
    this.precio = 0,
    this.codIva = "",
    this.iva = 0,
    this.subTotal = 0,
    this.total = 0,
  }) : super(
            id: id,
            idCab: idCab,
            idProducto: idProducto,
            cantidad: cantidad,
            idMotivo: idMotivo,
            precio: precio,
            codIva: codIva,
            iva: iva,
            subTotal: subTotal,
            total: total);

  int id;
  int idCab;
  int idProducto;
  int cantidad;
  int idMotivo;
  double precio;
  String codIva;
  int iva;
  double subTotal;
  double total;

  factory FacturaDetModel.fromJson(String str) =>
      FacturaDetModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FacturaDetModel.fromMap(Map<String, dynamic> json) => FacturaDetModel(
        id: json["id"],
        idCab: json["id_cab"],
        idProducto: json["id_producto"],
        cantidad: json["cantidad"],
        idMotivo: json["id_motivo"],
        precio: json["precio"].toDouble(),
        codIva: json["cod_iva"],
        iva: json["iva"],
        subTotal: json["sub_total"].toDouble(),
        total: json["total"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "id_cab": idCab,
        "id_producto": idProducto,
        "cantidad": cantidad,
        "id_motivo": idMotivo,
        "precio": precio,
        "cod_iva": codIva,
        "iva": iva,
        "sub_total": subTotal,
        "total": total,
      };
}
