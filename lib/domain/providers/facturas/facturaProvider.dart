import 'package:flutter/cupertino.dart';
import 'package:tesis/data/models/facturas/facturaDetModel.dart';
import 'package:tesis/data/models/facturas/facturaModel.dart';
import 'package:tesis/domain/entities/facturas/facturaDetEntity.dart';
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
  List<FacturaDetEntity> listDetalles = [];
  List<PedidoEntity> listPedidos = [];
  List<ProductosEntity> listProducto = [];
  List<PersonaEntity> listPersonas = [];
  //List<PedidoDetEntity> listPedidodetalle = [];

  TextEditingController ctObs = TextEditingController();

  int idPersona = 0;
  int idPedido = 0;

  PersonaEntity personaSelect = PersonaEntity();
  PedidoEntity pedidoSelect = PedidoEntity();
  FacturaEntity facturaSelect = FacturaEntity();

  void iniciar() {
    ctObs = TextEditingController();
    listDetalles = [];
    idPersona = 0;
    idPedido = 0;
    personaSelect = PersonaEntity();
    pedidoSelect = PedidoEntity();
    facturaSelect = FacturaEntity();
    listDetalles.add(new FacturaDetEntity());
  }

  void setFactura(FacturaEntity e) async {
    facturaSelect = e;
    idPersona = e.idCliente;
    idPedido = e.idPedido;
    ctObs = TextEditingController(text: e.observacion);
    try {
      listDetalles = [];
      var result = await _cososUsos.getFacturaById(e.id);
      listDetalles = result.getOrElse(() => []);
      if (listProducto.isEmpty) {
        await getProductos();
      }
      if (listPersonas.isEmpty) {
        await getPersonas();
      }
      if (listPedidos.isEmpty) {
        await getPedidos();
      }

      facturaSelect.listDetalles = listDetalles;
      for (var element in listDetalles) {
        element.prd =
            listProducto.firstWhere((prd) => prd.id == element.idProducto);
      }
      personaSelect =
          listPersonas.firstWhere((element) => element.id == idPersona);

      pedidoSelect =
          listPedidos.firstWhere((element) => element.id == idPedido);

      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future getFactura() async {
    try {
      var temp = await _cososUsos.getAllFactura();
      list = temp.getOrElse(() => []);

      if (listPersonas.isEmpty) {
        await getPersonas();
      }
      for (var item in list) {
        item.nomPersona = listPersonas
            .firstWhere((element) => element.id == item.idCliente)
            .nombres;
      }

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

  Future getPedidoDetalle() async {
    try {
      listDetalles = [];
      var result = await _cososUsosPedidos.getPedidoDetById(idPedido);
      var listdetalle = result.getOrElse(() => []);
      if (listProducto.isEmpty) {
        await getProductos();
      }
      for (var element in listdetalle) {
        FacturaDetEntity entity = FacturaDetEntity();
        entity.idProducto = element.idProducto;
        entity.cantidad = element.cantidad;
        entity.idMotivo = element.idMotivo;
        entity.precio = element.precio;
        entity.codIva = element.codIva;
        entity.iva = element.iva;
        entity.subTotal = element.subTotal;
        entity.total = element.total;
        entity.prd =
            listProducto.firstWhere((prd) => prd.id == entity.idProducto);
        listDetalles.add(entity);
      }
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
          listPersonas.where((element) => element.tipo == 2).toList();
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future anularFactura(FacturaEntity e) async {
    try {
      FacturaModel model = FacturaModel();
      model.id = e.id;
      model.fecha = e.fecha;

      var temp = await _cososUsos.anularFactura(model);
      try {
        var result = temp.getOrElse(() => FacturaEntity());
        if (result.id != 0) {
          e.estado = "I";
          notifyListeners();
        }
      } catch (e) {}
    } catch (e) {
      print(e.toString());
    }
  }

  Future<bool> insertFactura() async {
    try {
      FacturaModel model = FacturaModel();
      model.idCliente = idPersona;
      model.idPedido = idPedido;
      model.estado = "A";
      model.observacion = ctObs.text;
      model.fecha = DateTime.now();

      var temp = await _cososUsos.insertFactura(model);
      try {
        var result = temp.getOrElse(() => FacturaEntity());
        if (result.id != 0) {
          result.nomPersona = personaSelect.nombres;
          list.add(result);
          for (var element in listDetalles) {
            FacturaDetModel modelDet = FacturaDetModel();
            modelDet.idCab = result.id;
            modelDet.idProducto = element.idProducto;
            modelDet.cantidad = element.cantidad;
            modelDet.idMotivo = element.idMotivo;
            modelDet.precio = element.precio;
            modelDet.codIva = element.codIva;
            modelDet.iva = element.iva;
            modelDet.subTotal = element.subTotal;
            modelDet.total = element.total;

            await _cososUsos.insertDetFactura(modelDet);
          }
          notifyListeners();
        }
        return true;
      } catch (e) {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  void agregarDetalle() {
    listDetalles.add(new FacturaDetEntity());
    notifyListeners();
  }

  void calculos() {
    for (var e in listDetalles) {
      if (e.cantidad != 0 && e.precio != 0) {
        e.total = e.cantidad * e.precio;
      }
    }
    notifyListeners();
  }
}
