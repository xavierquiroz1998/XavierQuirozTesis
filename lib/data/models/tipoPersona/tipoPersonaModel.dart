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

class TipoTransaccionModel extends TipoTrassaccion {
  TipoTransaccionModel({
    this.total = 0,
    this.tipo = "",
  }) : super(total: total, tipo: tipo);

  int total;
  String tipo;

  factory TipoTransaccionModel.fromJson(String str) =>
      TipoTransaccionModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TipoTransaccionModel.fromMap(Map<String, dynamic> json) =>
      TipoTransaccionModel(
        total: int.parse(json["total"]),
        tipo: json["tipo"],
      );

  Map<String, dynamic> toMap() => {
        "total": total,
        "tipo": tipo,
      };
}
