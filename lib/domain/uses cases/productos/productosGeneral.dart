import 'package:dartz/dartz.dart';
import 'package:tesis/core/Errors/failure.dart';
import 'package:tesis/data/models/productos/productosModel.dart';
import 'package:tesis/domain/entities/productos/productosEntity.dart';
import 'package:tesis/domain/repositories/productos/abstractProductos.dart';

class ProductosGeneral {
  final AbstractProductos repository;

  ProductosGeneral(this.repository);

  Future<Either<Failure, List<ProductosEntity>>> getAll() async {
    return repository.getAllProductos();
  }

  Future<Either<Failure, List<ProductosEntity>>> getAllActivos() async {
    return repository.getAllProductosActivos();
  }

  Future<Either<Failure, List<CostovsPrecioEntity>>>
      getAllcostoVsprecio() async {
    return repository.getAllcostoVsprecio();
  }

  Future<Either<Failure, ProductosEntity>> insertProducto(
      ProductosModel prd) async {
    return repository.insertProductos(prd);
  }

  Future<Either<Failure, ProductosEntity>> updateProductos(
      ProductosModel prd) async {
    return repository.updateProductos(prd);
  }

  Future<Either<Failure, ProductosEntity>> anularProducto(
      ProductosModel prd) async {
    return repository.anularProductos(prd);
  }
}
