import 'package:dartz/dartz.dart';
import 'package:tesis/core/Errors/failure.dart';
import 'package:tesis/data/models/menu/menuModel.dart';
import 'package:tesis/domain/entities/menu/menuEntity.dart';
import 'package:tesis/domain/repositories/menu/abtractMenu.dart';

class MenuGeneral {
  final AbstractMenu repository;

  MenuGeneral(this.repository);

  Future<Either<Failure, List<MenuEntity>>> getAllMenu() async {
    return await repository.getAllMenu();
  }

  Future<Either<Failure, MenuEntity>> insertMenu(MenuModel model) async {
    return await repository.insertMenu(model);
  }
}
