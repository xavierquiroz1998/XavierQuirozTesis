import 'package:dartz/dartz.dart';
import 'package:tesis/core/Errors/failure.dart';
import 'package:tesis/data/models/departamento/departamentoModel.dart';
import 'package:tesis/domain/entities/departamentosEntity.dart';
import 'package:tesis/domain/repositories/abstractDepartamento.dart';

class DepartamentosGeneral {
  final AbstractDepartamento repository;
  DepartamentosGeneral(this.repository);

  Future<Either<Failure, List<DepartamentosEntity>>> getDepartamentos() async {
    return repository.getAllDep();
  }

  Future<Either<Failure, DepartamentosEntity>> insertMDep(
      ModelDepartamento dep) async {
    return repository.insertDep(dep);
  }
}
