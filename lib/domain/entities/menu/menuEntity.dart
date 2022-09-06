import 'package:equatable/equatable.dart';

class MenuEntity extends Equatable {
  MenuEntity({
    this.id = 0,
    this.descripcion = "",
    this.ruta = "",
    this.icono = "",
    this.estado = "",
    this.nuevo = false,
    this.modificar = false,
    this.anular = false,
    this.idUsuario = 0,
  });

  int id;
  String descripcion;
  String ruta;
  String icono;
  String estado;
  bool nuevo;
  bool modificar;
  bool anular;
  int idUsuario;

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        descripcion,
        ruta,
        icono,
        estado,
        nuevo,
        modificar,
        anular,
        idUsuario
      ];
}
