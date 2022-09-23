import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';
import 'package:tesis/domain/providers/Home/sideMenuProvider.dart';
import 'package:tesis/domain/providers/Login/LoginProvider.dart';
import 'package:tesis/ui/Router/FluroRouter.dart';
import 'package:tesis/ui/pages/404/noFound.dart';
import 'package:tesis/ui/pages/Facturacion/facturaCon.dart';
import 'package:tesis/ui/pages/Facturacion/facturaMant.dart';
import 'package:tesis/ui/pages/Report/tiposReport.dart';
import 'package:tesis/ui/pages/cambioProducto/cambioPrdCons.dart';
import 'package:tesis/ui/pages/cambioProducto/cambioPrdModi.dart';
import 'package:tesis/ui/pages/departamento/departamentosCon.dart';
import 'package:tesis/ui/pages/departamento/departamentosMant.dart';
import 'package:tesis/ui/pages/empresa/empresasCon.dart';
import 'package:tesis/ui/pages/empresa/empresasMant.dart';
import 'package:tesis/ui/pages/home/inicio.dart';
import 'package:tesis/ui/pages/login/Login.dart';
import 'package:tesis/ui/pages/motivo/motivosCon.dart';
import 'package:tesis/ui/pages/motivo/motivosMant.dart';
import 'package:tesis/ui/pages/ordenPedido/ordenPedidoCon.dart';
import 'package:tesis/ui/pages/ordenPedido/ordenPedidoMant.dart';
import 'package:tesis/ui/pages/person/personaCon.dart';
import 'package:tesis/ui/pages/person/personaMant.dart';
import 'package:tesis/ui/pages/product/productosCon.dart';
import 'package:tesis/ui/pages/product/productosMant.dart';
import 'package:tesis/ui/pages/usuarios/userCon.dart';
import 'package:tesis/ui/pages/usuarios/userMant.dart';

class Handlers {
  static Handler login = Handler(handlerFunc: (context, param) {
    // validacion de sesion
    return LoginView();
  });

