import 'package:tesis/core/Errors/exceptions.dart';
import 'package:tesis/data/datasource/motivos/motivosDts.dart';
import 'package:tesis/domain/entities/motivos/motivosEntity.dart';
import 'package:tesis/data/models/motivos/motivosModel.dart';
import 'package:tesis/core/Errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tesis/domain/repositories/motivos/abstractMotivos.dart';

class MotivosImp extends AbstractMotivos {
  final MotivosDTS datasource;
  MotivosImp(this.datasource);

  @override
  Future<Either<Failure, List<MotivosEntity>>> getAllMotivos() async {
    try {
      return right(await datasource.getAllMotivos());
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de grupos"));
    }
  }

  @override
  Future<Either<Failure, MotivosEntity>> insertMotivos(MotivosModel mtv) async {
    try {
      return right(await datasource.insertMotivos(mtv));
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de grupos"));
    }
  }

  @override
  Future<Either<Failure, MotivosEntity>> anularMotivos(MotivosModel mtv) async {
    try {
      return right(await datasource.anularMotivos(mtv));
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de grupos"));
    }
  }
}
