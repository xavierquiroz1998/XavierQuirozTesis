// To parse this JSON data, do
//
//     final personaModel = personaModelFromMap(jsonString);

import 'dart:convert';

import 'package:tesis/domain/entities/personas/personasEntity.dart';

class PersonaModel extends PersonaEntity {
  PersonaModel({
    this.id = 0,
    this.identificacion = "",
    this.nombres = "",
    this.direccion = "",
    this.correo = "",
    this.celular = "",
    this.telefono = "",
    this.empresaproveedor = "",
    this.idempresa = 0,
    this.iddepartamento = 0,
    this.tipo = 0,
    this.estado = "",
  }) : super(
            id: id,
            identificacion: identificacion,
            nombres: nombres,
            direccion: direccion,
            correo: correo,
            celular: celular,
            telefono: telefono,
            empresaproveedor: empresaproveedor,
            idempresa: idempresa,
            iddepartamento: iddepartamento,
            tipo: tipo,
            estado: estado);

  int id;
  String identificacion;
  String nombres;
  String direccion;
  String correo;
  String celular;
  String telefono;
  String empresaproveedor;
  int idempresa;
  int iddepartamento;
  int tipo;
  String estado;

  factory PersonaModel.fromJson(String str) =>
      PersonaModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PersonaModel.fromMap(Map<String, dynamic> json) => PersonaModel(
        id: json["id"],
        identificacion: json["identificacion"],
        nombres: json["nombres"],
        direccion: json["direccion"],
        correo: json["correo"],
        celular: json["celular"],
        telefono: json["telefono"],
        empresaproveedor: json["empresaproveedor"],
        idempresa: json["idempresa"],
        iddepartamento: json["iddepartamento"],
        tipo: json["tipo"],
        estado: json["estado"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "identificacion": identificacion,
        "nombres": nombres,
        "direccion": direccion,
        "correo": correo,
        "celular": celular,
        "telefono": telefono,
        "empresaproveedor": empresaproveedor,
        "idempresa": idempresa,
        "iddepartamento": iddepartamento,
        "tipo": tipo,
        "estado": estado,
      };
}
