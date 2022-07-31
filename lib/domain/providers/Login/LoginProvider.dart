import 'package:flutter/cupertino.dart';
import 'package:tesis/data/datasource/reference/local_storage.dart';
import 'package:tesis/domain/Navigation/NavigationService.dart';
import 'package:tesis/ui/Router/FluroRouter.dart';

enum AuthStatus { checking, authenticated, notAuthenticated }

class LoginProvider extends ChangeNotifier {
  String _cedula = "";
  AuthStatus authStatus = AuthStatus.checking;

  LoginProvider() {
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
  //no guardas el tyoken? no
  //necesitas el sharedpreference si pero quiero hacer la inseercion de datos
  //cual inserncion de datos? todos
  //Los datos que tienes que usar para el logeo son estos
  /// http://localhost:8080/api/auth/login?correo=jesusvera19_24@hotmail.com&password=123456
  /// esa es la ruta que necesitas con em metodo de tipo POST
  /// de ahi para validar el token necesitas esta ruta
  /// pero lo tienes en mongo db
  /// y quien va  asaber que estas consumiendo los usuarios de mongo db
  /// si pero debo abrir el mongo db y no se usar bien eso
  /// explicame
  /// https://flutter-web-admin-odontograma.herokuapp.com/api

  Future<void> logeo() async {
    try {
      authStatus = AuthStatus.authenticated;
      authenticated = true;
      notifyListeners();
      NavigationService.replaceTo(Flurorouter.inicio);
    } catch (e) {}
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
