import 'package:dartz/dartz.dart';
import 'package:tesis/core/Errors/failure.dart';
import 'package:tesis/data/models/productos/productosModel.dart';
import 'package:tesis/domain/entities/productos/productosEntity.dart';

abstract class AbstractProductos {
  Future<Either<Failure, List<ProductosEntity>>> getAllProductos();
  Future<Either<Failure, ProductosEntity>> insertProductos(ProductosModel dep);
  Future<Either<Failure, ProductosEntity>> anularProductos(ProductosModel dep);
}
