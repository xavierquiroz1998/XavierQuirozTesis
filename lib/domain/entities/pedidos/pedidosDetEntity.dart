import 'package:equatable/equatable.dart';
import 'package:tesis/domain/entities/productos/productosEntity.dart';

class PedidoDetEntity extends Equatable {
  PedidoDetEntity({
    this.id = 0,
    this.idCab = 0,
    this.idProducto = 0,
    this.cantidad = 0,
    this.idMotivo = 0,
    this.precio = 0,
    this.codIva = "",
    this.iva = 0,
    this.subTotal = 0,
    this.total = 0,
  });

  int id;
  int idCab;
  int idProducto;
  int cantidad;
  int idMotivo;
  double precio;
  String codIva;
  int iva;
  double subTotal;
  double total;
  ProductosEntity? prd;

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        idCab,
        idProducto,
        cantidad,
        idMotivo,
        precio,
        codIva,
        iva,
        subTotal,
        total
      ];
}
