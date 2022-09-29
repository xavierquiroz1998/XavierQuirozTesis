import 'package:dartz/dartz.dart';
import 'package:tesis/core/Errors/failure.dart';
import 'package:tesis/data/models/departamento/departamentoModel.dart';
import 'package:tesis/domain/entities/departamentosEntity.dart';

abstract class AbstractDepartamento {
  Future<Either<Failure, List<DepartamentosEntity>>> getAllDep();
  Future<Either<Failure, DepartamentosEntity>> insertDep(ModelDepartamento dep);
  Future<Either<Failure, DepartamentosEntity>> updateDepartamento(
      ModelDepartamento dep);
  Future<Either<Failure, DepartamentosEntity>> anularDep(ModelDepartamento dep);
}
