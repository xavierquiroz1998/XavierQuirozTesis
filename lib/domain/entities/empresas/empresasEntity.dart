import 'package:equatable/equatable.dart';

class EmpresasEntity extends Equatable {
  EmpresasEntity({
    this.id = 0,
    this.nombre = "",
    this.descripcion = "",
    this.estado = "",
  });

  int id;
  String nombre;
  String descripcion;
  String estado;

  @override
  // TODO: implement props
  List<Object?> get props => [id, nombre, descripcion, estado];
}
