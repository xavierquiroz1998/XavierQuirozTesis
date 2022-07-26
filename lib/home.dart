import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesis/domain/Navigation/NavigationService.dart';
import 'package:tesis/domain/providers/Home/sideMenuProvider.dart';
import 'package:tesis/domain/providers/Login/LoginProvider.dart';
import 'package:tesis/domain/providers/departamento/departamentoProvider.dart';
import 'package:tesis/domain/providers/empresas/empresasProvider.dart';
import 'package:tesis/domain/providers/facturas/facturaProvider.dart';
import 'package:tesis/domain/providers/menu/menuProvider.dart';
import 'package:tesis/domain/providers/motivos/motivosProvider.dart';
import 'package:tesis/domain/providers/pedidos/pedidoProvider.dart';
import 'package:tesis/domain/providers/personas/personasProvider.dart';
import 'package:tesis/domain/providers/productos/productosProvider.dart';
import 'package:tesis/domain/providers/remplazo/remplazoProvider.dart';
import 'package:tesis/domain/providers/usuarios/usuarioProvider.dart';
import 'package:tesis/injection.dart';
import 'package:tesis/ui/Router/FluroRouter.dart';
import 'package:tesis/ui/pages/NavBar/NavBar.dart';
import 'package:tesis/ui/pages/SiderBar/sideBar.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => sl<LoginProvider>()),
        ChangeNotifierProvider(lazy: false, create: (_) => SideMenuProvider()),
        ChangeNotifierProvider(create: (_) => sl<DepartamentoProvider>()),
        ChangeNotifierProvider(create: (_) => sl<EmpresasProvider>()),
        ChangeNotifierProvider(create: (_) => sl<MotivosProvider>()),
        ChangeNotifierProvider(create: (_) => sl<ProductosProvider>()),
        ChangeNotifierProvider(create: (_) => sl<MenuProvider>()),
        ChangeNotifierProvider(create: (_) => sl<UsuarioProvider>()),
        ChangeNotifierProvider(create: (_) => sl<FacturaProvider>()),
        ChangeNotifierProvider(create: (_) => sl<PedidoProvider>()),
        ChangeNotifierProvider(create: (_) => sl<UsuarioProvider>()),
        ChangeNotifierProvider(create: (_) => sl<PersonasProvider>()),
        ChangeNotifierProvider(create: (_) => sl<RemplazoProvider>()),
      ],
      child: MaterialApp(
        title: 'IT-MAS',
        debugShowCheckedModeBanner: false,
        initialRoute: "/login",
        onGenerateRoute: Flurorouter.router.generator,
        navigatorKey: NavigationService.navigatorKey,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        builder: (context1, child) {
          final logeo = Provider.of<LoginProvider>(context1);

          if (logeo.authStatus == AuthStatus.notAuthenticated) {
            return child!;
          } else {
            return HomePage(child: child!);
          }
        },
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SideMenuProvider.menuController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              if (size.width >= 700) SideBar(),
              Expanded(
                child: Column(
                  children: [
                    NavBar(),
                    Expanded(
                      child: widget.child,
                    ),
                  ],
                ),
              )
            ],
          ),
          if (size.width < 700)
            AnimatedBuilder(
              animation: SideMenuProvider.menuController,
              builder: (context, _) => Stack(
                children: [
                  if (SideMenuProvider.menuOpen)
                    Opacity(
                      opacity: SideMenuProvider.opacity.value,
                      child: GestureDetector(
                        onTap: () {
                          SideMenuProvider.closeMenu();
                        },
                        child: Container(
                          width: size.width,
                          height: size.height,
                          color: Colors.black26,
                        ),
                      ),
                    ),
                  Transform.translate(
                    offset: Offset(SideMenuProvider.movimiento.value, 0),
                    child: SideBar(),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
