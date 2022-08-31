import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tesis/data/datasource/url.dart';
import 'package:tesis/data/models/usuarios/usuariosModel.dart';
import 'package:tesis/domain/entities/usuarios/usuariosEntity.dart';

abstract class UsuarioDTS {
  Future<List<UsuariEntity>> getAllUsuarios();
  Future<UsuariEntity> insertUsuarios(UsuarioModel us);
  Future<UsuariEntity> getUsuario(String usuario);
}

class UsuarioDTSImp extends UsuarioDTS {
  final http.Client cliente;
  UsuarioDTSImp(this.cliente);

  String urlBase = "${UrlBase.url}usuarios";

  @override
  Future<List<UsuariEntity>> getAllUsuarios() async {
    try {
      List<UsuarioModel> tem = [];
      final result = await cliente.get(Uri.parse(urlBase));
      if (result.statusCode == 200) {
        tem = decodeUsuario(utf8.decode(result.bodyBytes));
      }

      return tem;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<UsuariEntity> getUsuario(String usuario) async {
    UsuarioModel usuarioModel = UsuarioModel();
    try {
      final result = await cliente.get(Uri.parse("$urlBase/login/$usuario"));
      if (result.statusCode == 200) {
        return UsuarioModel.fromMap(json.decode(result.body));
      }

      return usuarioModel;
    } catch (e) {
      return usuarioModel;
    }
  }

  @override
  Future<UsuariEntity> insertUsuarios(UsuarioModel us) async {
    UsuarioModel usuario = UsuarioModel();
    try {
      var grp = json.encode(us.toMap());

      final result = await cliente.post(Uri.parse(urlBase),
          body: grp, headers: {"Content-type": "application/json"});
      if (result.statusCode == 200) {
        return UsuarioModel.fromMap(json.decode(result.body));
      }

      return usuario;
    } catch (e) {
      return usuario;
    }
  }

  List<UsuarioModel> decodeUsuario(String respuesta) {
    var parseo = jsonDecode(respuesta);
    return parseo
        .map<UsuarioModel>((json) => UsuarioModel.fromMap(json))
        .toList();
  }
}
