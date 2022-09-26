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

  setProvider() {
    ctrCodigo = TextEditingController();
    ctrNombre = TextEditingController();
    ctrdescripcion = TextEditingController();
    ctrStock = TextEditingController();
    ctrCosto = TextEditingController();
    ctrPrecio = TextEditingController();
    ctrEstado = TextEditingController();
    ctrUnidad = TextEditingController();
  }

  setProductos(ProductosEntity entity) {
    ctrCodigo = TextEditingController(text: entity.codigo);
    ctrNombre = TextEditingController(text: entity.nombre);
    ctrdescripcion = TextEditingController(text: entity.descripcion);
    ctrStock = TextEditingController(text: entity.stock.toString());
    ctrCosto = TextEditingController(text: entity.costo.toString());
    ctrPrecio = TextEditingController(text: entity.precio.toString());
    //ctrEstado = TextEditingController(text: entity.estado);
    ctrUnidad = TextEditingController(text: entity.usuario);
  }

  Future anular(ProductosEntity entity) async {
    try {
      ProductosModel model = ProductosModel();
      model.id = entity.id;
      model.fecha = entity.fecha;
      var result = await _casosUsesProductos.anularProducto(model);
      try {
        var enti = result.getOrElse(() => ProductosEntity());
        if (enti.id != 0) {
          await getProductos();
        }
      } catch (e) {
        print(e.toString());
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future getProductos() async {
    try {
      var temp = await _casosUsesProductos.getAll();
      listProducto = temp.getOrElse(() => []);

      notifyListeners();
    } catch (e) {}
  }

  Future<bool> guardar() async {
    try {
      ProductosModel prd = ProductosModel();
      prd.codigo = ctrCodigo.text;
      prd.nombre = ctrNombre.text;
      prd.descripcion = ctrdescripcion.text;
      prd.stock = int.parse(ctrStock.text == "" ? "0" : ctrStock.text);
      prd.costo = double.parse(ctrCosto.text);
      prd.precio = double.parse(ctrPrecio.text);
      prd.estado = "A";
      prd.unidad = int.parse(ctrUnidad.text == "" ? "1" : ctrUnidad.text);
      prd.fecha = DateTime.now();
      var temp = await _casosUsesProductos.insertProducto(prd);
      try {
        ProductosEntity entity = temp.getOrElse(() => ProductosEntity());
        if (entity.id != 0) {
          listProducto.add(entity);
          notifyListeners();
          return true;
        }
        return false;
      } catch (e) {
        print("${e.toString()}");
        return true;
      }
    } catch (e) {
      print("${e.toString()}");
      return true;
    }
  }
}
