import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:tesis/data/datasource/reference/local_storage.dart';
import 'package:tesis/data/models/usuarios/usuariosModel.dart';
import 'package:tesis/domain/entities/menu/menuEntity.dart';
import 'package:tesis/domain/uses%20cases/menu/menuGeneral.dart';

class MenuProvider extends ChangeNotifier {
  final MenuGeneral _usesCasesMenu;

  MenuProvider(this._usesCasesMenu);

  List<MenuEntity> lisMenu = [];
  List<MenuEntity> lisMenuPermiso = [];

  Future getMenu() async {
    try {
      var temp = await _usesCasesMenu.getAllMenu();

      lisMenu = temp.getOrElse(() => []);
      notifyListeners();
    } catch (e) {}
  }

  void notificar() {
    notifyListeners();
  }

  Future callgetPermisos() async {
    var usuario = LocalStorage.prefs.getString('usuario');
    var mapUsuario = json.decode(usuario!);
    var temp = await _usesCasesMenu
        .getMenuUsuario(UsuarioModel.fromMap(mapUsuario).id);
    try {
      lisMenuPermiso = temp.getOrElse(() => []);
      if (lisMenu.isEmpty) {
        await getMenu();
      }

      for (var item in lisMenuPermiso) {
        item.descripcion =
            lisMenu.firstWhere((x) => x.id == item.id).descripcion;
      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
    //  var result = temp.fold((fail) => failure(fail), (unidades) => unidades);
  }
}
