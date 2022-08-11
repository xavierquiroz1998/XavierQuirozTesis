import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:tesis/data/datasource/departamento/departamentoDts.dart';
import 'package:tesis/data/datasource/empresas/empresasDts.dart';
import 'package:tesis/data/datasource/motivos/motivosDts.dart';
import 'package:tesis/data/datasource/tipoPersona/tipoPersonaDts.dart';
import 'package:tesis/data/repositories/departamentoImp.dart';
import 'package:tesis/domain/providers/Login/LoginProvider.dart';
import 'package:tesis/domain/providers/departamento/departamentoProvider.dart';
import 'package:tesis/domain/repositories/abstractDepartamento.dart';
import 'package:tesis/domain/uses%20cases/Departamento/DepartamentoGeneral.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => LoginProvider());
  sl.registerFactory(() => DepartamentoProvider(sl()));

  sl.registerLazySingleton(() => DepartamentosGeneral(sl()));

  sl.registerLazySingleton<AbstractDepartamento>(() => DepartamentoImp(sl()));

  sl.registerLazySingleton<DepartamentoDTS>(() => DepartamentoDTSImp(sl()));
  sl.registerLazySingleton<EmpresasDTS>(() => EmpresasDTSImp(sl()));
  sl.registerLazySingleton<MotivosDTS>(() => MotivosDTSImp(sl()));
  sl.registerLazySingleton<TipoPersonaDTS>(() => TipoPersonaDTSImp(sl()));

  sl.registerLazySingleton(() => http.Client());
}
