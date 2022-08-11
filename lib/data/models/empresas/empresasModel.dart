import 'dart:convert';

import 'package:tesis/domain/entities/empresas/empresasEntity.dart';

class EmpresasModel extends EmpresasEntity {
  EmpresasModel({
    this.id = 0,
    this.nombre = "",
    this.descripcion = "",
    this.estado = "",
  }) : super(id: id, nombre: nombre, descripcion: descripcion, estado: estado);

  int id;
  String nombre;
  String descripcion;
  String estado;

  factory EmpresasModel.fromJson(String str) =>
      EmpresasModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EmpresasModel.fromMap(Map<String, dynamic> json) => EmpresasModel(
        id: json["id"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        estado: json["estado"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
        "descripcion": descripcion,
        "estado": estado,
      };
}
