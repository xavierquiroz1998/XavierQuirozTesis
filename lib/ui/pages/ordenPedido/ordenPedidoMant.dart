import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tesis/domain/entities/productos/productosEntity.dart';
import 'package:tesis/domain/providers/pedidos/pedidoProvider.dart';
import 'package:tesis/ui/pages/widget/whiteCard.dart';

class OrdenPedidoMantenimiento extends StatefulWidget {
  const OrdenPedidoMantenimiento({Key? key}) : super(key: key);

  @override
  State<OrdenPedidoMantenimiento> createState() =>
      _OrdenPedidoMantenimientoState();
}

class _OrdenPedidoMantenimientoState extends State<OrdenPedidoMantenimiento> {
  DateTime fechaActual = DateTime.now();
  final DateFormat formatter = DateFormat('dd/MM/yyyy');

  @override
  void initState() {
    super.initState();
    var pedidoP = Provider.of<PedidoProvider>(context, listen: false);
    if (pedidoP.listProducto.length == 0) {
      pedidoP.getProductos();
    }
  }

  @override
  Widget build(BuildContext context) {
    final pedidoP = Provider.of<PedidoProvider>(context);
    return ListView(
      children: [
        WhiteCard(
          title: 'Pedido',
          child: Column(
            children: [
              Row(
                children: [
                  const Text("Fecha : "),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(formatter.format(fechaActual)),
                  )
                ],
              ),
              Row(
                children: [
                  const Text("Cliente"),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(),
                  )),
                ],
              ),
              Row(
                children: [
                  const Text("Observacion"),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: pedidoP.ctObs,
                    ),
                  )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    //style: ButtonStyle(),
                    onPressed: () {
                      pedidoP.agregarDetalle();
                    },

                    child: const Text("Agregar"),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                child: DataTable(
                  columns: const [
                    DataColumn(
                      label: Center(child: Text("Producto")),
                    ),
                    DataColumn(
                      label: Center(child: Text("Cantidad")),
                    ),
                    DataColumn(
                      label: Center(child: Text("Precio")),
                    ),
                    DataColumn(
                      label: Center(child: Text("Total")),
                    )
                  ],
                  rows: pedidoP.listdetalle
                      .map((e) => DataRow(cells: [
                            DataCell(
                              DropdownButton<ProductosEntity>(
                                onChanged: (value) async {
                                  e.idProducto = value!.id;
                                  e.prd = value;
                                  setState(() {});
                                },
                                items: pedidoP.listProducto.map((item) {
                                  return DropdownMenuItem<ProductosEntity>(
                                    value: item,
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          item.descripcion,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400),
                                        )),
                                  );
                                }).toList(),
                                hint: Text(e.idProducto != 0
                                    ? e.prd!.descripcion
                                    : "Seleccione "),
                              ),
                            ),
                            DataCell(
                              TextFormField(
                                initialValue: e.cantidad.toString(),
                                onChanged: (value) {
                                  e.cantidad = int.parse(value);
                                  pedidoP.calculos();
                                },
                              ),
                            ),
                            DataCell(
                              TextFormField(
                                initialValue: e.precio.toString(),
                                onChanged: (value) {
                                  e.precio = double.parse(value);
                                  pedidoP.calculos();
                                },
                              ),
                            ),
                            DataCell(
                              Text(e.total.toString()),
                            )
                          ]))
                      .toList(),
                ),
              ),
              Row(
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
                        await pedidoP.insertPedidos();
                      },
                      child: Text(
                        "Guardar",
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
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Cancelar",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
