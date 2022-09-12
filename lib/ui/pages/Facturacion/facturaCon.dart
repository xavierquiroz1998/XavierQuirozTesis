import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesis/domain/Navigation/NavigationService.dart';
import 'package:tesis/domain/providers/facturas/facturaProvider.dart';
import 'package:tesis/ui/Router/FluroRouter.dart';
import 'package:tesis/ui/pages/widget/helper/helPer.dart';
import 'package:tesis/ui/pages/widget/whiteCard.dart';

class FacturaConsulta extends StatefulWidget {
  const FacturaConsulta({Key? key}) : super(key: key);

  @override
  State<FacturaConsulta> createState() => _FacturaConsultaState();
}

class _FacturaConsultaState extends State<FacturaConsulta> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final pedidoP = Provider.of<FacturaProvider>(context, listen: false);
    pedidoP.getFactura();
  }

  @override
  Widget build(BuildContext context) {
    final pedidoP = Provider.of<FacturaProvider>(context);
    return ListView(
      children: [
        WhiteCard(
          title: 'Facturas',
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    //style: ButtonStyle(),
                    onPressed: () {
                      pedidoP.iniciar();
                      NavigationService.navigateTo(
                          Flurorouter.facturaMantenimiento);
                    },
                    child: Text("Nuevo"),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                child: DataTable(
                  columns: const [
                    DataColumn(
                      label: Center(child: Text("Código")),
                    ),
                    DataColumn(
                      label: Center(child: Text("Cliente")),
                    ),
                    DataColumn(
                      label: Center(child: Text("Fecha")),
                    ),
                    DataColumn(
                      label: Center(child: Text("Total")),
                    ),
                    DataColumn(
                      label: Center(child: Text("Estado")),
                    ),
                    DataColumn(
                      label: Center(child: Text("")),
                    ),
                  ],
                  rows: pedidoP.list
                      .map(
                        (e) => DataRow(
                          cells: [
                            DataCell(
                              Text(e.id.toString()),
                            ),
                            DataCell(
                              Text(e.idCliente.toString()),
                            ),
                            DataCell(
                              Text(Ayuda.parseFecha(e.fecha)),
                            ),
                            DataCell(
                              Text("falta"),
                            ),
                            DataCell(
                              Text(e.estado),
                            ),
                            DataCell(Row(
                              children: [
                                TextButton.icon(
                                    onPressed: () {
                                      pedidoP.setFactura(e);
                                      NavigationService.navigateTo(
                                          Flurorouter.facturaMantenimiento);
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                    ),
                                    label: Text("")),
                                TextButton.icon(
                                    onPressed: () async {
                                      if (e.estado != "A") {
                                        await pedidoP.anularFactura(e);
                                      } else {
                                        // mensaje
                                      }
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    label: Text("")),
                              ],
                            )),
                          ],
                        ),
                      )
                      .toList(),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
