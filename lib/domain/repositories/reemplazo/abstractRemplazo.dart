import 'package:dartz/dartz.dart';
import 'package:tesis/core/Errors/failure.dart';
import 'package:tesis/data/models/reemplazo/remplazoDetModel.dart';
import 'package:tesis/data/models/reemplazo/remplazoModel.dart';
import 'package:tesis/domain/entities/reemplazo/remplazoDetEntity.dart';
import 'package:tesis/domain/entities/reemplazo/remplazoEntity.dart';

abstract class AbstratRemplazo {
  Future<Either<Failure, List<ReemplazoEntity>>> getAllReemplazos();
  Future<Either<Failure, ReemplazoEntity>> insertReemplazos(
      ReemplazoModel model);
  Future<Either<Failure, ReemplazoEntity>> anularReemplazos(
      ReemplazoModel model);

  Future<Either<Failure, List<ReemplazoDetEntity>>> getDetalleReemplazos(
      int idcab);
  Future<Either<Failure, ReemplazoDetEntity>> insertDetReemplazos(
      ReemplazoDetModel model);
}
