// To parse this JSON data, do
//
//     final reemplazoModel = reemplazoModelFromMap(jsonString);

import 'dart:convert';

import 'package:tesis/domain/entities/reemplazo/remplazoEntity.dart';

class ReemplazoModel extends ReemplazoEntity {
  ReemplazoModel({
    this.id = 0,
    this.idPersona = 0,
    this.idMotivo = 0,
    this.observacion = "",
    this.fecha,
    this.estado = "",
  }) : super(
            id: id,
            idPersona: idPersona,
            idMotivo: idMotivo,
            observacion: observacion,
            fecha: fecha,
            estado: estado);

  int id;
  int idPersona;
  int idMotivo;
  String observacion;
  DateTime? fecha;
  String estado;

  factory ReemplazoModel.fromJson(String str) =>
      ReemplazoModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ReemplazoModel.fromMap(Map<String, dynamic> json) => ReemplazoModel(
        id: json["id"],
        idPersona: json["id_persona"],
        idMotivo: json["id_motivo"],
        observacion: json["observacion"],
        fecha: DateTime.parse(json["fecha"]),
        estado: json["estado"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "id_persona": idPersona,
        "id_motivo": idMotivo,
        "observacion": observacion,
        "fecha": fecha!.toIso8601String(),
        "estado": estado,
      };
}
