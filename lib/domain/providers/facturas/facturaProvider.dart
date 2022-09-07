import 'package:flutter/cupertino.dart';
import 'package:tesis/data/models/facturas/facturaModel.dart';
import 'package:tesis/domain/entities/facturas/facturaEntity.dart';
import 'package:tesis/domain/uses%20cases/factura/facturaGeneral.dart';

class FacturaProvider extends ChangeNotifier {
  final FacturaGeneral _cososUsos;
  FacturaProvider(this._cososUsos);
  List<FacturaEntity> list = [];

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
