import 'package:flutter/cupertino.dart';
import 'package:tesis/data/models/menu/menuModel.dart';
import 'package:tesis/data/models/usuarios/usuariosModel.dart';
import 'package:tesis/domain/entities/menu/menuEntity.dart';
import 'package:tesis/domain/entities/usuarios/usuariosEntity.dart';
import 'package:tesis/domain/uses%20cases/menu/menuGeneral.dart';
import 'package:tesis/domain/uses%20cases/usuarios/usuariosGeneral.dart';

class UsuarioProvider extends ChangeNotifier {
  final UsuariosGeneral _casosUsosUsuario;
  final MenuGeneral _casosUsosMenu;

  UsuarioProvider(this._casosUsosUsuario, this._casosUsosMenu);

  List<UsuariEntity> lisUsuarios = [];

  TextEditingController ctrUsuario = TextEditingController();
  TextEditingController ctrNombres = TextEditingController();
  TextEditingController ctrIdentifiacion = TextEditingController();
  TextEditingController ctrDomicilio = TextEditingController();
  TextEditingController ctrCorreo = TextEditingController();
  TextEditingController ctrCelular = TextEditingController();
  TextEditingController ctrContrasenia = TextEditingController();

  UsuariEntity entity = UsuariEntity();

  Future getUsuarios() async {
    try {
      var temp = await _casosUsosUsuario.getAllUsuarios();
      lisUsuarios = temp.getOrElse(() => []);
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  void limpiar() {
    ctrUsuario = TextEditingController();
    ctrNombres = TextEditingController();
    ctrIdentifiacion = TextEditingController();
    ctrDomicilio = TextEditingController();
    ctrCorreo = TextEditingController();
    ctrCelular = TextEditingController();
    ctrContrasenia = TextEditingController();
    entity = UsuariEntity();
  }

  void setUsuario() {
    try {
      ctrUsuario = TextEditingController(text: entity.usuario);
      ctrNombres = TextEditingController(text: entity.nombres);
      ctrIdentifiacion = TextEditingController(text: entity.identificacion);
      ctrDomicilio = TextEditingController(text: entity.domicilio);
      ctrCorreo = TextEditingController(text: entity.correo);
      ctrCelular = TextEditingController(text: entity.celular);
      ctrContrasenia = TextEditingController(text: entity.contrasenia);
    } catch (e) {}
  }

  Future anular(UsuariEntity uss) async {
    try {
      UsuarioModel usua = UsuarioModel();
      usua.id = uss.id;

      var result = await _casosUsosUsuario.anularUsuarios(usua);
      try {
        var entity = result.getOrElse(() => UsuariEntity());
        if (entity.id != 0) {
          await getUsuarios();
        }
      } catch (e) {
        print("${e.toString()} flujo secundario");
      }
    } catch (e) {
      print("${e.toString()} flujo principal");
    }
  }

  Future guardar(List<MenuEntity> lisMenu) async {
    try {
      UsuarioModel model = UsuarioModel();
      model.usuario = ctrUsuario.text;
      model.nombres = ctrNombres.text;
      model.identificacion = ctrIdentifiacion.text;
      model.domicilio = ctrDomicilio.text;
      model.celular = ctrCelular.text;
      model.correo = ctrCorreo.text;
      model.estado = "A";
      model.fechaTrans = DateTime.now();
      model.usuarioCreacion = 0;
      model.contrasenia = ctrContrasenia.text;

      var resultEmp = await _casosUsosUsuario.insertUsuarios(model);

      try {
        entity = resultEmp as UsuariEntity;

        if (entity.id > 0) {
          // guarda permisos del usuario
          lisMenu.forEach((element) {
            element.idUsuario = entity.id;
            _casosUsosMenu.insertMenu(element as MenuModel);
          });
        }
      } catch (e) {}
    } catch (e) {
      print(e.toString());
    }
  }
}
