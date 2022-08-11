import 'package:dartz/dartz.dart';
import 'package:tesis/core/Errors/failure.dart';
import 'package:tesis/data/models/departamento/departamentoModel.dart';

abstract class AbstractDepartamento {
  Future<Either<Failure, List<ModelDepartamento>>> getAllDep();
  Future<Either<Failure, ModelDepartamento>> insertDep(ModelDepartamento dep);
}
