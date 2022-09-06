import 'dart:convert';
import 'package:tesis/data/datasource/url.dart';
import 'package:http/http.dart' as http;
import 'package:tesis/data/models/menu/menuModel.dart';
import 'package:tesis/domain/entities/menu/menuEntity.dart';

abstract class MenuDTS {
  Future<List<MenuEntity>> getAllMenu();
  Future<MenuEntity> insertMenu(MenuModel emp);
  Future<List<MenuEntity>> getMenu_x_usuario(int idUsuario);
}

class MenuDTSImp extends MenuDTS {
  final http.Client cliente;
  MenuDTSImp(this.cliente);

  String urlBase = "${UrlBase.url}menu";

  @override
  Future<List<MenuModel>> getAllMenu() async {
    try {
      List<MenuModel> tem = [];
      final result = await cliente.get(Uri.parse(urlBase));
      if (result.statusCode == 200) {
        tem = decodeMenu(utf8.decode(result.bodyBytes));
      }

      return tem;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<MenuModel> insertMenu(MenuModel emp) async {
    MenuModel menu = MenuModel();
    try {
      var grp = json.encode(emp.toMap());

      final result = await cliente.post(Uri.parse(urlBase),
          body: grp, headers: {"Content-type": "application/json"});
      if (result.statusCode == 200) {
        return MenuModel.fromMap(json.decode(result.body));
      }

      return menu;
    } catch (e) {
      return menu;
    }
  }

  List<MenuModel> decodeMenu(String respuesta) {
    var parseo = jsonDecode(respuesta);
    return parseo.map<MenuModel>((json) => MenuModel.fromMap(json)).toList();
  }

  @override
  Future<List<MenuEntity>> getMenu_x_usuario(int idUsuario) async {
    try {
      List<MenuModel> tem = [];
      final result =
          await cliente.get(Uri.parse("$urlBase/permiso/$idUsuario"));
      if (result.statusCode == 200) {
        tem = decodeMenu(utf8.decode(result.bodyBytes));
      }

      return tem;
    } catch (e) {
      return [];
    }
  }
}
