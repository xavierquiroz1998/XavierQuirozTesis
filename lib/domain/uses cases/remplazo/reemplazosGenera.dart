import 'package:dartz/dartz.dart';
import 'package:tesis/core/Errors/failure.dart';
import 'package:tesis/data/models/reemplazo/remplazoModel.dart';
import 'package:tesis/domain/entities/reemplazo/remplazoEntity.dart';
import 'package:tesis/domain/repositories/reemplazo/abstractRemplazo.dart';

class ReemplazoGeneral {
  final AbstratRemplazo repository;
  ReemplazoGeneral(this.repository);

  Future<Either<Failure, List<ReemplazoEntity>>> getAllReemplazos() {
    return repository.getAllReemplazos();
  }

  Future<Either<Failure, ReemplazoEntity>> insertReemplazos(
      ReemplazoModel model) {
    return insertReemplazos(model);
  }

  Future<Either<Failure, ReemplazoEntity>> anularReemplazos(
      ReemplazoModel model) {
    return anularReemplazos(model);
  }
}
