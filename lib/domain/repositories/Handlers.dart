import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';
import 'package:tesis/domain/providers/Home/sideMenuProvider.dart';
import 'package:tesis/domain/providers/Login/LoginProvider.dart';
import 'package:tesis/ui/Router/FluroRouter.dart';
import 'package:tesis/ui/pages/404/noFound.dart';
import 'package:tesis/ui/pages/departamento/departamentosCon.dart';
import 'package:tesis/ui/pages/departamento/departamentosMant.dart';
import 'package:tesis/ui/pages/empresa/empresasCon.dart';
import 'package:tesis/ui/pages/empresa/empresasMant.dart';
import 'package:tesis/ui/pages/home/inicio.dart';
import 'package:tesis/ui/pages/login/Login.dart';
import 'package:tesis/ui/pages/motivo/motivosCon.dart';
import 'package:tesis/ui/pages/motivo/motivosMant.dart';
import 'package:tesis/ui/pages/product/productosCon.dart';
import 'package:tesis/ui/pages/product/productosMant.dart';

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

  static Handler noFound = Handler(handlerFunc: (context, param) {
    // validacion de sesion

    return NoPageFoundView();
  });
}
