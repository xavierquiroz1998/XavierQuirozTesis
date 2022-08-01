import 'package:flutter/material.dart';
import 'package:tesis/domain/Navigation/NavigationService.dart';
import 'package:tesis/ui/Router/FluroRouter.dart';
import 'package:tesis/ui/pages/widget/whiteCard.dart';

class EmpresasConsulta extends StatefulWidget {
  const EmpresasConsulta({Key? key}) : super(key: key);

  @override
  State<EmpresasConsulta> createState() => _EmpresasConsultaState();
}

class _EmpresasConsultaState extends State<EmpresasConsulta> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        WhiteCard(
          title: 'Empresas',
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    //style: ButtonStyle(),
                    onPressed: () {
                      NavigationService.navigateTo(
                          Flurorouter.empresaMantenimiento);
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
                      label: Center(child: Text("Nombre")),
                    ),
                    DataColumn(
                      label: Center(child: Text("Descripcion")),
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
