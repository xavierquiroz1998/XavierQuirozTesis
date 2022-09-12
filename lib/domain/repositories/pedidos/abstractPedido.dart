import 'package:dartz/dartz.dart';
import 'package:tesis/core/Errors/failure.dart';
import 'package:tesis/data/models/pedidos/pedidoDetModel.dart';
import 'package:tesis/data/models/pedidos/pedidoModel.dart';
import 'package:tesis/domain/entities/pedidos/pedidosDetEntity.dart';
import 'package:tesis/domain/entities/pedidos/pedidosEntity.dart';

abstract class AbstractPedidos {
  Future<Either<Failure, List<PedidoEntity>>> getAllPedidos();
  Future<Either<Failure, PedidoEntity>> insertPedidos(PedidoModel model);
  Future<Either<Failure, PedidoDetEntity>> insertDetPedidos(
      PedidoDetModel model);
  Future<Either<Failure, PedidoEntity>> anularPedidos(PedidoModel model);
  Future<Either<Failure, List<PedidoDetEntity>>> getPedidosById(int idPedido);
}
