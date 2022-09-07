import 'package:dartz/dartz.dart';
import 'package:tesis/core/Errors/failure.dart';
import 'package:tesis/data/models/pedidos/pedidoModel.dart';
import 'package:tesis/domain/entities/pedidos/pedidosEntity.dart';

abstract class AbstractPedidos {
  Future<Either<Failure, List<PedidoEntity>>> getAllPedidos();
  Future<Either<Failure, PedidoEntity>> insertPedidos(PedidoEntity model);
}
