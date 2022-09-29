import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tesis/domain/providers/menu/menuProvider.dart';
import 'package:tesis/domain/providers/usuarios/usuarioProvider.dart';
import 'package:tesis/ui/pages/widget/helper/helPer.dart';
import 'package:tesis/ui/pages/widget/whiteCard.dart';

class UsuarioMantenimiento extends StatefulWidget {
  const UsuarioMantenimiento({Key? key}) : super(key: key);

  @override
  State<UsuarioMantenimiento> createState() => _UsuarioMantenimientoState();
}

class _UsuarioMantenimientoState extends State<UsuarioMantenimiento> {
  final key = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final usuarioP = Provider.of<UsuarioProvider>(context);
    return ListView(
      children: [
        WhiteCard(
          title: 'Usuario',
          child: Form(
            key: key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text("Usuario :"),
                    Expanded(
                      child: TextFormField(
                        maxLength: 20,
                        controller: usuarioP.ctrUsuario,
                        validator: (value) {
                          if (value == null) {
                            return "Ingrese Usuario";
                          } else if (value.isEmpty) {
                            return "Ingrese Usuario";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("Nombres :"),
                    Expanded(
                      child: TextFormField(
                        maxLength: 50,
                        controller: usuarioP.ctrNombres,
                        validator: (value) {
                          if (value == null) {
                            return "Ingrese # Identificación";
                          } else if (value.isEmpty) {
                            return "Ingrese # Identificación";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(" # Identidificacion :"),
                    Expanded(
                      child: TextFormField(
                        maxLength: 13,
                        controller: usuarioP.ctrIdentifiacion,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(Ayuda.soloNumeros))
                        ],
                        validator: (value) {
                          if (value == null) {
                            return "Ingrese # Identificación";
                          } else if (value.isEmpty) {
                            return "Ingrese # Identificación";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("Domicilio :"),
                    Expanded(
                      child: TextFormField(
                        maxLength: 100,
                        controller: usuarioP.ctrDomicilio,
                        validator: (value) {
                          if (value == null) {
                            return "Ingrese Domicilio";
                          } else if (value.isEmpty) {
                            return "Ingrese Domicilio";
                          }
                          return null;
                        },
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
                        validator: (value) {
                          if (value == null) {
                            return "Ingrese correo";
                          } else if (value.isEmpty) {
                            return "Ingrese correo";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("Celular :"),
                    Expanded(
                      child: TextFormField(
                        maxLength: 10,
                        controller: usuarioP.ctrCelular,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(Ayuda.soloNumeros))
                        ],
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
                        validator: (value) {
                          if (value == null) {
                            return "Ingrese Contraseña";
                          } else if (value.isEmpty) {
                            return "Ingrese Contraseña";
                          }
                          return null;
                        },
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
                    rows: usuarioP.lisMenu.map((e) {
                      return DataRow(cells: [
                        DataCell(
                          Text("${e.descripcion}"),
                        ),
                        DataCell(
                          Checkbox(
                              value: e.nuevo,
                              onChanged: (value) {
                                e.nuevo = value ?? false;
                                usuarioP.notificar();
                              }),
                        ),
                        DataCell(
                          Checkbox(
                              value: e.modificar,
                              onChanged: (value) {
                                e.modificar = value ?? false;
                                usuarioP.notificar();
                              }),
                        ),
                        DataCell(
                          Checkbox(
                              value: e.anular,
                              onChanged: (value) {
                                e.anular = value ?? false;
                                usuarioP.notificar();
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
                          if (key.currentState!.validate()) {
                            await usuarioP.guardar(usuarioP.lisMenu);
                            bool? valor = await showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(""),
                                  content: Text("Guardado Correctamente "),
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
        ),
      ],
    );
  }
}
