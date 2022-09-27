import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:tesis/data/models/pedidos/pedidoDetModel.dart';
import 'package:tesis/data/models/pedidos/pedidoModel.dart';
import 'package:tesis/domain/entities/pedidos/pedidosDetEntity.dart';
import 'package:tesis/domain/entities/pedidos/pedidosEntity.dart';
import 'package:tesis/domain/entities/personas/personasEntity.dart';
import 'package:tesis/domain/entities/productos/productosEntity.dart';
import 'package:tesis/domain/uses%20cases/pedidos/pedidosGeneral.dart';
import 'package:tesis/domain/uses%20cases/personas/personasGeneral.dart';
import 'package:tesis/domain/uses%20cases/productos/productosGeneral.dart';
import 'package:collection/collection.dart';

class PedidoProvider extends ChangeNotifier {
  final PedidosGeneral _cososUsos;
  final ProductosGeneral _casosUsesProductos;
  final PersonasGeneral _casosdeUsoPersona;

  PedidoProvider(
      this._cososUsos, this._casosUsesProductos, this._casosdeUsoPersona);

  TextEditingController ctObs = TextEditingController();
  List<PedidoEntity> list = [];
  List<ProductosEntity> listProducto = [];
  List<PersonaEntity> listPersonas = [];
  List<PedidoDetEntity> listdetalle = [];

  List<PedidoEntity> listDash = [];

  int idPersona = 0;
  String msjError = "";

  PersonaEntity personaSelect = PersonaEntity();
  PedidoEntity pedidoSelect = PedidoEntity();

  Future getPedidos() async {
    try {
      var temp = await _cososUsos.getAllPedidos();
      list = temp.getOrElse(() => []);

      if (list.length != 0) {
        await getPersonas();
      }
      for (var element in list) {
        element.nomUsuario =
            listPersonas.firstWhere((e) => e.id == element.idCliente).nombres;
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
      listProducto =
          listProducto.where((element) => element.estado == "A").toList();
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

  void iniciar() {
    ctObs = TextEditingController();
    listdetalle = [];
    idPersona = 0;
    personaSelect = PersonaEntity();
    pedidoSelect = PedidoEntity();
    listdetalle.add(new PedidoDetEntity());
  }

  void setPedido(PedidoEntity e) async {
    personaSelect = PersonaEntity();
    pedidoSelect = e;
    idPersona = e.idCliente;
    ctObs = TextEditingController(text: e.observacion);
    try {
      listdetalle = [];
      var result = await _cososUsos.getPedidoDetById(e.id);
      listdetalle = result.getOrElse(() => []);
      if (listProducto.length == 0) {
        await getProductos();
      }
      if (listPersonas.length == 0) {
        await getPersonas();
      }
      pedidoSelect.listdetalle = listdetalle;
      for (var element in listdetalle) {
        element.prd =
            listProducto.firstWhere((prd) => prd.id == element.idProducto);
      }
      personaSelect =
          listPersonas.firstWhere((element) => element.id == idPersona);

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
        e.estado = "I";
        notifyListeners();
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
      msjError = "";
      PedidoModel model = PedidoModel();
      model.idCliente = idPersona;
      model.estado = "A";
      model.observacion = ctObs.text;
      model.fecha = DateTime.now();

      var temp = await _cososUsos.insertPedidos(model);
      try {
        var entity = temp.getOrElse(() => PedidoEntity());
        if (entity.id != 0) {
          entity.nomUsuario =
              listPersonas.firstWhere((e) => e.id == idPersona).nombres;
          list.add(entity);
          for (var element in listdetalle) {
            PedidoDetModel modelDet = PedidoDetModel();
            modelDet.idCab = entity.id;
            modelDet.idProducto = element.idProducto;
            modelDet.cantidad = element.cantidad;
            modelDet.idMotivo = element.idMotivo;
            modelDet.precio = element.precio;
            modelDet.codIva = element.codIva;
            modelDet.iva = element.iva;
            modelDet.subTotal = element.subTotal;
            modelDet.total = element.total;

            await _cososUsos.insertDetPedidos(modelDet);
            notifyListeners();
            return true;
          }
        } else {
          msjError = "No se guardo el pedido";
          return false;
        }
      } catch (e) {
        msjError = "No se guardo el Detalle del pedido ${e.toString()}";
        return false;
      }
      msjError = "No se guardo el pedido";
      return false;
    } catch (e) {
      print(e.toString());
      msjError = "No se guardo el Detalle del pedido ${e.toString()}";
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

  Future getPedidosDashboard() async {
    try {
      var fechaActual = DateTime.now();
      var inicioMes = DateTime.utc(fechaActual.year, fechaActual.month, 1);
      var finMes = DateTime.utc(fechaActual.year, fechaActual.month + 1, 1);
      listDash = await getReport1(inicioMes, finMes, false);
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<PedidoEntity>> getReport1(DateTime inicio, DateTime fin,
      [bool anulados = true]) async {
    try {
      List<PedidoEntity> listResult = [];
      var temp = await _cososUsos.getAllPedidos();
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

        var result = await _cososUsos.getPedidoDetById(element.id);
        element.listdetalle = result.getOrElse(() => []);
      }

      if (listado.isNotEmpty) {
        var asd = listado.groupListsBy(
          (e) => e.idCliente,
        );

        for (var item in asd.entries) {
          PedidoEntity t = PedidoEntity();
          t.idCliente = item.key;
          for (var cabe in item.value) {
            t.fecha = cabe.fecha;
            for (var det in cabe.listdetalle) {
              t.cantidad += det.cantidad;
              t.total += det.cantidad * det.precio;
            }
          }
          t.total = double.parse(t.total.toStringAsFixed(2));
          listResult.add(t);
        }

        for (var element in listResult) {
          element.nomUsuario =
              listPersonas.firstWhere((e) => e.id == element.idCliente).nombres;
        }
      }
      return listResult;
    } catch (e) {
      return [];
    }
  }
}
