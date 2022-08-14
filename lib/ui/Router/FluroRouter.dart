import 'package:fluro/fluro.dart';
import 'package:tesis/domain/repositories/Handlers.dart';

class Flurorouter {
  static final FluroRouter router = FluroRouter();

  static String login = "/login";
  static String inicio = "/inicio";

  static String productoMantenimiento = "/producto";
  static String productoConsulta = "/productos";

  static String empresaConsulta = "/empresas";
  static String empresaMantenimiento = "/empresa";

  static String departamentoConsulta = "/departamentos";
  static String departamentoMantenimiento = "/departamento";

  static String motivoConsulta = "/motivos";
  static String motivoMantenimiento = "/motivo";

  static String personaConsulta = "/personas";
  static String personaMantenimiento = "/persona";

  static String usuariosConsulta = "/usuarios";
  static String usuariosMantenimiento = "/usuario";

  static String ordenPedidoConsulta = "/ordenes";
  static String ordenPedidoMantenimiento = "/orden";

  static String facturaConsulta = "/facturas";
  static String facturaMantenimiento = "/factura";

  static void configureRoutes() {
    router.define(login,
        handler: Handlers.login, transitionType: TransitionType.fadeIn);

    router.define(inicio,
        handler: Handlers.inicio, transitionType: TransitionType.fadeIn);

    router.define(productoMantenimiento,
        handler: Handlers.productoMantenimiento,
        transitionType: TransitionType.fadeIn);

    router.define(productoConsulta,
        handler: Handlers.productoConsulta,
        transitionType: TransitionType.fadeIn);

    router.define(empresaConsulta,
        handler: Handlers.empresaConsulta,
        transitionType: TransitionType.fadeIn);

    router.define(empresaMantenimiento,
        handler: Handlers.empresaMantenimiento,
        transitionType: TransitionType.fadeIn);

    router.define(departamentoConsulta,
        handler: Handlers.departamentoConsulta,
        transitionType: TransitionType.fadeIn);

    router.define(departamentoMantenimiento,
        handler: Handlers.departamentoMantenimiento,
        transitionType: TransitionType.fadeIn);

    router.define(motivoConsulta,
        handler: Handlers.motivoConsulta,
        transitionType: TransitionType.fadeIn);

    router.define(motivoMantenimiento,
        handler: Handlers.motivoMantenimiento,
        transitionType: TransitionType.fadeIn);

    router.define(personaConsulta,
        handler: Handlers.personaConsulta,
        transitionType: TransitionType.fadeIn);

    router.define(personaMantenimiento,
        handler: Handlers.personaMantenimiento,
        transitionType: TransitionType.fadeIn);

    router.define(usuariosConsulta,
        handler: Handlers.usuariosConsulta,
        transitionType: TransitionType.fadeIn);

    router.define(usuariosMantenimiento,
        handler: Handlers.usuariosMantenimiento,
        transitionType: TransitionType.fadeIn);

    router.define(ordenPedidoConsulta,
        handler: Handlers.ordenConsulta, transitionType: TransitionType.fadeIn);

    router.define(ordenPedidoMantenimiento,
        handler: Handlers.ordenMantenimiento,
        transitionType: TransitionType.fadeIn);

    router.define(facturaConsulta,
        handler: Handlers.facturaConsulta,
        transitionType: TransitionType.fadeIn);

    router.define(facturaMantenimiento,
        handler: Handlers.facturaMantenimiento,
        transitionType: TransitionType.fadeIn);

    router.notFoundHandler = Handlers.noFound;
  }
}
