import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tesis/domain/entities/pedidos/pedidosEntity.dart';
import 'package:tesis/domain/entities/personas/personasEntity.dart';
import 'package:tesis/domain/entities/productos/productosEntity.dart';
import 'package:tesis/domain/providers/facturas/facturaProvider.dart';
import 'package:tesis/ui/pages/widget/helper/helPer.dart';
import 'package:tesis/ui/pages/widget/whiteCard.dart';
import 'package:tesis/ui/style/Custom_Inputs.dart';

class FacturaMantenimiento extends StatefulWidget {
  const FacturaMantenimiento({Key? key}) : super(key: key);

  @override
  State<FacturaMantenimiento> createState() => _FacturaMantenimientoState();
}

class _FacturaMantenimientoState extends State<FacturaMantenimiento> {
  DateTime fechaActual = DateTime.now();
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  final key = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    var pedidoP = Provider.of<FacturaProvider>(context, listen: false);

    pedidoP.getPersonas();

    pedidoP.getPedidos();

    pedidoP.getProductos();
  }

  @override
  Widget build(BuildContext context) {
    final pedidoP = Provider.of<FacturaProvider>(context);
    return ListView(
      children: [
        WhiteCard(
          title: 'Factura',
          child: Form(
            key: key,
            child: Column(
              children: [
                Row(
                  children: [
                    const Text("Fecha : "),
                    Text(formatter.format(fechaActual))
                  ],
                ),
                Row(
                  children: [
                    const Text("Clientes"),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButtonFormField<PersonaEntity>(
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
                            validator: (value) {
                              if (value == null) {
                                return "Seleccione un Cliente";
                              }
                              return null;
                            },
                            decoration: CustomInputs.formInputDecoration(
                                hint: pedidoP.idPersona != 0
                                    ? pedidoP.personaSelect.nombres
                                    : "Seleccione Cliente",
                                label: pedidoP.idPersona != 0
                                    ? pedidoP.personaSelect.nombres
                                    : "Seleccione Cliente",
                                icon: Icons.assignment)),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text("Pedidos"),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButtonFormField<PedidoEntity>(
                            onChanged: (value) async {
                              pedidoP.idPedido = value!.id;
                              pedidoP.pedidoSelect = value;
                              await pedidoP.getPedidoDetalle();
                            },
                            items: pedidoP.listPedidos.map((item) {
                              return DropdownMenuItem<PedidoEntity>(
                                value: item,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "${item.id} - ${item.observacion}",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              );
                            }).toList(),
                            decoration: CustomInputs.formInputDecoration(
                                hint: pedidoP.idPedido != 0
                                    ? "${pedidoP.pedidoSelect.id} - ${pedidoP.pedidoSelect.observacion}"
                                    : "Seleccione Pedido",
                                label: pedidoP.idPedido != 0
                                    ? "${pedidoP.pedidoSelect.id} - ${pedidoP.pedidoSelect.observacion}"
                                    : "Seleccione Pedido",
                                icon: Icons.assignment)),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text("Observaciòn"),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: pedidoP.ctObs,
                          validator: (value) {
                            if (value == null) {
                              return "Ingrese una Observaciòn";
                            } else if (value.isEmpty) {
                              return "Ingrese una Observaciòn";
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      //style: ButtonStyle(),
                      onPressed: pedidoP.idPedido == 0
                          ? () {
                              pedidoP.agregarDetalle();
                            }
                          : null,
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
                        label: Center(child: Text("Iva")),
                      ),
                      DataColumn(
                        label: Center(child: Text("Total")),
                      ),
                      DataColumn(
                        label: Center(child: Text("")),
                      )
                    ],
                    rows: pedidoP.listDetalles
                        .map(
                          (e) => DataRow(cells: [
                            DataCell(
                              IgnorePointer(
                                ignoring: pedidoP.idPedido == 0 ? false : true,
                                child: DropdownButton<ProductosEntity>(
                                  //key: Key("${e.idProducto}"),
                                  onChanged: (value) async {
                                    e.idProducto = value!.id;
                                    e.prd = value;
                                    e.precio = e.prd!.precio;
                                    pedidoP.calculos();
                                    setState(() {});
                                  },
                                  items: pedidoP.listProducto.map((item) {
                                    return DropdownMenuItem<ProductosEntity>(
                                      value: item,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          item.nombre,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  hint: Text(e.idProducto != 0
                                      ? e.prd!.nombre
                                      : "Seleccione "),
                                ),
                              ),
                            ),
                            DataCell(
                              pedidoP.idPedido == 0
                                  ? TextFormField(
                                      initialValue: e.cantidad.toString(),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'^(?:\+|-)?\d+$'))
                                      ],
                                      onChanged: (value) {
                                        e.cantidad = int.parse(value);
                                        pedidoP.calculos();
                                      },
                                    )
                                  : Text("${e.cantidad}"),
                            ),
                            DataCell(
                              Text("${e.precio}"),
                            ),
                            DataCell(
                              TextFormField(
                                initialValue: e.iva.toString(),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^(?:\+|-)?\d+$'))
                                ],
                                onChanged: (value) {
                                  e.iva = int.parse(value);
                                  pedidoP.calculos();
                                },
                              ),
                            ),
                            DataCell(
                              Text(NumberFormat.currency(
                                      locale: 'en_US', symbol: r'$')
                                  .format(e.total)),
                            ),
                            DataCell(TextButton.icon(
                                onPressed: pedidoP.idPedido == 0
                                    ? () {
                                        pedidoP.listDetalles.remove(e);
                                        setState(() {});
                                      }
                                    : null,
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
                        "Total : ${NumberFormat.currency(locale: 'en_US', symbol: r'$').format(pedidoP.listDetalles.sum((p) => p.total))}",
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
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
                          if (key.currentState!.validate()) {
                            if (await pedidoP.insertFactura()) {
                              await Ayuda.alerta(
                                  context, "Exito", "Guardado Correctamente");
                              Navigator.of(context).pop();
                            } else {
                               await Ayuda.alerta(
                                  context, "Advertencia", pedidoP.msjError);
                            }
                          }
                        },
                        child: const Text(
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
                          // var result = await PdfInvoiceApi.generate(
                          //     pedidoP.pedidoSelect,
                          //     pedidoP.pedidoSelect.id.toString());
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
          ),
        )
      ],
    );
  }
}
