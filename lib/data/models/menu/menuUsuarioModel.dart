import 'dart:convert';

class MenuUsuarioModel {
  MenuUsuarioModel({
    this.idMenu = 0,
    this.idUsuario = 0,
    this.create = false,
    this.update = false,
    this.delete = false,
    this.ruta = "",
  });

  int idMenu;
  int idUsuario;
  bool create;
  bool update;
  bool delete;
  String ruta;

  factory MenuUsuarioModel.fromJson(String str) =>
      MenuUsuarioModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MenuUsuarioModel.fromMap(Map<String, dynamic> json) =>
      MenuUsuarioModel(
        idMenu: json["id_menu"],
        idUsuario: json["id_usuario"],
        create: json["create"],
        update: json["update"],
        delete: json["delete"],
        ruta: json["ruta"],
      );

  Map<String, dynamic> toMap() => {
        "id_menu": idMenu,
        "id_usuario": idUsuario,
        "create": create,
        "update": update,
        "delete": delete,
        "ruta": ruta,
      };
}
