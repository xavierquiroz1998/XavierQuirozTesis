import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tesis/domain/providers/productos/productosProvider.dart';
import 'package:tesis/ui/pages/widget/helper/helPer.dart';
import 'package:tesis/ui/pages/widget/whiteCard.dart';

class ProductosMantenimiento extends StatefulWidget {
  const ProductosMantenimiento({Key? key}) : super(key: key);

  @override
  State<ProductosMantenimiento> createState() => _ProductosMantenimientoState();
}

class _ProductosMantenimientoState extends State<ProductosMantenimiento> {
  String numeros = r'^(?:\+|-)?\d+$';
  final key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final pvProducto = Provider.of<ProductosProvider>(context);
    return Container(
      child: ListView(
        children: [
          WhiteCard(
            title: 'Producto',
            child: Form(
              key: key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("Codigo :"),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 5),
                          child: TextFormField(
                            controller: pvProducto.ctrCodigo,
                            validator: (value) {
                              if (value == null) {
                                return "Ingrese Codigo del Producto";
                              } else if (value.isEmpty) {
                                return "Ingrese Codigo del Producto";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Nombre :"),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 5),
                          child: TextFormField(
                            controller: pvProducto.ctrNombre,
                            validator: (value) {
                              if (value == null) {
                                return "Ingrese Nombre del Producto";
                              } else if (value.isEmpty) {
                                return "Ingrese Nombre del Producto";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text("Descripción :"),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 5),
                          child: TextFormField(
                            controller: pvProducto.ctrdescripcion,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Row(
                  //   children: [
                  //     Text("Stock :"),
                  //     Expanded(
                  //       child: Padding(
                  //         padding: const EdgeInsets.symmetric(
                  //             horizontal: 8, vertical: 5),
                  //         child: TextFormField(
                  //           inputFormatters: [
                  //             FilteringTextInputFormatter.allow(RegExp(numeros))
                  //           ],
                  //           controller: pvProducto.ctrStock,
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  Row(
                    children: [
                      Text("Costo :"),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 5),
                          child: TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(Ayuda.decimales))
                            ],
                            controller: pvProducto.ctrCosto,
                            validator: (value) {
                              if (value == null) {
                                return "Ingrese Costo del Producto";
                              } else if (value.isEmpty) {
                                return "Ingrese Costo del Producto";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Precio :"),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 5),
                          child: TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(Ayuda.decimales))
                            ],
                            controller: pvProducto.ctrPrecio,
                            validator: (value) {
                              if (value == null) {
                                return "Ingrese Precio del Producto";
                              } else if (value.isEmpty) {
                                return "Ingrese Precio del Producto";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Row(
                  //   children: [
                  //     Text("Unidad :"),
                  //     Expanded(
                  //       child: TextFormField(
                  //         controller: pvProducto.ctrUnidad,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.blue,
                              elevation: 15,
                            ),
                            onPressed: () async {
                              if (key.currentState!.validate()) {
                                if (await pvProducto.guardar()) {
                                  bool? valor = await showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text(""),
                                        content:
                                            Text("Guardado Correctamente "),
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

                                  if (valor ?? true) {
                                    Navigator.pop(context);
                                  }
                                }
                              }
                            },
                            child: const Text(
                              'Guardar',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.blue,
                              elevation: 15,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Cancelar',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
