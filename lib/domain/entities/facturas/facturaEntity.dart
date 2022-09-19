import 'package:equatable/equatable.dart';
import 'package:tesis/domain/entities/facturas/facturaDetEntity.dart';

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
  String nomPersona = "";
  double total = 0;
  double cantidad = 0;
  List<FacturaDetEntity> listDetalles = [];

  @override
  // TODO: implement props
  List<Object?> get props =>
      [id, idCliente, observacion, fecha, estado, idUsuario, idPedido];
}
