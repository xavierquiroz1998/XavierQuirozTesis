import 'package:dartz/dartz.dart';
import 'package:tesis/core/Errors/failure.dart';
import 'package:tesis/data/models/usuarios/usuariosModel.dart';
import 'package:tesis/domain/entities/usuarios/usuariosEntity.dart';
import 'package:tesis/domain/repositories/usuarios/abstractUsuarios.dart';

class UsuariosGeneral {
  final AbstractUsuarios repository;
  UsuariosGeneral(this.repository);

  Future<Either<Failure, List<UsuariEntity>>> getAllUsuarios() {
    return repository.getAllUsuarios();
  }

  Future<Either<Failure, UsuariEntity>> insertUsuarios(UsuarioModel uss) {
    return repository.insertUsuarios(uss);
  }

  Future<Either<Failure, UsuariEntity>> anularUsuarios(UsuarioModel uss) {
    return repository.anularUsuarios(uss);
  }

  Future<Either<Failure, UsuariEntity>> getUsuario(String usuario) {
    return repository.getUsuario(usuario);
  }
}
