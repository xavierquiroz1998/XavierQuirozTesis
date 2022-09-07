import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesis/domain/Navigation/NavigationService.dart';
import 'package:tesis/domain/providers/pedidos/pedidoProvider.dart';
import 'package:tesis/ui/Router/FluroRouter.dart';
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
                              Text(e.fecha.toString()),
                            ),
                            DataCell(
                              Text("falta"),
                            ),
                            DataCell(
                              Text(e.estado),
                            ),
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
