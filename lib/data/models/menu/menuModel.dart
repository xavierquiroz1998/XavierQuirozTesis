// To parse this JSON data, do
//
//     final menuModel = menuModelFromMap(jsonString);

import 'dart:convert';

import 'package:tesis/domain/entities/menu/menuEntity.dart';

class MenuModel extends MenuEntity {
  MenuModel({
    this.id = 0,
    this.descripcion = "",
    this.ruta = "",
    this.icono = "",
    this.estado = "",
    this.nuevo = false,
    this.modificar = false,
    this.anular = false,
    this.idUsuario = 0,
  }) : super(
            id: id,
            descripcion: descripcion,
            ruta: ruta,
            icono: icono,
            estado: estado,
            nuevo: nuevo,
            modificar: modificar,
            anular: anular,
            idUsuario: idUsuario);

  int id;
  String descripcion;
  String ruta;
  String icono;
  String estado;
  bool nuevo;
  bool modificar;
  bool anular;
  int idUsuario;

  factory MenuModel.fromJson(String str) => MenuModel.fromMap(json.decode(str));

  //String toJson() => json.encode(toMap());

  factory MenuModel.fromMap(Map<String, dynamic> json) => MenuModel(
        id: json["id"],
        descripcion: json["descripcion"],
        ruta: json["ruta"],
        icono: json["icono"],
        estado: json["estado"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "descripcion": descripcion,
        "ruta": ruta,
        "icono": icono,
        "estado": estado,
      };
}
