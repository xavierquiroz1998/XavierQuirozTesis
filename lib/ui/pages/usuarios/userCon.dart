import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesis/domain/Navigation/NavigationService.dart';
import 'package:tesis/domain/providers/usuarios/usuarioProvider.dart';
import 'package:tesis/ui/Router/FluroRouter.dart';
import 'package:tesis/ui/pages/widget/whiteCard.dart';

class UsuarioConsulta extends StatefulWidget {
  const UsuarioConsulta({Key? key}) : super(key: key);

  @override
  State<UsuarioConsulta> createState() => _UsuarioConsultaState();
}

class _UsuarioConsultaState extends State<UsuarioConsulta> {
  @override
  void initState() {
    super.initState();

    var tempUS = Provider.of<UsuarioProvider>(context, listen: false);
    tempUS.getUsuarios();
  }

  @override
  Widget build(BuildContext context) {
    final tempUS = Provider.of<UsuarioProvider>(context);
    return Container(
      child: ListView(
        children: [
          WhiteCard(
            title: 'Usuarios',
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      //style: ButtonStyle(),
                      onPressed: () {
                        tempUS.limpiar();
                        NavigationService.navigateTo(
                            Flurorouter.usuariosMantenimiento);
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
                        label: Center(child: Text("Usuario")),
                      ),
                      DataColumn(
                        label: Center(child: Text("Nombres")),
                      ),
                      DataColumn(
                        label: Center(child: Text("Correo")),
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
                    rows: tempUS.lisUsuarios
                        .map(
                          (e) => DataRow(
                            cells: [
                              DataCell(
                                Text(e.usuario),
                              ),
                              DataCell(
                                Text(e.nombres),
                              ),
                              DataCell(
                                Text(e.correo),
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
                                        tempUS.entity = e;
                                        tempUS.setUsuario();
                                        NavigationService.navigateTo(
                                            Flurorouter.usuariosMantenimiento);
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        color: Colors.blue,
                                      ),
                                      label: Text("")),
                                  TextButton.icon(
                                      onPressed: () async {
                                        if (e.estado == "A") {
                                          tempUS.anular(e);
                                        }
                                      },
                                      icon: Icon(
                                        Icons.delete_rounded,
                                        color: Colors.red,
                                      ),
                                      label: Text(""))
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
      ),
    );
  }
}
