import 'package:flutter/cupertino.dart';
import 'package:tesis/domain/entities/productos/productosEntity.dart';
import 'package:tesis/domain/uses%20cases/productos/productosGeneral.dart';

class ProductosProvider extends ChangeNotifier {
  final ProductosGeneral _casosUsesProductos;

  ProductosProvider(this._casosUsesProductos);

  List<ProductosEntity> listProducto = [];

  Future getProductos() async {
    try {
      var temp = await _casosUsesProductos.getAll();
      listProducto = temp.getOrElse(() => []);

      notifyListeners();
    } catch (e) {}
  }
}
