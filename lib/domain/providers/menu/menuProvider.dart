import 'package:flutter/cupertino.dart';
import 'package:tesis/domain/entities/menu/menuEntity.dart';
import 'package:tesis/domain/uses%20cases/menu/menuGeneral.dart';

class MenuProvider extends ChangeNotifier {
  final MenuGeneral _usesCasesMenu;

  MenuProvider(this._usesCasesMenu);

  List<MenuEntity> lisMenu = [];

  void getMenu() async {
    try {
      var temp = await _usesCasesMenu.getAllMenu();

      lisMenu = temp.getOrElse(() => []);
      notifyListeners();
    } catch (e) {}
  }

  void notificar() {
    notifyListeners();
  }
}
