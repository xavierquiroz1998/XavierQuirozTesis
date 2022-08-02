import 'package:flutter/material.dart';
import 'package:tesis/ui/pages/widget/whiteCard.dart';

class PersonaMantenimiento extends StatefulWidget {
  const PersonaMantenimiento({Key? key}) : super(key: key);

  @override
  State<PersonaMantenimiento> createState() => _PersonaMantenimientoState();
}

class _PersonaMantenimientoState extends State<PersonaMantenimiento> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          WhiteCard(
            title: 'Persona',
            child: Column(
              children: [
                Row(
                  children: [
                    Text("Identificación :"),
                    Expanded(child: TextFormField()),
                  ],
                ),
                Row(
                  children: [
                    Text("Nombres :"),
                    Expanded(child: TextFormField()),
                  ],
                ),
                Row(
                  children: [
                    Text("Apellidos :"),
                    Expanded(child: TextFormField()),
                  ],
                ),
                Row(
                  children: [
                    Text("Direccion :"),
                    Expanded(child: TextFormField()),
                  ],
                ),
                Row(
                  children: [
                    Text("Tipo persona :"),
                    Expanded(child: TextFormField()),
                  ],
                ),
                Row(
                  children: [
                    Text("Correo :"),
                    Expanded(child: TextFormField()),
                  ],
                ),
                Row(
                  children: [
                    Text("Celular :"),
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
