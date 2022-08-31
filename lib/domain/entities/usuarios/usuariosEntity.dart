import 'package:equatable/equatable.dart';

class UsuariEntity extends Equatable {
  UsuariEntity({
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
  });

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

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        usuario,
        nombres,
        identificacion,
        domicilio,
        correo,
        celular,
        estado,
        fechaTrans,
        usuarioCreacion,
        contrasenia
      ];

  Map<String, dynamic> toMap() => {
        "id": id,
        "usuario": usuario,
        "nombres": nombres,
        "identificacion": identificacion,
        "domicilio": domicilio,
        "correo": correo,
        "celular": celular,
        "estado": estado,
        "fecha_trans": fechaTrans!.toIso8601String(),
        "usuario_creacion": usuarioCreacion,
        "contrasenia": contrasenia,
      };
}
