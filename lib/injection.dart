import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:tesis/data/datasource/departamento/departamentoDts.dart';
import 'package:tesis/data/datasource/empresas/empresasDts.dart';
import 'package:tesis/data/datasource/facturas/facturaDts.dart';
import 'package:tesis/data/datasource/menu/menuDts.dart';
import 'package:tesis/data/datasource/motivos/motivosDts.dart';
import 'package:tesis/data/datasource/pedidos/pedidosDts.dart';
import 'package:tesis/data/datasource/persona/personaDts.dart';
import 'package:tesis/data/datasource/productos/productosDts.dart';
import 'package:tesis/data/datasource/reemplazo/reemplazoDts.dart';
import 'package:tesis/data/datasource/tipoPersona/tipoPersonaDts.dart';
import 'package:tesis/data/datasource/usuarios/usuariosDts.dart';
import 'package:tesis/data/repositories/departamentoImp.dart';
import 'package:tesis/data/repositories/empresas/empresasImp.dart';
import 'package:tesis/data/repositories/facturas/facturaImp.dart';
import 'package:tesis/data/repositories/menu/menuImp.dart';
import 'package:tesis/data/repositories/motivos/motivosImp.dart';
import 'package:tesis/data/repositories/pedidos/pedidoImp.dart';
import 'package:tesis/data/repositories/personas/personasImp.dart';
import 'package:tesis/data/repositories/productos/productosImo.dart';
import 'package:tesis/data/repositories/remplazo/remplazoImp.dart';
import 'package:tesis/data/repositories/tipoPersonas/tipoPErsonaImp.dart';
import 'package:tesis/data/repositories/usuarios/usuariosImp.dart';
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
import 'package:tesis/domain/repositories/abstractDepartamento.dart';
import 'package:tesis/domain/repositories/empresas/abtractEmpresas.dart';
import 'package:tesis/domain/repositories/facturas/abstractFactura.dart';
import 'package:tesis/domain/repositories/menu/abtractMenu.dart';
import 'package:tesis/domain/repositories/motivos/abstractMotivos.dart';
import 'package:tesis/domain/repositories/pedidos/abstractPedido.dart';
import 'package:tesis/domain/repositories/persona/abstractPersonas.dart';
import 'package:tesis/domain/repositories/productos/abstractProductos.dart';
import 'package:tesis/domain/repositories/reemplazo/abstractRemplazo.dart';
import 'package:tesis/domain/repositories/tipoPersona/abstractTipoPersonas.dart';
import 'package:tesis/domain/repositories/usuarios/abstractUsuarios.dart';
import 'package:tesis/domain/uses%20cases/Departamento/DepartamentoGeneral.dart';
import 'package:tesis/domain/uses%20cases/empresas/empresasGeneral.dart';
import 'package:tesis/domain/uses%20cases/factura/facturaGeneral.dart';
import 'package:tesis/domain/uses%20cases/menu/menuGeneral.dart';
import 'package:tesis/domain/uses%20cases/motivos/motivosGeneral.dart';
import 'package:tesis/domain/uses%20cases/pedidos/pedidosGeneral.dart';
import 'package:tesis/domain/uses%20cases/personas/personasGeneral.dart';
import 'package:tesis/domain/uses%20cases/productos/productosGeneral.dart';
import 'package:tesis/domain/uses%20cases/remplazo/reemplazosGenera.dart';
import 'package:tesis/domain/uses%20cases/tipoPersonas/tipoPersonaGeneral.dart';
import 'package:tesis/domain/uses%20cases/usuarios/usuariosGeneral.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // provide
  sl.registerFactory(() => LoginProvider(sl()));
  sl.registerFactory(() => DepartamentoProvider(sl(), sl()));
  sl.registerFactory(() => EmpresasProvider(sl()));
  sl.registerFactory(() => MotivosProvider(sl()));
  sl.registerFactory(() => ProductosProvider(sl()));
  sl.registerFactory(() => MenuProvider(sl()));
  sl.registerFactory(() => PedidoProvider(sl(), sl(), sl()));
  sl.registerFactory(() => FacturaProvider(sl(), sl(), sl(), sl()));
  sl.registerFactory(() => UsuarioProvider(sl(), sl()));
  sl.registerFactory(() => PersonasProvider(sl(), sl(), sl(), sl()));
  sl.registerFactory(() => RemplazoProvider(sl(),sl(),sl(),sl(),sl()));

// casos de uso
  sl.registerLazySingleton(() => DepartamentosGeneral(sl()));
  sl.registerLazySingleton(() => EmpresasGeneral(sl()));
  sl.registerLazySingleton(() => MotivosGeneral(sl()));
  sl.registerLazySingleton(() => TipoPersonaGeneral(sl()));
  sl.registerLazySingleton(() => ProductosGeneral(sl()));
  sl.registerLazySingleton(() => MenuGeneral(sl()));
  sl.registerLazySingleton(() => UsuariosGeneral(sl()));
  sl.registerLazySingleton(() => PedidosGeneral(sl()));
  sl.registerLazySingleton(() => FacturaGeneral(sl()));
  sl.registerLazySingleton(() => PersonasGeneral(sl()));
  sl.registerLazySingleton(() => ReemplazoGeneral(sl()));

// repository
  sl.registerLazySingleton<AbstractDepartamento>(() => DepartamentoImp(sl()));
  sl.registerLazySingleton<AbstractEmpresas>(() => EmpresasImp(sl()));
  sl.registerLazySingleton<AbstractMotivos>(() => MotivosImp(sl()));
  sl.registerLazySingleton<AbstractTipoPersonas>(() => TipoPersonaImp(sl()));
  sl.registerLazySingleton<AbstractProductos>(() => ProductosImp(sl()));
  sl.registerLazySingleton<AbstractMenu>(() => MenuImp(sl()));
  sl.registerLazySingleton<AbstractUsuarios>(() => UsuariosImp(sl()));
  sl.registerLazySingleton<AbstractPedidos>(() => PedidoImp(sl()));
  sl.registerLazySingleton<AbstractFactura>(() => FacturaImp(sl()));
  sl.registerLazySingleton<AbstractPersonas>(() => PersonasImp(sl()));
  sl.registerLazySingleton<AbstratRemplazo>(() => ReemplazoImp(sl()));

// datasource
  sl.registerLazySingleton<DepartamentoDTS>(() => DepartamentoDTSImp(sl()));
  sl.registerLazySingleton<EmpresasDTS>(() => EmpresasDTSImp(sl()));
  sl.registerLazySingleton<MotivosDTS>(() => MotivosDTSImp(sl()));
  sl.registerLazySingleton<TipoPersonaDTS>(() => TipoPersonaDTSImp(sl()));
  sl.registerLazySingleton<ProductosDTS>(() => ProductoDTSImp(sl()));
  sl.registerLazySingleton<MenuDTS>(() => MenuDTSImp(sl()));
  sl.registerLazySingleton<UsuarioDTS>(() => UsuarioDTSImp(sl()));
  sl.registerLazySingleton<PedidosDts>(() => PedidosDtsImp(sl()));
  sl.registerLazySingleton<FacturaDts>(() => FacturaDtsImp(sl()));
  sl.registerLazySingleton<PersonaDts>(() => PersonaDtsImp(sl()));
  sl.registerLazySingleton<RemplazoDTS>(() => ReemplazoDtsImp(sl()));

  sl.registerLazySingleton(() => http.Client());
}
