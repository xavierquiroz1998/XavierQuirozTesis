import 'dart:convert';

import 'package:tesis/domain/entities/usuarios/usuariosEntity.dart';

class UsuarioModel extends UsuariEntity {
  UsuarioModel({
    this.id = 0,
    this.usuario = "",
    this.nombres = "",
    this.identificacion = "",
    this.domicilio = "",
    this.correo = "",
    this.celular = "",
    this.estado = "",
    this.fechaTrans,
    this.usuarioCreacion = 0,
    this.contrasenia = "",
  }) : super(
            id: id,
            usuario: usuario,
            nombres: nombres,
            identificacion: identificacion,
            domicilio: domicilio,
            correo: correo,
            celular: celular,
            estado: estado,
            fechaTrans: fechaTrans,
            usuarioCreacion: usuarioCreacion,
            contrasenia: contrasenia);

  int id;
  String usuario;
  String nombres;
  String identificacion;
  String domicilio;
  String correo;
  String celular;
  String estado;
  DateTime? fechaTrans;
  int usuarioCreacion;
  String contrasenia;

  factory UsuarioModel.fromJson(String str) =>
      UsuarioModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UsuarioModel.fromMap(Map<String, dynamic> json) {
    return UsuarioModel(
      id: json["id"],
      usuario: json["usuario"],
      nombres: json["nombres"],
      identificacion: json["identificacion"],
      domicilio: json["domicilio"],
      correo: json["correo"],
      celular: json["celular"],
      estado: json["estado"],
      fechaTrans: DateTime.parse(json["fecha_trans"] ?? DateTime.now()),
      usuarioCreacion: json["usuario_creacion"],
      contrasenia: json["contrasenia"],
    );
  }
}
