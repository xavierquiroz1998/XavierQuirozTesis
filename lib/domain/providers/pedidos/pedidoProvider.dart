import 'package:flutter/cupertino.dart';
import 'package:tesis/domain/entities/pedidos/pedidosEntity.dart';
import 'package:tesis/domain/uses%20cases/pedidos/pedidosGeneral.dart';
import 'package:universal_html/html.dart';

class PedidoProvider extends ChangeNotifier {
  final PedidosGeneral _cososUsos;
  PedidoProvider(this._cososUsos);
TextEditingController ctObs = TextEditingController();
  List<PedidoEntity> list = [];

  Future getPedidos() async {
    try {
      var temp = await _cososUsos.getAllPedidos();
      list = temp.getOrElse(() => []);
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future insertPedidos() async {
    try {
      PedidoEntity entity = PedidoEntity();
      entity.estado = "A";
         entity.observacion = ctObs.text;
      entity.fecha = DateTime.now();

      var temp = await _cososUsos.insertPedidos(entity);
    } catch (e) {
      print(e.toString());
    }
  }
}
