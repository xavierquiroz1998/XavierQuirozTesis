import 'package:equatable/equatable.dart';

class TipoPersonaEntity extends Equatable {
  TipoPersonaEntity({
    this.id = 0,
    this.descripcion = "",
    this.estado = "",
  });

  int id;
  String descripcion;
  String estado;

  @override
  // TODO: implement props
  List<Object?> get props => [id, descripcion, estado];
}

class TipoTrassaccion extends Equatable {
  TipoTrassaccion({
    this.total = 0,
    this.tipo = "",
  });

  int total;
  String tipo;

  @override
  // TODO: implement props
  List<Object?> get props => [total, tipo];
}
