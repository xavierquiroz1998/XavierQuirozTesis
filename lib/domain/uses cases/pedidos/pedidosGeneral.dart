import 'package:dartz/dartz.dart';
import 'package:tesis/core/Errors/failure.dart';
import 'package:tesis/domain/entities/pedidos/pedidosEntity.dart';
import 'package:tesis/domain/repositories/pedidos/abstractPedido.dart';

class PedidosGeneral {
  final AbstractPedidos repository;

  PedidosGeneral(this.repository);

  Future<Either<Failure, List<PedidoEntity>>> getAllPedidos() {
    return repository.getAllPedidos();
  }

  Future<Either<Failure, PedidoEntity>> insertPedidos(PedidoEntity model) {
    return repository.insertPedidos(model);
  }
}
