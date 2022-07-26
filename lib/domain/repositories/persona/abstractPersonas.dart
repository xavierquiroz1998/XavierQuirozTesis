import 'package:dartz/dartz.dart';
import 'package:tesis/core/Errors/failure.dart';
import 'package:tesis/data/models/personas/personasModel.dart';
import 'package:tesis/domain/entities/personas/personasEntity.dart';

abstract class AbstractPersonas {
  Future<Either<Failure, List<PersonaEntity>>> getAllPersonas();
  Future<Either<Failure, PersonaEntity>> insertPersonas(PersonaModel model);
  Future<Either<Failure, PersonaEntity>> updatePersonas(PersonaModel model);
  Future<Either<Failure, PersonaEntity>> anularPersonas(PersonaModel model);
}
