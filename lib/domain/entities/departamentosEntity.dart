import 'package:equatable/equatable.dart';

class DepartamentosEntity extends Equatable {
  DepartamentosEntity({
    this.id = 0,
    this.nombre = "",
    this.descripcion = "",
    this.estado = "",
    this.idEmpresa = 0,
  });

  int id;
  String nombre;
  String descripcion;
  String estado;
  int idEmpresa;

  @override
  // TODO: implement props
  List<Object?> get props => [id, nombre, descripcion, estado, idEmpresa];
}
