import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesis/domain/Navigation/NavigationService.dart';
import 'package:tesis/domain/providers/pedidos/pedidoProvider.dart';
import 'package:tesis/domain/providers/remplazo/remplazoProvider.dart';
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

    final remplazo = Provider.of<RemplazoProvider>(context, listen: false);
    remplazo.getRemplazos();
    remplazo.getEmpresas();
    remplazo.getDepartamentos();
  }

  @override
  Widget build(BuildContext context) {
    final pedidoP = Provider.of<RemplazoProvider>(context);
    return WhiteCard(
      title: 'Cambio productos por Empleado',
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                //style: ButtonStyle(),
                onPressed: () {
                  pedidoP.inicio();
                  NavigationService.navigateTo(Flurorouter.cambioMantenimiento);
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
                  label: Center(child: Text("Empleado")),
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
              rows: pedidoP.listRemplazos
                  .map((e) => DataRow(cells: [
                        DataCell(
                          Text("${e.id}"),
                        ),
                        DataCell(
                          Text(e.nomPersona),
                        ),
                        DataCell(
                          Text("${Ayuda.parseFecha(e.fecha)}"),
                        ),
                        DataCell(
                          Text(e.estado),
                        ),
                        DataCell(
                          Row(
                            children: [
                              if (e.estado == "A") ...{
                                TextButton.icon(
                                    onPressed: () async {
                                      await pedidoP.setReemplazo(e);
                                      NavigationService.navigateTo(
                                          Flurorouter.cambioMantenimiento);
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                    ),
                                    label: Text("")),
                                TextButton.icon(
                                    onPressed: () async {
                                      await pedidoP.anular(e);
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    label: Text("")),
                              },
                            ],
                          ),
                        ),
                      ]))
                  .toList(),

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
    );
  }
}
