import 'package:dartz/dartz.dart';
import 'package:tesis/core/Errors/failure.dart';
import 'package:tesis/data/models/tipoPersona/tipoPersonaModel.dart';
import 'package:tesis/domain/entities/tipoPersona/tipoPersonaEntity.dart';
import 'package:tesis/domain/repositories/tipoPersona/abstractTipoPersonas.dart';

class TipoPersonaGeneral {
  final AbstractTipoPersonas repository;
  TipoPersonaGeneral(this.repository);

  Future<Either<Failure, List<TipoPersonaEntity>>> getAllTipoPersonas() async {
    return repository.getAllTipoPersonas();
  }

  Future<Either<Failure, TipoPersonaEntity>> insertTipoPersonas(
      TipoPersonaModel tp) async {
    return repository.insertTipoPersonas(tp);
  }
}
