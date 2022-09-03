import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesis/domain/providers/menu/menuProvider.dart';
import 'package:tesis/domain/providers/usuarios/usuarioProvider.dart';
import 'package:tesis/ui/pages/widget/whiteCard.dart';

class UsuarioMantenimiento extends StatefulWidget {
  const UsuarioMantenimiento({Key? key}) : super(key: key);

  @override
  State<UsuarioMantenimiento> createState() => _UsuarioMantenimientoState();
}

class _UsuarioMantenimientoState extends State<UsuarioMantenimiento> {
  @override
  void initState() {
    super.initState();
    var temp = Provider.of<MenuProvider>(context, listen: false);
    temp.getMenu();
  }

  @override
  Widget build(BuildContext context) {
    final menuP = Provider.of<MenuProvider>(context);
    final usuarioP = Provider.of<UsuarioProvider>(context);
    return Container(
      child: ListView(
        children: [
          WhiteCard(
            title: 'Usuario',
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text("Usuario :"),
                    Expanded(
                      child: TextFormField(
                        controller: usuarioP.ctrUsuario,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("Nombres :"),
                    Expanded(
                      child: TextFormField(
                        controller: usuarioP.ctrNombres,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(" # Identidificacion :"),
                    Expanded(
                      child: TextFormField(
                        controller: usuarioP.ctrIdentifiacion,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("Domicilio :"),
                    Expanded(
                      child: TextFormField(
                        controller: usuarioP.ctrDomicilio,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("Correo :"),
                    Expanded(
                      child: TextFormField(
                        controller: usuarioP.ctrCorreo,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("Celular :"),
                    Expanded(
                      child: TextFormField(
                        controller: usuarioP.ctrCelular,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("Contraseña :"),
                    Expanded(
                      child: TextFormField(
                        obscureText: true,
                        controller: usuarioP.ctrContrasenia,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  child: DataTable(
                    columns: const [
                      DataColumn(
                        label: Center(child: Text("Descripcion")),
                      ),
                      DataColumn(
                        label: Center(child: Text("Nuevo")),
                      ),
                      DataColumn(
                        label: Center(child: Text("Modificar")),
                      ),
                      DataColumn(
                        label: Center(child: Text("Anular")),
                      )
                    ],
                    rows: menuP.lisMenu.map((e) {
                      return DataRow(cells: [
                        DataCell(
                          Text("${e.descripcion}"),
                        ),
                        DataCell(
                          Checkbox(
                              value: e.nuevo,
                              onChanged: (value) {
                                e.nuevo = value ?? false;
                                menuP.notificar();
                              }),
                        ),
                        DataCell(
                          Checkbox(
                              value: e.modificar,
                              onChanged: (value) {
                                e.modificar = value ?? false;
                                menuP.notificar();
                              }),
                        ),
                        DataCell(
                          Checkbox(
                              value: e.anular,
                              onChanged: (value) {
                                e.anular = value ?? false;
                                menuP.notificar();
                              }),
                        ),
                      ]);
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () async {
                          await usuarioP.guardar(menuP.lisMenu);
                          bool? valor = await showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(""),
                                content: Text("Guardado Correctamente falta"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context, true);
                                      },
                                      child: Text("OK"))
                                ],
                              );
                            },
                          );
                          if (valor ?? false) {
                            Navigator.pop(context);
                          }
                        },
                        child: const Text('Guardar'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancelar'),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
