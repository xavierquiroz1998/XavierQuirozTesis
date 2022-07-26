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
import 'package:collection/collection.dart';

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
  List<FacturasClientesEntity> lisfactClientes = [];

  TextEditingController ctObs = TextEditingController();

  int idPersona = 0;
  int idPedido = 0;
  String msjError = "";

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

  Future setFactura(FacturaEntity e) async {
    facturaSelect = e;
    idPersona = e.idCliente;
    idPedido = e.idPedido;
    ctObs = TextEditingController(text: e.observacion);
    try {
      listDetalles = [];
      var result = await _cososUsos.getFacturaById(e.id);
      listDetalles = result.getOrElse(() => []);

      await getProductosTotal();

      if (listPersonas.isEmpty) {
        await getPersonas();
      }

      await getPedidosTotal();

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
      var temp = await _cososUsosPedidos.getAllPedidosPendientes();
      listPedidos = temp.getOrElse(() => []);
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future getPedidosTotal() async {
    try {
      var temp = await _cososUsosPedidos.getAllPedidos();
      listPedidos = temp.getOrElse(() => []);
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future getFactClientes() async {
    try {
      var temp = await _cososUsos.getFacturaClientes();
      lisfactClientes = temp.getOrElse(() => []);
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

      await getProductosTotal();

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
      var temp = await _casosUsesProductos.getAllActivos();
      listProducto = temp.getOrElse(() => []);

      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future getProductosTotal() async {
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
      msjError = "";
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
          return true;
        } else {
          msjError = "Error al guardar Factura";
          return false;
        }
      } catch (e) {
        msjError = "Error al guardar detalle de Factura ${e.runtimeType}";
        return false;
      }
    } catch (e) {
      print(e.toString());
      msjError = "Error al guardar la Factura ${e.runtimeType}";
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
        if (e.iva != 0) {
          var valueIva = (e.iva / 100);
          e.total = e.total + (e.total * valueIva);
        }
      }
    }
    notifyListeners();
  }

  Future<List<FacturaEntity>> getFacturasReport(DateTime inicio, DateTime fin,
      [bool anulados = true]) async {
    try {
      List<FacturaEntity> listResult = [];
      var temp = await _cososUsos.getAllFactura();
      var listado = temp.getOrElse(() => []);
      if (listado.length != 0) {
        await getPersonas();
      }

      // for (var e in listado) {
      //   int diasIni = e.fecha!.difference(inicio).inDays;
      //   int diasFin = e.fecha!.difference(fin).inDays;
      //   if (true) {
      //     print("");
      //   }
      // }

      if (!anulados) {
        listado = listado
            .where((e) =>
                e.fecha!.difference(inicio).inDays > 0 &&
                e.fecha!.difference(fin).inDays < 0 &&
                e.estado == "A")
            .toList();
      } else {
        listado = listado
            .where((e) =>
                e.fecha!.difference(inicio).inDays < 1 &&
                e.fecha!.difference(fin).inDays <= -1)
            .toList();
      }

      for (var element in listado) {
        // for (var element in listado) {
        //   var diasInicio = element.fecha!.difference(inicioMes).inDays;
        //   var diasFin = element.fecha!.difference(finMes).inDays;

        var result = await _cososUsos.getFacturaById(element.id);
        element.listDetalles = result.getOrElse(() => []);
      }

      if (listado.isNotEmpty) {
        var asd = listado.groupListsBy(
          (e) => e.idCliente,
        );

        for (var item in asd.entries) {
          FacturaEntity t = FacturaEntity();
          t.idCliente = item.key;
          for (var cabe in item.value) {
            t.fecha = cabe.fecha;
            for (var det in cabe.listDetalles) {
              t.cantidad += det.cantidad;
              t.total += det.cantidad * det.precio;
            }
          }
          t.total = double.parse(t.total.toStringAsFixed(2));
          listResult.add(t);
        }

        for (var element in listResult) {
          element.nomPersona =
              listPersonas.firstWhere((e) => e.id == element.idCliente).nombres;
        }
      }
      return listResult;
    } catch (e) {
      return [];
    }
  }
}
