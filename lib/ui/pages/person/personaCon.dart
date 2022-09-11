import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesis/domain/Navigation/NavigationService.dart';
import 'package:tesis/domain/providers/personas/personasProvider.dart';
import 'package:tesis/ui/Router/FluroRouter.dart';
import 'package:tesis/ui/pages/widget/whiteCard.dart';

class PersonaConsulta extends StatefulWidget {
  const PersonaConsulta({Key? key}) : super(key: key);

  @override
  State<PersonaConsulta> createState() => _PersonaConsultaState();
}

class _PersonaConsultaState extends State<PersonaConsulta> {
  @override
  void initState() {
    super.initState();

    var prov = Provider.of<PersonasProvider>(context, listen: false);
    prov.getTipoPersonas();
    prov.getPersonas();
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<PersonasProvider>(context);
    return ListView(
      children: [
        WhiteCard(
          title: 'Personas',
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      prov.iniciar();
                      NavigationService.navigateTo(
                          Flurorouter.personaMantenimiento);
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
                      label: Center(child: Text("Nombres")),
                    ),
                    DataColumn(
                      label: Center(child: Text("Dirección")),
                    ),
                    DataColumn(
                      label: Center(child: Text("Celular")),
                    ),
                    DataColumn(
                      label: Center(child: Text("Estado")),
                    ),
                    DataColumn(
                      label: Center(child: Text("")),
                    ),
                  ],
                  rows: prov.listPersonas
                      .map((e) => DataRow(
                            cells: [
                              DataCell(
                                Text(e.nombres),
                              ),
                              DataCell(
                                Text(e.direccion),
                              ),
                              DataCell(
                                Text(e.celular),
                              ),
                              DataCell(
                                Text(e.estado),
                              ),
                              DataCell(Row(
                                children: [
                                  TextButton.icon(
                                    onPressed: () {
                                      prov.setPersona(e);
                                      NavigationService.navigateTo(
                                          Flurorouter.personaMantenimiento);
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                    ),
                                    label: Text(""),
                                  ),
                                  TextButton.icon(
                                    onPressed: () {
                                      if (e.estado == "A") {
                                        prov.anular(e);
                                      }
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    label: Text(""),
                                  ),
                                ],
                              )),
                            ],
                          ))
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
