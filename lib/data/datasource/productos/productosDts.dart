import 'dart:convert';

import 'package:tesis/data/datasource/url.dart';
import 'package:http/http.dart' as http;
import 'package:tesis/data/models/productos/productosModel.dart';
import 'package:tesis/domain/entities/productos/productosEntity.dart';

abstract class ProductosDTS {
  Future<List<ProductosEntity>> getAllProductos();
  Future<List<ProductosEntity>> getAllProductosActivos();
  Future<List<CostovsPrecioEntity>> getAllcostoVsprecio();
  Future<ProductosEntity> insertProductos(ProductosModel prd);
  Future<ProductosEntity> updateProductos(ProductosModel prd);
  Future<ProductosEntity> anularProductos(ProductosModel prd);
}

class ProductoDTSImp extends ProductosDTS {
  final http.Client cliente;
  ProductoDTSImp(this.cliente);

  String urlBase = "${UrlBase.url}productos";

  List<ProductosModel> decodePrd(String respuesta) {
    var parseo = jsonDecode(respuesta);
    return parseo
        .map<ProductosModel>((json) => ProductosModel.fromMap(json))
        .toList();
  }

  @override
  Future<List<ProductosModel>> getAllProductos() async {
    try {
      List<ProductosModel> tem = [];
      final result = await cliente.get(Uri.parse(urlBase));
      if (result.statusCode == 200) {
        tem = decodePrd(utf8.decode(result.bodyBytes));
      }

      return tem;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<ProductosModel> insertProductos(ProductosModel prd) async {
    ProductosModel producto = ProductosModel();
    try {
      var grp = json.encode(prd.toMap());

      final result = await cliente.post(Uri.parse(urlBase),
          body: grp, headers: {"Content-type": "application/json"});
      if (result.statusCode == 200) {
        return ProductosModel.fromMap(json.decode(result.body));
      }

      return producto;
    } catch (e) {
      return producto;
    }
  }

  @override
  Future<ProductosEntity> anularProductos(ProductosModel prd) async {
    ProductosModel producto = ProductosModel();
    try {
      var grp = json.encode(prd.toMap());

      final result = await cliente.post(Uri.parse("$urlBase/anular"),
          body: grp, headers: {"Content-type": "application/json"});
      if (result.statusCode == 200) {
        return ProductosModel.fromMap(json.decode(result.body));
      }

      return producto;
    } catch (e) {
      return producto;
    }
  }

  @override
  Future<List<ProductosEntity>> getAllProductosActivos() async {
    try {
      List<ProductosModel> tem = [];
      final result = await cliente.get(Uri.parse("$urlBase/activos"));
      if (result.statusCode == 200) {
        tem = decodePrd(utf8.decode(result.bodyBytes));
      }

      return tem;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<CostovsPrecioEntity>> getAllcostoVsprecio() async {
    try {
      List<CostovsPrecioEntity> tem = [];
      final result = await cliente.get(Uri.parse("$urlBase/costovsprecio"));
      if (result.statusCode == 200) {
        tem = decodeCosto(utf8.decode(result.bodyBytes));
      }

      return tem;
    } catch (e) {
      return [];
    }
  }

  List<CostovsPrecioModel> decodeCosto(String respuesta) {
    var parseo = jsonDecode(respuesta);
    return parseo
        .map<CostovsPrecioModel>((json) => CostovsPrecioModel.fromMap(json))
        .toList();
  }
  
  @override
  Future<ProductosEntity> updateProductos(ProductosModel prd)async {
     ProductosModel producto = ProductosModel();
    try {
      var grp = json.encode(prd.toMap());

      final result = await cliente.post(Uri.parse("$urlBase/update"),
          body: grp, headers: {"Content-type": "application/json"});
      if (result.statusCode == 200) {
        return ProductosModel.fromMap(json.decode(result.body));
      }

      return producto;
    } catch (e) {
      return producto;
    }
  }
}
