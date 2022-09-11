import 'package:dartz/dartz.dart';
import 'package:tesis/core/Errors/failure.dart';
import 'package:tesis/data/models/motivos/motivosModel.dart';
import 'package:tesis/domain/entities/motivos/motivosEntity.dart';
import 'package:tesis/domain/repositories/motivos/abstractMotivos.dart';

class MotivosGeneral {
  final AbstractMotivos repository;
  MotivosGeneral(this.repository);

  Future<Either<Failure, List<MotivosEntity>>> getAllMotivos() async {
    return repository.getAllMotivos();
  }

  Future<Either<Failure, MotivosEntity>> insertMotivos(MotivosModel mtv) async {
    return repository.insertMotivos(mtv);
  }

  Future<Either<Failure, MotivosEntity>> anularMotivos(MotivosModel mtv) async {
    return repository.anularMotivos(mtv);
  }
}
