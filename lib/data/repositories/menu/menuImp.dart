import 'package:tesis/core/Errors/exceptions.dart';
import 'package:tesis/data/datasource/menu/menuDts.dart';
import 'package:tesis/data/models/menu/menuUsuarioModel.dart';
import 'package:tesis/domain/entities/menu/menuEntity.dart';
import 'package:tesis/data/models/menu/menuModel.dart';
import 'package:tesis/core/Errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tesis/domain/repositories/menu/abtractMenu.dart';

class MenuImp extends AbstractMenu {
  final MenuDTS datasource;

  MenuImp(this.datasource);

  @override
  Future<Either<Failure, List<MenuEntity>>> getAllMenu() async {
    try {
      return right(await datasource.getAllMenu());
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de grupos"));
    }
  }

  @override
  Future<Either<Failure, MenuUsuarioModel>> insertMenu(MenuUsuarioModel dep) async {
    try {
      return right(await datasource.insertMenu(dep));
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de grupos"));
    }
  }

  @override
  Future<Either<Failure, List<MenuEntity>>> getMenu_x_usuario(
      int idUsuario) async {
    try {
      return right(await datasource.getMenu_x_usuario(idUsuario));
    } on ServerException {
      return left(ServerFailure(mensaje: "Error al obtener lista de grupos"));
    }
  }
}
