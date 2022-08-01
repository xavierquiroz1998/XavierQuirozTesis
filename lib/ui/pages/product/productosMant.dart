import 'package:flutter/material.dart';
import 'package:tesis/ui/pages/widget/whiteCard.dart';

class ProductosMantenimiento extends StatefulWidget {
  const ProductosMantenimiento({Key? key}) : super(key: key);

  @override
  State<ProductosMantenimiento> createState() => _ProductosMantenimientoState();
}

class _ProductosMantenimientoState extends State<ProductosMantenimiento> {
  @override
  Widget build(BuildContext context) {
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
                    Expanded(child: TextFormField()),
                  ],
                ),
                Row(
                  children: [
                    Text("Nombre :"),
                    Expanded(child: TextFormField()),
                  ],
                ),
                Row(
                  children: [
                    Text("Descripcion :"),
                    Expanded(child: TextFormField()),
                  ],
                ),
                Row(
                  children: [
                    Text("Stock :"),
                    Expanded(child: TextFormField()),
                  ],
                ),
                Row(
                  children: [
                    Text("Costo :"),
                    Expanded(child: TextFormField()),
                  ],
                ),
                Row(
                  children: [
                    Text("Precio :"),
                    Expanded(child: TextFormField()),
                  ],
                ),
                Row(
                  children: [
                    Text("Estado :"),
                    Expanded(child: TextFormField()),
                  ],
                ),
                Row(
                  children: [
                    Text("Unidad :"),
                    Expanded(child: TextFormField()),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () async {
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
