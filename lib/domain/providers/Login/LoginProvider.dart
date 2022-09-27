import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:tesis/data/datasource/reference/local_storage.dart';
import 'package:tesis/domain/Navigation/NavigationService.dart';
import 'package:tesis/domain/entities/usuarios/usuariosEntity.dart';
import 'package:tesis/domain/uses%20cases/usuarios/usuariosGeneral.dart';
import 'package:tesis/ui/Router/FluroRouter.dart';

enum AuthStatus { checking, authenticated, notAuthenticated }

class LoginProvider extends ChangeNotifier {
  String _cedula = "";
  AuthStatus authStatus = AuthStatus.checking;
  final UsuariosGeneral _casosUsosUsuario;
  String msjError = "";

  LoginProvider(this._casosUsosUsuario) {
    isAuthenticated();
  }
  String get cedula => _cedula;

  bool authenticated = false;

  set cedula(String cedula) {
    _cedula = cedula;
    notifyListeners();
  }

  String _contrasenia = "";

  String get contrasenia => _contrasenia;

  set contrasenia(String contrasenia) {
    _contrasenia = contrasenia;
    notifyListeners();
  }

  Future<bool> logeo() async {
    try {
      msjError = "";
      if (_cedula != "" && _contrasenia != "") {
        var temp = await _casosUsosUsuario.getUsuario(_cedula);

        var usuario = temp.getOrElse(() => UsuariEntity());
        if (usuario.id != 0) {
          if (_contrasenia == usuario.contrasenia) {
            authStatus = AuthStatus.authenticated;
            authenticated = true;
            LocalStorage.prefs.setString('token', "asdddsswwee");
            LocalStorage.prefs
                .setString('usuario', json.encode(usuario.toMap()));
            NavigationService.replaceTo(Flurorouter.inicio);
            notifyListeners();
            return true;
          } else {
             msjError = "Contraseña Incorrecta";
            return false;
          }
        } else {
           msjError = "Usuario no Existe";
          return false;
        }
      }
      return false;
    } catch (e) {
      msjError = e.toString();
      return false;
    }
  }

  Future<void> lagout() async {
    try {
      authenticated = false;
      authStatus = AuthStatus.notAuthenticated;
      LocalStorage.prefs.remove('token');
      LocalStorage.prefs.remove('usuario');
      notifyListeners();
    } catch (ex) {}
  }

  Future<bool> isAuthenticated() async {
    final token = LocalStorage.prefs.getString('token');
    LocalStorage.prefs.getString('usuario');

    if (token == null) {
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    } else {
      authStatus = AuthStatus.authenticated;
      notifyListeners();
      return true;
    }

    // try {

    // } catch (e) {
    //   authStatus = AuthStatus.notAuthenticated;
    //   notifyListeners();
    //   return false;
    // }
  }
}
