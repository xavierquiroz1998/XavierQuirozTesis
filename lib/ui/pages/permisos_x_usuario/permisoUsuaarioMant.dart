import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tesis/ui/pages/widget/whiteCard.dart';

class PermisosMantenimiento extends StatefulWidget {
  const PermisosMantenimiento({Key? key}) : super(key: key);

  @override
  State<PermisosMantenimiento> createState() => _PermisosMantenimientoState();
}

class _PermisosMantenimientoState extends State<PermisosMantenimiento> {
  DateTime fechaActual = DateTime.now();
  final DateFormat formatter = DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        WhiteCard(
          title: 'Permisos',
          child: Column(
            children: [
              Row(
                children: [
                  const Text("Usuario"),
                  Expanded(child: TextFormField()),
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
                      label: Center(child: Text("Consultar")),
                    ),
                    DataColumn(
                      label: Center(child: Text("Anular")),
                    )
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
                        )
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
