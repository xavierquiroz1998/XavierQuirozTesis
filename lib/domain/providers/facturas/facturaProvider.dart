import 'package:flutter/cupertino.dart';
import 'package:tesis/data/models/facturas/facturaModel.dart';
import 'package:tesis/domain/entities/facturas/facturaEntity.dart';
import 'package:tesis/domain/entities/pedidos/pedidosDetEntity.dart';
import 'package:tesis/domain/entities/pedidos/pedidosEntity.dart';
import 'package:tesis/domain/entities/personas/personasEntity.dart';
import 'package:tesis/domain/entities/productos/productosEntity.dart';
import 'package:tesis/domain/uses%20cases/factura/facturaGeneral.dart';
import 'package:tesis/domain/uses%20cases/pedidos/pedidosGeneral.dart';
import 'package:tesis/domain/uses%20cases/personas/personasGeneral.dart';
import 'package:tesis/domain/uses%20cases/productos/productosGeneral.dart';

class FacturaProvider extends ChangeNotifier {
  final FacturaGeneral _cososUsos;
  final PedidosGeneral _cososUsosPedidos;
  final ProductosGeneral _casosUsesProductos;
  final PersonasGeneral _casosdeUsoPersona;

  FacturaProvider(this._cososUsos, this._cososUsosPedidos,
      this._casosUsesProductos, this._casosdeUsoPersona);

  List<FacturaEntity> list = [];
  List<PedidoEntity> listPedidos = [];
  List<ProductosEntity> listProducto = [];
  List<PersonaEntity> listPersonas = [];
  List<PedidoDetEntity> listdetalle = [];

  TextEditingController ctObs = TextEditingController();

  Future getFactura() async {
    try {
      var temp = await _cososUsos.getAllFactura();
      list = temp.getOrElse(() => []);
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future getPedidos() async {
    try {
      var temp = await _cososUsosPedidos.getAllPedidos();
      listPedidos = temp.getOrElse(() => []);
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

  Future getPersonas() async {
    try {
      var temp = await _casosdeUsoPersona.getAllPersonas();
      listPersonas = temp.getOrElse(() => []);
      // tipo 3 proveedor
      listPersonas =
          listPersonas.where((element) => element.tipo == 3).toList();
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future insertFactura() async {
    try {
      FacturaEntity entity = FacturaEntity();
      entity.estado = "A";
      entity.observacion = ctObs.text;
      entity.fecha = DateTime.now();

      var temp = await _cososUsos.insertFactura(entity as FacturaModel);
    } catch (e) {
      print(e.toString());
    }
  }
}
