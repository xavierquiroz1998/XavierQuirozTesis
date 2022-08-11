import 'package:equatable/equatable.dart';

class MotivosEntity extends Equatable {
  MotivosEntity({
    this.id = 0,
    this.nombre = "",
    this.descipcion = "",
    this.estado = "",
  });

  int id;
  String nombre;
  String descipcion;
  String estado;

  @override
  // TODO: implement props
  List<Object?> get props => [id, nombre, descipcion, estado];
}
