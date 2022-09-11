import 'package:dartz/dartz.dart';
import 'package:tesis/core/Errors/failure.dart';
import 'package:tesis/data/models/personas/personasModel.dart';
import 'package:tesis/domain/entities/personas/personasEntity.dart';
import 'package:tesis/domain/repositories/persona/abstractPersonas.dart';

class PersonasGeneral {
  final AbstractPersonas repository;
  PersonasGeneral(this.repository);

  Future<Either<Failure, List<PersonaEntity>>> getAllPersonas() {
    return repository.getAllPersonas();
  }

  Future<Either<Failure, PersonaEntity>> insertPersonas(PersonaModel model) {
    return repository.insertPersonas(model);
  }

  Future<Either<Failure, PersonaEntity>> anularPersonas(PersonaModel model) {
    return repository.anularPersonas(model);
  }
}
