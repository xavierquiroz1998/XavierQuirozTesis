import 'package:equatable/equatable.dart';
import 'package:tesis/domain/entities/productos/productosEntity.dart';

class ReemplazoDetEntity extends Equatable {
  ReemplazoDetEntity({
    this.id = 0,
    this.idCab = 0,
    this.idProducto1 = 0,
    this.cantidad = 0,
    this.motivo = 0,
    this.idProducto2 = 0,
    this.cantidad2 = 0,
  });

  int id;
  int idCab;
  int idProducto1;
  int cantidad;
  int motivo;
  int idProducto2;
  int cantidad2;
  ProductosEntity? prd;
  ProductosEntity? prd2;

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        idCab,
        idProducto1,
        cantidad,
        motivo,
        idProducto2,
        cantidad2,
      ];
}
