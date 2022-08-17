import 'package:flutter/material.dart';
import 'package:tesis/domain/Navigation/NavigationService.dart';
import 'package:tesis/ui/Router/FluroRouter.dart';
import 'package:tesis/ui/pages/widget/whiteCard.dart';

class FacturaConsulta extends StatefulWidget {
  const FacturaConsulta({Key? key}) : super(key: key);

  @override
  State<FacturaConsulta> createState() => _FacturaConsultaState();
}

class _FacturaConsultaState extends State<FacturaConsulta> {
  @override
  Widget build(BuildContext context) {
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
                        ),
                        DataCell(
                          Text(""),
                        ),
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
