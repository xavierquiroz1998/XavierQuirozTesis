import 'package:dartz/dartz.dart';
import 'package:tesis/core/Errors/failure.dart';
import 'package:tesis/data/models/empresas/empresasModel.dart';
import 'package:tesis/domain/entities/empresas/empresasEntity.dart';
import 'package:tesis/domain/repositories/empresas/abtractEmpresas.dart';

class EmpresasGeneral {
  final AbstractEmpresas repository;
  EmpresasGeneral(this.repository);

  Future<Either<Failure, List<EmpresasEntity>>> getAllEmpresas() async {
    return repository.getAllEmpresas();
  }

  Future<Either<Failure, EmpresasEntity>> insertEmpresas(
      EmpresasModel emp) async {
    return repository.insertEmpresas(emp);
  }
}
