import 'package:equatable/equatable.dart';

class ProductosEntity extends Equatable {
  ProductosEntity({
    this.id = 0,
    this.codigo = "",
    this.nombre = "",
    this.descripcion = "",
    this.stock = 0,
    this.costo = 0,
    this.precio = 0,
    this.unidad = 0,
    this.estado = "",
    this.fecha,
    this.usuario = "",
  });

  int id;
  String codigo;
  String nombre;
  String descripcion;
  int stock;
  double costo;
  double precio;
  int unidad;
  String estado;
  DateTime? fecha;
  String usuario;

  @override
  // TODO: implement props
  List<Object?> get props => throw [
        id,
        codigo,
        nombre,
        descripcion,
        stock,
        costo,
        precio,
        unidad,
        estado,
        fecha,
        usuario
      ];
}

class CostovsPrecioEntity extends Equatable {
  CostovsPrecioEntity({
    this.id = 0,
    this.codigo = "",
    this.nombre = "",
    this.costo = 0,
    this.precio = 0,
    this.estado = "",
    this.canpendfact = 0,
    this.costototal = 0,
    this.preciototal = 0,
  });

  int id;
  String codigo;
  String nombre;
  double costo;
  double precio;
  String estado;
  int canpendfact;
  double costototal;
  double preciototal;

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        codigo,
        nombre,
        costo,
        precio,
        estado,
        canpendfact,
        costototal,
        preciototal
      ];
}
