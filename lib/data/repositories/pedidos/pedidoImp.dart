import 'package:tesis/core/Errors/exceptions.dart';
import 'package:tesis/data/datasource/pedidos/pedidosDts.dart';
import 'package:tesis/data/models/pedidos/pedidoDetModel.dart';
import 'package:tesis/domain/entities/pedidos/pedidosDetEntity.dart';
import 'package:tesis/domain/entities/pedidos/pedidosEntity.dart';
import 'package:tesis/data/models/pedidos/pedidoModel.dart';
import 'package:tesis/core/Errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tesis/domain/repositories/pedidos/abstractPedido.dart';

class PedidoImp extends AbstractPedidos {
  final PedidosDts datasource;
  PedidoImp(this.datasource);

  @override
  Future<Either<Failure, List<PedidoEntity>>> getAllPedidos() async {
    try {
      return right(await datasource.getAllPedidos());
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de grupos"));
    }
  }

  @override
  Future<Either<Failure, PedidoEntity>> insertPedidos(PedidoModel model) async {
    try {
      return right(await datasource.insertPedidos(model));
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de grupos"));
    }
  }

  @override
  Future<Either<Failure, PedidoEntity>> anularPedidos(PedidoModel model) async {
    try {
      return right(await datasource.anularPedidos(model));
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de grupos"));
    }
  }

  @override
  Future<Either<Failure, List<PedidoDetEntity>>> getPedidosById(
      int idPedido) async {
    try {
      return right(await datasource.getPedidosById(idPedido));
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de grupos"));
    }
  }

  @override
  Future<Either<Failure, PedidoDetEntity>> insertDetPedidos(
      PedidoDetModel model) async {
    try {
      return right(await datasource.insertDetPedidos(model));
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de grupos"));
    }
  }

  @override
  Future<Either<Failure, List<PedidoEntity>>> getAllPedidosPendientes() async {
    try {
      return right(await datasource.getAllPedidosPendientes());
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de grupos"));
    }
  }
}
