import 'package:tesis/data/models/facturas/facturaDetModel.dart';
import 'package:tesis/data/models/facturas/facturaModel.dart';
import 'package:dartz/dartz.dart';
import 'package:tesis/core/Errors/failure.dart';
import 'package:tesis/domain/entities/facturas/facturaDetEntity.dart';
import 'package:tesis/domain/entities/facturas/facturaEntity.dart';

abstract class AbstractFactura {
  Future<Either<Failure, List<FacturaEntity>>> getAllFactura();
  Future<Either<Failure, FacturaEntity>> insertFactura(FacturaModel model);
  Future<Either<Failure, FacturaEntity>> anularFactura(FacturaModel model);

  Future<Either<Failure, FacturaDetEntity>> insertDetFactura(
      FacturaDetModel model);
  Future<Either<Failure, List<FacturaDetEntity>>> getFacturaById(int idFactura);
}
