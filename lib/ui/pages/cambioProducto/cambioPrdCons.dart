import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesis/domain/Navigation/NavigationService.dart';
import 'package:tesis/domain/providers/pedidos/pedidoProvider.dart';
import 'package:tesis/ui/Router/FluroRouter.dart';
import 'package:tesis/ui/pages/widget/helper/helPer.dart';
import 'package:tesis/ui/pages/widget/whiteCard.dart';

class CambioPrdConsulta extends StatefulWidget {
  const CambioPrdConsulta({Key? key}) : super(key: key);

  @override
  State<CambioPrdConsulta> createState() => _CambioPrdConsultaState();
}

class _CambioPrdConsultaState extends State<CambioPrdConsulta> {
  @override
  void initState() {
    super.initState();

    // final pedidoP = Provider.of<PedidoProvider>(context, listen: false);
    // pedidoP.getPedidos();
  }

  @override
  Widget build(BuildContext context) {
    // final pedidoP = Provider.of<PedidoProvider>(context);
    return ListView(
      children: [
        WhiteCard(
          title: 'Cambio productos por Empleado',
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    //style: ButtonStyle(),
                    onPressed: () {
                      //pedidoP.iniciar();
                      //NavigationService.navigateTo(Flurorouter.ordenPedidoMantenimiento);
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
                    // DataColumn(
                    //   label: Center(child: Text("Total")),
                    // ),
                    DataColumn(
                      label: Center(child: Text("Estado")),
                    ),
                    DataColumn(
                      label: Center(child: Text("")),
                    ),
                  ],
                  rows: [
                    DataRow(cells: [
                      DataCell(Text("")),
                      DataCell(Text("")),
                      DataCell(Text("")),
                      DataCell(Text("")),
                      DataCell(
                        Row(
                          children: [
                            TextButton.icon(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                                label: Text("")),
                            TextButton.icon(
                                onPressed: () async {},
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                label: Text("")),
                          ],
                        ),
                      ),
                    ]),
                  ],

                  // pedidoP.list
                  //     .map(
                  //       (e) => DataRow(
                  //         cells: [
                  //           DataCell(
                  //             Text(e.id.toString()),
                  //           ),
                  //           DataCell(
                  //             Text(e.nomUsuario),
                  //           ),
                  //           DataCell(
                  //             Text(Ayuda.parseFecha(e.fecha)),
                  //           ),
                  //           // DataCell(
                  //           //   Text("falta"),
                  //           // ),
                  //           DataCell(
                  //             Text(e.estado),
                  //           ),
                  //           DataCell(Row(
                  //             children: [
                  //               TextButton.icon(
                  //                   onPressed: () {
                  //                     pedidoP.setPedido(e);
                  //                     NavigationService.navigateTo(
                  //                         Flurorouter.ordenPedidoMantenimiento);
                  //                   },
                  //                   icon: Icon(
                  //                     Icons.edit,
                  //                     color: Colors.blue,
                  //                   ),
                  //                   label: Text("")),
                  //               TextButton.icon(
                  //                   onPressed: () async {
                  //                     if (e.estado != "A") {
                  //                       await pedidoP.anularPedido(e);
                  //                     } else {
                  //                       // mensaje
                  //                     }
                  //                   },
                  //                   icon: Icon(
                  //                     Icons.delete,
                  //                     color: Colors.red,
                  //                   ),
                  //                   label: Text("")),
                  //             ],
                  //           )),

                  //         ],
                  //       ),
                  //     )
                  //     .toList(),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
