import 'dart:convert';

import 'package:tesis/domain/entities/tipoPersona/tipoPersonaEntity.dart';

class TipoPersonaModel extends TipoPersonaEntity {
  TipoPersonaModel({
    this.id = 0,
    this.descripcion = "",
    this.estado = "",
  }) : super(id: id, descripcion: descripcion, estado: estado);

  int id;
  String descripcion;
  String estado;

  factory TipoPersonaModel.fromJson(String str) =>
      TipoPersonaModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TipoPersonaModel.fromMap(Map<String, dynamic> json) =>
      TipoPersonaModel(
        id: json["id"],
        descripcion: json["descripcion"],
        estado: json["estado"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "descripcion": descripcion,
        "estado": estado,
      };
}
