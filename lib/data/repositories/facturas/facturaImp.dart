import 'package:tesis/core/Errors/exceptions.dart';
import 'package:tesis/data/datasource/facturas/facturaDts.dart';
import 'package:tesis/domain/entities/facturas/facturaDetEntity.dart';
import 'package:tesis/data/models/facturas/facturaDetModel.dart';
import 'package:tesis/domain/entities/facturas/facturaEntity.dart';
import 'package:tesis/data/models/facturas/facturaModel.dart';
import 'package:tesis/core/Errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tesis/domain/repositories/facturas/abstractFactura.dart';

class FacturaImp extends AbstractFactura {
  final FacturaDts datasource;
  FacturaImp(this.datasource);

  @override
  Future<Either<Failure, List<FacturaEntity>>> getAllFactura() async {
    try {
      return right(await datasource.getAllFacturas());
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de facturas"));
    }
  }

  @override
  Future<Either<Failure, FacturaEntity>> insertFactura(
      FacturaModel model) async {
    try {
      return right(await datasource.insertFacturas(model));
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al insertar Factura"));
    }
  }

  @override
  Future<Either<Failure, FacturaEntity>> anularFactura(
      FacturaModel model) async {
    try {
      return right(await datasource.anularFacturas(model));
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al insertar Factura"));
    }
  }

  @override
  Future<Either<Failure, List<FacturaDetEntity>>> getFacturaById(
      int idFactura) async {
    try {
      return right(await datasource.getFacturaById(idFactura));
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de facturas"));
    }
  }

  @override
  Future<Either<Failure, FacturaDetEntity>> insertDetFactura(
      FacturaDetModel model) async {
    try {
      return right(await datasource.insertDetFacturas(model));
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al insertar Factura"));
    }
  }
}
