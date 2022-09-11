import 'package:dartz/dartz.dart';
import 'package:tesis/core/Errors/failure.dart';
import 'package:tesis/data/models/usuarios/usuariosModel.dart';
import 'package:tesis/domain/entities/usuarios/usuariosEntity.dart';

abstract class AbstractUsuarios {
  Future<Either<Failure, List<UsuariEntity>>> getAllUsuarios();
  Future<Either<Failure, UsuariEntity>> insertUsuarios(UsuarioModel uss);
  Future<Either<Failure, UsuariEntity>> anularUsuarios(UsuarioModel uss);
  Future<Either<Failure, UsuariEntity>> getUsuario(String usuario);
}