  static Handler inicio = Handler(handlerFunc: (context, param) {
    // validacion de sesion
    final logeo = Provider.of<LoginProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.inicio);
    if (logeo.authStatus == AuthStatus.authenticated) {
      return Inicio();
    } else {
      return LoginView();
    }
  });

  static Handler productoMantenimiento = Handler(handlerFunc: (context, param) {
    // validacion de sesion
    final logeo = Provider.of<LoginProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.productoMantenimiento);
    if (logeo.authStatus == AuthStatus.authenticated) {
      return const ProductosMantenimiento();
    } else {
      return const LoginView();
    }
  });

  static Handler productoConsulta = Handler(handlerFunc: (context, param) {
    // validacion de sesion
    final logeo = Provider.of<LoginProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.productoConsulta);
    if (logeo.authStatus == AuthStatus.authenticated) {
      return const ProductosConsulta();
    } else {
      return const LoginView();
    }
  });

  static Handler empresaConsulta = Handler(handlerFunc: (context, param) {
    // validacion de sesion
    final logeo = Provider.of<LoginProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.empresaConsulta);
    if (logeo.authStatus == AuthStatus.authenticated) {
      return const EmpresasConsulta();
    } else {
      return const LoginView();
    }
  });
  static Handler empresaMantenimiento = Handler(handlerFunc: (context, param) {
    final logeo = Provider.of<LoginProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.empresaMantenimiento);
    if (logeo.authStatus == AuthStatus.authenticated) {
      return const EmpresasMantenimiento();
    } else {
      return const LoginView();
    }
  });

  static Handler departamentoConsulta = Handler(handlerFunc: (context, param) {
    final logeo = Provider.of<LoginProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.departamentoConsulta);
    if (logeo.authStatus == AuthStatus.authenticated) {
      return const DepartamentoConsulta();
    } else {
      return const LoginView();
    }
  });
  static Handler departamentoMantenimiento =
      Handler(handlerFunc: (context, param) {
    final logeo = Provider.of<LoginProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.departamentoMantenimiento);
    if (logeo.authStatus == AuthStatus.authenticated) {
      return const DepartamentoMantenimiento();
    } else {
      return const LoginView();
    }
  });

  static Handler motivoConsulta = Handler(handlerFunc: (context, param) {
    final logeo = Provider.of<LoginProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.motivoConsulta);
    if (logeo.authStatus == AuthStatus.authenticated) {
      return const MotivosConsulta();
    } else {
      return const LoginView();
    }
  });

  static Handler motivoMantenimiento = Handler(handlerFunc: (context, param) {
    final logeo = Provider.of<LoginProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.motivoMantenimiento);
    if (logeo.authStatus == AuthStatus.authenticated) {
      return const MotivoMantenimiento();
    } else {
      return const LoginView();
    }
  });

  static Handler personaConsulta = Handler(handlerFunc: (context, param) {
    final logeo = Provider.of<LoginProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.personaConsulta);
    if (logeo.authStatus == AuthStatus.authenticated) {
      return const PersonaConsulta();
    } else {
      return const LoginView();
    }
  });

  static Handler personaMantenimiento = Handler(handlerFunc: (context, param) {
    final logeo = Provider.of<LoginProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.personaMantenimiento);
    if (logeo.authStatus == AuthStatus.authenticated) {
      return const PersonaMantenimiento();
    } else {
      return const LoginView();
    }
  });

  static Handler usuariosConsulta = Handler(handlerFunc: (context, param) {
    final logeo = Provider.of<LoginProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.usuariosConsulta);
    if (logeo.authStatus == AuthStatus.authenticated) {
      return const UsuarioConsulta();
    } else {
      return const LoginView();
    }
  });

  static Handler usuariosMantenimiento = Handler(handlerFunc: (context, param) {
    final logeo = Provider.of<LoginProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.usuariosMantenimiento);
    if (logeo.authStatus == AuthStatus.authenticated) {
      return const UsuarioMantenimiento();
    } else {
      return const LoginView();
    }
  });

  static Handler ordenConsulta = Handler(handlerFunc: (context, param) {
    final logeo = Provider.of<LoginProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.ordenPedidoConsulta);
    if (logeo.authStatus == AuthStatus.authenticated) {
      return const OrdenPedidoConsulta();
    } else {
      return const LoginView();
    }
  });

  static Handler ordenMantenimiento = Handler(handlerFunc: (context, param) {
    final logeo = Provider.of<LoginProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.ordenPedidoMantenimiento);
    if (logeo.authStatus == AuthStatus.authenticated) {
      return const OrdenPedidoMantenimiento();
    } else {
      return const LoginView();
    }
  });

  static Handler facturaConsulta = Handler(handlerFunc: (context, param) {
    final logeo = Provider.of<LoginProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.facturaConsulta);
    if (logeo.authStatus == AuthStatus.authenticated) {
      return const FacturaConsulta();
    } else {
      return const LoginView();
    }
  });

  static Handler facturaMantenimiento = Handler(handlerFunc: (context, param) {
    final logeo = Provider.of<LoginProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.facturaMantenimiento);
    if (logeo.authStatus == AuthStatus.authenticated) {
      return const FacturaMantenimiento();
    } else {
      return const LoginView();
    }
  });

  static Handler reporteria = Handler(handlerFunc: (context, param) {
    final logeo = Provider.of<LoginProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.reporteria);
    if (logeo.authStatus == AuthStatus.authenticated) {
      return const TiposReport();
    } else {
      return const LoginView();
    }
  });

  static Handler cambioConsult = Handler(handlerFunc: (context, param) {
    final logeo = Provider.of<LoginProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.cambioConsulta);
    if (logeo.authStatus == AuthStatus.authenticated) {
      return const CambioPrdConsulta();
    } else {
      return const LoginView();
    }
  });

  static Handler cambioMant = Handler(handlerFunc: (context, param) {
    final logeo = Provider.of<LoginProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.cambioMantenimiento);
    if (logeo.authStatus == AuthStatus.authenticated) {
      return CambioProdMant();
    } else {
      return const LoginView();
    }
  });

  static Handler noFound = Handler(handlerFunc: (context, param) {
    // validacion de sesion

    return NoPageFoundView();
  });
}
