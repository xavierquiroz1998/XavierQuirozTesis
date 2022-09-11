import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tesis/domain/providers/productos/productosProvider.dart';
import 'package:tesis/ui/pages/widget/whiteCard.dart';

class ProductosMantenimiento extends StatefulWidget {
  const ProductosMantenimiento({Key? key}) : super(key: key);

  @override
  State<ProductosMantenimiento> createState() => _ProductosMantenimientoState();
}

class _ProductosMantenimientoState extends State<ProductosMantenimiento> {
  String numeros = r'^(?:\+|-)?\d+$';
  @override
  Widget build(BuildContext context) {
    final pvProducto = Provider.of<ProductosProvider>(context);
    return Container(
      child: ListView(
        children: [
          WhiteCard(
            title: 'Producto',
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text("Codigo :"),
                    Expanded(
                      child: TextFormField(
                        controller: pvProducto.ctrCodigo,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("Nombre :"),
                    Expanded(
                      child: TextFormField(
                        controller: pvProducto.ctrNombre,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("Descripcion :"),
                    Expanded(
                      child: TextFormField(
                        controller: pvProducto.ctrdescripcion,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("Stock :"),
                    Expanded(
                      child: TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(numeros))
                        ],
                        controller: pvProducto.ctrStock,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("Costo :"),
                    Expanded(
                      child: TextFormField(
                        controller: pvProducto.ctrCosto,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("Precio :"),
                    Expanded(
                      child: TextFormField(
                        controller: pvProducto.ctrPrecio,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("Unidad :"),
                    Expanded(
                      child: TextFormField(
                        controller: pvProducto.ctrUnidad,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () async {
                          await pvProducto.guardar();

                          bool? valor = await showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(""),
                                content: Text("Guardado Correctamente falta"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context, true);
                                      },
                                      child: Text("OK"))
                                ],
                              );
                            },
                          );
                          if (valor ?? false) {
                            Navigator.pop(context);
                          }
                        },
                        child: const Text('Guardar'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancelar'),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
