import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:tesis/data/datasource/departamento/departamentoDts.dart';
import 'package:tesis/data/datasource/empresas/empresasDts.dart';
import 'package:tesis/data/datasource/motivos/motivosDts.dart';
import 'package:tesis/data/datasource/productos/productosDts.dart';
import 'package:tesis/data/datasource/tipoPersona/tipoPersonaDts.dart';
import 'package:tesis/data/repositories/departamentoImp.dart';
import 'package:tesis/data/repositories/empresas/empresasImp.dart';
import 'package:tesis/data/repositories/motivos/motivosImp.dart';
import 'package:tesis/data/repositories/productos/productosImo.dart';
import 'package:tesis/data/repositories/tipoPersonas/tipoPErsonaImp.dart';
import 'package:tesis/domain/providers/Login/LoginProvider.dart';
import 'package:tesis/domain/providers/departamento/departamentoProvider.dart';
import 'package:tesis/domain/providers/empresas/empresasProvider.dart';
import 'package:tesis/domain/providers/motivos/motivosProvider.dart';
import 'package:tesis/domain/providers/productos/productosProvider.dart';
import 'package:tesis/domain/repositories/abstractDepartamento.dart';
import 'package:tesis/domain/repositories/empresas/abtractEmpresas.dart';
import 'package:tesis/domain/repositories/motivos/abstractMotivos.dart';
import 'package:tesis/domain/repositories/productos/abstractProductos.dart';
import 'package:tesis/domain/repositories/tipoPersona/abstractTipoPersonas.dart';
import 'package:tesis/domain/uses%20cases/Departamento/DepartamentoGeneral.dart';
import 'package:tesis/domain/uses%20cases/empresas/empresasGeneral.dart';
import 'package:tesis/domain/uses%20cases/motivos/motivosGeneral.dart';
import 'package:tesis/domain/uses%20cases/productos/productosGeneral.dart';
import 'package:tesis/domain/uses%20cases/tipoPersonas/tipoPersonaGeneral.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // provide
  sl.registerFactory(() => LoginProvider());
  sl.registerFactory(() => DepartamentoProvider(sl()));
  sl.registerFactory(() => EmpresasProvider(sl()));
  sl.registerFactory(() => MotivosProvider(sl()));
  sl.registerFactory(() => ProductosProvider(sl()));

// casos de uso
  sl.registerLazySingleton(() => DepartamentosGeneral(sl()));
  sl.registerLazySingleton(() => EmpresasGeneral(sl()));
  sl.registerLazySingleton(() => MotivosGeneral(sl()));
  sl.registerLazySingleton(() => TipoPersonaGeneral(sl()));
  sl.registerLazySingleton(() => ProductosGeneral(sl()));

// repository
  sl.registerLazySingleton<AbstractDepartamento>(() => DepartamentoImp(sl()));
  sl.registerLazySingleton<AbstractEmpresas>(() => EmpresasImp(sl()));
  sl.registerLazySingleton<AbstractMotivos>(() => MotivosImp(sl()));
  sl.registerLazySingleton<AbstractTipoPersonas>(() => TipoPersonaImp(sl()));
  sl.registerLazySingleton<AbstractProductos>(() => ProductosImp(sl()));

// datasource
  sl.registerLazySingleton<DepartamentoDTS>(() => DepartamentoDTSImp(sl()));
  sl.registerLazySingleton<EmpresasDTS>(() => EmpresasDTSImp(sl()));
  sl.registerLazySingleton<MotivosDTS>(() => MotivosDTSImp(sl()));
  sl.registerLazySingleton<TipoPersonaDTS>(() => TipoPersonaDTSImp(sl()));
  sl.registerLazySingleton<ProductosDTS>(() => ProductoDTSImp(sl()));

  sl.registerLazySingleton(() => http.Client());
}
