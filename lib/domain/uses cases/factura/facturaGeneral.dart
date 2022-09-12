import 'package:dartz/dartz.dart';
import 'package:tesis/core/Errors/failure.dart';
import 'package:tesis/data/models/facturas/facturaDetModel.dart';
import 'package:tesis/data/models/facturas/facturaModel.dart';
import 'package:tesis/domain/entities/facturas/facturaDetEntity.dart';
import 'package:tesis/domain/entities/facturas/facturaEntity.dart';
import 'package:tesis/domain/repositories/facturas/abstractFactura.dart';

class FacturaGeneral {
  final AbstractFactura repository;
  FacturaGeneral(this.repository);

  Future<Either<Failure, List<FacturaEntity>>> getAllFactura() {
    return repository.getAllFactura();
  }

  Future<Either<Failure, FacturaEntity>> insertFactura(FacturaModel model) {
    return repository.insertFactura(model);
  }

  Future<Either<Failure, FacturaEntity>> anularFactura(FacturaModel model) {
    return repository.anularFactura(model);
  }

  Future<Either<Failure, FacturaDetEntity>> insertDetFactura(
      FacturaDetModel model) {
    return repository.insertDetFactura(model);
  }

  Future<Either<Failure, List<FacturaDetEntity>>> getFacturaById(
      int idFactura) {
    return repository.getFacturaById(idFactura);
  }
}
