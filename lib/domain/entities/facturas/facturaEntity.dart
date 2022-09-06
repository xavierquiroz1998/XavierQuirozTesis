import 'package:equatable/equatable.dart';

class FacturaEntity extends Equatable {
  FacturaEntity({
    this.id = 0,
    this.idCliente = 0,
    this.observacion = "",
    this.fecha,
    this.estado = "",
    this.idUsuario = 0,
    this.idPedido = 0,
  });

  int id;
  int idCliente;
  String observacion;
  DateTime? fecha;
  String estado;
  int idUsuario;
  int idPedido;

  @override
  // TODO: implement props
  List<Object?> get props =>
      [id, idCliente, observacion, fecha, estado, idUsuario, idPedido];
}
