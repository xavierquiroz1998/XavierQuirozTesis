import 'package:flutter/material.dart';
import 'package:tesis/ui/pages/widget/whiteCard.dart';

class MotivoMantenimiento extends StatefulWidget {
  const MotivoMantenimiento({Key? key}) : super(key: key);

  @override
  State<MotivoMantenimiento> createState() => _MotivoMantenimientoState();
}

class _MotivoMantenimientoState extends State<MotivoMantenimiento> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          WhiteCard(
            title: 'Motivo',
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
