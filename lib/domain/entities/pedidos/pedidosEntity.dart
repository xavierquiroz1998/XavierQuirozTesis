import 'package:equatable/equatable.dart';
import 'package:tesis/domain/entities/pedidos/pedidosDetEntity.dart';

class PedidoEntity extends Equatable {
  PedidoEntity({
    this.id = 0,
    this.idCliente = 0,
    this.observacion = "",
    this.fecha,
    this.estado = "",
    this.idUsuario = 0,
    this.nomUsuario = "",
    this.total = 0,
  });

  int id;
  int idCliente;
  String observacion;
  DateTime? fecha;
  String estado;
  int idUsuario;
  String nomUsuario;
  double total;
  List<PedidoDetEntity> listdetalle = [];

  @override
  // TODO: implement props
  List<Object?> get props =>
      [id, idCliente, observacion, fecha, estado, idUsuario];
}
