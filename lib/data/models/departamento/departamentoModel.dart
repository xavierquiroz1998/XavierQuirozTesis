import 'dart:convert';

import 'package:tesis/domain/entities/departamentosEntity.dart';

class ModelDepartamento extends DepartamentosEntity {
  ModelDepartamento({
    this.id = 0,
    this.nombre = "",
    this.descripcion = "",
    this.estado = "",
    this.idEmpresa = 0,
  }) : super(
          id: id,
          nombre: nombre,
          descripcion: descripcion,
          estado: estado,
          idEmpresa: idEmpresa,
        );

  int id;
  String nombre;
  String descripcion;
  String estado;
  int idEmpresa;

  factory ModelDepartamento.fromJson(String str) =>
      ModelDepartamento.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ModelDepartamento.fromMap(Map<String, dynamic> json) =>
      ModelDepartamento(
        id: json["id"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        estado: json["estado"],
        idEmpresa: json["id_empresa"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
        "descripcion": descripcion,
        "estado": estado,
        "id_empresa": idEmpresa,
      };
}
