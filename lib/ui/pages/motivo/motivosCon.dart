import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesis/domain/Navigation/NavigationService.dart';
import 'package:tesis/domain/providers/motivos/motivosProvider.dart';
import 'package:tesis/ui/Router/FluroRouter.dart';
import 'package:tesis/ui/pages/widget/whiteCard.dart';

class MotivosConsulta extends StatefulWidget {
  const MotivosConsulta({Key? key}) : super(key: key);

  @override
  State<MotivosConsulta> createState() => _MotivosConsultaState();
}

class _MotivosConsultaState extends State<MotivosConsulta> {
  @override
  void initState() {
    super.initState();
    var temp = Provider.of<MotivosProvider>(context, listen: false);
    temp.cargarMotivos();
  }

  @override
  Widget build(BuildContext context) {
    final motivoProv = Provider.of<MotivosProvider>(context);
    return ListView(
      children: [
        WhiteCard(
          title: 'Motivos',
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    //style: ButtonStyle(),
                    onPressed: () {
                      motivoProv.limpiar();

                      NavigationService.navigateTo(
                          Flurorouter.motivoMantenimiento);
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
                      label: Center(child: Text("Accion")),
                    ),
                  ],
                  rows: motivoProv.listMotivos.map((e) {
                    return DataRow(cells: [
                      DataCell(
                        Text("${e.nombre}"),
                      ),
                      DataCell(
                        Text("${e.descipcion}"),
                      ),
                      DataCell(
                        Text("${e.estado}"),
                      ),
                      DataCell(
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 5, right: 5),
                              child: TextButton.icon(
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                                onPressed: () {
                                  motivoProv.entidad = e;
                                  NavigationService.navigateTo(
                                      Flurorouter.motivoMantenimiento);
                                },
                                label: Text(''),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 5, right: 5),
                              child: TextButton.icon(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () async {
                                  if (e.estado == "A") {
                                    await motivoProv.anular(e);
                                  }
                                },
                                label: Text(''),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]);
                  }).toList(),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
