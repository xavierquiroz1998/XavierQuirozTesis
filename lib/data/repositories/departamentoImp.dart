import 'package:tesis/core/Errors/exceptions.dart';
import 'package:tesis/core/Errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tesis/data/datasource/reference/departamento/departamentoDts.dart';
import 'package:tesis/data/models/departamento/departamentoModel.dart';
import 'package:tesis/domain/repositories/abstractDepartamento.dart';

class DepartamentoImp implements AbstractDepartamento {
  final DepartamentoDTS datasource;

  DepartamentoImp(this.datasource);

  @override
  Future<Either<Failure, List<ModelDepartamento>>> getAllDep() async {
    try {
      return right(await datasource.getAllDepartamentos());
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de grupos"));
    }
  }

  @override
  Future<Either<Failure, ModelDepartamento>> insertDep(
      ModelDepartamento dep) async {
    try {
      return right(await datasource.insertDepartamento(dep));
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de grupos"));
    }
  }
}
