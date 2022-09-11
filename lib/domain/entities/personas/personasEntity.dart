import 'package:equatable/equatable.dart';

class PersonaEntity extends Equatable {
  PersonaEntity({
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
  });

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

  @override
  List<Object?> get props => [
        id,
        identificacion,
        nombres,
        direccion,
        correo,
        celular,
        telefono,
        empresaproveedor,
        idempresa,
        iddepartamento,
        tipo,
        estado
      ];
}
