import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tesis/domain/providers/facturas/facturaProvider.dart';
import 'package:tesis/ui/pages/widget/whiteCard.dart';

class FacturaMantenimiento extends StatefulWidget {
  const FacturaMantenimiento({Key? key}) : super(key: key);

  @override
  State<FacturaMantenimiento> createState() => _FacturaMantenimientoState();
}

class _FacturaMantenimientoState extends State<FacturaMantenimiento> {
  DateTime fechaActual = DateTime.now();
  final DateFormat formatter = DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    final pedidoP = Provider.of<FacturaProvider>(context);
    return ListView(
      children: [
        WhiteCard(
          title: 'Factura',
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
                  Expanded(
                    child: TextFormField(
                      controller: pedidoP.ctObs,
                    ),
                  ),
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
