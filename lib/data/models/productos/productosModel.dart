// To parse this JSON data, do
//
//     final productosModel = productosModelFromMap(jsonString);

import 'dart:convert';

import 'package:tesis/domain/entities/productos/productosEntity.dart';

class ProductosModel extends ProductosEntity {
  ProductosModel({
    this.id = 0,
    this.codigo = "",
    this.nombre = "",
    this.descripcion = "",
    this.stock = 0,
    this.costo = 0,
    this.precio = 0,
    this.unidad = 0,
    this.estado = "",
    this.fecha,
    this.usuario = "",
  }) : super(
            id: id,
            codigo: codigo,
            nombre: nombre,
            descripcion: descripcion,
            stock: stock,
            costo: costo,
            precio: precio,
            unidad: unidad,
            estado: estado,
            fecha: fecha,
            usuario: usuario);

  int id;
  String codigo;
  String nombre;
  String descripcion;
  int stock;
  double costo;
  double precio;
  int unidad;
  String estado;
  DateTime? fecha;
  String usuario;

  factory ProductosModel.fromJson(String str) =>
      ProductosModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductosModel.fromMap(Map<String, dynamic> json) => ProductosModel(
        id: json["id"],
        codigo: json["codigo"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        stock: json["stock"],
        costo: json["costo"].toDouble(),
        precio: json["precio"],
        unidad: json["unidad"],
        estado: json["estado"],
        fecha: DateTime.parse(json["fecha"]),
        usuario: json["usuario"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "codigo": codigo,
        "nombre": nombre,
        "descripcion": descripcion,
        "stock": stock,
        "costo": costo,
        "precio": precio,
        "unidad": unidad,
        "estado": estado,
        "fecha": fecha!.toIso8601String(),
        "usuario": usuario,
      };
}

class CostovsPrecioModel extends CostovsPrecioEntity {
  CostovsPrecioModel({
    this.id = 0,
    this.codigo = "",
    this.nombre = "",
    this.costo = 0,
    this.precio = 0,
    this.estado = "",
    this.canpendfact = 0,
    this.costototal = 0,
    this.preciototal = 0,
  }) : super(
          id: id,
          codigo: codigo,
          nombre: nombre,
          costo: costo,
          precio: precio,
          estado: estado,
          canpendfact: canpendfact,
          costototal: costototal,
          preciototal: preciototal,
        );

  int id;
  String codigo;
  String nombre;
  double costo;
  double precio;
  String estado;
  int canpendfact;
  double costototal;
  double preciototal;

  factory CostovsPrecioModel.fromJson(String str) =>
      CostovsPrecioModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CostovsPrecioModel.fromMap(Map<String, dynamic> json) =>
      CostovsPrecioModel(
        id: json["id"],
        codigo: json["codigo"],
        nombre: json["nombre"],
        costo: json["costo"].toDouble(),
        precio: json["precio"].toDouble(),
        estado: json["estado"],
        canpendfact: json["canpendfact"],
        costototal: json["costototal"].toDouble(),
        preciototal: json["preciototal"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "codigo": codigo,
        "nombre": nombre,
        "costo": costo,
        "precio": precio,
        "estado": estado,
        "canpendfact": canpendfact,
        "costototal": costototal,
        "preciototal": preciototal,
      };
}
