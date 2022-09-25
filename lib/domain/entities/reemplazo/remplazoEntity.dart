import 'package:equatable/equatable.dart';

class ReemplazoEntity extends Equatable {
  ReemplazoEntity({
    this.id = 0,
    this.idPersona = 0,
    this.idMotivo = 0,
    this.observacion = "",
    this.fecha,
    this.estado = "",
  });

  int id;
  int idPersona;
  int idMotivo;
  String observacion;
  DateTime? fecha;
  String estado;
  String nomPersona="";

  @override
  // TODO: implement props
  List<Object?> get props =>
      [id, idPersona, idMotivo, observacion, fecha, estado];
}
