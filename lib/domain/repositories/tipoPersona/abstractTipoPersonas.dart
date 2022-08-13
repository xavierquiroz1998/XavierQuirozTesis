import 'package:dartz/dartz.dart';
import 'package:tesis/core/Errors/failure.dart';
import 'package:tesis/data/models/tipoPersona/tipoPersonaModel.dart';
import 'package:tesis/domain/entities/tipoPersona/tipoPersonaEntity.dart';

abstract class AbstractTipoPersonas {
  Future<Either<Failure, List<TipoPersonaEntity>>> getAllTipoPersonas();
  Future<Either<Failure, TipoPersonaEntity>> insertTipoPersonas(
      TipoPersonaModel tp);
}
