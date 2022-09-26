import 'package:dartz/dartz.dart';
import 'package:tesis/core/Errors/failure.dart';
import 'package:tesis/data/models/pedidos/pedidoDetModel.dart';
import 'package:tesis/data/models/pedidos/pedidoModel.dart';
import 'package:tesis/domain/entities/pedidos/pedidosDetEntity.dart';
import 'package:tesis/domain/entities/pedidos/pedidosEntity.dart';
import 'package:tesis/domain/repositories/pedidos/abstractPedido.dart';

class PedidosGeneral {
  final AbstractPedidos repository;

  PedidosGeneral(this.repository);

  Future<Either<Failure, List<PedidoEntity>>> getAllPedidos() {
    return repository.getAllPedidos();
  }

  Future<Either<Failure, List<PedidoEntity>>> getAllPedidosPendientes() {
    return repository.getAllPedidosPendientes();
  }

  Future<Either<Failure, PedidoEntity>> insertPedidos(PedidoModel model) {
    return repository.insertPedidos(model);
  }

  Future<Either<Failure, PedidoDetEntity>> insertDetPedidos(
      PedidoDetModel model) {
    return repository.insertDetPedidos(model);
  }

  Future<Either<Failure, PedidoEntity>> anularPedidos(PedidoModel model) {
    return repository.anularPedidos(model);
  }

  Future<Either<Failure, List<PedidoDetEntity>>> getPedidoDetById(
      int idPedido) {
    return repository.getPedidosById(idPedido);
  }
}
