import 'package:tesis/core/Errors/exceptions.dart';
import 'package:tesis/core/Errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tesis/data/datasource/reemplazo/reemplazoDts.dart';
import 'package:tesis/domain/entities/reemplazo/remplazoDetEntity.dart';
import 'package:tesis/data/models/reemplazo/remplazoDetModel.dart';
import 'package:tesis/domain/entities/reemplazo/remplazoEntity.dart';
import 'package:tesis/data/models/reemplazo/remplazoModel.dart';
import 'package:tesis/domain/repositories/reemplazo/abstractRemplazo.dart';

class ReemplazoImp extends AbstratRemplazo {
  final RemplazoDTS datasource;

  ReemplazoImp(this.datasource);

  @override
  Future<Either<Failure, ReemplazoEntity>> anularReemplazos(
      ReemplazoModel model) async {
    try {
      return right(await datasource.anularReemplazos(model));
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de grupos"));
    }
  }

  @override
  Future<Either<Failure, List<ReemplazoEntity>>> getAllReemplazos() async {
    try {
      return right(await datasource.getAllReemplazos());
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de grupos"));
    }
  }

  @override
  Future<Either<Failure, ReemplazoEntity>> insertReemplazos(
      ReemplazoModel model) async {
    try {
      return right(await datasource.insertReemplazos(model));
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de grupos"));
    }
  }

  @override
  Future<Either<Failure, List<ReemplazoDetEntity>>> getDetalleReemplazos(
      int idCab) async {
    try {
      return right(await datasource.getDetalleReemplazos(idCab));
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de grupos"));
    }
  }

  @override
  Future<Either<Failure, ReemplazoDetEntity>> insertDetReemplazos(
      ReemplazoDetModel model) async {
    try {
      return right(await datasource.insertDetReemplazos(model));
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de grupos"));
    }
  }
}
