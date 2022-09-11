import 'package:tesis/core/Errors/exceptions.dart';
import 'package:tesis/data/datasource/persona/personaDts.dart';
import 'package:tesis/domain/entities/personas/personasEntity.dart';
import 'package:tesis/data/models/personas/personasModel.dart';
import 'package:tesis/core/Errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tesis/domain/repositories/persona/abstractPersonas.dart';

class PersonasImp extends AbstractPersonas {
  final PersonaDts datasource;
  PersonasImp(this.datasource);

  @override
  Future<Either<Failure, List<PersonaEntity>>> getAllPersonas() async {
    try {
      return right(await datasource.getAllPersonas());
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de grupos"));
    }
  }

  @override
  Future<Either<Failure, PersonaEntity>> insertPersonas(
      PersonaModel model) async {
    try {
      return right(await datasource.insertPersonas(model));
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de grupos"));
    }
  }

  @override
  Future<Either<Failure, PersonaEntity>> anularPersonas(
      PersonaModel model) async {
    try {
      return right(await datasource.anularPersonas(model));
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de grupos"));
    }
  }
}
