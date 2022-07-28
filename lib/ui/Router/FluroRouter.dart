import 'package:fluro/fluro.dart';
import 'package:tesis/domain/repositories/Handlers.dart';

class Flurorouter {
  static final FluroRouter router = FluroRouter();

  static String login = "/login";

  static void configureRoutes() {
    router.define(login,
        handler: Handlers.login, transitionType: TransitionType.fadeIn);

    router.notFoundHandler = Handlers.noFound;
  }
}
