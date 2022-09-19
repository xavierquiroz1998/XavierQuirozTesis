import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesis/data/datasource/reference/local_storage.dart';
import 'package:tesis/domain/Navigation/NavigationService.dart';
import 'package:tesis/domain/providers/Home/sideMenuProvider.dart';
import 'package:tesis/domain/providers/Login/LoginProvider.dart';
import 'package:tesis/ui/Router/FluroRouter.dart';
import 'package:tesis/ui/pages/Logo/logo.dart';
import 'package:tesis/ui/pages/SiderBar/sidebarWidgets/menu_item.dart';

class SideBar extends StatefulWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  void initState() {
    //Provider.of<PermisoProvider>(context, listen: false).callgetPermisos();
    super.initState();
  }

  void navigateTo(String routeName) {
    NavigationService.replaceTo(routeName);
    SideMenuProvider.closeMenu();
  }

  @override
  Widget build(BuildContext context) {
    final logeo = Provider.of<LoginProvider>(context);
    //final permiso = Provider.of<PermisoProvider>(context);
    final sideMenuProvider = Provider.of<SideMenuProvider>(context);
    final LocalStorage _prefService = LocalStorage();
    return Container(
      width: 200,
      height: double.infinity,
      decoration: builBoxDecoration(),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          const Logo(),
          const SizedBox(
            height: 30,
          ),
          // for (var value in permiso.listGrupo) ...[
          //   MenuItemP(
          //     text: value.proyecto!.nombre,
          //     icon: UtilView.icons[int.parse(value.proyecto!.referencia)],
          //     onPressed: () async {
          //       navigateTo(value.proyecto!.ruta);
          //       /*      _prefService.createCache(value).whenComplete(() {
          //         Navigator.pushNamed(context, 'dashboard');
          //       }); */
          //     },
          //     isActive: sideMenuProvider.currentPage == value.proyecto!.ruta,
          //   ),
          // ],

          MenuItemP(
            text: 'Inicio',
            icon: Icons.home,
            onPressed: () => NavigationService.navigateTo(Flurorouter.inicio),
            isActive: sideMenuProvider.currentPage == Flurorouter.inicio,
          ),
          MenuItemP(
            text: 'Productos',
            icon: Icons.home,
            onPressed: () =>
                NavigationService.navigateTo(Flurorouter.productoConsulta),
            isActive:
                sideMenuProvider.currentPage == Flurorouter.productoConsulta ||
                    sideMenuProvider.currentPage ==
                        Flurorouter.productoMantenimiento,
          ),
          MenuItemP(
            text: 'Pedido',
            icon: Icons.home,
            onPressed: () =>
                NavigationService.navigateTo(Flurorouter.ordenPedidoConsulta),
            isActive: sideMenuProvider.currentPage ==
                    Flurorouter.ordenPedidoConsulta ||
                sideMenuProvider.currentPage ==
                    Flurorouter.ordenPedidoMantenimiento,
          ),
          MenuItemP(
            text: 'Facturacion',
            icon: Icons.home,
            onPressed: () =>
                NavigationService.navigateTo(Flurorouter.facturaConsulta),
            isActive:
                sideMenuProvider.currentPage == Flurorouter.facturaConsulta ||
                    sideMenuProvider.currentPage ==
                        Flurorouter.facturaMantenimiento,
          ),
          MenuItemP(
            text: 'Personas',
            icon: Icons.home,
            onPressed: () =>
                NavigationService.navigateTo(Flurorouter.personaConsulta),
            isActive:
                sideMenuProvider.currentPage == Flurorouter.personaConsulta ||
                    sideMenuProvider.currentPage ==
                        Flurorouter.personaMantenimiento,
          ),
          MenuItemP(
            text: 'Empresas',
            icon: Icons.home,
            onPressed: () =>
                NavigationService.navigateTo(Flurorouter.empresaConsulta),
            isActive:
                sideMenuProvider.currentPage == Flurorouter.empresaConsulta ||
                    sideMenuProvider.currentPage ==
                        Flurorouter.empresaMantenimiento,
          ),
          MenuItemP(
            text: 'Departamentos',
            icon: Icons.home,
            onPressed: () =>
                NavigationService.navigateTo(Flurorouter.departamentoConsulta),
            isActive: sideMenuProvider.currentPage ==
                    Flurorouter.departamentoConsulta ||
                sideMenuProvider.currentPage ==
                    Flurorouter.departamentoConsulta,
          ),
          MenuItemP(
            text: 'Motivos',
            icon: Icons.home,
            onPressed: () =>
                NavigationService.navigateTo(Flurorouter.motivoConsulta),
            isActive: sideMenuProvider.currentPage ==
                    Flurorouter.motivoConsulta ||
                sideMenuProvider.currentPage == Flurorouter.motivoMantenimiento,
          ),
          // MenuItemP(
          //   text: 'Devolucion de Productos',
          //   icon: Icons.home,
          //   onPressed: () => null,
          //   //isActive: sideMenuProvider.currentPage == Flurorouter.inicio,
          // ),
          MenuItemP(
            text: 'Cambio de productos',
            icon: Icons.home,
            onPressed: () =>
                NavigationService.navigateTo(Flurorouter.cambioConsulta),
            isActive: sideMenuProvider.currentPage ==
                    Flurorouter.cambioConsulta ||
                sideMenuProvider.currentPage == Flurorouter.cambioMantenimiento,
          ),
          MenuItemP(
            text: 'Usuarios',
            icon: Icons.home,
            onPressed: () =>
                NavigationService.navigateTo(Flurorouter.usuariosConsulta),
            isActive:
                sideMenuProvider.currentPage == Flurorouter.usuariosConsulta ||
                    sideMenuProvider.currentPage ==
                        Flurorouter.usuariosMantenimiento,
          ),
          MenuItemP(
            text: 'Reporteria',
            icon: Icons.home,
            onPressed: () =>
                NavigationService.navigateTo(Flurorouter.reporteria),
            isActive: sideMenuProvider.currentPage == Flurorouter.reporteria,
          ),

          MenuItemP(
            text: 'Salir',
            icon: Icons.exit_to_app,
            onPressed: () {
              logeo.lagout();
              NavigationService.navigateTo("/login");
            },
            //isActive: NavigationService.currentPage == Flurorouter.salir,
          ),
        ],
      ),
    );
  }

  BoxDecoration builBoxDecoration() => const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff092044),
            Color(0xff092042),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
          ),
        ],
      );
}
