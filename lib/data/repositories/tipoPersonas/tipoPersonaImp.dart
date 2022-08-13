import 'package:tesis/core/Errors/exceptions.dart';
import 'package:tesis/data/datasource/tipoPersona/tipoPersonaDts.dart';
import 'package:tesis/domain/entities/tipoPersona/tipoPersonaEntity.dart';
import 'package:tesis/data/models/tipoPersona/tipoPersonaModel.dart';
import 'package:tesis/core/Errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tesis/domain/repositories/tipoPersona/abstractTipoPersonas.dart';

class TipoPersonaImp extends AbstractTipoPersonas {
  final TipoPersonaDTS datasource;
  TipoPersonaImp(this.datasource);

  @override
  Future<Either<Failure, List<TipoPersonaEntity>>> getAllTipoPersonas() async {
    try {
      return right(await datasource.getAllTipoPersona());
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de grupos"));
    }
  }

  @override
  Future<Either<Failure, TipoPersonaEntity>> insertTipoPersonas(
      TipoPersonaModel tp) async {
    try {
      return right(await datasource.insertTipoPersona(tp));
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de grupos"));
    }
  }
}
