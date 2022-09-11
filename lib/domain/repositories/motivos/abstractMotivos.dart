import 'package:dartz/dartz.dart';
import 'package:tesis/core/Errors/failure.dart';
import 'package:tesis/data/models/motivos/motivosModel.dart';
import 'package:tesis/domain/entities/motivos/motivosEntity.dart';

abstract class AbstractMotivos {
  Future<Either<Failure, List<MotivosEntity>>> getAllMotivos();
  Future<Either<Failure, MotivosEntity>> insertMotivos(MotivosModel mtv);
  Future<Either<Failure, MotivosEntity>> anularMotivos(MotivosModel mtv);
}
