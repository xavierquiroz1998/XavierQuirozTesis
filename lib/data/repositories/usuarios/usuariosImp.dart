import 'package:tesis/core/Errors/exceptions.dart';
import 'package:tesis/data/datasource/usuarios/usuariosDts.dart';
import 'package:tesis/domain/entities/usuarios/usuariosEntity.dart';
import 'package:tesis/data/models/usuarios/usuariosModel.dart';
import 'package:tesis/core/Errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tesis/domain/repositories/usuarios/abstractUsuarios.dart';

class UsuariosImp extends AbstractUsuarios {
  final UsuarioDTS datasource;

  UsuariosImp(this.datasource);

  @override
  Future<Either<Failure, List<UsuariEntity>>> getAllUsuarios() async {
    try {
      return right(await datasource.getAllUsuarios());
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de grupos"));
    }
  }

  @override
  Future<Either<Failure, UsuariEntity>> getUsuario(String usuario) async {
    try {
      return right(await datasource.getUsuario(usuario));
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de grupos"));
    }
  }

  @override
  Future<Either<Failure, UsuariEntity>> insertUsuarios(UsuarioModel uss) async {
    try {
      return right(await datasource.insertUsuarios(uss));
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de grupos"));
    }
  }

  @override
  Future<Either<Failure, UsuariEntity>> anularUsuarios(UsuarioModel uss) async {
    try {
      return right(await datasource.anularUsuarios(uss));
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de grupos"));
    }
  }
}
