import 'package:dartz/dartz.dart';
import 'package:tesis/core/Errors/failure.dart';
import 'package:tesis/data/models/menu/menuModel.dart';
import 'package:tesis/domain/entities/menu/menuEntity.dart';

abstract class AbstractMenu {
  Future<Either<Failure, List<MenuEntity>>> getAllMenu();
  Future<Either<Failure, MenuEntity>> insertMenu(MenuModel dep);
}
