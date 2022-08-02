import 'package:flutter/material.dart';
import 'package:tesis/ui/pages/widget/whiteCard.dart';

class DepartamentoMantenimiento extends StatefulWidget {
  const DepartamentoMantenimiento({Key? key}) : super(key: key);

  @override
  State<DepartamentoMantenimiento> createState() =>
      _DepartamentoMantenimientoState();
}

class _DepartamentoMantenimientoState extends State<DepartamentoMantenimiento> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          WhiteCard(
            title: 'Departamento',
            child: Column(
              children: [
                Row(
                  children: [
                    Text("Nombre :"),
                    Expanded(child: TextFormField()),
                  ],
                ),
                Row(
                  children: [
                    Text("Descripcion :"),
                    Expanded(child: TextFormField()),
                  ],
                ),
                Row(
                  children: [
                    Text("Estado :"),
                    Expanded(child: TextFormField()),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
