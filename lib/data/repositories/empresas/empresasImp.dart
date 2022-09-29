import 'package:tesis/core/Errors/exceptions.dart';
import 'package:tesis/data/datasource/empresas/empresasDts.dart';
import 'package:tesis/domain/entities/empresas/empresasEntity.dart';
import 'package:tesis/data/models/empresas/empresasModel.dart';
import 'package:tesis/core/Errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tesis/domain/repositories/empresas/abtractEmpresas.dart';

class EmpresasImp extends AbstractEmpresas {
  final EmpresasDTS datasource;

  EmpresasImp(this.datasource);

  @override
  Future<Either<Failure, List<EmpresasEntity>>> getAllEmpresas() async {
    try {
      return right(await datasource.getAllEmpresa());
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de grupos"));
    }
  }

  @override
  Future<Either<Failure, EmpresasEntity>> insertEmpresas(
      EmpresasModel emp) async {
    try {
      return right(await datasource.insertEmpresas(emp));
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de grupos"));
    }
  }

  @override
  Future<Either<Failure, EmpresasEntity>> anularEmpresas(
      EmpresasModel emp) async {
    try {
      return right(await datasource.anularEmpresas(emp));
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de grupos"));
    }
  }

  @override
  Future<Either<Failure, EmpresasEntity>> updateEmpresas(
      EmpresasModel emp) async {
    try {
      return right(await datasource.updateEmpresas(emp));
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de grupos"));
    }
  }
}
