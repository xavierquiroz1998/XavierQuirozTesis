import 'dart:convert';
import 'package:tesis/domain/entities/motivos/motivosEntity.dart';

class MotivosModel extends MotivosEntity {
  MotivosModel({
    this.id = 0,
    this.nombre = "",
    this.descipcion = "",
    this.estado = "",
  }) : super(id: id, nombre: nombre, descipcion: descipcion, estado: estado);

  int id;
  String nombre;
  String descipcion;
  String estado;

  factory MotivosModel.fromJson(String str) =>
      MotivosModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MotivosModel.fromMap(Map<String, dynamic> json) => MotivosModel(
        id: json["id"],
        nombre: json["nombre"],
        descipcion: json["descipcion"],
        estado: json["estado"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
        "descipcion": descipcion,
        "estado": estado,
      };
}
