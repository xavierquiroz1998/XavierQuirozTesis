import 'package:tesis/core/Errors/exceptions.dart';
import 'package:tesis/data/datasource/productos/productosDts.dart';
import 'package:tesis/domain/entities/productos/productosEntity.dart';
import 'package:tesis/data/models/productos/productosModel.dart';
import 'package:tesis/core/Errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tesis/domain/repositories/productos/abstractProductos.dart';

class ProductosImp implements AbstractProductos {
  final ProductosDTS datasource;
  ProductosImp(this.datasource);

  @override
  Future<Either<Failure, List<ProductosEntity>>> getAllProductos() async {
    try {
      return right(await datasource.getAllProductos());
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de grupos"));
    }
  }

  @override
  Future<Either<Failure, ProductosEntity>> insertProductos(
      ProductosModel dep) async {
    try {
      return right(await datasource.insertProductos(dep));
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de grupos"));
    }
  }

  @override
  Future<Either<Failure, ProductosEntity>> anularProductos(
      ProductosModel dep) async {
    try {
      return right(await datasource.anularProductos(dep));
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de grupos"));
    }
  }
}
