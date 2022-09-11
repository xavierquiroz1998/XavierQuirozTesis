import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesis/domain/Navigation/NavigationService.dart';
import 'package:tesis/domain/providers/pedidos/pedidoProvider.dart';
import 'package:tesis/ui/Router/FluroRouter.dart';
import 'package:tesis/ui/pages/widget/helper/helPer.dart';
import 'package:tesis/ui/pages/widget/whiteCard.dart';

class OrdenPedidoConsulta extends StatefulWidget {
  const OrdenPedidoConsulta({Key? key}) : super(key: key);

  @override
  State<OrdenPedidoConsulta> createState() => _OrdenPedidoConsultaState();
}

class _OrdenPedidoConsultaState extends State<OrdenPedidoConsulta> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final pedidoP = Provider.of<PedidoProvider>(context, listen: false);
    pedidoP.getPedidos();
  }

  @override
  Widget build(BuildContext context) {
    final pedidoP = Provider.of<PedidoProvider>(context);
    return ListView(
      children: [
        WhiteCard(
          title: 'Ordenes de Pedido',
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
                          Flurorouter.ordenPedidoMantenimiento);
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
                                      pedidoP.setPedido(e);
                                      NavigationService.navigateTo(
                                          Flurorouter.ordenPedidoMantenimiento);
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                    ),
                                    label: Text("")),
                                TextButton.icon(
                                    onPressed: () async {
                                      if (e.estado != "A") {
                                        await pedidoP.anularPedido(e);
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
