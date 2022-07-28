import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:tesis/domain/providers/Login/LoginProvider.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => LoginProvider());
}
