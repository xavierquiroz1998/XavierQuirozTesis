import 'package:flutter/cupertino.dart';
import 'package:tesis/data/models/productos/productosModel.dart';
import 'package:tesis/domain/entities/productos/productosEntity.dart';
import 'package:tesis/domain/uses%20cases/productos/productosGeneral.dart';

class ProductosProvider extends ChangeNotifier {
  final ProductosGeneral _casosUsesProductos;

  ProductosProvider(this._casosUsesProductos);

  List<ProductosEntity> listProducto = [];

  TextEditingController ctrCodigo = TextEditingController();
  TextEditingController ctrNombre = TextEditingController();
  TextEditingController ctrdescripcion = TextEditingController();
  TextEditingController ctrStock = TextEditingController();
  TextEditingController ctrCosto = TextEditingController();
  TextEditingController ctrPrecio = TextEditingController();
  TextEditingController ctrEstado = TextEditingController();
  TextEditingController ctrUnidad = TextEditingController();

setProvider(){
  ctrCodigo = TextEditingController();
  ctrNombre = TextEditingController();
  ctrdescripcion = TextEditingController();
  ctrStock = TextEditingController();
  ctrCosto = TextEditingController();
  ctrPrecio = TextEditingController();
  ctrEstado = TextEditingController();
  ctrUnidad = TextEditingController();

}




  Future getProductos() async {
    try {
      var temp = await _casosUsesProductos.getAll();
      listProducto = temp.getOrElse(() => []);

      notifyListeners();
    } catch (e) {}
  }

  Future guardar() async {
    try {
      ProductosModel prd = ProductosModel();
      prd.codigo = ctrCodigo.text;
      prd.nombre = ctrNombre.text;
      prd.descripcion = ctrdescripcion.text;
      prd.stock = int.parse(ctrStock.text);
      prd.costo = double.parse(ctrCosto.text);
      prd.precio = double.parse(ctrPrecio.text);
      prd.estado = ctrEstado.text;
      prd.unidad = int.parse(ctrUnidad.text);
      prd.fecha = DateTime.now();
      var temp = await _casosUsesProductos.insertProducto(prd);
    } catch (e) {
      print("${e.toString()}");
    }
  }
}
