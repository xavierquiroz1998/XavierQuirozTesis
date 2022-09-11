import 'package:dartz/dartz.dart';
import 'package:tesis/core/Errors/failure.dart';
import 'package:tesis/data/models/empresas/empresasModel.dart';
import 'package:tesis/domain/entities/empresas/empresasEntity.dart';

abstract class AbstractEmpresas {
  Future<Either<Failure, List<EmpresasEntity>>> getAllEmpresas();
  Future<Either<Failure, EmpresasEntity>> insertEmpresas(EmpresasModel emp);
  Future<Either<Failure, EmpresasEntity>> anularEmpresas(EmpresasModel emp);
}
