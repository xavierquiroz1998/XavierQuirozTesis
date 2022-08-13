import 'package:flutter/material.dart';
import 'package:tesis/domain/Navigation/NavigationService.dart';
import 'package:tesis/ui/Router/FluroRouter.dart';
import 'package:tesis/ui/pages/widget/whiteCard.dart';

class UsuarioConsulta extends StatefulWidget {
  const UsuarioConsulta({Key? key}) : super(key: key);

  @override
  State<UsuarioConsulta> createState() => _UsuarioConsultaState();
}

class _UsuarioConsultaState extends State<UsuarioConsulta> {
  @override
  Widget build(BuildContext context) {
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
                        NavigationService.navigateTo(Flurorouter.usuariosMantenimiento);
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
      ),
    );
  }
}
