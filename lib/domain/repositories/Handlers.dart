import 'package:fluro/fluro.dart';
import 'package:tesis/ui/pages/404/noFound.dart';
import 'package:tesis/ui/pages/login/Login.dart';

class Handlers {
  static Handler login = Handler(handlerFunc: (context, param) {
    // validacion de sesion
    return LoginView();
  });

  static Handler noFound = Handler(handlerFunc: (context, param) {
    // validacion de sesion

    return NoPageFoundView();
  });
}
