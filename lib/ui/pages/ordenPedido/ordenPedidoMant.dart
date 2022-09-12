import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:darq/darq.dart';
import 'package:provider/provider.dart';
import 'package:tesis/domain/entities/personas/personasEntity.dart';
import 'package:tesis/domain/entities/productos/productosEntity.dart';
import 'package:tesis/domain/providers/pedidos/pedidoProvider.dart';
import 'package:tesis/ui/pages/Report/createPdf.dart';
import 'package:tesis/ui/pages/Report/viewPdf.dart';
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
    pedidoP.getPersonas();
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
                  const Text("Proveedor : "),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton<PersonaEntity>(
                        onChanged: (value) async {
                          pedidoP.idPersona = value!.id;
                          pedidoP.personaSelect = value;
                          setState(() {});
                        },
                        items: pedidoP.listPersonas.map((item) {
                          return DropdownMenuItem<PersonaEntity>(
                            value: item,
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  item.nombres,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                                )),
                          );
                        }).toList(),
                        hint: Text(pedidoP.idPersona != 0
                            ? pedidoP.personaSelect.nombres
                            : "Seleccione Proveedor"),
                      ),
                    ),
                  ),
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
                    ),
                    DataColumn(
                      label: Center(child: Text("")),
                    )
                  ],
                  rows: pedidoP.listdetalle
                      .map(
                        (e) => DataRow(cells: [
                          DataCell(
                            DropdownButton<ProductosEntity>(
                              onChanged: (value) async {
                                e.idProducto = value!.id;
                                e.prd = value;
                                e.precio = e.prd!.precio;
                                setState(() {});
                              },
                              items: pedidoP.listProducto.map((item) {
                                return DropdownMenuItem<ProductosEntity>(
                                  value: item,
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        item.nombre,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400),
                                      )),
                                );
                              }).toList(),
                              hint: Text(e.idProducto != 0
                                  ? e.prd!.nombre
                                  : "Seleccione "),
                            ),
                          ),
                          DataCell(
                            TextFormField(
                              initialValue: e.cantidad.toString(),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^(?:\+|-)?\d+$'))
                              ],
                              onChanged: (value) {
                                e.cantidad = int.parse(value);
                                pedidoP.calculos();
                              },
                            ),
                          ),
                          DataCell(
                            Text("${e.precio}"),
                          ),
                          DataCell(
                            Text(NumberFormat.currency(
                                    locale: 'en_US', symbol: r'$')
                                .format(e.total)),
                          ),
                          DataCell(TextButton.icon(
                              onPressed: () {
                                pedidoP.listdetalle.remove(e);
                              },
                              icon: Icon(Icons.delete),
                              label: Text("")))
                        ]),
                      )
                      .toList(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Total : " +
                          NumberFormat.currency(locale: 'en_US', symbol: r'$')
                              .format(pedidoP.listdetalle.sum((p) => p.total)),
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
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
                        if (await pedidoP.insertPedidos()) {
                          Navigator.of(context).pop();
                        } else {
                          // mensaje de error
                        }
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
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue,
                        elevation: 15,
                      ),
                      onPressed: () async {
                        var result = await PdfInvoiceApi.generate(
                            pedidoP.pedidoSelect,
                            pedidoP.pedidoSelect.id.toString());
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => ViewPdf(
                        //             data: result,
                        //           )),
                        // );
                      },
                      child: Text(
                        "Generar Pdf",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              )
           
            ],
          ),
        )
      ],
    );
  }
}
