import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesis/domain/Navigation/NavigationService.dart';
import 'package:tesis/domain/providers/departamento/departamentoProvider.dart';
import 'package:tesis/ui/Router/FluroRouter.dart';
import 'package:tesis/ui/pages/widget/whiteCard.dart';

class DepartamentoConsulta extends StatefulWidget {
  const DepartamentoConsulta({Key? key}) : super(key: key);

  @override
  State<DepartamentoConsulta> createState() => _DepartamentoConsultaState();
}

class _DepartamentoConsultaState extends State<DepartamentoConsulta> {
  @override
  void initState() {
    super.initState();
    var depTemp = Provider.of<DepartamentoProvider>(context, listen: false);
    depTemp.cargarDepartamentos();
  }

  @override
  Widget build(BuildContext context) {
    final dep = Provider.of<DepartamentoProvider>(context);
    return ListView(
      children: [
        WhiteCard(
          title: 'Departamentos',
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    //style: ButtonStyle(),
                    onPressed: () {
                      dep.limpiar();
                      NavigationService.navigateTo(
                          Flurorouter.departamentoMantenimiento);
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
                  rows: dep.listDepartamentos
                      .map(
                        (e) => DataRow(
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
                            DataCell(
                              Row(
                                children: [
                                  if (e.estado == "A") ...{
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 5, right: 5),
                                      child: TextButton.icon(
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.blue,
                                        ),
                                        onPressed: () {
                                          dep.entity = e;
                                          NavigationService.navigateTo(
                                              Flurorouter
                                                  .departamentoMantenimiento);
                                        },
                                        label: Text(''),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 5, right: 5),
                                      child: TextButton.icon(
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        onPressed: () async {
                                          if (e.estado == "A") {
                                            await dep.anular(e);
                                          }
                                        },
                                        label: Text(''),
                                      ),
                                    ),
                                  },
                                ],
                              ),
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
