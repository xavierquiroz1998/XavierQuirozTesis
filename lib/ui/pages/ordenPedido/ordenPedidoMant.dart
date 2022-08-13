import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  Widget build(BuildContext context) {
    return ListView(
      children: [
        WhiteCard(
          title: 'Pedido',
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
                  const Text("Cliente"),
                  Expanded(child: TextFormField()),
                ],
              ),
              Row(
                children: [
                  const Text("Observacion"),
                  Expanded(child: TextFormField()),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    //style: ButtonStyle(),
                    onPressed: () {},
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
                  rows: const [
                    DataRow(
                      cells: [
                        DataCell(
                          Text(""),
                        ),
                        DataCell(
                          Text(""),
                        ),
                        DataCell(
                          Text(""),
                        ),
                        DataCell(
                          Text(""),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
