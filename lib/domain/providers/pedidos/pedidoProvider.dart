import 'package:flutter/cupertino.dart';
import 'package:tesis/data/models/pedidos/pedidoModel.dart';
import 'package:tesis/domain/entities/pedidos/pedidosDetEntity.dart';
import 'package:tesis/domain/entities/pedidos/pedidosEntity.dart';
import 'package:tesis/domain/entities/productos/productosEntity.dart';
import 'package:tesis/domain/uses%20cases/pedidos/pedidosGeneral.dart';
import 'package:tesis/domain/uses%20cases/productos/productosGeneral.dart';
import 'package:universal_html/html.dart';

class PedidoProvider extends ChangeNotifier {
  final PedidosGeneral _cososUsos;
  final ProductosGeneral _casosUsesProductos;
  PedidoProvider(this._cososUsos, this._casosUsesProductos);
  TextEditingController ctObs = TextEditingController();
  List<PedidoEntity> list = [];
  List<ProductosEntity> listProducto = [];

  List<PedidoDetEntity> listdetalle = [];

  Future getPedidos() async {
    try {
      var temp = await _cososUsos.getAllPedidos();
      list = temp.getOrElse(() => []);
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future getProductos() async {
    try {
      var temp = await _casosUsesProductos.getAll();
      listProducto = temp.getOrElse(() => []);

      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  void iniciar() {
    ctObs = TextEditingController();
    listdetalle = [];
    listdetalle.add(new PedidoDetEntity());
  }

  void setPedido(PedidoEntity e) async {
    ctObs = TextEditingController(text: e.observacion);
    try {
      var result = await _cososUsos.getPedidoDetById(e.id);
      listdetalle = result.getOrElse(() => []);
      if (listProducto.length == 0) {
        await getProductos();
      }
      for (var element in listdetalle) {
        element.prd =
            listProducto.firstWhere((prd) => prd.id == element.idProducto);
      }
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<bool> anularPedido(PedidoEntity e) async {
    try {
      PedidoModel model = PedidoModel();
      model.id = e.id;
      model.fecha = e.fecha;

      var temp = await _cososUsos.anularPedidos(model);
      try {
        var entity = temp.getOrElse(() => PedidoEntity());
        await getPedidos();
        return true;
      } catch (e) {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> insertPedidos() async {
    try {
      PedidoModel model = PedidoModel();
      model.idCliente = 0;
      model.estado = "A";
      model.observacion = ctObs.text;
      model.fecha = DateTime.now();

      var temp = await _cososUsos.insertPedidos(model);
      try {
        var entity = temp.getOrElse(() => PedidoEntity());
        if (entity.id != 0) {
          list.add(entity);
        }
        // guarda detalle
        notifyListeners();
        return true;
      } catch (e) {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  void calculos() {
    for (var e in listdetalle) {
      if (e.cantidad != 0 && e.precio != 0) {
        e.total = e.cantidad * e.precio;
      }
    }
    notifyListeners();
  }

  void agregarDetalle() {
    listdetalle.add(new PedidoDetEntity());
    notifyListeners();
  }
}
