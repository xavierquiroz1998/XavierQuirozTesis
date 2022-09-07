import 'package:tesis/data/models/facturas/facturaModel.dart';
import 'package:dartz/dartz.dart';
import 'package:tesis/core/Errors/failure.dart';
import 'package:tesis/domain/entities/facturas/facturaEntity.dart';

abstract class AbstractFactura {
  Future<Either<Failure, List<FacturaEntity>>> getAllFactura();
  Future<Either<Failure, FacturaEntity>> insertFactura(FacturaModel model);
}
