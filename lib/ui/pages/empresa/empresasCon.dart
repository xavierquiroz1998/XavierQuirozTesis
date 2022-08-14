import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesis/domain/Navigation/NavigationService.dart';
import 'package:tesis/domain/providers/empresas/empresasProvider.dart';
import 'package:tesis/ui/Router/FluroRouter.dart';
import 'package:tesis/ui/pages/widget/whiteCard.dart';

class EmpresasConsulta extends StatefulWidget {
  const EmpresasConsulta({Key? key}) : super(key: key);

  @override
  State<EmpresasConsulta> createState() => _EmpresasConsultaState();
}

class _EmpresasConsultaState extends State<EmpresasConsulta> {
  @override
  void initState() {
    super.initState();
    var empProviderTemp = Provider.of<EmpresasProvider>(context, listen: false);
    empProviderTemp.cargarEmpresas();
  }

  @override
  Widget build(BuildContext context) {
    final empProvider = Provider.of<EmpresasProvider>(context);
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
                    DataColumn(
                      label: Center(child: Text("Acciones")),
                    ),
                  ],
                  rows: empProvider.listEmpresas.map(
                    (e) {
                      return DataRow(
                        cells: [
                          DataCell(
                            Text("${e.nombre}"),
                          ),
                          DataCell(
                            Text("${e.descripcion}"),
                          ),
                          DataCell(
                            Text("${e.estado}"),
                          ),
                          DataCell(Row(
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(left: 5, right: 5),
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5, right: 5),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          )),
                        ],
                      );
                    },
                  ).toList(),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
